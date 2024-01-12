import State "State";
import Agent "../Agent";
import { hashSeedPhrase; principalOfPublicKey } "Utils";
import { fromBlob = principalFromBlob } "mo:base/Principal";

module {

  public type Agent = Agent.Agent;
  public type State = State.State;
  public type KeyId = Agent.KeyId;
  public type Message = Agent.Message;
  public type Signature = Agent.Signature;
  public type SeedPhrase = State.SeedPhrase;
  public type AddCyclesFn = Agent.AddCyclesFn;
  public type AsyncReturn<T> = Agent.AsyncReturn<T>;
  public type PublicKey = Agent.PublicKey;

  ///
  ///
  public class Identity(state: State, agent: Agent) = {

    public let key_id: KeyId = state.1;

    public let public_key: PublicKey = state.2;

    public let principal: Principal = principalOfPublicKey(state.2);

    public func is_owner_seed(seed: SeedPhrase): Bool {
      let hash: Blob = hashSeedPhrase( seed );
      hash == state.0;
    };

    public func sign(msg: Message, addCycles: AddCyclesFn): async* AsyncReturn<Signature>{
      let params : Agent.Params = {
        canister_id = null;
        key_id = state.1;
        derivation_path = [ state.0 ];
      };
      await* agent.request_signature(msg, params, addCycles)
    };

  };


};