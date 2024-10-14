local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local config = require('telescope.config').values
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local previewers = require('telescope.previewers')

local log = require("plenary.log"):new()
log.level = 'debug'

local M = {}

M.obsl = function(opts)
  opts = opts or {}

  pickers.new(opts, {

    layout_strategy = "vertical",
    prompt_prefix = "[[?]] ",
    initial_mode = "insert",

    finder = finders.new_async_job({
      command_generator = function()
        return {
          "find", ".", "!", "-path", "*/.trash/*", "-a", "!", "-path", "*/admin/*", "-a", "-name", "*.md", "-type", "f"
        }
      end,

      entry_maker = function (entry)
        return {
          value = entry,
          display = entry,
          ordinal = entry
        }
      end
    }),

    sorter = config.generic_sorter(opts),

    previewer = previewers.new_buffer_previewer({
      title = "File Preview",
      define_preview = function(self, entry)
        config.buffer_previewer_maker(entry.value, self.state.bufnr, {
          bufname = self.state.bufname,
          winid = self.state.winid,
          preview = opts.preview,
          file_encoding = opts.file_encoding,
        })
      end,
    }),

    attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = '[[' .. action_state.get_selected_entry().value .. ']] '
          actions.close(prompt_bufnr)
          local lnum = vim.api.nvim_win_get_cursor(0)[1]
          local col = vim.api.nvim_win_get_cursor(0)[2]
          local line = vim.api.nvim_get_current_line()
          local nline = line:sub(0, col) .. selection .. line:sub(col + 1)
          vim.api.nvim_set_current_line(nline)
          vim.api.nvim_win_set_cursor(0, {lnum, #selection+col})
        end)
      return true
    end,

  }):find()

end

vim.keymap.set('i', '<C-l>', function() require("obsidian_link").obsl() end, { noremap = true, silent = true })

return M

