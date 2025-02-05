return {
  {
    'jez/vim-better-sml',
    ft = 'sml', -- Lazy load only for SML files
    init = function()
      -- Filetype detection
      vim.g.sml_auto_create_def_use = 1
      vim.g.sml_mlton_flags = '-prefer-abs-paths true -stop tc'
      vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
        pattern = { '*.fun', '*.sig' },
        command = 'set filetype=sml',
      })

      -- Keybindings configuration
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'sml',
        callback = function()
          -- Traditional LSP-style keybindings
          local opts = { buffer = true, silent = true }

          -- Goto definition (same as LSP)
          vim.keymap.set('n', 'gd', '<cmd>SMLJumpToDef<CR>', opts)

          -- Type information (like LSP hover)
          vim.keymap.set('n', 'K', '<cmd>SMLTypeQuery<CR>', opts)

          -- REPL management (mnemonic bindings)
          vim.keymap.set('n', '<leader>lr', '<cmd>SMLReplStart<CR>', opts) -- Language REPL
          vim.keymap.set('n', '<leader>lq', '<cmd>SMLReplStop<CR>', opts) -- Quit REPL
          vim.keymap.set('n', '<leader>lb', '<cmd>SMLReplBuild<CR>', opts) -- Build
          vim.keymap.set('n', '<leader>lu', '<cmd>SMLReplUse<CR>', opts) -- Use file

          -- Optional: Enable conceal characters
          -- vim.opt_local.conceallevel = 2
        end,
      })
    end,
  },
}
