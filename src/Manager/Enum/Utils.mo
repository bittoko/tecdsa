import Nat32 "mo:base/Nat32";

module {

  /// Red-black tree of key `Nat`.
  public type Tree = ?({ #R; #B }, Tree, Nat, Tree);

  public type CompareFn<T> = (T, T) -> { #equal; #greater; #less };

  /// Common functions between both classes
  public func lbalance(left : Tree, y : Nat, right : Tree) : Tree {
    switch (left, right) {
      case (?(#R, ?(#R, l1, y1, r1), y2, r2), r) ?(#R, ?(#B, l1, y1, r1), y2, ?(#B, r2, y, r));
      case (?(#R, l1, y1, ?(#R, l2, y2, r2)), r) ?(#R, ?(#B, l1, y1, l2), y2, ?(#B, r2, y, r));
      case _ ?(#B, left, y, right);
    };
  };

  public func rbalance(left : Tree, y : Nat, right : Tree) : Tree {
    switch (left, right) {
      case (l, ?(#R, l1, y1, ?(#R, l2, y2, r2))) ?(#R, ?(#B, l, y, l1), y1, ?(#B, l2, y2, r2));
      case (l, ?(#R, ?(#R, l1, y1, r1), y2, r2)) ?(#R, ?(#B, l, y, l1), y1, ?(#B, r1, y2, r2));
      case _ ?(#B, left, y, right);
    };
  };

  public type Locator = {size: Nat; var index: Nat};

  public func insert<T>(tree: Tree, array: [var T], key: T, loc: Locator, compare: CompareFn<T>) : Tree {
    switch tree {
      case (?(#B, left, y, right)) {
        switch (compare(key, array[y])) {
          case (#less) lbalance(insert<T>(left, array, key, loc, compare), y, right);
          case (#greater) rbalance(left, y, insert<T>(right, array, key, loc, compare));
          case (#equal) {
            loc.index := y;
            tree;
          };
        };
      };
      case (?(#R, left, y, right)) {
        switch (compare(key, array[y])) {
          case (#less) ?(#R, insert<T>(left, array, key, loc, compare), y, right);
          case (#greater) ?(#R, left, y, insert<T>(right, array, key, loc, compare));
          case (#equal) {
            loc.index := y;
            tree;
          };
        };
      };
      case (null) {
        loc.index := loc.size;
        ?(#R, null, loc.size, null);
      };
    };
  };

  public func get_in_tree<T>(tree: Tree, array: [var T], key: T, compare: CompareFn<T>) : ?Nat {
    switch tree {
      case (?(_, l, y, r)) {
        switch (compare(key, array[y])) {
          case (#less) get_in_tree(l, array, key, compare);
          case (#equal) ?y;
          case (#greater) get_in_tree(r, array, key, compare);
        };
      };
      case (null) null;
    };
  };

  // approximate growth by sqrt(2) by 2-powers
  // the function will trap if n == 0 or n >= 3 * 2 ** 30
  public func next_size(n_ : Nat) : Nat {
    if (n_ == 1) return 2;
    let n = Nat32.fromNat(n_); // traps if n >= 2 ** 32
    let s = 30 - Nat32.bitcountLeadingZero(n); // traps if n == 0
    let m = ((n >> s) +% 1) << s;
    assert (m != 0); // traps if n >= 3 * 2 ** 30
    Nat32.toNat(m);
  };

};