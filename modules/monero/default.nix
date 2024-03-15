{ config, ... }: {

  services.monero = {
    enable = true;
    dataDir = "/var/lib/MoneroNode/";
  };
}
