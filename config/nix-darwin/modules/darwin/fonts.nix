{ pkgs, ... }:
{
  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.comic-shanns-mono
    pkgs.nerd-fonts.jetbrains-mono
  ];
}
