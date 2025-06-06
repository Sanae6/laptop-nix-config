{
  pkgs,
  _010editor,
  extensions,
  ...
}: let
  system = pkgs.system;
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
    visualstudiotoolsforunity.vstuc
    surendrajat.apklab
    loyieking.smalise
    denoland.vscode-deno
    pbkit.vscode-pbkit
    ms-python.python
    haskell.haskell
    justusadam.language-haskell
    baincd.stretchy-spaces-baincd
    ocamllabs.ocaml-platform
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
    obs-studio
    tea
    miniserve
    remmina
    prismlauncher
    unstable.dotnetCorePackages.dotnet_9.sdk
    unstable.jetbrains.rider
    unstable.jetbrains.clion
    unstable.jetbrains.idea-community
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
    file
    rsync
    binwalk
    qpwgraph
    dig
    signal-desktop
    _010editor
    OVMFFull
    gdb

    (unstable.discord-canary.override {withVencord = true;})
    (unstable.vscode-with-extensions.override {inherit vscodeExtensions;})
  ];
}
