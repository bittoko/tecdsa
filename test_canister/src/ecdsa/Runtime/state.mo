import ECDSA "../../../../src";
import Utils "mo:utilities";

module {

  public let { SECP256K1 } = ECDSA;

  public type State = {
    state: { #standby; #initialized };
    fee_state : Utils.Fees.State;
    nonce_state: Utils.Nonce.State;
    ecdsa_client_state : ECDSA.Client.State;
  };

  public func init(): State {
    let common_nonce = Utils.Nonce.State.init();
    let common_fees = Utils.Fees.State.init([(SECP256K1.ID.DFX_TEST_KEY, SECP256K1.FEE.DFX_TEST_KEY)]);
    return {
      state = #standby;
      fee_state = common_fees;
      nonce_state = common_nonce;
      ecdsa_client_state = ECDSA.Client.State.init({
        canister_id = "aaaaa-aa";
        fees = common_fees;
      });
    }
  };

};
