import { decodeNat } "mo:xtended-numbers/NatX";
import Nat "mo:base/Nat";
import Blob "mo:base/Blob";
import Buffer "mo:base/Buffer";
import C "const";
import T "types";

module {

  let test_key : Blob = "\03\13\c1\f2\09\58\b7\85\f5\67\a2\6b\21\a7\68\59\ed\fc\bb\20\5f\ed\96\76\a9\fc\09\36\b5\b4\83\87\84";

  public func resolve_keyname(mk: T.MasterKey): Text = switch( mk ){
    case( #dfx_test_key ) C.ID_DFX_TEST_KEY;
    case( #test_key_1 ) C.ID_TEST_KEY_1;
    case( #key_1 ) C.ID_KEY_1;
  };

  let p_blob : Blob = "\FF\FF\FF\FF\FF\FF\FF\FF\FF\FF\FF\FF\FF\FF\FF\FF\FF\FF\FF\FF\FF\FF\FF\FF\FF\FF\FF\FE\FF\FF\FC\2F";

  public func decompress_public_key(blob: Blob): Blob {   
    let compressed : [Nat8] = Blob.toArray( blob ); 
    let p : Nat = decodeNat(p_blob.vals(), #unsignedLEB128);
    let x : Nat = decodeNat(compressed.vals(), #unsignedLEB128);
    let prefix : Nat8 = compressed[0];
    let y_square : Nat = (pow_mod(x, 3, p) + 7) % p;
    let y_square_square_root : Nat = pow_mod(y_square, (p+1)/4, p);
    let is_odd : Bool = y_square_square_root % 2 == 1;
    let is_even : Bool = not is_odd;
    if ( (prefix == 0x02 and is_odd) or (prefix == 0x03 and is_even) ){
      
    }
  };

  func pow_mod(base: Nat, exponent: Nat, modulus: Nat ) : Nat {
    var result: Nat = 1;
    var base_ = base;
    var exponent_ = exponent;

    base_ := base_ % modulus;
    while (exponent_ > 0){
      if(exponent_ % 2 == 1) result := (result * base_) % modulus;
      exponent_ := exponent_ / 2;
      base_ := (base_ * base_) % modulus
    };
    return result;
  };

// import binascii

// p_hex = 'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F'
// p = int(p_hex, 16)
// compressed_key_hex = '0250863AD64A87AE8A2FE83C1AF1A8403CB53F53E486D8511DAD8A04887E5B2352'
// x_hex = compressed_key_hex[2:66]
// x = int(x_hex, 16)
// prefix = compressed_key_hex[0:2]

// y_square = (pow(x, 3, p)  + 7) % p
// y_square_square_root = pow(y_square, (p+1)/4, p)
// if (prefix == "02" and y_square_square_root & 1) or (prefix == "03" and not y_square_square_root & 1):
//     y = (-y_square_square_root) % p
// else:
//     y = y_square_square_root

// computed_y_hex = format(y, '064x')
// computed_uncompressed_key = "04" + x_hex + computed_y_hex

// print computed_uncompressed_key

};