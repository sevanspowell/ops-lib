{ pkgs
, config
, ...
}:

let

  static = {
    grafanaCreds = {
      user = "root";
      password = "";
    };
    graylogCreds = {
      user = "root";
      password = "aifaeChai5jagh9lah4iebaitiego2oc";
      passwordHash = "8b180fb3288ca5ccc6e13047750f41da40149c850bcde19e8ae5ea892084020d";
      clusterSecret = "poo9aishixah3Ohbei3eefee8hohve3deec2ooleirieh4oopahX3heapeicho5eez6ahC0taengaek5Weg4ikae2Au2chee";
    };
    oauth = {
      clientID = "";
      clientSecret = "";
      cookie.secret = "";
      emailDomain = "iohk.io";
    };
  };

in
{
  name = "monitoring-test";

  nodes = {
    monitor = {lib, config, pkgs, ...}: {
      imports = [ ../../../modules/monitoring-services.nix ];

      services.monitoring-services = {
        enable = true;
        webhost = "x";
        enableACME = false;

        monitoredNodes = {
          node_1 = {
            hasNginx = false;
            applicationMonitoringPorts = [ 8000 ];
            labels.role = "core";
          };
        };

        inherit (static)
          grafanaCreds
          graylogCreds
          oauth;
      };
    };


    node_1 = {lib, config, pkgs, ...}: {
      imports = [ ../../../modules/monitoring-exporters.nix ];

      services.monitoring-exporters = {
        graylogHost = "monitoring:5044";
      };

    };
  };

  testScript = ''
    startAll
    $monitor->succeed("mkdir -p /var/lib/cardano-node");
  '';
}
