import Agent "../Agent";
import Manager "../Manager";

module {

  public type State = {
    var ecdsa_agent_state: Agent.State;
    var ecdsa_manager_state: Manager.State;
  };

  public func init(server_id: Text): State = {
    var ecdsa_agent_state = Agent.State.init(server_id);
    var ecdsa_manager_state = Manager.State.init();
  }; 

};