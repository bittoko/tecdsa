import S "State";
import C "Class";

module {

  public let { Enum } = C;

  public type Enum<T> = C.Enum<T>;
  
  public type State<T> = C.State<T>;

  public module State = { public let { init } = S };

};