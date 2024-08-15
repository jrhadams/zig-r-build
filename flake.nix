{
  description = "A simple derivation for the project";
  inputs.nixpkgs.url = "nixpkgs/nixpkgs-unstable";
  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux = with nixpkgs.legacyPackages.x86_64-linux; stdenv.mkDerivation {
      name = "my-zig-project";
      buildInputs = [ zig ];
    };
    devShell.x86_64-linux = with nixpkgs.legacyPackages.x86_64-linux; mkShell {
      buildInputs = [ zig R ];
    };
  };
}
