{ pkgs
, latestKernel ? false
}:

{
  name = "example";
  meta = with pkgs.stdenv.lib.maintainers; {
    maintainers = [ sevanspowell ];
  };

  nodes = (import ../example/clusters/example.nix pkgs pkgs.iohk-ops-lib.physical.test);

  testScript =
    ''
      $monitoring->waitForUnit('multi-user.target');
    '';
} 
