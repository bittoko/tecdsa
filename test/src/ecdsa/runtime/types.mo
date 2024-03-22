import { Identity; Client } "../../../../src";
import { Fees } "mo:utilities";

module {

  public type State = {
    var initialized : Bool;
    var fees_state : Fees.State;
    var client_state : Client.State;
    var identity_state : Identity.State
  };

  public type InitParams = {
    fees : [(Text, Nat64)];
    canister_id : Text;
    key_id : Identity.KeyId;
    seed_phrase : ?Identity.SeedPhrase;
  };
  
  public type Identity = Identity.Identity;

  public type AsyncReturn<T> = Identity.AsyncReturn<T>;

}