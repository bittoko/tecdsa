import { Identity; SECP256K1 = { CURVE; ID = { DFX_TEST_KEY } }  } "../../../src";
import { print } "mo:base/Debug";
import { toBlob } "mo:base/Principal";
import { encodeUtf8 } "mo:base/Text";
import RT "Runtime";

actor {

  type Identity = Identity.State;
  
  stable let config = RT.init();
  
  let runtime = RT.Runtime( config );

  let nonce_factory = runtime.nonce_factory();
  let ecdsa_client = runtime.ecdsa_client();
  let fees = runtime.fees();

  var identity: ?Identity = null;

  public shared func generate_new_identity(): async ?Identity {
    switch( await* Identity.State.init({client=ecdsa_client; key_id={curve=CURVE; name=DFX_TEST_KEY}}) ){
      case( #ok (_, i) ) { identity := ?i; identity };
      case( #err _ ) null;
    }
  };

  public shared query func get_principal(): async ?Principal {
    let ?id = identity else { return null };
    let _identity = Identity.Identity(id, ecdsa_client);
    ?_identity.getPrincipal()
  };

  public shared query func get_public_key(): async ?[Nat8] {
    let ?id = identity else { return null };
    let _identity = Identity.Identity(id, ecdsa_client);
    ?_identity.public_key
  };

  public shared func sign_message(): async ?Blob {
    let ?id = identity else { return null };
    let _identity = Identity.Identity(id, ecdsa_client);
    let data = encodeUtf8("Hello world");
    switch( await* _identity.sign( data ) ){
      case( #ok signature ) ?signature;
      case( #err msg ){
        print(debug_show(#err(msg)));
        null
      }
    }
  };

};
