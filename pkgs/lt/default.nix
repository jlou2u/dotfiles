{ pkgs, ... }:

{
  packageOverrides =
    super:
    let
      self = super.pkgs;
    in
    {
      lt = self.callPackage /home/jlou2u/code/py-lewis-trading { };
    };
}
