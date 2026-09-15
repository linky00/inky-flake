{
  lib,
  stdenv,
  fetchzip,
  fetchurl,
  autoPatchelfHook,
  makeWrapper,
  makeDesktopItem,
  copyDesktopItems,
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
  libglvnd,
  libnotify,
  libsecret,
  mesa,
  nspr,
  nss,
  openssl,
  pango,
  pipewire,
  systemd,
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

  icon = fetchurl {
    url = "https://raw.githubusercontent.com/inkle/inky/${finalAttrs.version}/resources/Icon1024.png";
    hash = "sha256-EUl8CtnR46XV8KQCk/o//Z/J7RTvH3A1GNR0eSNvMEw=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
    copyDesktopItems
  ];

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

  runtimeDependencies = [
    icu
    libglvnd
    libnotify
    libsecret
    openssl
    pipewire
    (lib.getLib systemd)
    zlib
  ];

  desktopItems = [
    (makeDesktopItem {
      name = "inky";
      exec = "inky %F";
      icon = "inky";
      desktopName = "Inky";
      comment = "Editor for ink, inkle's narrative scripting language";
      categories = [
        "Development"
        "TextEditor"
      ];
    })
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/inky $out/bin
    cp -r . $out/share/inky
    chmod -R u+w $out/share/inky

    makeWrapper $out/share/inky/Inky $out/bin/inky \
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}}"

    install -Dm644 $icon $out/share/icons/hicolor/1024x1024/apps/inky.png

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
