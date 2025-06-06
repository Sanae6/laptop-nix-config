{pkgs, ...}: let
  runtimeLibs = with pkgs;
    [
      libGL
      libGLU
      libevent
      libffi
      libjpeg
      libpng
      libstartup_notification
      libvpx
      libwebp
      stdenv.cc.cc
      fontconfig
      libxkbcommon
      zlib
      freetype
      gtk3
      libxml2
      dbus
      xcb-util-cursor
      alsa-lib
      libpulseaudio
      pango
      atk
      cairo
      gdk-pixbuf
      glib
      udev
      libva
      mesa
      libnotify
      cups
      pciutils
      ffmpeg
      libglvnd
      pipewire
    ]
    ++ (with pkgs.xorg; [
      libxcb
      libX11
      libXcursor
      libXrandr
      libXi
      libXext
      libXcomposite
      libXdamage
      libXfixes
      libXScrnSaver
    ]);
in
  pkgs.stdenv.mkDerivation rec {
    system = "x86_64-linux";
    version = "1.11.5b";
    pname = "zen-browser";

    src = builtins.fetchTarball {
      url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-x86_64.tar.xz";
      sha256 = "sha256:1p3g4w6i3lx9s864y6jhdmw9i8g9dn46jg559k7l7kslkpqv8k9a";
    };

    desktopSrc = ./.;

    phases = ["installPhase" "fixupPhase"];

    nativeBuildInputs = [pkgs.makeWrapper pkgs.copyDesktopItems pkgs.wrapGAppsHook];

    installPhase = "  mkdir -p $out/bin && cp -r $src/* $out/bin\n  install -D $desktopSrc/zen.desktop $out/share/applications/zen.desktop\n  install -D $src/browser/chrome/icons/default/default128.png $out/share/icons/hicolor/128x128/apps/zen.png\n";

    fixupPhase = ''
      chmod 755 $out/bin/*
      patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/zen
      wrapProgram $out/bin/zen --set LD_LIBRARY_PATH "${
        pkgs.lib.makeLibraryPath runtimeLibs
      }" \
                      --set MOZ_LEGACY_PROFILES 1 --set MOZ_ALLOW_DOWNGRADE 1 --set MOZ_APP_LAUNCHER zen --prefix XDG_DATA_DIRS : "$GSETTINGS_SCHEMAS_PATH"
      patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/zen-bin
      wrapProgram $out/bin/zen-bin --set LD_LIBRARY_PATH "${
        pkgs.lib.makeLibraryPath runtimeLibs
      }" \
                      --set MOZ_LEGACY_PROFILES 1 --set MOZ_ALLOW_DOWNGRADE 1 --set MOZ_APP_LAUNCHER zen --prefix XDG_DATA_DIRS : "$GSETTINGS_SCHEMAS_PATH"
      patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/glxtest
      wrapProgram $out/bin/glxtest --set LD_LIBRARY_PATH "${
        pkgs.lib.makeLibraryPath runtimeLibs
      }"
      patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/updater
      wrapProgram $out/bin/updater --set LD_LIBRARY_PATH "${
        pkgs.lib.makeLibraryPath runtimeLibs
      }"
      patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/vaapitest
      wrapProgram $out/bin/vaapitest --set LD_LIBRARY_PATH "${
        pkgs.lib.makeLibraryPath runtimeLibs
      }"
    '';

    meta.mainProgram = "zen";
  }
