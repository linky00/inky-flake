{
  lib,
  stdenv,
  fetchzip,
  autoPatchelfHook,
  alsa-lib,
  at-spi2-core,
  atk,
  cairo,
  cups,
  dbus,
  expat,
  gdk-pixbuf,
  glib,
  gtk3,
  icu,
  libdrm,
  libxkbcommon,
  mesa,
  nspr,
  nss,
  pango,
  libx11,
  libxcb,
  libxcomposite,
  libxdamage,
  libxext,
  libxfixes,
  libxrandr,
  zlib,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "inky";
  version = "0.15.2";

  src = fetchzip {
    url = "https://github.com/inkle/inky/releases/download/${finalAttrs.version}/Inky_linux.zip";
    stripRoot = false;
    hash = "sha256-Oesw09et2tJOx1O1w0FOJje6F1+o0cTyBmziTAtKgw0=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [
    alsa-lib
    at-spi2-core
    atk
    cairo
    cups
    dbus
    expat
    gdk-pixbuf
    glib
    gtk3
    icu
    libdrm
    libxkbcommon
    mesa
    nspr
    nss
    pango
    stdenv.cc.cc
    libx11
    libxcomposite
    libxdamage
    libxext
    libxfixes
    libxrandr
    libxcb
    zlib
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/inky $out/bin
    cp -r . $out/share/inky
    chmod -R u+w $out/share/inky
    ln -s $out/share/inky/Inky $out/bin/inky

    runHook postInstall
  '';

  meta = {
    description = "Editor for ink, inkle's narrative scripting language";
    homepage = "https://github.com/inkle/inky";
    license = lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    mainProgram = "inky";
  };
})
