-- Vitest adapter for neotest.
--
-- Defaults handle discovery: the vitest binary comes from the nearest
-- node_modules/.bin, the config from vitest.config.*/vite.config.*, and the
-- root/cwd from the nearest package.json (so each workspace package in a
-- monorepo runs on its own).

local has_vitest_cache = {}

--- Whether the nearest package.json above `path` declares vitest as a dependency.
---@param path string
---@return boolean
local function has_vitest(path)
  local lib = require("neotest.lib")
  local root = lib.files.match_root_pattern("package.json")(path)

  if not root then
    return false
  end

  if has_vitest_cache[root] ~= nil then
    return has_vitest_cache[root]
  end

  local found = false
  local read_ok, content = pcall(lib.files.read, root .. "/package.json")

  if read_ok then
    local parse_ok, pkg = pcall(vim.json.decode, content)

    if parse_ok and type(pkg) == "table" then
      for _, field in ipairs({ "dependencies", "devDependencies" }) do
        if type(pkg[field]) == "table" and pkg[field].vitest then
          found = true
          break
        end
      end
    end
  end

  has_vitest_cache[root] = found
  return found
end

return {
  { "marilari88/neotest-vitest" },

  {
    "nvim-neotest/neotest",
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}

      table.insert(
        opts.adapters,
        require("neotest-vitest")({
          -- Claim a file only in packages that actually depend on vitest, so
          -- jest projects stay with neotest-jest instead of both adapters
          -- fighting over the same *.test.ts.
          is_test_file = function(file)
            return file ~= nil
              and file:match("%.[cm]?[jt]sx?$") ~= nil
              and (file:match("%.test%.") ~= nil or file:match("%.spec%.") ~= nil)
              and has_vitest(file)
          end,

          filter_dir = function(name)
            return name ~= "node_modules" and name ~= "dist" and name ~= "tests-output"
          end,
        })
      )
    end,
  },
}
