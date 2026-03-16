{
  lib,
  ...
}:
let
  helpers = lib.nixvim;
in
{
  plugins.leap = {
    enable = true;
    settings = {
      preview = helpers.mkRaw ''
        function (ch0, ch1, ch2)
          return not (
            ch1:match('%s')
            or (ch0:match('%a') and ch1:match('%a') and ch2:match('%a'))
          )
        end
      '';
      equivalence_classes = [ " \t\r\n', '([{', ')]}', '\'\"`" ];
    };
    luaConfig.post = ''
      vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)', {desc = 'Leap to text'})
      vim.keymap.set('n',             'S', '<Plug>(leap-from-window)', {desc = 'Leap from window'})

      require('leap.user').set_repeat_keys('<enter>', '<backspace>')


      vim.keymap.set({'n', 'o'}, 'gs', function ()
        require('leap.remote').action {
          -- Automatically enter Visual mode when coming from Normal.
          input = vim.fn.mode(true):match('o') and "" or 'v'
        }
      end)

      -- Forced linewise version (`gS{leap}jjy`):
      vim.keymap.set({'n', 'o'}, 'gS', function ()
        require('leap.remote').action { input = 'V' }
      end)
    '';
  };
}
