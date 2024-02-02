import ECDSA "../../../../src";
import Utils "mo:utilities";

module {

  public let { FEE_DFX_TEST_KEY = FEE_TEST_KEY; ID_DFX_TEST_KEY = ID_TEST_KEY } = ECDSA.Client;

  public type State = {
    state: { #standby; #initialized };
    fee_state : Utils.Fees.State;
    nonce_state: Utils.Nonce.State;
    ecdsa_client_state : ECDSA.Client.State;
  };

  public func init(): State {
    let common_nonce = Utils.Nonce.State.init();
    let common_fees = Utils.Fees.State.init([(ID_TEST_KEY, FEE_TEST_KEY)]);
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
