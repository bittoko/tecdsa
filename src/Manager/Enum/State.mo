import Utils "Utils";

module {

  public type State<T> = {
    var empty: T;
    var size: Nat;
    var tree: Utils.Tree;
    var array: [var T];
  };

  public func init<T>(empty: T): State<T> {
    return {
      var empty = empty;
      var size = 0;
      var tree = null;
      var array = [var empty];
    }
  };

};