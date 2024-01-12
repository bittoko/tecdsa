import C "Class";
import S "State";
import U "Utils";
import A "../Agent";
import Const "Const";

module {

  public type KeyId = S.KeyId;
  
  public type Agent = A.Agent;
  
  public type Message = A.Message;
  
  public type Signature = A.Signature;
  
  public type PublicKey = S.PublicKey;
  
  public type SeedPhrase = S.SeedPhrase;
  
  public type AsyncReturn<T> = C.AsyncReturn<T>;

  public type AddCyclesFn = C.AddCyclesFn;
  
  public let { Identity } = C;

  public type State = S.State;

  public type Identity = C.Identity;

  public let { principalOfPublicKey } = U;

  public let { generateSeedPhrase; hashSeedPhrase } = U;

  public let { BIP39_WORD_COUNT; BIP39_WORD_LIST } = Const;

  public module State = { public let { init; compare } = S };

};