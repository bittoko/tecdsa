module {

  public let ID_KEY_1 : Text = "key_1";
  public let FEE_KEY_1 : Nat64 = 26_153_846_153;

  public let ID_TEST_KEY_1 : Text = "test_key_1";
  public let FEE_TEST_KEY_1 : Nat64 = 10_000_000_000; 

  public let ID_DFX_TEST_KEY : Text = "dfx_test_key";
  public let FEE_DFX_TEST_KEY : Nat64 = 10_000_000_000;

  public let P_VALUE : Int = 115792089237316195423570985008687907853269984665640564039457584007908834671663;

  public let SECP256K1_PRESTRING_LEN : Nat = 31;
  
  public let SECP256K1_PRESTRING : [Nat8] = [
    0x30, 0x56, 0x30, 0x10, 0x06, 0x07, 0x2a, 0x86,
    0x48, 0xce, 0x3d, 0x02, 0x01, 0x06, 0x05, 0x2b,
    0x81, 0x04, 0x00, 0x0a, 0x03, 0x42, 0x00
  ];

};