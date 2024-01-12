import C "Class";
import S "State";
import U "Utils";
import Const "Const";

module {

  public type Fee = U.Fee;
  public type KeyId = C.KeyId;
  public type Params = C.Params;
  public type Message = C.Message;
  public type Signature = C.Signature;
  public type MasterKey = U.MasterKey;
  public type PublicKey = C.PublicKey;
  public type AddCyclesFn = C.AddCyclesFn;
  public type AsyncReturn<T> = C.AsyncReturn<T>;

  public let { Agent } = C;

  public type Agent = C.Agent;

  public type State = S.State;

  public let { FEE_TEST_KEY_1; FEE_KEY_1 } = Const;

  public module State = { public let { init } = S };

};