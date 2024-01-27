import Identity "../Identity";
import Enum "Enum";

module {

  public type State = { var ecdsa_identities: Enum.State<Identity.State> };

  public func init(): State = {
    var ecdsa_identities = Enum.State.init<Identity.State>(("", {name = #dfx_test_key; curve = #secp256k1}, ""))
  };
  
};