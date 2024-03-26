{ config, pkgs, stdenv, slstatus, ... }:
stdenv.mkDerivation rec {
  pname = "slstatus";
  version = "1.0";

  src = slstatus;

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ libX11 libXau libXdmcp ];

  installFlags = [ "PREFIX=$(out)" ];


  postPatch = let configFile = ./config.h;
  in ''
    cp ${configFile} config.def.h;
  '';

  meta = with lib; {
    homepage = "https://tools.suckless.org/slstatus/";
    description =
      "status monitor for window managers that use WM_NAME like dwm";
    license = licenses.isc;
    maintainers = with maintainers; [ oxzi ];
    platforms = platforms.linux;
  };
}
