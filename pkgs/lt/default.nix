{ pkgs, ... }:

{
  packageOverrides =
    super:
    let
      self = super.pkgs;
    in
    {
      myPackage = self.callPackage /home/jlou2u/code/py-lewis-trading { };
    };
}
