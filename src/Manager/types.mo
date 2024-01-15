import Client "../Client";
import Identity "../Identity";

module {

  public type SlotId = Nat;
  public type KeyId = Client.KeyId;
  public type Client = Client.Client;
  public type SeedPhrase = Identity.SeedPhrase;
  public type AsyncReturn<T> = Client.AsyncReturn<T>;

  public type Identity = Identity.Identity;

};