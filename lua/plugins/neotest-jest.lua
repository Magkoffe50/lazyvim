-- Jest adapter for neotest.
--
-- The adapter's own defaults are correct for this machine's jest projects, so
-- nothing is overridden here:
--   * command  -> nearest node_modules/.bin/jest (falls back to `jest` on PATH)
--   * config   -> jest.config.{js,ts} when present, otherwise the "jest" key
--                 in package.json (which is how ~/frontend/creative is set up)
--   * root/cwd -> nearest package.json
--   * a file is only claimed when that package.json actually declares `jest`,
--     so vitest packages are left to neotest-vitest.
return {
  { "nvim-neotest/neotest-jest" },

  {
    "nvim-neotest/neotest",
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      table.insert(opts.adapters, require("neotest-jest")({}))
    end,
  },
}
