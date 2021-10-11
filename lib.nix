{
  hm = { pkgs, lib, config, ... }:
    let xdg = config.xdg;
    in {
      # Enable xdg to set env variable for XDG_CACHE_HOME, XDG_CONFIG_HOME...etc
      xdg = { enable = true; };

      home.activation = {
        prep = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          $DRY_RUN_CMD mkdir $VERBOSE_ARG -p '${xdg.cacheHome}/redis' '${xdg.cacheHome}/less' '${xdg.cacheHome}/X11' '${xdg.cacheHome}/mysql'
            
          $DRY_RUN_CMD mkdir $VERBOSE_ARG -p '${xdg.dataHome}/redis' '${xdg.dataHome}/less' '${xdg.dataHome}/X11' '${xdg.dataHome}/mysql' '${xdg.dataHome}/sqlite' '${xdg.dataHome}/pg' '${xdg.dataHome}/node'
        '';
      };

      home.sessionVariables = let gemHome = "${xdg.cacheHome}/gem";
      in {
        AWS_SHARED_CREDENTIALS_FILE = "${xdg.configHome}/aws/credentials";
        AWS_CONFIG_FILE = "${xdg.configHome}/aws/config";
        CABAL_DIR = "${xdg.cacheHome}/cabal";
        CABAL_CONFIG = "${xdg.configHome}/cabal/config";
        CARGO_HOME = "${xdg.cacheHome}/cargo";
        STACK_ROOT = "${xdg.cacheHome}/stack";
        DENO_DIR = "${xdg.cacheHome}/deno-cache";
        DENO_INSTALL_ROOT = "${xdg.cacheHome}/deno";
        ELM_HOME = "${xdg.cacheHome}/elm";
        GTK_RC_FILES = "${xdg.configHome}/gtk-1.0/gtkrc";
        GTK2_RC_FILES = "${xdg.configHome}/gtk-2.0/gtkrc";
        GEM_HOME = gemHome;
        GEM_PATH = "$GEM_PATH:${gemHome}";
        GRADLE_USER_HOME = "${xdg.cacheHome}/gradle";
        GOPATH = "${xdg.cacheHome}/go";
        LESSKEY = "${xdg.cacheHome}/less/key";
        LESSHISTFILE = "${xdg.dataHome}/less/history";
        NPM_CONFIG_USERCONFIG = "${xdg.configHome}/npm/npmrc";
        NODE_REPL_HISTORY = "${xdg.dataHome}/node/node_repl_history";
        # elixir
        MIX_HOME = "${xdg.cacheHome}/mix";
        HEX_HOME = "${xdg.cacheHome}/hex";
        MYSQL_HISTFILE = "${xdg.dataHome}/mysql/history";
        PLTUSERHOME = "${xdg.cacheHome}/racket";
        PSQLRC = "${xdg.configHome}/pg/psqlrc";
        PSQL_HISTORY = "${xdg.dataHome}/pg/psql_history";
        PGPASSFILE = "${xdg.cacheHome}/pg/pgpass";
        PGSERVICEFILE = "${xdg.cacheHome}/pg/pg_service.conf";
        RIPGREP_CONFIG_PATH = "$HOME/.config/ripgrep/config";
        REDISCLI_HISTFILE = "${xdg.dataHome}/redis/rediscli_history";
        REDISCLI_RCFILE = "${xdg.configHome}/redis/redisclirc";
        SOLARGRAPH_CACHE = "${xdg.cacheHome}";
        SQLITE_HISTORY = "${xdg.dataHome}/sqlite/sqlite_history";
        # X related 
        XCOMPOSEFILE = "${xdg.cacheHome}/X11/xcompose";
        XCOMPOSECACHE = "${xdg.cacheHome}/X11/xcompose";
        ERRFILE = "${xdg.dataHome}/X11/xsession-errors";
      };

      programs.gpg = { homedir = "${xdg.dataHome}/gnupg"; };
    };
}
