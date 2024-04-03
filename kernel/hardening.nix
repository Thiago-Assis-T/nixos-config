{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  nix.settings.allowed-users = mkDefault [ "@users" ];

  # gave me problems with firefox opening:

  # environment.memoryAllocator.provider = mkDefault "scudo";
  # environment.variables.SCUDO_OPTIONS = mkDefault "ZeroContents=1";

  security = {
    lockKernelModules = mkDefault false;

    protectKernelImage = mkDefault true;

    #don't want a performance hit
    allowSimultaneousMultithreading = mkDefault true;

    forcePageTableIsolation = mkDefault true;

    # This is required by podman to run containers in rootless mode and steam to launch;
    unprivilegedUsernsClone = mkDefault (
      config.virtualisation.containers.enable || config.programs.steam.enable
    );

    virtualisation.flushL1DataCache = mkDefault "always";

    apparmor.enable = mkDefault true;
    apparmor.killUnconfinedConfinables = mkDefault true;
  };

  boot = {
    kernelParams = [
      # Don't merge slabs
      "slab_nomerge"

      # Overwrite free'd pages
      "page_poison=1"

      # Enable page allocator randomization
      "page_alloc.shuffle=1"

      # Disable debugfs
      "debugfs=off"
    ];

    blacklistedKernelModules = [
      # Obscure network protocols
      "ax25"
      "netrom"
      "rose"

      # Old or rare or insufficiently audited filesystems
      "adfs"
      "affs"
      "bfs"
      "befs"
      "cramfs"
      "efs"
      "erofs"
      "exofs"
      "freevxfs"
      "f2fs"
      "hfs"
      "hpfs"
      "jfs"
      "minix"
      "nilfs2"
      "ntfs"
      "omfs"
      "qnx4"
      "qnx6"
      "sysv"
      "ufs"
    ];

    # Hide kptrs even for processes with CAP_SYSLOG
    kernel.sysctl = {
      "kernel.kptr_restrict" = lib.mkOverride 500 2;

      # Disable bpf() JIT (to eliminate spray attacks)
      "net.core.bpf_jit_enable" = mkDefault false;

      # Disable ftrace debugging
      "kernel.ftrace_enabled" = mkDefault false;

      # Enable strict reverse path filtering (that is, do not attempt to route
      # packets that "obviously" do not belong to the iface's network; dropped
      # packets are logged as martians).
      "net.ipv4.conf.all.log_martians" = mkDefault true;
      "net.ipv4.conf.all.rp_filter" = mkDefault "1";
      "net.ipv4.conf.default.log_martians" = mkDefault true;
      "net.ipv4.conf.default.rp_filter" = mkDefault "1";

      # Ignore broadcast ICMP (mitigate SMURF)
      "net.ipv4.icmp_echo_ignore_broadcasts" = mkDefault true;

      # Ignore incoming ICMP redirects (note: default is needed to ensure that the
      # setting is applied to interfaces added after the sysctls are set)
      "net.ipv4.conf.all.accept_redirects" = mkDefault false;
      "net.ipv4.conf.all.secure_redirects" = mkDefault false;
      "net.ipv4.conf.default.accept_redirects" = mkDefault false;
      "net.ipv4.conf.default.secure_redirects" = mkDefault false;
      "net.ipv6.conf.all.accept_redirects" = mkDefault false;
      "net.ipv6.conf.default.accept_redirects" = mkDefault false;

      # Ignore outgoing ICMP redirects (this is ipv4 only)
      "net.ipv4.conf.all.send_redirects" = mkDefault false;
      "net.ipv4.conf.default.send_redirects" = mkDefault false;
    };
  };
}
