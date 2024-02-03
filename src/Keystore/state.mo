import Client "../Client";
import Map "mo:map/Map";

module {

  public type State = {
    var client_state: Client.State;
    var identities: Map.Map<Blob, Blob>
  };

  public type InitParams = Client.State.InitParams;

  public func init(params: InitParams): State = {
    var client_state = Client.State.init(params);
    var manager_state = Manager.State.init();
  }; 

};