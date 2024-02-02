import { blobToArray; arrayToBlob } "mo:⛔";
import { tabulate } "mo:base/Array";
import C "const";
import T "types";
import Int "int";

module {

  public func resolve_keyname(mk: T.MasterKey): Text = switch( mk ){
    case( #dfx_test_key ) C.ID_DFX_TEST_KEY;
    case( #test_key_1 ) C.ID_TEST_KEY_1;
    case( #key_1 ) C.ID_KEY_1;
  };

  public func decompress(pk: Blob): [Nat8] {
    
    assert pk.size() == 33;
    let compressed_pk : [Nat8] = blobToArray( pk );
    let x = Int.generate(32, func(i): Nat8 {compressed_pk[i+1]});

    let p: Int = C.P_VALUE;
    let y_square : Int = (((x ** 3) % p) + 7) % p;
    let y_square_square_root = Int.pow_mod(y_square, ((p + 1) / 4), p);

    let prefix : Nat8 = compressed_pk[0];
    let is_even : Bool = (y_square_square_root % 2) == 0;
    let y : Int = if ( (prefix == 0x02 and not is_even ) or (prefix == 0x03 and is_even ) ) 
      Int.modulo(-1 * y_square_square_root, p) else y_square_square_root;

    let (y_size, y_genFn) = Int.generator( y );
    tabulate<Nat8>(65, func(i): Nat8 {
      if ( i == 0 ) return 0x04;
      if ( i < 33 ) compressed_pk[i]
      else y_genFn(i - 33)
    });

  };

};