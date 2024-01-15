import Client "../Client";
import Identity "../Identity";
import Manager "../Manager";

module {

  public type KeyId = Client.KeyId;
  
  public type SlotId = Manager.SlotId;

  public type Message = Client.Message;

  public type Signature = Client.Signature;

  public type Identity = Identity.Identity;

  public type PublicKey = Identity.PublicKey;

  public type SeedPhrase = Identity.SeedPhrase;

  public type AsyncReturn<T> = Client.AsyncReturn<T>;

};