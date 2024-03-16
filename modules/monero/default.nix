{ config, pkgs, ... }: {

  imports = [ ];
  environment.systemPackages = with pkgs; [ p2pool xmrig ];
  # ./p2pool --host 127.0.0.1 --wallet $my_address --mini
  # wallet: 88d3E2YS7uvWsFtFmSXu8YSQFjLm9qBVvgwC1Bg7xM7cDXAw9xmnTsLhyFy54B95vHCyMaRWtcH1P9NsyzUKDsidUJ3Msn9
  # ./xmrig -o 127.0.0.1:3333 -u x+50000 --randomx-1gb-pages

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
