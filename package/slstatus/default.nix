{ pkgs, stdenv, lib, slstatus-src, ... }:
stdenv.mkDerivation rec {
  pname = "slstatus";
  version = "1.0";

  src = slstatus-src;

  preBuild = let configFile = ./config.h;
  in ''
    cp ${configFile} config.def.h
    makeFlagsArray+=(LDLIBS="-lX11 -lxcb -lXau -lXdmcp" CC=$CC)
  '';

  nativeBuildInputs = with pkgs; [ pkg-config ];
  buildInputs = with pkgs.xorg; [ libX11 libXau libXdmcp ];

  installFlags = [ "PREFIX=$(out)" ];

  meta = with lib; {
    homepage = "https://tools.suckless.org/slstatus/";
    description =
      "status monitor for window managers that use WM_NAME like dwm";
    license = licenses.isc;
    maintainers = with maintainers; [ oxzi ];
    platforms = platforms.linux;
    mainProgram = "slstatus";
  };
}
