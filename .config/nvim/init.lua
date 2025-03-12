_G.dd = function(...)
    Snacks.debug.inspect(...)
end

_G.bt = function()
    Snacks.debug.backtrace()
end

_G.print = _G.dd

vim.print = _G.dd

require("nobilissimum.utils")

require("nobilissimum.globals")
require("nobilissimum.options")
require("nobilissimum.manager")
