import ECDSA "../../../../src";
import { Fees } "mo:utilities";
import T "types";

module {

  public let { SECP256K1 } = ECDSA;

  public func stage() : T.State = {
    var initialized = false;
    var fees_state = Fees.State.empty();
    var client_state = ECDSA.Client.State.empty();
    var identity_state = ECDSA.Identity.State.empty(); 
  };

  public func load(state: T.State, params: T.InitParams): async* T.AsyncReturn<()> {
    Fees.State.load(state.fees_state, params);
    let client_params = {canister_id = params.canister_id; fees = state.fees_state };
    ECDSA.Client.State.load(state.client_state, client_params);
    let client = ECDSA.Client.Client(state.client_state);
    let identity_params = {client = client; key_id = params.key_id; seed_phrase = params.seed_phrase };
    switch( await* ECDSA.Identity.State.load(state.identity_state, identity_params) ){
      case( #ok _ ) #ok( state.initialized := true );
      case( #err msg ) #err(msg);
    }
  };

};
