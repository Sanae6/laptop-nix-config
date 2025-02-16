{pkgs, ...}: let
  system = pkgs.system;
  extensions =
    (import (builtins.fetchGit {
      url = "https://github.com/nix-community/nix-vscode-extensions";
      ref = "refs/heads/master";
      rev = "370af219cf4ad7660e3ad4577849fb0478edb33c";
    }))
    .extensions
    .${system};
  vscodeExtensions = with pkgs;
  with extensions.vscode-marketplace; [
    trag1c.gleam-theme
    rust-lang.rust-analyzer
    arrterian.nix-env-selector
    bbenoist.nix
    vscodevim.vim
    tamasfe.even-better-toml
    mtxr.sqltools
    mtxr.sqltools-driver-sqlite
    thenuprojectcontributors.vscode-nushell-lang
    vscode-icons-team.vscode-icons
    mkhl.direnv
    mkornelsen.vscode-arm64
    vscode-extensions.ms-vscode.cpptools-extension-pack
    vscode-extensions.llvm-vs-code-extensions.vscode-clangd
    svelte.svelte-vscode
    ms-vscode.cmake-tools
    ms-dotnettools.vscode-dotnet-runtime
    vscode-extensions.ms-dotnettools.csharp
    vscode-extensions.ms-dotnettools.csdevkit
    visualstudiotoolsforunity.vstuc
    surendrajat.apklab
    loyieking.smalise
  ];
in {
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    comic-mono
  ];

  environment.systemPackages = with pkgs;
  with import ../packages pkgs; [
    neovim
    python3
    unzip
    ripgrep
    gitkraken
    lua51Packages.lua
    lua51Packages.luarocks
    clang
    mako
    wl-clipboard
    wget
    wezterm
    git
    vesktop
    pnpm
    kdePackages.plasma-systemmonitor
    shutter
    direnv
    killall
    llvmPackages_19.clang-unwrapped
    neofetch
    avalonia-ilspy
    obsidian
    libreoffice-still
    vlc
    zen-browser
    bruno
    chromium
    nmap
    nixos-rebuild
    fusee-nano
    ghidra-bin
    jetbrains.clion
    jetbrains.idea-ultimate
    obs-studio
    tea
    miniserve
    remmina
    prismlauncher
    unstable.dotnetCorePackages.dotnet_9.sdk
    unstable.jetbrains.rider
    libfaketime
    unityhub
    kdePackages.kcalc
    material-maker
    blender
    jdk23
    ryujinx
    pinta
    gh
    renderdoc
    rclone
    digital
    nodejs

    (builtins.getFlake "github:Sanae6/010editor-flake").packages."${system}".default
    (vscode-with-extensions.override {inherit vscodeExtensions;})
  ];
}
