import { State = SB } "mo:stable-buffer";
import { State = Client } "../../../Client";
import { STATE_SIZE } "../../../Identity";
import { Fees } "mo:utilities";
import T "../../types";

module {

  public type Predecessors = { #null_ };
  
  public type State = { 
    client_state : Client.State;
    buffer_state : StableBuffer.State
  };

  public type InitParams = {
    canister_id : Text;
    fees : Fees.State;
  };

  public func init(params : InitParams): State = { 
    client_state = Client.init( params );
    buffer_state = SB.init({size=STATE_SIZE; capacity = 1});
  }
  
};