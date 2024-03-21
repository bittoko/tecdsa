import Version "version";
import T "../types";

module {

  public type Version = Version.Version;

  public type InitParams = Version.InitParams;

  public type State = { var version : Version };

  public func empty(): State = { var version = #null_ };

  public func load(state: State, params: InitParams) : async* T.AsyncReturn<T.SeedPhrase> {
    switch( await* Version.init( params ) ){
      case( #err(msg) ) #err(msg);
      case( #ok(sp, version) ){
        state.version := version;
        #ok( sp )
      }
    }
  };

  public func init(params : Version.InitParams): async* T.AsyncReturn<(T.SeedPhrase, State)> {
    switch( await* Version.init( params ) ){
      case( #err(msg) ) #err(msg);
      case( #ok(sp, version) ){
        let state = { var version = version };
        #ok(sp, state)
      }
    }
  };

  public func unwrap(state: State): Version.State {
    state.version := Version.migrate_from( state.version );
    Version.unwrap( state.version )
  };

}