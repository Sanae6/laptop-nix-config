#!/usr/bin/env nu
def "get hostname" [hostname?: string] { $hostname | default (hostname) };
def --wrapped rebuild [subcmd: string, hostname: string, ...rest] {
  nix fmt
  git add -A # make sure the goddamn files are added because nix stores won't include unchecked files
  if $hostname == (hostname) {
    sudo nixos-rebuild --flake $".#(hostname)" --impure $subcmd ...$rest
  } else {
    let r = echo ...$rest | into string;
    nix-shell -p nixos-rebuild --command $"nixos-rebuild --flake .#($hostname) --target-host ($hostname) --use-remote-sudo ($subcmd) ($r)";
  }
};

def --wrapped "main switch" [
  --hostname (-h): string, # the hostname of the machine to push to
  ...rest
] {
  let hostname = (get hostname $hostname);
  rebuild switch $hostname ...$rest
}

def --wrapped "main boot" [
  --restart (-r) # restart after building
  --hostname (-h): string, # the hostname of the machine to push to
  ...rest
] {
  let hostname = (get hostname $hostname);
  rebuild boot $hostname ...$rest
  if $restart {
    ssh $hostname -t "sudo reboot now"
  }
}

def main [] {
  main switch -h (hostname)
}
