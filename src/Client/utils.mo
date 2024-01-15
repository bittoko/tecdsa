import C "const";
import T "types";

module {

  public func resolve_keyname(mk: T.MasterKey): Text = switch( mk ){
    case( #dfx_test_key ) C.ID_DFX_TEST_KEY;
    case( #test_key_1 ) C.ID_TEST_KEY_1;
    case( #key_1 ) C.ID_KEY_1;
  };

};