import { Identity; Client } "../../../../src";
import S "state";
import T "types";

module {

  public class Runtime(state: T.State) = {

    public func init(params: T.InitParams): async* T.AsyncReturn<()> {
      if ( state.initialized == false ) await* S.load(state, params)
      else #ok
    };

    public func identity(): T.Identity {
      Identity.Identity(state.identity_state, Client.Client(state.client_state))
    };

  };


}