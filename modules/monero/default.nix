{ config, pkgs, lib, ... }:
let
  wallet =
    "43974ZxwbJvMq8BpXJTqHhMjXsUKhDQJEYfa1YFMdsWf2onzSQwAwccPtYvmUxdNYxL18TEL6qVf7gLxUdH9FxYvTA3G3eB";
in {

  environment.systemPackages = with pkgs; [ pkgs.p2pool pkgs.xmrig ];

  systemd.services.p2pool = {
    wantedBy = [ "multi-user.target" ];
    # ./p2pool --host 127.0.0.1 --wallet $my_address --mini --log-level 6
    after = [ "monero.service" ];
    description = "Monero p2pool.";
    serviceConfig = {
      Type = "simple";
      User = "monero";
      ExecStart =
        "${pkgs.p2pool}/bin/p2pool --host 127.0.0.1 --wallet ${wallet} --mini --loglevel 6";
      Restart = "always";
      RestartSec = 5;
    };

  };

  # ./xmrig -o 127.0.0.1:3333 --randomx-1gb-pages

  systemd.services.xmrig = {
    wantedBy = [ "multi-user.target" ];
    after = [ "p2pool.service" ];
    description = "Xmrig Miner.";
    serviceConfig = {
      Type = "simple";
      User = "root";
      ExecStart =
        "${pkgs.xmrig}/bin/xmrig -o 127.0.0.1:3333 -S --cpu-no-yield --huge-pages-jit --randomx-1gb-pages --cpu-priority=3 --asm ryzen --pause-on-active=300 --pause-on-battery";
      Restart = "always";
      RestartSec = 5;
    };
  };

  networking.firewall = {
    allowedUDPPorts = [ 18080 37889 37888 18084 18083 18081 ];
    allowedTCPPorts = [ 18080 37889 37888 18084 18083 18081 ];
  };

  services = {
    monero = {
      enable = true;
      dataDir = "/var/lib/MoneroNode/";
      extraConfig = ''
        prune-blockchain=1
        db-sync-mode=fastest:async
        disable-dns-checkpoints=1
        enable-dns-blocklist=1
        zmq-pub=tcp://127.0.0.1:18083
      '';
    };
  };
}
