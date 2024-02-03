import M "../Manager";
import I "../Identity";
import C "../Client";
import T "types";
import S "state";

module {

  public class Keystore(state: S.State) = {

    let client = C.Client( state.client_state );

    let manager = M.Manager( state.manager_state );

    public let calculate_fee = client.calculate_fee;

    public func slot_key_id(slotId: T.SlotId): T.KeyId = I.Identity(manager.get(slotId), client).key_id;

    public func slot_principal(slotId: T.SlotId): Principal = I.Identity(manager.get(slotId), client).getPrincipal();

    public func slot_public_key(slotId: T.SlotId): T.PublicKey = I. Identity(manager.get(slotId), client).public_key;

    public func slot_identity(slotId: T.SlotId): T.Identity = I.Identity(manager.get(slotId), client);

    public func fill_next_slot(masterKey: T.KeyId): async* T.AsyncReturn<(T.SlotId, T.SeedPhrase)> {
      await* manager.new_identity({client = client; key_id = masterKey});
    };

    public func is_owner_of_slot(phrase: T.SeedPhrase, slotId: T.SlotId) : Bool {
      let identity = I.Identity(manager.get(slotId), client);
      identity.isOwnerSeedPhrase( phrase )
    };
    
    public func sign_with_slot(slotId: T.SlotId, msg: T.Message): async* T.AsyncReturn<T.Signature> {
      let identity = I.Identity(manager.get( slotId ), client);
      await* identity.sign( msg )
    };

  };

};