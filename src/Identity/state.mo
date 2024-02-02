import { compare = compareBlob } "mo:base/Blob";
import { fromText = principalFromText } "mo:base/Principal";
import { print } "mo:base/Debug";
import Utils "utils";
import T "types";

module {

  public type State = (T.Seed, T.KeyId, T.PublicKey);

  public type InitParams = {client: T.Client; key_id: T.KeyId};

  public func init(params: InitParams): async* T.AsyncReturn<(State, T.SeedPhrase)> {
    print("0");
    let phrase : T.SeedPhrase = await* Utils.generateSeedPhrase();
    print("1");
    let seed : Blob = Utils.hashSeedPhrase( phrase );
    print("2");
    let client_params: T.Params = {key_id = params.key_id; canister_id = null; derivation_path = [ seed ]};
    print("3");
    switch( await* params.client.request_public_key( client_params ) ){
      case( #ok pk ) #ok((seed, client_params.key_id, pk), phrase);
      case( #err txt ) return #err( txt );
    };
  };

  public func compare(x: State, y: State): {#less; #equal; #greater} = compareBlob(x.0, y.0);

};