return {
  {
    "rebelot/heirline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
    config = function()
      local conditions = require("heirline.conditions")
      local utils = require("heirline.utils")
      local heirline = require("heirline")

      local colors = {
        bright_bg = utils.get_highlight("Folded").bg,
        bright_fg = utils.get_highlight("Folded").fg,
        red = utils.get_highlight("DiagnosticError").fg,
        dark_red = utils.get_highlight("DiffDelete").bg,
        green = utils.get_highlight("String").fg,
        blue = utils.get_highlight("Function").fg,
        gray = utils.get_highlight("NonText").fg,
        orange = utils.get_highlight("Constant").fg,
        purple = utils.get_highlight("Statement").fg,
        cyan = utils.get_highlight("Special").fg,
        diag_warn = utils.get_highlight("DiagnosticWarn").fg,
        diag_error = utils.get_highlight("DiagnosticError").fg,
        diag_hint = utils.get_highlight("DiagnosticHint").fg,
        diag_info = utils.get_highlight("DiagnosticInfo").fg,
        git_del = utils.get_highlight("diffDeleted").fg,
        git_add = utils.get_highlight("diffAdded").fg,
        git_change = utils.get_highlight("diffChanged").fg,
      }

      heirline.load_colors(colors)

      ---@class StatusLineConfigItem
      ---@field condition? fun(self: StatusLine): any
      ---@field init? fun(self: StatusLine): any
      ---@field provider? string|number|fun(self: StatusLine):string|number|nil
      ---@field hl? HeirlineHighlight|string|fun(self: StatusLine): HeirlineHighlight|string|nil  controls the colors of what is printed by the component's provider, or by any of its descendants.
      ---@field restrict? table<string, boolean>
      ---@field after? fun(self: StatusLine): any
      ---@field update? table|string|fun(self: StatusLine): boolean
      ---@field on_click? HeirlineOnClickCallback|HeirlineOnClick

      ---@alias StatusLineConfig StatusLineConfigItem | StatusLineConfigItem[]

      ---@type StatusLineConfig
      local ViMode = {
        init = function(self)
          self.mode = vim.fn.mode(1)
        end,

        static = {
          mode_names = { -- change the strings if you like it vvvvverbose!
            n = "N",
            no = "N?",
            nov = "N?",
            noV = "N?",
            ["no\22"] = "N?",
            niI = "Ni",
            niR = "Nr",
            niV = "Nv",
            nt = "Nt",
            v = "V",
            vs = "Vs",
            V = "V_",
            Vs = "Vs",
            ["\22"] = "^V",
            ["\22s"] = "^V",
            s = "S",
            S = "S_",
            ["\19"] = "^S",
            i = "I",
            ic = "Ic",
            ix = "Ix",
            R = "R",
            Rc = "Rc",
            Rx = "Rx",
            Rv = "Rv",
            Rvc = "Rv",
            Rvx = "Rv",
            c = "C",
            cv = "Ex",
            r = "...",
            rm = "M",
            ["r?"] = "?",
            ["!"] = "!",
            t = "T",
          },
          mode_colors = {
            n = "red",
            i = "green",
            v = "cyan",
            V = "cyan",
            ["\22"] = "cyan",
            c = "orange",
            s = "purple",
            S = "purple",
            ["\19"] = "purple",
            R = "orange",
            r = "orange",
            ["!"] = "red",
            t = "red",
          }
        },

        provider = function(self)
          return " %2(" .. self.mode_names[self.mode] .. "%)"
        end,
        hl = function(self)
          local mode = self.mode:sub(1, 1)
          return { fg = self.mode_colors[mode], bold = true, }
        end,
        update = {
          "ModeChanged",
          pattern = "*:*",
          callback = vim.schedule_wrap(function()
            vim.cmd("redrawstatus")
          end)
        }
      }

      ---@type StatusLineConfig
      local FileNameBlock = {
        init = function(self)
          self.filename = vim.api.nvim_buf_get_name(0)
        end,
      }

      ---@type StatusLineConfig
      local FileIcon = {
        init = function(self)
          local filename = self.filename
          local extension = vim.fn.fnamemodify(filename, ":e")
          self.icon, self.icon_color =
              require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
        end,
        provider = function(self)
          return self.icon and (self.icon .. " ")
        end,
        hl = function(self)
          return { fg = self.icon_color }
        end,
      }

      ---@type StatusLineConfig
      local FileName = {
        provider = function(self)
          local filename = vim.fn.fnamemodify(self.filename, ":.")
          if filename == "" then return "[No Name]" end
          if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
          end
          return filename
        end,
        hl = { fg = utils.get_highlight("Directory").fg },
      }

      ---@type StatusLineConfig
      local FileFlags = {
        {
          condition = function()
            return vim.bo.modified
          end,
          provider = "[+]",
          hl = { fg = "green" },
        },
        {
          condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
          end,
          provider = "",
          hl = { fg = "orange" },
        },
      }

      ---@type StatusLineConfig
      local TablineBufnr = {
        provider = function(self)
          return tostring(self.bufnr) .. '. '
        end,
        hl = "Comment",
      }

      ---@type StatusLineConfig
      local TablineFileName = {
        provider = function(self)
          local filename = self.filename
          filename = filename == "" and "[no name]" or vim.fn.fnamemodify(filename, ":t")
          return filename
        end,
        hl = function(self)
          return { bold = self.is_active or self.is_visible, italic = true }
        end
      }

      ---@type StatusLineConfig
      local TablineFileFlags = {
        {
          condition = function(self)
            return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
          end,
          provider = "[+]",
          hl = { fg = "green" },
        },
        {
          condition = function(self)
            return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
                or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
          end,
          provider = function(self)
            if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
              return "  "
            else
              return ""
            end
          end,
          hl = { fg = "orange" },
        },
      }

      ---@type StatusLineConfig
      local TablineFileNameBlock = {
        init = function(self)
          self.filename = vim.api.nvim_buf_get_name(self.bufnr)
        end,
        hl = function(self)
          if self.is_active then
            return "tabLineSel"
          else
            return "TabLine"
          end
        end,
        on_click = {
          callback = function(_, minwid, _, button)
            if (button == "m") then
              vim.schedule(function()
                vim.api.nvim_buf_delete(minwid, { force = false })
              end)
            else
              vim.api.nvim_win_set_buf(0, minwid)
            end
          end,
          minwid = function(self)
            return self.bufnr
          end,
          name = "heirline_tabline_buffer_callback",
        },
        TablineBufnr,
        FileIcon,
        TablineFileName,
        TablineFileFlags,
      }

      ---@type StatusLineConfig
      local TablineCloseButton = {
        condition = function(self)
          return not vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
        end,
        {
          provider = " "
        },
        {
          provider = "",
          hl = { fg = "gray" },
          on_click = {
            callback = function(_, minwid)
              vim.schedule(function()
                vim.api.nvim_buf_delete(minwid, { force = false })
                vim.cmd.redrawtabline()
              end)
            end,
            minwid = function(self)
              return self.bufnr
            end,
            name = "heirline_tabline_close_buffer_callback"
          }
        },
      }

      local TablineBufferBlock = utils.surround({ "", "" }, function(self)
        if self.is_active then
          return utils.get_highlight("tabLineSel").bg
        else
          return utils.get_highlight("TabLine").bg
        end
      end, { TablineFileNameBlock, TablineCloseButton })

      local get_bufs = function()
        return vim.tbl_filter(function(bufnr)
          return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
        end, vim.api.nvim_list_bufs())
      end

      local buflist_cache = {}

      vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            local buffers = get_bufs()
            for i, v in ipairs(buffers) do
              buflist_cache[i] = v
            end
            for i = #buffers + 1, #buflist_cache do
              buflist_cache[i] = nil
            end

            if #buflist_cache > 1 then
              vim.o.showtabline = 2
            elseif vim.o.showtabline ~= 1 then
              vim.o.showtabline = 1
            end
          end)
        end
      })


      ---@type StatusLineConfig
      local TablinePicker = {
        condition = function(self)
          return self._show_picker
        end,
        init = function(self)
          local bufname = vim.api.nvim_buf_get_name(self.bufnr)
          bufname = vim.fn.fnamemodify(bufname, ":t")
          local label = bufname:sub(1, 1)
          local i = 2
          while self._picker_labels[label] do
            if i > #bufname then
              break
            end
            label = bufname:sub(i, i)
            i = i + 1
          end
          self._picker_labels[label] = self.bufnr
          self.label = label
        end,
        provider = function(self)
          return self.label
        end,
        hl = { fg = "red", bold = true },
      }

      vim.keymap.set("n", "gbp", function()
        local tabline = require("heirline").tabline
        local buflist = tabline._buflist[1]
        buflist._picker_labels = {}
        buflist._show_picker = true
        vim.cmd.redrawtabline()
        local char = vim.fn.getcharstr()
        local bufnr = buflist._picker_labels[char]
        if bufnr then
          vim.api.nvim_win_set_buf(0, bufnr)
        end
        buflist._show_picker = false
        vim.cmd.redrawtabline()
      end)

      local BufferLine = utils.make_buflist({ TablinePicker, TablineBufferBlock },
        { provider = "", hl = { fg = "gray" } },
        { provider = "", hl = { fg = "gray" } },
        function()
          return buflist_cache
        end,
        false
      )

      ---@type StatusLineConfig
      local Tabpage = {
        provider = function(self)
          return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
        end,
        hl = function(self)
          if not self.is_active then
            return "TabLine"
          else
            return "tabLineSel"
          end
        end,
      }

      ---@type StatusLineConfig
      local TabpageClose = {
        provider = "%999X  %X",
        hl = "TabLine",
      }

      ---@type StatusLineConfig
      local TabPages = {
        condition = function()
          return #vim.api.nvim_list_tabpages() >= 2
        end,
        utils.make_tablist(Tabpage),
        TabpageClose,
      }

      ---@type StatusLineConfig
      local TabLineOffset = {
        condition = function(self)
          local win = vim.api.nvim_tabpage_list_wins(0)[1]
          local bufnr = vim.api.nvim_win_get_buf(win)
          self.winid = win

          if vim.bo[bufnr].filetype == "NvimTree" then
            self.title = "NvimTree"
            return true;
            -- elseif vim.bo[bufnr].filetype == "TagBar" then
            --     ...
          end
        end,
        provider = function(self)
          local title = self.title
          local width = vim.api.nvim_win_get_width(self.winid)
          local pad = math.ceil((width - #title) / 2)
          return string.rep(" ", pad) .. title .. string.rep(" ", pad)
        end,
        hl = function(self)
          if vim.api.nvim_get_current_win() == self.winid then
            return "TablineSel"
          else
            return "Tabline"
          end
        end
      }

      local TabLine = { TabLineOffset, BufferLine, TabPages }

      heirline.setup {
        tabline = TabLine,
      }

      vim.o.showtabline = 2
      vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
    end
  }
}
