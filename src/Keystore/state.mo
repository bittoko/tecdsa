import Client "../Client";
import Manager "../Manager";

module {

  public type State = {
    var client_state: Client.State;
    var manager_state: Manager.State;
  };

  public type InitParams = Client.State.InitParams;

  public func init(params: InitParams): State = {
    var client_state = Client.State.init(params);
    var manager_state = Manager.State.init();
  }; 

};