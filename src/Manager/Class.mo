import Agent "../Agent";
import Identity "../Identity";
import State "State";
import Enum "Enum";

module {

  public type SlotId = Nat;
  public type State = State.State;
  public type KeyId = Agent.KeyId;
  public type Agent = Agent.Agent;
  public type SeedPhrase = Identity.SeedPhrase;
  public type AsyncReturn<T> = Agent.AsyncReturn<T>;

  public class Manager(state: State) = {

    let enumeration = Enum.Enum<Identity.State>(state.ecdsa_identities, Identity.State.compare);

    public let get = enumeration.get;

    public let size = enumeration.size;

    public func new_identity(agent: Agent, keyId: KeyId): async* AsyncReturn<(SlotId, SeedPhrase)> {
      switch( await* Identity.State.init(agent, keyId) ){
        case( #err txt ) #err( txt );
        case( #ok (state, seed) ){
          let slot_id: SlotId = enumeration.add(state);
          #ok( (slot_id, seed) )
        };
      }
    };

    // comparison is based on hashed seed values;
    public func find(seed: SeedPhrase): ?SlotId {
      enumeration.lookup( (Identity.hashSeedPhrase( seed ), {name = #dfx_test_key; curve = #secp256k1}, "") );
    };

  };

};