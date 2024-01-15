import { Fees } = "../../../utilities/src";

module {

  public type State = {
    var client_canister_id: Text;
    var client_fees: Fees.State;
  };

  public type InitParams = {
    canister_id : Text;
    fees : Fees.State;
  };

  public func init(params: InitParams): State = {
    var client_canister_id = params.canister_id;
    var client_fees = params.fees;
  };

};