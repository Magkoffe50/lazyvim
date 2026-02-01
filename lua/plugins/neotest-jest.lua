return {
  { "nvim-neotest/neotest-jest" },

  {
    "nvim-neotest/neotest",
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}

      table.insert(
        opts.adapters,
        require("neotest-jest")({
          -- choose the one you use:
          jestCommand = "pnpm test --",
          -- jestCommand = "yarn test --",
          -- jestCommand = "npm test --",

          -- Monorepo-aware: pick package root based on file path
          cwd = function(file)
            -- matches ".../packages/<pkg>/" and returns that directory
            local pkg = file and file:match("(.*/packages/[^/]+/)")
            return pkg or vim.fn.getcwd()
          end,

          -- Monorepo-aware: pick jest config inside that package
          jestConfigFile = function(file)
            local pkg = file and file:match("(.*/packages/[^/]+/)")
            if pkg then
              return pkg .. "jest.config.ts" -- change to jest.config.js if needed
            end
            return vim.fn.getcwd() .. "/jest.config.ts"
          end,
        })
      )
    end,
  },
}
