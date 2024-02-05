import Client "../Client";
import Identity "../Identity";
import StableBuffer "mo:stable-buffer";

module {

  public type SlotId = Nat;
  public type KeyId = Client.KeyId;
  public type Client = Client.Client;
  public type SeedPhrase = Identity.SeedPhrase;
  public type AsyncReturn<T> = Client.AsyncReturn<T>;

  public type Identity = Identity.Identity;

  public type State = { 
    client_state : Client.State;
    buffer_state : StableBuffer.State
  };

};