
module {

  public type State = { var ecdsa_server_id: Text };

  public func init(canister_id: Text): State = { var ecdsa_server_id = canister_id };

};