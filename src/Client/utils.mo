import { decodeNat } "mo:xtended-numbers/NatX";
import Hex "hex";
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

  public func decompressPublicKey(compressedPublicKey: Blob): async {decompressedPublicKey: Blob; x: Text; y: Text } {
    let p_hex : Text = "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F";
    let compressedPublicKeyHex : Text = Hex.encode(Blob.toArray(compressedPublicKey));
    let compressedPublicKeyHexArray : [Char] = Text.toArray(compressedPublicKeyHex);
    let prefix: Text = Hex.convertCharArrayToText([compressedPublicKeyHexArray[0], compressedPublicKeyHexArray[1]]);
    let x_hex: Text = Hex.convertCharArrayToText(Array.subArray<Char>(compressedPublicKeyHexArray, 2, compressedPublicKeyHexArray.size() - 2));
    let xAsInt: Int = await Hex.toNat(x_hex);
    let pAsInt: Nat = await Hex.toNat(p_hex);
    let pow_1 = xAsInt **3;
    let rem_1 = NatX.modulo(pow_1, pAsInt);
    let sum_1 = rem_1 + 7;
    let y_square: Int = NatX.modulo(sum_1, pAsInt);
    let sum_2 = pAsInt + 1;
    let quo_1 = Int.div(sum_2,4);
    let y_square_square_root: Int = NatX.pow_mod(Int.abs(y_square), Int.abs(quo_1), pAsInt);
    var y : Int = y_square_square_root;
    if(
        (prefix == "02" and NatX.modulo(y_square_square_root, 2) == 1) or 
        (prefix == "03" and NatX.modulo(y_square_square_root, 2) == 0)
    ){ y := NatX.modulo(-1 * y_square_square_root,  pAsInt) };
    let y_hex = Hex.padHex("0", Hex.toHex(Int.abs(y)), 64);
    let prefixNat8Array: [Nat8] = [0x04];
    let xNat8Array: [Nat8] = Hex.decode(x_hex);
    let yNat8Array: [Nat8] = Hex.decode(y_hex);
    let decompressedPublicKeyNat8Array: [Nat8] = Array.append(prefixNat8Array,xNat8Array );
    let decompressedPublicKeyNat8Array_: [Nat8] = Array.append(decompressedPublicKeyNat8Array, yNat8Array);
    { decompressedPublicKey = Blob.fromArray(decompressedPublicKeyNat8Array_); x = x_hex; y = y_hex };
  };

  public func pow_mod(base: Nat, exponent: Nat, modulus: Nat ) : Nat {
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

  public func modulo(num: Int, modulus:Nat): Nat {
    var result = num % modulus;
    if(result < 0) result += modulus;
    return Int.abs(result);
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