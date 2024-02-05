import C "Client";
import I "Identity";
import M "Manager";

module {

  ///
  ///
  public let { SECP256K1 } = C;

  ///
  ///
  public type Client = C.Client;

  public module Client = {

    public let { Client; State } = C;

    public type Client = C.Client;

    public type State = C.State;

  };

  ///
  ///
  public type Identity = I.Identity;

  public module Identity = {
    
    public let { Identity; State } = I;

    public type Identity = I.Identity;

    public type State = I.State;

  };

  ///
  ///
  public type Manager = M.Manager;

  public module Manager = {

    public let { Manager; State } = M;

    public type Manager = M.Manager;

    public type State = M.State;

  };

};