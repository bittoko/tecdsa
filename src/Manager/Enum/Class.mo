import State "State";
import Utils "Utils";
import { tabulateVar } "mo:base/Array";

module {

  public type State<T> = State.State<T>;

  public class Enum<T>(state: State<T>, compare: Utils.CompareFn<T>) = {
    
    public func size() : Nat = state.size;

    public func get(index: Nat): T  = state.array[index];

    public func lookup(key : T) : ?Nat = Utils.get_in_tree<T>(state.tree, state.array, key, compare);

    public func add(key : T) : Nat {
      let locator = {size = state.size; var index = 0};
      state.tree := switch (Utils.insert<T>(state.tree, state.array, key, locator, compare)) {
        case (?(#R, left, y, right)) ?(#B, left, y, right);
        case other other;
      };
      if (locator.index == state.size) {
        if (state.size == state.array.size()) {
          state.array := tabulateVar<T>(Utils.next_size(state.size),
            func(i) = if (i < state.size) { state.array[i] } else { state.empty }
          );
        };
        state.array[state.size] := key;
        state.size += 1;
      };
      return locator.index;
    };
    
  };

};