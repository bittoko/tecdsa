import State "State";
import Utils "Utils";
import Error "mo:base/Error";
import Sha256 "mo:sha2/Sha256";

module {

  public type Fee = Utils.Fee;

  public type Message = Blob;

  public type Signature = Blob;

  public type PublicKey = Blob;

  public type AddCyclesFn = (Utils.Fee) -> Bool;

  public type KeyId = {name: Utils.MasterKey; curve: Utils.Curve};

  public type Params = {key_id: KeyId; derivation_path: [Blob]; canister_id: ?Principal};

  public type AsyncReturn<T> = { #ok: T; #err: Text };

  ///
  ///
  public class Agent(state: State.State) = {

    let server = Utils.actor_from_canister_id(state.ecdsa_server_id);

    public func resolve_fee(keyId: KeyId): Fee {
      let (_, fee) = Utils.get_key_name_and_fee(keyId.name);
      fee
    };

    public func request_public_key(params: Params): async* AsyncReturn<PublicKey> {
      try {
        let key_curve: Utils.Curve = params.key_id.curve;
        let (key_name, _) = Utils.get_key_name_and_fee( params.key_id.name );
        let { public_key } = await server.ecdsa_public_key({
          canister_id = params.canister_id;
          derivation_path = params.derivation_path;
          key_id = { curve = key_curve; name = key_name };
        });
        #ok(public_key);
      } catch (e) {
        #err(Error.message(e))
      }
    };

    public func request_signature(msg: Message, params: Params, addCycles: AddCyclesFn): async* AsyncReturn<Signature> {
      try {
        let key_curve: Utils.Curve = params.key_id.curve;
        let (key_name, fee) = Utils.get_key_name_and_fee( params.key_id.name );
        let hash: Blob = Sha256.fromBlob(#sha256, msg);
        if ( addCycles(fee) == false ) return #err("Failed to add cycles: " # debug_show(fee) );
        let { signature } = await server.sign_with_ecdsa({
          message_hash = hash;
          derivation_path = params.derivation_path;
          key_id = { curve = key_curve; name = key_name };
        });
        #ok(signature)
      } catch (e) {
        #err(Error.message(e))
      }
    };

  };

};