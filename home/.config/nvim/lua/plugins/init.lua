vim.cmd [[packadd packer.nvim]]
vim.cmd [[ autocmd BufWritePost **/nvim/lua/plugins/*.lua :lua reload()<cr> ]]
vim.cmd [[ autocmd BufWritePost **/nvim/lua/plugins/*.lua PackerCompile ]]

require("packer").startup({
    function()
        -- Packer can manage itself as an optional plugin
        use {"wbthomason/packer.nvim", opt = true}
        use "dstein64/vim-startuptime"
        -- text objects
        use "kana/vim-textobj-user"
        use "glts/vim-textobj-comment"
        use "kana/vim-textobj-indent"
        use "wellle/targets.vim"
        -- abbreviations, substitusion, coercion (transform case)
        use "tpope/vim-abolish"
        -- add bunch of mappings like ]p ]e ]<space> etc.
        use "tpope/vim-unimpaired"
        -- allows repeat via dot for some plugins like surround
        use "tpope/vim-repeat"
        -- add\update\remove surround stuff like '"{}"'
        use "tpope/vim-surround"
        --  shiftwidth/expandtab/etc
        use "tpope/vim-sleuth"
        -- git plugin
        use {"tpope/vim-fugitive", config = require("plugins.vim-fugitive")}
        -- auto placing paired signs like {} [] '' "" etc
        use "cohama/lexima.vim"
        -- when navigate to previously opened files - open in last file position
        use "farmergreg/vim-lastplace"
        use {"schickling/vim-bufonly", config = require("plugins.vim-bufonly")}
        use {"moll/vim-bbye", config = require("plugins.vim-bbye")}
        -- start screen
        use {"mhinz/vim-startify", config = require("plugins.vim-startify")}
        -- text object camel case word
        use {"chaoren/vim-wordmotion", config = require("plugins.vim-wordmotion")}
        -- open terminal in floating window
        use {"voldikss/vim-floaterm", config = require("plugins.vim-floaterm")}
        -- move to {motion}
        use {"svermeulen/vim-subversive", config = require("plugins.vim-subversive")}
        -- icons for lua
        use "kyazdani42/nvim-web-devicons"
        -- file tree
        use {"kyazdani42/nvim-tree.lua", config = require("plugins.nvim-tree")}
        use {"AndrewRadev/splitjoin.vim", config = require("plugins.splitjoin")}
        -- plugin for vim-tmux interactions
        use {"christoomey/vim-tmux-navigator", config = require("plugins.vim-tmux-navigator")}
        -- resizing windows
        use {"talek/obvious-resize", config = require("plugins.obvious-resize")}
        -- fzf
        use {"junegunn/fzf", run = "./install --all"}
        use {"junegunn/fzf.vim", config = require("plugins.fzf-vim")}
        -- " fzf commands for lsp sources
        use "gfanto/fzf-lsp.nvim"
        -- " find/jump definition/reference with fzf
        use {"pechorin/any-jump.vim", config = require("plugins.any-jump")}
        use {"stsewd/fzf-checkout.vim", config = require("plugins.fzf-checkout")}
        -- add commenting for different langs via gcc
        use "tpope/vim-commentary"
        -- plugin which allows vim to work with common editorconfig
        use "editorconfig/editorconfig-vim"
        -- " database viewer
        use "tpope/vim-dadbod"
        use "kristijanhusak/vim-dadbod-ui"
        -- main lsp plugin to enable servers communication
        -- top buff line
        use {"akinsho/nvim-bufferline.lua", config = require("plugins.nvim-bufferline")}
        -- statusline
        use {"glepnir/galaxyline.nvim", config = require("plugins.galaxyline-nvim")}
        -- parser
        use {"nvim-treesitter/nvim-treesitter", cmd = "TSUpdate all", config = require("plugins.nvim-treesitter")}
        -- color scheme
        use "christianchiarulli/nvcode-color-schemes.vim"
        -- lsp configs placed here
        use "neovim/nvim-lspconfig"
        -- plugin to add completeion possibility
        use {"nvim-lua/completion-nvim", config = require("plugins.completion-nvim") }
        use "steelsojka/completion-buffers"
        use {"aca/completion-tabnine", run = "version=3.1.9 ./install.sh"}
        use "tmux-plugins/vim-tmux"

      end,

    config = {
           display = {
               open_fn = require"packer.util".float
           }
       }
     }
)