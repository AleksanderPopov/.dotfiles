for _, mappings in pairs(
    {
        {"n", "<c-w>", ":w<cr>"},
        {"n", "<C-q>", "ZZ"}, -- write and exit from current buffer
        {"n", "Y", "y$"}, -- do Y to yank till the end of the line
        -- split and navigate to it
        {"n", "<shift><up>", ":bn"},
        {"n", "<shift><down>", ":bp"},
        {"n", "<leader>-", ":split | wincmd j<cr>"},
        {"n", "<leader>|", ":vsplit | wincmd l<cr>"},
        {"n", "<leader>rr", ":lua reload()<cr>"}, -- reload config
        {"n", "zl", "zo"}, -- remap zl back to zo
        -- replace selected
        {"n", "R", ":%s///g<left><left>"},
        {"i", "{<CR>", "{<CR>}<ESC>O", {noremap = true}},
        {"n", "Q", "q:"},
    }
) do
    local mode = mappings[1]
    local key = mappings[2]
    local value = mappings[3]
    local options = mappings[4]
    map(mode, key, value, options)
end
