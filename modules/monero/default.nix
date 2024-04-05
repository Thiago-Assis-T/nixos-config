{
  config,
  pkgs,
  lib,
  ...
}:
let
  wallet = "43974ZxwbJvMq8BpXJTqHhMjXsUKhDQJEYfa1YFMdsWf2onzSQwAwccPtYvmUxdNYxL18TEL6qVf7gLxUdH9FxYvTA3G3eB";
  oneGbPages = "1gb-pages";
in
{

  environment.systemPackages = with pkgs; [ pkgs.p2pool ];

  #systemd.services.p2pool = {
  #  wantedBy = [ "multi-user.target" ];
  #  # ./p2pool --host 127.0.0.1 --wallet $my_address --mini --log-level 6
  #  after = [ "monero.service" ];
  #  description = "Monero p2pool.";
  #  serviceConfig = {
  #    Type = "simple";
  #    User = "monero";
  #    ExecStart = "${pkgs.p2pool}/bin/p2pool --host 127.0.0.1 --wallet ${wallet} --mini --loglevel 6";
  #    Restart = "always";
  #    RestartSec = 5;
  #  };
  #};

  # ./xmrig -o 127.0.0.1:3333 --randomx-1gb-pages

  services.xmrig = {
    enable = false;
    settings = {
      autosave = true;
      background = false;
      colors = true;
      pause-on-active = true;
      watch = true;
      dmi = true;
      randomx = {
        mode = "auto";
        ${oneGbPages} = true;
        rdmsr = true;
        wrmsr = false;
        cache_qos = false;
        numa = true;
        scratchpad_prefetch_mode = 1;
      };
      cpu = {
        enable = true;
        huge-pages = true;
        huge-pages-jit = true;
        priority = 3;
        yild = false;
        max-threads-hint = 100;
        asm = "ryzen";
      };
      retries = 10000;
      pools = [
        {
          url = "127.0.0.1:3333";
          keepalive = true;
          tls = false;
        }
      ];
    };
  };
  #systemd.services.xmrig = {
  #  wantedBy = [ "multi-user.target" ];
  #  after = [ "p2pool.service" ];
  #  serviceConfig = {
  #    Type = "simple";
  #    User = "root";
  #    Restart = "always";
  #    RestartSec = 5;
  #    DynamicUser = lib.mkForce true;
  #  };
  #};

  networking.firewall = {
    allowedUDPPorts = [
      18080
      37889
      37888
      18084
      18083
      18081
    ];
    allowedTCPPorts = [
      18080
      37889
      37888
      18084
      18083
      18081
    ];
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
