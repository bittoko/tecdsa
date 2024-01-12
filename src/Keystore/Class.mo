import Manager "../Manager";
import Identity "../Identity";
import Agent "../Agent";
import State "State";

module {

  public type KeyId = Agent.KeyId;

  public type State = State.State;
  
  public type SlotId = Manager.SlotId;

  public type Message = Agent.Message;

  public type Signature = Agent.Signature;

  public type Identity = Identity.Identity;

  public type PublicKey = Identity.PublicKey;

  public type SeedPhrase = Identity.SeedPhrase;

  public type AsyncReturn<T> = Agent.AsyncReturn<T>;

  public type CyclesInterface = {
    reserve: (Nat64) -> ?Nat;
    claim: (Nat) -> ?Blob;
    log: (Blob) -> ();
  };

  public class Keystore(state: State, cycles: CyclesInterface) = {

    let agent = Agent.Agent(state.ecdsa_agent_state);

    let manager = Manager.Manager(state.ecdsa_manager_state);

    public let find_slot_of_seed = manager.find;

    public func slot_key_id(slotId: SlotId): KeyId = Identity.Identity(manager.get(slotId), agent).key_id;

    public func slot_principal(slotId: SlotId): Principal = Identity.Identity(manager.get(slotId), agent).principal;

    public func slot_public_key(slotId: SlotId): PublicKey = Identity.Identity(manager.get(slotId), agent).public_key;

    public func slot_identity(slotId: SlotId): Identity = Identity.Identity(manager.get(slotId), agent);

    public func fill_next_slot(masterKey: KeyId): async* AsyncReturn<(SlotId, SeedPhrase)> {
      await* manager.new_identity(agent, masterKey);
    };

    public func is_owner_of_slot(slotId: SlotId, seed: SeedPhrase): Bool {
      let identity = Identity.Identity(manager.get(slotId), agent);
      identity.is_owner_seed( seed )
    };
    
    public func sign_with_slot(slotId: SlotId, msg: Message): async* AsyncReturn<Signature> {
      var logEntry: ?Blob = null;
      let identity = Identity.Identity(manager.get( slotId ), agent);
      let fee = agent.resolve_fee( identity.key_id );
      let ?reservation = cycles.reserve( fee ) else { return #err("Insufficient Cycles") };
      let addCycles = func(x: Nat64): Bool {
        if ( x <= fee ) {logEntry := cycles.claim(reservation); true } else false 
      };
      switch( await* identity.sign(msg, addCycles) ){
        case( #err txt ) return #err( txt );
        case( #ok sig ){
          let ?entry = logEntry else { return #ok(sig) };
          cycles.log(entry);
          #ok(sig)
        };
      }
    };

  };

};