local neogit = require('neogit')

neogit.setup({
    disable_signs = false,
    disable_context_highlighting = false,
    disable_commit_confirmation = false,

    -- customize displayed signs
    signs = {
        -- { CLOSED, OPENED }
        section = { "", "" },
        item = { "", "" },
        hunk = { "", "" },
    },
    integrations = { diffview = true }
})
