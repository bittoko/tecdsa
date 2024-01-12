import S "State";
import C "Class";
import A "../Agent";
import I "../Identity";

module {

  public type KeyId = A.KeyId;
  
  public type Agent = A.Agent;
  
  public type SlotId = C.SlotId;
  
  public type SeedPhrase = I.SeedPhrase;

  public type MasterKey = A.MasterKey;

  public type AsyncReturn<T> = A.AsyncReturn<T>;

  public let { Manager } = C;

  public type State = S.State;

  public type Manager = C.Manager;

  public module State = { public let { init } = S };
  
};