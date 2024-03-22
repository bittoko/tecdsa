import { Client; Identity; SECP256K1 = { CURVE; ID = { DFX_TEST_KEY } }  } "../../../src";
import { toBlob } "mo:base/Principal";
import { encodeUtf8 } "mo:base/Text";
import { print } "mo:base/Debug";
import { Runtime; State; Types = T  } "runtime";

actor {
  
  stable let _state = State.stage();

  let runtime = Runtime( _state );

  public func init(params: T.InitParams): async T.AsyncReturn<()> { await* runtime.init( params ) };

  public shared query func get_principal(id: Nat): async Principal {
    runtime
      .identity()
      .get_principal();
  };

  public shared query func get_public_key(id: Nat): async [Nat8] {
    runtime
      .identity()
      .public_key
  };

  public shared func sign_message(msg: Text): async ?Blob {
    let identity = runtime.identity();
    switch( await* identity.sign( encodeUtf8(msg) ) ){
      case( #ok signature ) ?signature;
      case( #err msg ){
        print(debug_show(#err(msg)));
        null
      }
    }
  };

};
