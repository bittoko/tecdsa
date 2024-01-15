import C "Client";
import I "Identity";
import M "Manager";
import K "Keystore";

module {

  ///
  ///
  public let Client = C;

  public let Keystore = K;

  public module Identity = {
    
    public type State = I.State;

    public type Identity = I.Identity;

    public type Manager = M.Manager;

    public let { Identity; State } = I;

    public let Manager = M;

  };

  ///
  ///
  public let { principalOfPublicKey } = I;

  public let { generateSeedPhrase; hashSeedPhrase } = I;

};