{ lib, ... }:
let
  helpers = lib.nixvim;
  config = {
    plugins.snacks.enable = true;
    plugins.snacks.settings = {
      input.enabled = true;
      terminal.enabled = true;
      notifier = {
        top_down = true;
      };
      picker.enabled = true;
    };


    ### terminal ###
    userCommands.Colorize = {
      command = helpers.mkRaw '' function () Snacks.terminal.colorize() end '';
      desc = "Colorize the current terminal";
    };


    ### notifier ###
    extraConfigLuaPre = ''
      local progress = vim.defaulttable()
    '';

    autoCmd = [
      {
        event = "LspProgress";
        callback = helpers.mkRaw ''
          function(ev)
              local client = vim.lsp.get_client_by_id(ev.data.client_id)
              local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
              if not client or type(value) ~= "table" then
                return
              end
              local p = progress[client.id]

              for i = 1, #p + 1 do
                if i == #p + 1 or p[i].token == ev.data.params.token then
                  p[i] = {
                    token = ev.data.params.token,
                    msg = ("[%3d%%] %s%s"):format(
                      value.kind == "end" and 100 or value.percentage or 100,
                      value.title or "",
                      value.message and (" **%s**"):format(value.message) or ""
                    ),
                    done = value.kind == "end",
                  }
                  break
                end
              end

              local msg = {} ---@type string[]
              progress[client.id] = vim.tbl_filter(function(v)
                return table.insert(msg, v.msg) or not v.done
              end, p)

              local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
              vim.notify(table.concat(msg, "\n"), "info", {
                id = "lsp_progress",
                title = client.name,
                opts = function(notif)
                  notif.icon = #progress[client.id] == 0 and " "
                    or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
                end,
              })
            end
        '';
      }
    ];
  };
  terminalKeymaps = [
      {
        key = "<leader>t";
        action = helpers.mkRaw ''
          function () Snacks.terminal.toggle() end
        '';
        options = {
          silent = true;
          desc = "Open a terminal with split view";
        };
      }
      {
        key = "<leader>T";
        action = helpers.mkRaw ''
          function () 
            vim.ui.input({ prompt = 'Cmd: ', completion = 'shellcmdline' }, function (input) 
              Snacks.terminal.toggle(input, { auto_close = false })
            end) 
          end
        '';
        options = {
          silent = true;
          desc = "Open a floating terminal with a command";
        };
      }
      {
        key = "<C-x>";
        mode = "t";
        action = "<C-\\><C-n>";
        options = {
          noremap = true;
          desc = "Exit out of terminal mode";
        };
      }
    ];
    pickerKeymaps = [
      {
        key = "<leader><Space>";
        action = helpers.mkRaw '' function () Snacks.picker.smart() end '';
        options = {
          silent = true;
          desc = "Smart find files";
        };
      }
      {
        key = "<leader>/";
        action = helpers.mkRaw '' function () Snacks.picker.grep() end '';
        options = {
          silent = true;
          desc = "Grep search files";
        };
      }
      {
        key = "<leader>ff";
        action = helpers.mkRaw '' function () Snacks.picker.files() end '';
        options = {
          silent = true;
          desc = "Find files";
        };
      }
      {
        key = "gd";
        action = helpers.mkRaw '' function () Snacks.picker.lsp_definitions() end '';
        options = {
          silent = true;
          desc = "Goto Definition";
        };
      }
      {
        key = "gD";
        action = helpers.mkRaw '' function () Snacks.picker.lsp_declarations() end '';
        options = {
          silent = true;
          desc = "Goto Declaration";
        };
      }
      {
        key = "gr";
        action = helpers.mkRaw '' function () Snacks.picker.lsp_references() end '';
        options = {
          silent = true;
          desc = "Goto References";
        };
      }
      {
        key = "gt";
        action = helpers.mkRaw '' function () Snacks.picker.lsp_type_definitions() end '';
        options = {
          silent = true;
          desc = "Goto Type definition";
        };
      }
    ];
in
config // {
  keymaps = terminalKeymaps ++ pickerKeymaps;
}
