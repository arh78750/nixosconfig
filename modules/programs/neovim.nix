{config, pkgs, ... }:
{

  # Config information https://gist.github.com/nat-418/d76586da7a5d113ab90578ed56069509
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    coc.enable = false;

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      nvim-treesitter-parsers.nix
      plenary-nvim
      gruvbox-material
      mini-nvim
    ];
  };
}
