import Agent "../Agent";
import Utils "Utils";
import { compare = compareBlob } "mo:base/Blob";
import { fromText = principalFromText } "mo:base/Principal";

module {

  public type Seed = Blob;
  public type KeyId = Agent.KeyId;
  public type PublicKey = Agent.PublicKey;
  public type AsyncReturn<T> = Agent.AsyncReturn<T>;
  public type Agent = Agent.Agent;
  public type SeedPhrase = [Text];

  public type State = (Seed, KeyId, PublicKey);

  public func init(agent: Agent, keyId: KeyId): async* AsyncReturn<(State, SeedPhrase)> {
    let phrase : SeedPhrase = await* Utils.generateSeedPhrase();
    let seed : Blob = Utils.hashSeedPhrase( phrase );
    let params: Agent.Params = {key_id = keyId; canister_id = null; derivation_path = [ seed ]};
    switch( await* agent.request_public_key( params ) ){
      case( #ok pk ) #ok((seed, keyId, pk), phrase);
      case( #err txt ) return #err( txt );
    };
  };

  public func compare(x: State, y: State): {#less; #equal; #greater} = compareBlob(x.0, y.0);

};