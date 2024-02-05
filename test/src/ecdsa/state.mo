import ECDSA "../../../src";
import Utils "mo:utilities";

module {

  public let { SECP256K1 } = ECDSA;

  public type State = { manager_state : ECDSA.Manager.State };

  public func init(): State = {
    manager_state = ECDSA.Manager.State.init({
      canister_id = "aaaaa-aa";
      fees = Utils.Fees.State.init([(SECP256K1.ID.DFX_TEST_KEY, SECP256K1.FEE.DFX_TEST_KEY)]);
    })
  };

};
