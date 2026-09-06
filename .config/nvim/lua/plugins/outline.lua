return {
    "hedyhli/outline.nvim",
    config = function()
        require("outline").setup({
            -- Your setup opts here (leave empty to use defaults)
        })

        -- Example mapping to toggle outline
        vim.keymap.set("n", "<D-o>", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
    end,
}
