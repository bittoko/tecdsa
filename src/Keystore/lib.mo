import C "Class";
import S "State";
import A "../Agent";
import I "../Identity";
import M "../Manager";

module {

  public let { Keystore } = C;

  public type State = S.State;

  public type KeyId = A.KeyId;
  
  public type SlotId = M.SlotId;

  public type Message = A.Message;

  public type Keystore = C.Keystore;

  public type Signature = A.Signature;

  public type Identity = I.Identity;

  public type PublicKey = I.PublicKey;

  public type SeedPhrase = I.SeedPhrase;

  public type AsyncReturn<T> = A.AsyncReturn<T>;

  public type CyclesInterface = C.CyclesInterface;

  public module State = { public let { init } = S };


};