import A "Agent";
import I "Identity";
import M "Manager";
import K "Keystore";

module {

  public type KeyId = A.KeyId;
  public type Params = A.Params;
  public type SlotId = M.SlotId;
  public type Message = A.Message;
  public type Signature = A.Signature;
  public type PublicKey = A.PublicKey;
  public type MasterKey = A.MasterKey;
  public type SeedPhrase = I.SeedPhrase;
  public type AddCyclesFn = A.AddCyclesFn;
  public type AsyncReturn<T> = A.AsyncReturn<T>;
  public type CyclesInterface = K.CyclesInterface;

  ///
  ///
  public let { principalOfPublicKey } = I;

  public let { generateSeedPhrase; hashSeedPhrase } = I;
  ///
  ///
  public type  Agent = A.Agent;
  
  public module Agent = {
    
    public type State = A.State;
    
    public let { Agent; State } = A;
  
  };

  ///
  ///
  public type Manager = M.Manager;

  public module Manager = {

    public type State = A.State;
    
    public let { Manager; State } = M;
  
  };

  ///
  ///
  public type Identity = I.Identity;

  public module Identity = {

    public type State = A.State;

    public let { Identity; State } = I;
  
  };

  ///
  ///
  public type Keystore = K.Keystore;

  public module Keystore = {

    public type State = A.State;

    public let { Keystore; State } = K;

  };


};