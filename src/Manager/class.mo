import Identity "../Identity";
import SB "mo:stable-buffer";
import Client "../Client";
import T "types";

module {

  type SlotParams = Identity.State.InitParams;

  public class Manager(state: T.State) = {

    let client = Client.Client( state.client_state );

    let buffer = SB.StableBuffer( state.buffer_state );

    public let size = buffer.size;

    public func get_slot(id: T.SlotId): T.Identity { Identity.Identity(buffer.get( id ), client) };

    public func fill_next_slot(keyId : T.KeyId): async* T.AsyncReturn<(T.SlotId, T.SeedPhrase)> {
      switch( await* Identity.State.init({client = client; key_id = keyId}) ){
        case( #err txt ) #err( txt );
        case( #ok (seed, state) ){
          switch( buffer.add( state ) ){
            case( #err _ ) #err(#other("mo:tecdsa/Manager: line 26"));
            case( #ok slot_id ) #ok( (slot_id, seed) )
          }
        }
      }
    };

  };

};