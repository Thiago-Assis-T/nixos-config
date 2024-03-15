{ config, pkgs, ... }: {

  imports = [ ];
  environment.systemPackages = with pkgs; [ p2pool xmrig ];

  services.monero = {
    enable = true;
    dataDir = "/var/lib/MoneroNode/";
    extraConfig = ''
      db-sync-mode=fastest:async
      disable-dns-checkpoints=1
      enable-dns-blocklist=1
      zmq-pub=tcp://127.0.0.1:18083
    '';
  };
}
