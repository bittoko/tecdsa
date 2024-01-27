import S "state";
import T "types";
import { hashSeedPhrase; principalOfPublicKey } "utils";
import { fromBlob = principalFromBlob } "mo:base/Principal";

module {

  public class Identity(state: S.State, client: T.Client) = {

    public let key_id: T.KeyId = state.1;

    public let public_key: T.PublicKey = state.2;

    public let principal: Principal = principalOfPublicKey(state.2);

    public let calculate_fee = client.calculate_fee;

    public func is_owner_seed(seed: T.SeedPhrase): Bool {
      let hash: Blob = hashSeedPhrase( seed );
      hash == state.0;
    };

    public func sign(msg: T.Message): async* T.AsyncReturn<T.Signature>{
      let params : T.Params = {
        canister_id = null;
        key_id = state.1;
        derivation_path = [ state.0 ];
      };
      await* client.request_signature(msg, params)
    };

  };


};