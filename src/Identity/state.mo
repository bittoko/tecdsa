import { compare = compareBlob; toArray = blobToArray; fromArray = blobFromArray } "mo:base/Blob";
import { fromText = principalFromText } "mo:base/Principal";
import { tabulate } "mo:base/Array";
import { print } "mo:base/Debug";
import { STATE_SIZE } "const";
import { KeyId } "../Client";
import Utils "utils";
import T "types";

module {

  public type State = Blob;

  public type InitParams = {client: T.Client; key_id: T.KeyId};

  public let compare = compareBlob;

  public func init(params: InitParams): async* T.AsyncReturn<(T.SeedPhrase, State)> {
    let ?tag = KeyId.toTag( params.key_id ) else { return #err(#other("mo:tecdsa/identity/state: line 15")) };
    let phrase : T.SeedPhrase = await* Utils.generateSeedPhrase();
    let seed : Blob = Utils.hashSeedPhrase( phrase );
    let client_params: T.Params = {key_id = params.key_id; canister_id = null; derivation_path = [ seed ]};
    switch( await* params.client.request_public_key( client_params ) ){
      case( #err msg ) return #err( msg );
      case( #ok pk ){
        let seed_bytes : [Nat8] = blobToArray( seed );
        print(debug_show(seed.size() + pk.size() + 2));
        #ok(phrase, blobFromArray(
          tabulate<Nat8>(STATE_SIZE, func(i): Nat8 {
            if ( i == 0 ) tag.0
            else if ( i == 1 ) tag.1
            else if ( i < 90 ) pk[i-2]
            else seed_bytes[i - 90]
          })
        ));
      }
    };
  };

};