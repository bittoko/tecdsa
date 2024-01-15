import Cycles "mo:base/ExperimentalCycles";
import { Fees } "../../../utilities/src";
import Sha256 "mo:sha2/Sha256";
import Nat64 "mo:base/Nat64";
import Error "mo:base/Error";
import State "state";
import Utils "utils";
import T "types";

module {

  public class Client(state: State.State) = {

    let fees = Fees.Fees( state.client_fees );

    let server : T.IC = actor( state.client_canister_id );

    public func calculate_fee(keyId: T.KeyId): T.ReturnFee {
      let keyname = Utils.resolve_keyname( keyId.name );
      fees.get( keyname );
    };

    public func request_public_key(params: T.Params): async* T.AsyncReturn<T.PublicKey> {
      try {
        let curve: T.Curve = params.key_id.curve;
        let keyname = Utils.resolve_keyname( params.key_id.name );
        let { public_key } = await server.ecdsa_public_key({
          canister_id = params.canister_id;
          derivation_path = params.derivation_path;
          key_id = { curve = curve; name = keyname };
        });
        #ok(public_key);
      } catch (e) {
        #err(#trapped(Error.message(e)))
      }
    };

    public func request_signature(msg: T.Message, params: T.Params): async* T.AsyncReturn<T.Signature> {
      try {
        let curve: T.Curve = params.key_id.curve;
        let keyname = Utils.resolve_keyname( params.key_id.name );
        let hash: Blob = Sha256.fromBlob(#sha256, msg);
        switch( fees.get( keyname ) ){
          case( #err msg ) #err(msg);
          case( #ok fee ){
            Cycles.add( Nat64.toNat(fee) );
            let { signature } = await server.sign_with_ecdsa({
              message_hash = hash;
              derivation_path = params.derivation_path;
              key_id = { curve = curve; name = keyname };
            });
            #ok(signature)
        }};
      } catch (e) {
        #err(#trapped(Error.message(e)))
      }
    };

  };

};