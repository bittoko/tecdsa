import Manager "../Manager";
import Identity "../Identity";
import Client "../Client";
import S "state";

module {

  let { Identity } = Identity;
  let { Manager } = Manager;
  let { Client } = Client;

  public class Keystore(state: S.State) = {

    let client = client( state.client_state );

    let manager = Manager( state.manager_state );

    public let find_slot_of_seed = manager.find;

    public let calculate_fee = client.calculate_fee;

    public func slot_key_id(slotId: T.SlotId): T.KeyId = Identity(manager.get(slotId), client).key_id;

    public func slot_principal(slotId: T.SlotId): T.Principal = Identity(manager.get(slotId), client).principal;

    public func slot_public_key(slotId: T.SlotId): T.PublicKey = Identity(manager.get(slotId), client).public_key;

    public func slot_identity(slotId: T.SlotId): T.Identity = Identity(manager.get(slotId), client);

    public func fill_next_slot(masterKey: T.KeyId): async* T.AsyncReturn<(T.SlotId, T.SeedPhrase)> {
      await* manager.new_identity({client = client; key_id = masterKey});
    };

    public func is_owner_of_slot(phrase: T.SeedPhrase, slotId: T.SlotId) : Bool {
      let identity = Identity(manager.get(slotId), client);
      identity.is_owner_seed( phrase )
    };
    
    public func sign_with_slot(slotId: T.SlotId, msg: T.Message): async* T.AsyncReturn<T.Signature> {
      let identity = Identity(manager.get( slotId ), client);
      await* identity.sign( msg )
    };

  };

};