import Identity "../Identity";
import Enum "Enum";
import S "state";
import T "types";

module {

  type InitParams = Identity.State.InitParams;

  public class Manager(state: S.State) = {

    let enumeration = Enum.Enum<Identity.State>(state.ecdsa_identities, Identity.State.compare);

    public let get = enumeration.get;

    public let size = enumeration.size;

    public func new_identity(params: InitParams): async* T.AsyncReturn<(T.SlotId, T.SeedPhrase)> {
      switch( await* Identity.State.init( params ) ){
        case( #err txt ) #err( txt );
        case( #ok (state, seed) ){
          let slot_id: T.SlotId = enumeration.add(state);
          #ok( (slot_id, seed) )
        };
      }
    };

    // comparison is based on hashed seed values;
    public func find(seed: T.SeedPhrase): ?T.SlotId {
      enumeration.lookup( (Identity.hashSeedPhrase( seed ), {name = #dfx_test_key; curve = #secp256k1}, "") );
    };

  };

};