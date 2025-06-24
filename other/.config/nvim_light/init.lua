-- init.lua

local vim = vim
local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

--
-- Plugins
--

-- Vim
local Plug = vim.fn["plug#"]

vim.call("plug#begin")

Plug("RRethy/base16-nvim")
Plug("itchyny/lightline.vim")
Plug("mike-hearn/base16-vim-lightline")
Plug("preservim/nerdtree")
Plug("preservim/nerdcommenter")
Plug("ctrlpvim/ctrlp.vim")
Plug("qpkorr/vim-bufkill")
Plug("mileszs/ack.vim")
Plug("christoomey/vim-tmux-navigator")
Plug("tmux-plugins/vim-tmux-focus-events")
Plug("tpope/vim-sensible")
Plug("bronson/vim-crosshairs")
Plug("udalov/kotlin-vim")
Plug("embear/vim-localvimrc")
Plug("github/copilot.vim")
Plug("rhysd/conflict-marker.vim")
Plug("neovim/nvim-lspconfig")
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-cmdline")
Plug("hrsh7th/nvim-cmp")
Plug("L3MON4D3/LuaSnip")
Plug("saadparwaiz1/cmp_luasnip")
Plug("stevearc/conform.nvim")
Plug("mfussenegger/nvim-lint")

vim.call("plug#end")

--
-- Settings
--

-- General
vim.g.loaded_matchparen = true

vim.o.autoread = true
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.o.expandtab = true
vim.o.hidden = true
vim.o.hlsearch = true
vim.o.mouse = ""
vim.o.mousescroll = "ver:0,hor:0"
vim.o.shiftwidth = 4
vim.o.showmode = false
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.termguicolors = true
--vim.o.ttimeoutlen = 0
--vim.o.updatetime = 300
vim.o.wrap = true

-- Plugins
vim.g.ackprg = "rg --vimgrep --case-sensitive --sort path"
vim.g.ctrlp_working_path_mode = "a"
vim.g.ctrlp_user_command = "ag %s --files-with-matches --nocolor --nogroup --hidden -g ''"

function LspStatus()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		return ""
	end

	local diagnostics = vim.diagnostic.get(0) -- Gets ALL diagnostics from buffer
	local errors = #vim.tbl_filter(function(d)
		return d.severity == 1
	end, diagnostics)
	local warnings = #vim.tbl_filter(function(d)
		return d.severity == 2
	end, diagnostics)

	local status = "LSP"
	if errors > 0 and warnings > 0 then
		return status .. " E" .. errors .. " W" .. warnings
	elseif errors > 0 then
		return status .. " E" .. errors
	elseif warnings > 0 then
		return status .. " W" .. warnings
	else
		return status
	end
end

vim.g.lightline = {
	colorscheme = "base16_cupertino",
	active = {
		left = {
			{ "mode" },
			{ "filename" },
		},
		right = {
			{ "lineinfo" },
			{ "percent" },
			{ "lspstatus" },
		},
	},
	component_function = {
		filename = "LightlineFilename",
		lspstatus = "v:lua.LspStatus",
	},
}
vim.g.localvimrc_sandbox = 0 -- autocmds cannot be sandboxed
vim.g.localvimrc_whitelist = {
	-- Set ft=htmldjango for all html files:
	-- autocmd BufRead,BufNewFile *.html set filetype=htmldjango
	-- /.../web/templates/web/.lvimrc
	-- /.../dongle/templates/dongle/.lvimrc
	-- etc.
	[[/.*/\(.*\)/templates/\(\1\)/.lvimrc]],
}
vim.g.NERDTreeWinSize = 33
vim.g.NERDTreeDirArrowExpandable = "▸"
vim.g.NERDTreeDirArrowCollapsible = "▾"
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeIgnore = {
	".pyc$",
	"__pycache__$",
	".git$",
	".tox$",
	".egg-info$",
	".DS_Store$",
	"\\..*cache$",
	"direnv",
	".envrc",
	"python-version",
	".vim",
}
vim.g.tmux_navigator_disable_when_zoomed = 1
vim.g.tmux_navigator_save_on_switch = 2

-- Color scheme
vim.cmd("colorscheme base16-cupertino")

-- TODO: Try converting to lua
vim.cmd([[
    function! LightlineFilename()
        return expand("%:t") !=# "" ? @% : "[No Name]"
    endfunction
]])

--
-- Autocommands
--

-- Show Coc stats in lightline
autocmd("User", {
	pattern = { "CocStatusChange", "CocDiagnosticChange" },
	command = "lightline#update()",
})

-- Remove trailing whitespace and newline
autocmd("BufWritePre", {
	pattern = { "*" },
	command = [[%s/\s\+$//e | %s/\n\+\%$//e]],
})

-- Save all on focus lost
autocmd({ "FocusLost", "BufLeave", "VimResized" }, {
	pattern = { "*" },
	command = "wa",
})

-- Set filetype for .envrc files
autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { ".envrc" },
	command = "set filetype=sh",
})

-- Disable semantic highlighting in basedpyright
autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.name == "basedpyright" then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})

--
-- Keybindings
--

-- Disable arrow keys
map("", "<up>", "<nop>", { noremap = true })
map("", "<down>", "<nop>", { noremap = true })
map("", "<left>", "<nop>", { noremap = true })
map("", "<right>", "<nop>", { noremap = true })
map("i", "<up>", "<nop>", { noremap = true })
map("i", "<down>", "<nop>", { noremap = true })
map("i", "<left>", "<nop>", { noremap = true })
map("i", "<right>", "<nop>", { noremap = true })

-- Move lines keeping selection
map("x", "<", "<gv", { noremap = true })
map("x", ">", ">gv", { noremap = true })

-- Leader combos
vim.g.mapleader = ","

-- :verbose nmap <leader> to see all leader mappings
map("n", "<BS>", ":noh<CR>", { noremap = true })
map("n", "*", "*``", { noremap = true })
map("n", "<leader>s", ":w<CR>", { noremap = true })
map("n", "<leader>x", ":BD<CR>", { noremap = true })
map("n", "<leader>w", "ggVGgq<C-o><C-o>", { noremap = true })
map("n", "<leader>rc", ":source $MYVIMRC<CR>", { noremap = true })
map("n", "<leader>nt", ":NERDTreeToggle<CR>", { noremap = true })
map("n", "<leader>lw", ":set wrap!<CR>", { noremap = true })
map("n", "<leader>ln", ":set number!<CR>", { noremap = true })
map("n", "<leader>'", "*:Ack!<C-r><C-w><CR>", { noremap = true })
map("n", "<leader>;", ":Ack!<Space>", { noremap = true })
map("n", [[<leader>\]], ":Ack! --type python --glob '!tests' --glob '!migrations'<Space>", { noremap = true })
map(
	"n",
	"<leader>/",
	"*:Ack! --type python --glob '!tests' --glob '!migrations'<Space><C-r><C-w><CR>",
	{ noremap = true }
)
map("n", "<leader>q", ":q<CR>", { noremap = true })
map("n", "<leader>a", ":wq<CR>", { noremap = true })
map("n", "<leader>z", ":qa<CR>", { noremap = true })
map("n", "<leader>.", ":%bdelete<CR>", { noremap = true })
map("n", "<leader>rs", ":LspRestart<CR><CR>", { noremap = true })
map("n", "<leader>v", ":vsplit<CR>", { noremap = true })
map("n", "<leader>h", ":hsplit<CR>", { noremap = true })
map("n", "<leader>t", [[o__import__("pdb").set_trace()<Esc>]], { noremap = true })
map(
	"n",
	"<leader>o",
	[[:!echo `git url`/blob/`git rev-parse --abbrev-ref HEAD`/%\#L<C-R>=line('.')<CR><CR>]],
	{ noremap = true }
)
map("n", "<leader>m", ":CtrlPBuffer<CR>", { noremap = true })
map("n", "<leader>d", "<C-]>", {})
map("n", "<leader>rn", vim.lsp.buf.rename, {})
map("n", "<leader>fi", vim.lsp.buf.code_action, {})
map("v", "<leader>y", [["+y]], { noremap = true })
map("n", "<leader>p", [["+p]], { noremap = true })

--
-- diagnostics config
--
vim.diagnostic.config({
	jump = {
		float = true,
	},
	float = {
		border = "rounded",
		source = false, -- No source display (we are using our own format function)
		header = "",
		prefix = "",
		style = "minimal",
		--max_width = 120,
		--max_height = 20,

		format = function(diagnostic)
			return string.format("%s: %s", diagnostic.source:lower() or "diagnostic", diagnostic.message)
		end,
	},
})

--
-- nvim-treesitter
--
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"python",
		"go",
		"rust",
		"bash",
		"html",
		"css",
		"javascript",
		"typescript",
		"markdown",
		"json",
		"yaml",
		"terraform",
		"xml",
		"htmldjango",
	},

	sync_install = false,
	auto_install = true,

	highlight = {
		enable = false,
	},

	indent = {
		enable = true,
	},
})

--
-- nvim-cmp
--
local cmp = require("cmp")
local ls = require("luasnip")

require("cmp").setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	sources = cmp.config.sources({ { name = "nvim_lsp" } }, { { name = "buffer" } }),
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif ls.locally_jumpable(1) then
				ls.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<C-p>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif ls.locally_jumpable(-1) then
				ls.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<CR>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				if ls.expandable() then
					ls.expand()
				else
					cmp.confirm({
						select = false,
					})
					return cmp.close()
				end
			else
				fallback()
			end
		end),
	}),
})

--
-- nvim-lspconfig
--

vim.lsp.config("ruff", {
	on_attach = function(client, _)
		client.server_capabilities.codeActionProvider = false
	end,
})

vim.lsp.config("basedpyright", {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	settings = {
		basedpyright = {
			disableOrganizeImports = true,
			disableTaggedHints = true,
			typeCheckingMode = "basic",
			--analysis = {
			--    autoImportCompletions = true,
			--},
		},
	},
})

vim.lsp.enable("ruff")
vim.lsp.enable("gopls")
vim.lsp.enable("basedpyright")
vim.lsp.enable("lua_ls")
vim.lsp.enable("bashls")

--
-- conform.nvim
--
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

--
-- nvim-lint
--
require("lint").linters_by_ft = {
	python = { "mypy" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint(nil, { ignore_errors = true })
	end,
})
