final: prev: {
  claude-code = prev.callPackage ./claude-code { };
  tpack = prev.callPackage ./tpack { };
}
