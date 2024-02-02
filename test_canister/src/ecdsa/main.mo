import { Identity } "../../../src";
import { toBlob } "mo:base/Principal";
import { encodeUtf8 } "mo:base/Text";
import RT "Runtime";

actor {

  stable let config = RT.init();
  
  let runtime = RT.Runtime( config );

  let nonce_factory = runtime.nonce_factory();
  let ecdsa_client = runtime.ecdsa_client();
  let fees = runtime.fees();

  type Identity = Identity.State;

  public shared ({ caller }) func generate_new_identity(): async ?Identity {
    switch( await* Identity.State.init({client=ecdsa_client; key_id={curve=#secp256k1; name=#dfx_test_key}}) ){
      case( #err _ ) null;
      case( #ok (i, _) ) ?i
    }
  };

  public shared ({ caller }) func sign_message(): async Blob {
    
    let data = encodeUtf8("Hello world");
    switch( await* ecdsa_client.request_signature(data, {
      key_id = { curve = #secp256k1; name = #dfx_test_key };
      derivation_path = [ toBlob(caller) ];
      canister_id = null;
    }) ){
      case( #ok blob ) blob;
      case _ ""
    };

  };

};
