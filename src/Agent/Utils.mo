import C "Const";

module {
  
  public type Fee = Nat64;

  public type Curve = { #secp256k1 };

  public type MasterKey = {#dfx_test_key; #test_key_1; #key_1};

  public type IC = actor {
    ecdsa_public_key : ({
      canister_id : ?Principal;
      derivation_path : [Blob];
      key_id : { curve: { #secp256k1; } ; name: Text };
    }) -> async ({ public_key : Blob; chain_code : Blob; });
    sign_with_ecdsa : ({
      message_hash : Blob;
      derivation_path : [Blob];
      key_id : { curve: { #secp256k1; } ; name: Text };
    }) -> async ({ signature : Blob });
  };

  public func actor_from_canister_id(id: Text): IC = actor(id);

  public func get_key_name_and_fee(k: MasterKey): (Text, Fee) = switch(k){
    case( #dfx_test_key ) ("dfx_test_key", C.FEE_TEST_KEY_1);
    case( #test_key_1 ) ("test_key_1", C.FEE_TEST_KEY_1);
    case( #key_1 )( "key_1", C.FEE_KEY_1);
  };

};