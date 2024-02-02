import State "state";
import { Fees; Nonce } "mo:utilities";
import { Client; Identity } "../../../../src";
import { trap } "mo:base/Debug";

module {

  public type Fees = Fees.Fees;
  public type Nonce = Nonce.Nonce;
  public type State = State.State;
  public type Client = Client.Client;

  public class Runtime(state: State) = {

    public func fees() : Fees = Fees.Fees(state.fee_state);
    public func nonce_factory() : Nonce = Nonce.Nonce(state.nonce_state);
    public func ecdsa_client() : Client = Client.Client(state.ecdsa_client_state);

  };

};
