
return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add = { text = "┃" },
                change = { text = "┃" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },

            current_line_blame = false,

            on_attach = function(bufnr)
                local gs = require("gitsigns")

                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, {
                        buffer = bufnr,
                        desc = desc,
                        silent = true,
                    })
                end

                -- Navigate between changed sections
                map("n", "]c", gs.nav_hunk, "Next hunk")
                map("n", "[c", function()
                    gs.nav_hunk("prev")
                end, "Previous hunk")

                -- Hunk actions
                map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
                map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
                map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
                map("n", "<leader>hb", gs.blame_line, "Blame line")

                -- Toggle inline Git blame
                map("n", "<leader>tb", gs.toggle_current_line_blame,
                    "Toggle line blame")

                -- Select a hunk as a text object
                map({ "o", "x" }, "ih", gs.select_hunk, "Select hunk")
            end,
        },
    },
}

