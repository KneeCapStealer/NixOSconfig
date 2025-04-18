{ lib, ... }:
let
  helpers = lib.nixvim;
in
{
  plugins.mini = {
    enable = true;
    mockDevIcons = true;

    modules = {
      basics = { };

      ai = { };
      pairs = { };
      snippets = { };
      git = { };

      icons = { };
      animate = { };
      statusline = { };
      indentscope = { };
      starter = {
        content_hooks = {
          "__unkeyed-1.adding_bullet" = helpers.mkRaw "require('mini.starter').gen_hook.adding_bullet()";

          "__unkeyed-2.indexing" =
            helpers.mkRaw "require('mini.starter').gen_hook.indexing('all', { 'Builtin actions' })";

          "__unkeyed-3.padding" =
            helpers.mkRaw "require('mini.starter').gen_hook.aligning('center', 'center')";
        };
        evaluate_single = true;
        header = ''
          ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗
          ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║
          ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║
          ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║
          ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
        '';
        items = {
          "__unkeyed-1.buildtin_actions" = helpers.mkRaw "require('mini.starter').sections.builtin_actions()";

          "__unkeyed-2.recent_files_current_directory" =
            helpers.mkRaw "require('mini.starter').sections.recent_files(10, false)";

          "__unkeyed-3.recent_files" =
            helpers.mkRaw "require('mini.starter').sections.recent_files(10, true)";

          "__unkeyed-4.sessions" = helpers.mkRaw "require('mini.starter').sections.sessions(5, true)";
        };
      };
    };
  };
}
