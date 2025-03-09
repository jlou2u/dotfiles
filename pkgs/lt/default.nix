{ pkgs, ... }:

{
  packageOverrides =
    super:
    let
      self = super.pkgs;
    in
    {
      py-lewis-trading = self.callPackage /home/jlou2u/code/py-lewis-trading { };
    };
}
