{
  description = "My Lean package";

  inputs.lean.url = "github:leanprover/lean4/a44dd71ad62a1760e32b0e8a12449e560ddcf492";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    nixpkgs,
    lean,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      leanPkgs = lean.packages.${system};
      pkgs = import nixpkgs {inherit system;};
      proofWidgets =
        {inherit (leanPkgs) lean;}
        // leanPkgs.buildLeanPackage {
          name = "ProofWidgets";
          src = pkgs.fetchFromGitHub {
            owner = "EdAyers";
            repo = "ProofWidgets4";
            rev = "c43db94a8f495dad37829e9d7ad65483d68c86b8";
            sha256 = "8O6x0FWRCbbhIwXSSIR4K80KjU6brUMcNKKVvRStFMM=";
          };
        };
      aesop =
        {inherit (leanPkgs) lean;}
        // leanPkgs.buildLeanPackage {
          name = "Aesop";
          src = pkgs.fetchFromGitHub {
            owner = "JLimperg";
            repo = "aesop";
            rev = "ca73109cc40837bc61df8024c9016da4b4f99d4c";
            sha256 = "rp0qmKWdOPDuCYKemyJ6jxMZE8F64ZPSWMFnWiNJ+Ww=";
          };
        };
      quote4 =
        {inherit (leanPkgs) lean;}
        // leanPkgs.buildLeanPackage {
          name = "Qq";
          src = pkgs.fetchFromGitHub {
            owner = "gebner";
            repo = "quote4";
            rev = "c71f94e34c1cda52eef5c93dc9da409ab2727420";
            sha256 = "V41XlySrbrQ7YM/iwVDaz3oK4MVWACk2GkiB3PcU6Nw=";
          };
        };
      std4 =
        {inherit (leanPkgs) lean;}
        // leanPkgs.buildLeanPackage {
          name = "Std";
          src = pkgs.fetchFromGitHub {
            owner = "leanprover";
            repo = "std4";
            rev = "e68aa8f5fe47aad78987df45f99094afbcb5e936";
            sha256 = "tR4wB5oOx/hPZ4Jph4uhEoMQULbVDTcVJsiitocAk1E=";
          };
        };
      mathLib =
        {inherit (leanPkgs) lean;}
        // leanPkgs.buildLeanPackage {
          deps = [std4 quote4 aesop proofWidgets];
          name = "Mathlib";
          src = pkgs.fetchFromGitHub {
            owner = "leanprover-community";
            repo = "mathlib4";
            rev = "caec9984838902721a2dbc9ab3e885ee00731653";
            sha256 = "mQKZvvuHUvRpTBq2Lpz6S9YCTmGD6myTkUcFnaa4xaw=";
          };
        };
      pkg = leanPkgs.buildLeanPackage {
        deps = [mathLib];
        name = "Main";
        src = ./.;
      };
    in {
      packages =
        pkg
        // {
          inherit (leanPkgs) lean;
          inherit std4 quote4 aesop proofWidgets;
        };

      devShell = pkgs.mkShell {packages = [leanPkgs.lean-dev];};

      defaultApp = {
        type = "app";
        program = "${pkg.executable}/bin/main";
      };
      defaultPackage = pkg.modRoot;
    });
}
