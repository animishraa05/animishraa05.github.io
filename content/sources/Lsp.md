---
title: "Lsp"
created: 2026-04-12
description: "hyperextensible Vim-based text editor"
tags:
  - "neovim"
  - "internals of neovim"
---
*Nvim `:help` pages, [generated](https://github.com/neovim/neovim/blob/master/src/gen/gen_help_html.lua) from [source](https://github.com/neovim/neovim/blob/master/runtime/doc/lsp.txt) using the [tree-sitter-vimdoc](https://github.com/neovim/tree-sitter-vimdoc) parser.*

---

Nvim supports the Language Server Protocol (LSP), which means it acts as a client to LSP servers and includes a Lua framework `vim.lsp` for building enhanced LSP tools.

LSP facilitates features like go-to-definition, find references, hover, completion, rename, format, refactor, etc., using semantic whole-project analysis (unlike [ctags](https://neovim.io/doc/user/tagsrch/#ctags)).

## QUICKSTART

Nvim provides an LSP client, but the servers are provided by third parties. Follow these steps to get LSP features:

Install language servers using your package manager or by following the upstream installation instructions. You can find language servers here: [https://microsoft.github.io/language-server-protocol/implementors/servers/](https://microsoft.github.io/language-server-protocol/implementors/servers/)

Define a new config [lsp-new-config](https://neovim.io/doc/user/lsp/#lsp-new-config) (or install [https://github.com/neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)). Example:
```lua
vim.lsp.config['lua_ls'] = {
  -- Command and arguments to start the server.
  cmd = { 'lua-language-server' },
  -- Filetypes to automatically attach to.
  filetypes = { 'lua' },
  -- Sets the "workspace" to the directory where any of these files is found.
  -- Files that share a root directory will reuse the LSP server connection.
  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
  -- Specific settings to send to the server. The schema is server-defined.
  -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      }
    }
  }
}
```

Use [vim.lsp.enable()](https://neovim.io/doc/user/lsp/#vim.lsp.enable\(\)) to enable the config. Example:
```lua
vim.lsp.enable('lua_ls')
```

Open a code file matching one of the `filetypes` specified in the config. **Note:** Depending on the LSP server, you may need to ensure your project has a [lsp-root\_markers](https://neovim.io/doc/user/lsp/#lsp-root_markers) file so the workspace can be recognized.

Check that LSP is active ("attached") for the buffer:
```
:checkhealth vim.lsp
```

**Note:** some LSP features are disabled by default, you can enable them manually:

(Optional) Configure keymaps and autocommands to use LSP features. [lsp-attach](https://neovim.io/doc/user/lsp/#lsp-attach)

## DEFAULTS

When LSP activates, by default it enables various LSP features and sets options and keymaps, listed below, if (1) the language server supports the functionality and (2) the options are empty or were set by the builtin runtime (ftplugin) files. The options are not restored when the LSP client is stopped or detached.

These GLOBAL keymaps are created unconditionally when Nvim starts:

"gra" (Normal and Visual mode) is mapped to [vim.lsp.buf.code\_action()](https://neovim.io/doc/user/lsp/#vim.lsp.buf.code_action\(\))

`CTRL-S` (Insert mode) is mapped to [vim.lsp.buf.signature\_help()](https://neovim.io/doc/user/lsp/#vim.lsp.buf.signature_help\(\))

[v\_an](https://neovim.io/doc/user/treesitter/#v_an) and [v\_in](https://neovim.io/doc/user/treesitter/#v_in) fall back to LSP [vim.lsp.buf.selection\_range()](https://neovim.io/doc/user/lsp/#vim.lsp.buf.selection_range\(\)) if treesitter is not active.

[gx](https://neovim.io/doc/user/various/#gx) handles `textDocument/documentLink`. Example: with gopls, invoking gx on "os" in this Go code will open documentation externally:
```
package nvim
import (
   "os"
)
```

These LSP features are enabled by default:

Diagnostics [lsp-diagnostic](https://neovim.io/doc/user/lsp/#lsp-diagnostic). See [vim.diagnostic.config()](https://neovim.io/doc/user/diagnostic/#vim.diagnostic.config\(\)) to customize.

`workspace/didChangeWatchedFiles` (except on Linux). If you see poor performance in big workspaces, run `:checkhealth vim.lsp` and look for "file watching". Try disabling file-watching:
```lua
local capabilities = vim.lsp.protocol.make_client_capabilities()
if capabilities.workspace then
  capabilities.workspace.didChangeWatchedFiles = nil
end
vim.lsp.config('*', {
  capabilities = capabilities,
})
```

### BUFFER-LOCAL DEFAULTS

['omnifunc'](https://neovim.io/doc/user/options/#'omnifunc) is set to [vim.lsp.omnifunc()](https://neovim.io/doc/user/lsp/#vim.lsp.omnifunc\(\)), use [i\_CTRL-X\_CTRL-O](https://neovim.io/doc/user/insert/#i_CTRL-X_CTRL-O) to trigger completion.

['tagfunc'](https://neovim.io/doc/user/options/#'tagfunc) is set to [vim.lsp.tagfunc()](https://neovim.io/doc/user/lsp/#vim.lsp.tagfunc\(\)). This enables features like go-to-definition, [:tjump](https://neovim.io/doc/user/tagsrch/#%3Atjump), and keymaps like [CTRL-\]](https://neovim.io/doc/user/tagsrch/#CTRL-%5D), [CTRL-W\_\]](https://neovim.io/doc/user/windows/#CTRL-W_%5D), [CTRL-W\_}](https://neovim.io/doc/user/windows/#CTRL-W_%7D) to utilize the language server.

['formatexpr'](https://neovim.io/doc/user/options/#'formatexpr) is set to [vim.lsp.formatexpr()](https://neovim.io/doc/user/lsp/#vim.lsp.formatexpr\(\)), so you can format lines via [gq](https://neovim.io/doc/user/change/#gq) if the language server supports it.

To opt out of this use [gw](https://neovim.io/doc/user/change/#gw) instead of gq, or clear ['formatexpr'](https://neovim.io/doc/user/options/#'formatexpr) on [LspAttach](https://neovim.io/doc/user/lsp/#LspAttach).

[K](https://neovim.io/doc/user/various/#K) is mapped to [vim.lsp.buf.hover()](https://neovim.io/doc/user/lsp/#vim.lsp.buf.hover\(\)) unless ['keywordprg'](https://neovim.io/doc/user/options/#'keywordprg) is customized or a custom keymap for `K` exists.

Document colors are enabled for highlighting color references in a document.

To opt out call `vim.lsp.document_color.enable(false, { bufnr = ev.buf })` on [LspAttach](https://neovim.io/doc/user/lsp/#LspAttach).

### DISABLING DEFAULTS

You can remove GLOBAL keymaps at any time using [vim.keymap.del()](https://neovim.io/doc/user/lua/#vim.keymap.del\(\)) or [:unmap](https://neovim.io/doc/user/map/#%3Aunmap). See also [gr-default](https://neovim.io/doc/user/change/#gr-default).

To remove or override BUFFER-LOCAL defaults, define a [LspAttach](https://neovim.io/doc/user/lsp/#LspAttach) handler:
```lua
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    -- Unset 'formatexpr'
    vim.bo[ev.buf].formatexpr = nil
    -- Unset 'omnifunc'
    vim.bo[ev.buf].omnifunc = nil
    -- Unmap K
    vim.keymap.del('n', 'K', { buf = ev.buf })
    -- Disable document colors
    vim.lsp.document_color.enable(false, { bufnr = ev.buf })
  end,
})
```

:lsp enable \[config\_name\] [:lsp-enable](#%3Alsp-enable)  
Activates LSP for current and future buffers. See [vim.lsp.enable()](https://neovim.io/doc/user/lsp/#vim.lsp.enable\(\)).

:lsp disable \[config\_name\] [:lsp-disable](#%3Alsp-disable)  
Disables LSP (and stops if running) for current and future buffers. See [vim.lsp.enable()](https://neovim.io/doc/user/lsp/#vim.lsp.enable\(\)).

:lsp restart \[client\_name\] [:lsp-restart](#%3Alsp-restart)  
Restarts LSP clients and servers. If no client names are given, all active clients attached to the current buffer are restarted.

:lsp stop \[client\_name\] [:lsp-stop](#%3Alsp-stop)  
Stops LSP clients and servers. If no client names are given, all active clients attached to the current buffer are stopped. Use [Client:stop()](https://neovim.io/doc/user/lsp/#Client%3Astop\(\)) for non-interactive use.

## CONFIG

You can configure LSP behavior statically via vim.lsp.config(), and dynamically via [lsp-attach](https://neovim.io/doc/user/lsp/#lsp-attach) or [Client:on\_attach()](https://neovim.io/doc/user/lsp/#Client%3Aon_attach\(\)).

Use [vim.lsp.config()](https://neovim.io/doc/user/lsp/#vim.lsp.config\(\)) to define or modify LSP configurations, and [vim.lsp.enable()](https://neovim.io/doc/user/lsp/#vim.lsp.enable\(\)) to auto-activate them. This is basically a wrapper around [vim.lsp.start()](https://neovim.io/doc/user/lsp/#vim.lsp.start\(\)) which allows you to share and merge configs (provided by Nvim, plugins, and your local config).

### NEW CONFIG

To create a new config you can either use `vim.lsp.config()` or create a `lsp/<config-name>.lua` file.

EXAMPLE: DEFINE A CONFIG AS CODE

Run `:lua vim.lsp.config('foo', {cmd={'true'}})`

Run `:lua vim.lsp.enable('foo')`

Run `:checkhealth vim.lsp`, check "Enabled Configurations". 

EXAMPLE: DEFINE A CONFIG AS A FILE

Create a file `lsp/foo.lua` somewhere on your ['runtimepath'](https://neovim.io/doc/user/options/#'runtimepath).
```
:exe 'edit' stdpath('config') .. '/lsp/foo.lua'
```

Add this code to the file (or copy an example from [https://github.com/neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)):
```
return {
  cmd = { 'true' },
}
```

Save the file (with `++p` to ensure its parent directory is created).
```
:write ++p
```

Enable the config.
```
:lua vim.lsp.enable('foo')
```

Run `:checkhealth vim.lsp`, check "Enabled Configurations". 

### HOW CONFIGS ARE MERGED

When an LSP client starts, it resolves its configuration by merging the following sources (merge semantics defined by [vim.tbl\_deep\_extend()](https://neovim.io/doc/user/lua/#vim.tbl_deep_extend\(\)) with "force" behavior), in order of increasing priority:

Configuration defined for the `'*'` name.

The merged configuration of all `lsp/<config>.lua` files in ['runtimepath'](https://neovim.io/doc/user/options/#'runtimepath) for the config named `<config>`.

The merged configuration of all `after/lsp/<config>.lua` files in ['runtimepath'](https://neovim.io/doc/user/options/#'runtimepath).

This behavior of the "after/" directory is a standard Vim feature [after-directory](https://neovim.io/doc/user/options/#after-directory) which allows you to override `lsp/*.lua` configs provided by plugins (such as nvim-lspconfig).

Configurations defined anywhere else.

Example: given the following configs...
```lua
-- Defined in init.lua
vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  },
  root_markers = { '.git' },
})
-- Defined in <rtp>/lsp/clangd.lua
return {
  cmd = { 'clangd' },
  root_markers = { '.clangd', 'compile_commands.json' },
  filetypes = { 'c', 'cpp' },
}
-- Defined in init.lua
vim.lsp.config('clangd', {
  filetypes = { 'c' },
})
```

...the merged result is:
```lua
{
  -- From the clangd configuration in <rtp>/lsp/clangd.lua
  cmd = { 'clangd' },
  -- From the clangd configuration in <rtp>/lsp/clangd.lua
  -- Overrides the "*" configuration in init.lua
  root_markers = { '.clangd', 'compile_commands.json' },
  -- From the clangd configuration in init.lua
  -- Overrides the clangd configuration in <rtp>/lsp/clangd.lua
  filetypes = { 'c' },
  -- From the "*" configuration in init.lua
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  }
}
```

### CONFIGURE ON ATTACH

To use LSP features beyond those provided by Nvim (see [lsp-buf](https://neovim.io/doc/user/lsp/#lsp-buf)), you can set keymaps and options on [Client:on\_attach()](https://neovim.io/doc/user/lsp/#Client%3Aon_attach\(\)) or [LspAttach](https://neovim.io/doc/user/lsp/#LspAttach). Not all language servers provide the same capabilities; check `supports_method()` in your LspAttach handler. Example: Enable auto-completion and auto-formatting ("linting"):
```lua
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if client:supports_method('textDocument/implementation') then
      -- Create a keymap for vim.lsp.buf.implementation ...
    end
    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      -- client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
    end
    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', {clear=false}),
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})
```

To see the capabilities for a given server, try this in a LSP-enabled buffer:
```
:lua =vim.lsp.get_clients()[1].server_capabilities
```

## FAQ

A: Use `:lsp restart`. You can also stop all clients, then reload the buffer:
```
:lsp stop
:edit
```

A: In the buffer where you want to use LSP, check that ['omnifunc'](https://neovim.io/doc/user/options/#'omnifunc) is set to "v:lua.vim.lsp.omnifunc": `:verbose set omnifunc?`

Some other plugin may be overriding the option. To avoid that you could set the option in an [after-directory](https://neovim.io/doc/user/options/#after-directory) ftplugin, e.g. "after/ftplugin/python.vim".

Q: How do I run a request synchronously (e.g. for formatting on file save)?

A: Check if the function has an `async` parameter and set the value to false. E.g. code formatting:
```
" Auto-format *.rs (rust) files prior to saving them
" (async = false is the default for format)
autocmd BufWritePre *.rs lua vim.lsp.buf.format({ async = false })
```

Q: How to avoid my own lsp/ folder being overridden?

A: Place your configs under "after/lsp/". Files in "after/lsp/" are loaded after those in "nvim/lsp/", so your settings will take precedence over the defaults provided by nvim-lspconfig. See also: [after-directory](https://neovim.io/doc/user/options/#after-directory)

[lsp-vs-treesitter](#lsp-vs-treesitter)  

Q: How do LSP, Treesitter and Ctags compare?

A: LSP requires a client and language server. The language server uses semantic analysis to understand code at a project level. This provides language servers with the ability to rename across files, find definitions in external libraries and more.

[treesitter](https://neovim.io/doc/user/treesitter/#treesitter) is a language parsing library that provides excellent tools for incrementally parsing text and handling errors. This makes it a great fit for editors to understand the contents of the current file for things like syntax highlighting, simple goto-definitions, scope analysis and more.

A [ctags](https://neovim.io/doc/user/tagsrch/#ctags) -like program can generate a [tags](https://neovim.io/doc/user/tagsrch/#tags) file that allows Nvim to jump to definitions, provide simple completions via [i\_CTRL-X\_CTRL-\]](https://neovim.io/doc/user/insert/#i_CTRL-X_CTRL-%5D) command. It is not as featureful and doesn't have semantic understanding, but it is fast, lightweight and useful for navigating polyglot projects.

## LSP API

The [lsp-core](https://neovim.io/doc/user/lsp/#lsp-core) API provides core functions for creating and managing clients. The [lsp-buf](https://neovim.io/doc/user/lsp/#lsp-buf) functions perform operations for LSP clients attached to the current buffer.

[lsp-method](#lsp-method)  
Requests and notifications defined by the LSP specification are referred to as "LSP methods". These are handled by Lua [lsp-handler](https://neovim.io/doc/user/lsp/#lsp-handler) functions.

[lsp-handler](#lsp-handler)  
LSP handlers are functions that handle [lsp-response](https://neovim.io/doc/user/lsp/#lsp-response) s to requests made by Nvim to the server. (Notifications, as opposed to requests, are fire-and-forget: there is no response, so they can't be handled. [lsp-notification](https://neovim.io/doc/user/lsp/#lsp-notification))

Each handler has the following signature:
```
vim.lsp.ResponseHandler:
    fun(err, result, ctx)
vim.lsp.NotificationHandler:
    fun(err, params, ctx)
vim.lsp.RequestHandler:
    fun(err, params, ctx): Result?, lsp.ResponseError?
```
Each response handler has this signature:
```
function(err, result, ctx)
```

Parameters:

`{err}` (`table|nil`) Error info dict, or `nil` if the request completed.

`{result}` (`Result|Params|nil`) `result` key of the [lsp-response](https://neovim.io/doc/user/lsp/#lsp-response) or `nil` if the request failed.

`{ctx}` (`table`) Table of calling state associated with the handler, with these keys:

`{method}` (`string`) [lsp-method](https://neovim.io/doc/user/lsp/#lsp-method) name.

`{client_id}` (`number`) [vim.lsp.Client](https://neovim.io/doc/user/lsp/#vim.lsp.Client) identifier.

`{bufnr}` (`Buffer`) Buffer handle.

`{params}` (`table|nil`) Request parameters table.

`{version}` (`number`) Document version at time of request. Handlers can compare this to the current document version to check if the response is "stale". See also [b:changedtick](https://neovim.io/doc/user/vimeval/#b%3Achangedtick).

(`Result?`) `result` on success, or `nil` on error.

(`lsp.ResponseError?`) `error` on failure, or `nil` on success. RPC error shape:
```
{ code, message, data? }
```

You can use [vim.lsp.rpc.rpc\_response\_error()](https://neovim.io/doc/user/lsp/#vim.lsp.rpc.rpc_response_error\(\)) to create this object.

[lsp-response](https://neovim.io/doc/user/lsp/#lsp-response) and [lsp-notification](https://neovim.io/doc/user/lsp/#lsp-notification) handlers do not have return values.

[lsp-handler-resolution](#lsp-handler-resolution)  
Handlers can be set by (in increasing priority):

  

Directly calling a LSP method via [Client:request()](https://neovim.io/doc/user/lsp/#Client%3Arequest\(\)). This is the only way to "override" the default client-to-server request handling (by side-stepping `vim.lsp.buf` and related interfaces).
```lua
local client = assert(vim.lsp.get_clients()[1])
client:request('textDocument/definition')
```

Setting a field in `vim.lsp.handlers`. This global table contains the default mappings of [lsp-method](https://neovim.io/doc/user/lsp/#lsp-method) names to handlers. (**Note:** only for server-to-client requests/notifications, not client-to-server.) Example:
```lua
vim.lsp.handlers['textDocument/publishDiagnostics'] = my_custom_diagnostics_handler
```

Passing a `{handlers}` parameter to [vim.lsp.start()](https://neovim.io/doc/user/lsp/#vim.lsp.start\(\)). This sets the default [lsp-handler](https://neovim.io/doc/user/lsp/#lsp-handler) for a specific server. (**Note:** only for server-to-client requests/notifications, not client-to-server.) Example:
```lua
vim.lsp.start {
  ..., -- Other configuration omitted.
  handlers = {
    ['textDocument/publishDiagnostics'] = my_custom_diagnostics_handler
  },
}
```

Passing a `{handler}` parameter to [vim.lsp.buf\_request\_all()](https://neovim.io/doc/user/lsp/#vim.lsp.buf_request_all\(\)). This sets the [lsp-handler](https://neovim.io/doc/user/lsp/#lsp-handler) ONLY for the given request(s). Example:
```lua
vim.lsp.buf_request_all(
  0,
  'textDocument/publishDiagnostics',
  my_request_params,
  my_handler
)
```

[vim.lsp.log\_levels](#vim.lsp.log_levels)  
Log levels are defined in [vim.log.levels](https://neovim.io/doc/user/lua/#vim.log.levels)

### VIM.LSP.PROTOCOL

Module `vim.lsp.protocol` defines constants dictated by the LSP specification, and helper functions for creating protocol-related objects. [https://github.com/microsoft/language-server-protocol/raw/gh-pages/\_specifications/specification-3-14.md](https://github.com/microsoft/language-server-protocol/raw/gh-pages/_specifications/specification-3-14.md)

For example `vim.lsp.protocol.ErrorCodes` allows reverse lookup by number or name:
```lua
vim.lsp.protocol.TextDocumentSyncKind.Full == 1
vim.lsp.protocol.TextDocumentSyncKind[1] == "Full"
```

  
LSP request shape:
```
{ id: integer|string, method: string, params?: Params }
```

  
LSP response shape:
```
{ id: integer|string|nil, result: Result, error: nil }       (on success)
{ id: integer|string|nil, result: nil, error: ResponseError }  (on error)
```

  
LSP notification shape:
```
{ method: string, params?: Params }
```

## LSP HIGHLIGHT

Highlight groups that are meant to be used by [vim.lsp.buf.document\_highlight()](https://neovim.io/doc/user/lsp/#vim.lsp.buf.document_highlight\(\)).

You can see more about the differences in types here: [https://microsoft.github.io/language-server-protocol/specification#textDocument\_documentHighlight](https://microsoft.github.io/language-server-protocol/specification#textDocument_documentHighlight)

[hl-LspReferenceText](#hl-LspReferenceText)  
LspReferenceText used for highlighting "text" references [hl-LspReferenceRead](#hl-LspReferenceRead)  
LspReferenceRead used for highlighting "read" references [hl-LspReferenceWrite](#hl-LspReferenceWrite)  
LspReferenceWrite used for highlighting "write" references [hl-LspReferenceTarget](#hl-LspReferenceTarget)  
LspReferenceTarget used for highlighting reference targets (e.g. in a hover range) [hl-LspInlayHint](#hl-LspInlayHint)  
LspInlayHint used for highlighting inlay hints

[hl-LspCodeLens](#hl-LspCodeLens)  
LspCodeLens Used to color the virtual text of the codelens. See [nvim\_buf\_set\_extmark()](https://neovim.io/doc/user/api/#nvim_buf_set_extmark\(\)).

LspCodeLensSeparator [hl-LspCodeLensSeparator](#hl-LspCodeLensSeparator)  
Used to color the separator between two or more code lenses.

[hl-LspSignatureActiveParameter](#hl-LspSignatureActiveParameter)  
LspSignatureActiveParameter Used to highlight the active parameter in the signature help. See [vim.lsp.handlers.signature\_help()](https://neovim.io/doc/user/deprecated/#vim.lsp.handlers.signature_help\(\)).

### LSP SEMANTIC HIGHLIGHTS

When available, the LSP client highlights code using [lsp-semantic\_tokens](https://neovim.io/doc/user/lsp/#lsp-semantic_tokens), which are another way that LSP servers can provide information about source code. Note that this is in addition to treesitter syntax highlighting; semantic highlighting does not replace syntax highlighting.

The server will typically provide one token per identifier in the source code. The token will have a `type` such as "function" or "variable", and 0 or more `modifier` s such as "readonly" or "deprecated." The standard types and modifiers are described here: [https://microsoft.github.io/language-server-protocol/specification/#textDocument\_semanticTokens](https://microsoft.github.io/language-server-protocol/specification/#textDocument_semanticTokens) LSP servers may also use off-spec types and modifiers.

The LSP client adds one or more highlights for each token. The highlight groups are derived from the token's type and modifiers:

`@lsp.type.<type>.<ft>` for the type

`@lsp.mod.<mod>.<ft>` for each modifier

`@lsp.typemod.<type>.<mod>.<ft>` for each modifier Use [:Inspect](https://neovim.io/doc/user/lua/#%3AInspect) to view the highlights for a specific token. Use [:hi](https://neovim.io/doc/user/syntax/#%3Ahi) or [nvim\_set\_hl()](https://neovim.io/doc/user/api/#nvim_set_hl\(\)) to change the appearance of semantic highlights:
```
hi @lsp.type.function guifg=Yellow        " function names are yellow
hi @lsp.type.variable.lua guifg=Green     " variables in lua are green
hi @lsp.mod.deprecated gui=strikethrough  " deprecated is crossed out
hi @lsp.typemod.function.async guifg=Blue " async functions are blue
```

The value [vim.hl.priorities](https://neovim.io/doc/user/lua/#vim.hl.priorities)`.semantic_tokens` is the priority of the `@lsp.type.*` highlights. The `@lsp.mod.*` and `@lsp.typemod.*` highlights have priorities one and two higher, respectively.

You can disable semantic highlights by clearing the highlight groups:
```lua
-- Hide semantic highlights for functions
vim.api.nvim_set_hl(0, '@lsp.type.function', {})
-- Hide all semantic highlights
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end
```

You probably want these inside a [ColorScheme](https://neovim.io/doc/user/autocmd/#ColorScheme) autocommand.

Use [LspTokenUpdate](https://neovim.io/doc/user/lsp/#LspTokenUpdate) and [vim.lsp.semantic\_tokens.highlight\_token()](https://neovim.io/doc/user/lsp/#vim.lsp.semantic_tokens.highlight_token\(\)) for more complex highlighting.

The following is a list of standard captures used in queries for Nvim, highlighted according to the current colorscheme (use [:Inspect](https://neovim.io/doc/user/lua/#%3AInspect) on one to see the exact definition):

@lsp.type.class Identifiers that declare or reference a class type @lsp.type.comment Tokens that represent a comment @lsp.type.decorator Identifiers that declare or reference decorators and annotations @lsp.type.enum Identifiers that declare or reference an enumeration type @lsp.type.enumMember Identifiers that declare or reference an enumeration property, constant, or member @lsp.type.event Identifiers that declare an event property @lsp.type.function Identifiers that declare a function @lsp.type.interface Identifiers that declare or reference an interface type @lsp.type.keyword Tokens that represent a language keyword @lsp.type.macro Identifiers that declare a macro @lsp.type.method Identifiers that declare a member function or method @lsp.type.modifier Tokens that represent a modifier @lsp.type.namespace Identifiers that declare or reference a namespace, module, or package @lsp.type.number Tokens that represent a number literal @lsp.type.operator Tokens that represent an operator @lsp.type.parameter Identifiers that declare or reference a function or method parameters @lsp.type.property Identifiers that declare or reference a member property, member field, or member variable @lsp.type.regexp Tokens that represent a regular expression literal @lsp.type.string Tokens that represent a string literal @lsp.type.struct Identifiers that declare or reference a struct type @lsp.type.type Identifiers that declare or reference a type that is not covered above @lsp.type.typeParameter Identifiers that declare or reference a type parameter @lsp.type.variable Identifiers that declare or reference a local or global variable

@lsp.mod.abstract Types and member functions that are abstract @lsp.mod.async Functions that are marked async @lsp.mod.declaration Declarations of symbols @lsp.mod.defaultLibrary Symbols that are part of the standard library @lsp.mod.definition Definitions of symbols, for example, in header files @lsp.mod.deprecated Symbols that should no longer be used @lsp.mod.documentation Occurrences of symbols in documentation @lsp.mod.modification Variable references where the variable is assigned to @lsp.mod.readonly Readonly variables and member fields (constants) @lsp.mod.static Class members (static members)

## EVENTS

LspAttach [LspAttach](#LspAttach)  
After an LSP client performs "initialize" and attaches to a buffer. The [autocmd-pattern](https://neovim.io/doc/user/autocmd/#autocmd-pattern) is the buffer name. The client ID is passed in the Lua handler [event-data](https://neovim.io/doc/user/api/#event-data) argument.

Example:
```lua
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    -- ...
  end
})
```

**Note:** If the LSP server performs dynamic registration, capabilities may be registered any time \_after\_ LspAttach. In that case you may want to handle the "registerCapability" event.

Example:
```lua
vim.lsp.handlers['client/registerCapability'] = (function(overridden)
  return function(err, res, ctx)
    local result = overridden(err, res, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if not client then
      return
    end
    for bufnr, _ in pairs(client.attached_buffers) do
      -- Call your custom on_attach logic...
      -- my_on_attach(client, bufnr)
    end
    return result
  end
end)(vim.lsp.handlers['client/registerCapability'])
```
LspDetach  
Just before an LSP client detaches from a buffer. The [autocmd-pattern](https://neovim.io/doc/user/autocmd/#autocmd-pattern) is the buffer name. The client ID is passed in the Lua handler [event-data](https://neovim.io/doc/user/api/#event-data) argument.

Example:
```lua
vim.api.nvim_create_autocmd('LspDetach', {
  callback = function(ev)
    -- Get the detaching client
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    -- Remove the autocommand to format the buffer on save, if it exists
    if client:supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({
        event = 'BufWritePre',
        buffer = ev.buf,
      })
    end
  end,
})
```

LspNotify [LspNotify](#LspNotify)  
This event is triggered after each successful notification sent to an LSP server.

The client\_id, LSP method, and parameters are sent in the Lua handler [event-data](https://neovim.io/doc/user/api/#event-data) table argument.

Example:
```lua
vim.api.nvim_create_autocmd('LspNotify', {
  callback = function(ev)
    local bufnr = ev.buf
    local client_id = ev.data.client_id
    local method = ev.data.method
    local params = ev.data.params
    -- do something with the notification
    if method == 'textDocument/...' then
      update_buffer(bufnr)
    end
  end,
})
```

LspProgress [LspProgress](#LspProgress)  
Upon receipt of a progress notification from the server. Notifications can be polled from a `progress` ring buffer of a [vim.lsp.Client](https://neovim.io/doc/user/lsp/#vim.lsp.Client) or use [vim.lsp.status()](https://neovim.io/doc/user/lsp/#vim.lsp.status\(\)) to get an aggregate message.

If the server sends a "work done progress", the `pattern` is set to `kind` (one of `begin`, `report` or `end`).

The Lua handler [event-data](https://neovim.io/doc/user/api/#event-data) argument has `client_id` and `params` properties, where `params` is the request params sent by the server (see `lsp.ProgressParams`).

Redraw the statusline whenever an LSP progress message arrives:
```
autocmd LspProgress * redrawstatus
```

Emit a [progress-message](https://neovim.io/doc/user/message/#progress-message) on LSP progress events:
```lua
vim.api.nvim_create_autocmd('LspProgress', { buffer = buf, callback = function(ev)
    local value = ev.data.params.value
    vim.api.nvim_echo({ { value.message or 'done' } }, false, {
      id = 'lsp.' .. ev.data.params.token,
      kind = 'progress',
      source = 'vim.lsp',
      title = value.title,
      status = value.kind ~= 'end' and 'running' or 'success',
      percent = value.percentage,
    })
  end,
})
```

LspRequest [LspRequest](#LspRequest)  
For each request sent to an LSP server, this event is triggered for every change to the request's status. The status can be one of `pending`, `complete`, or `cancel` and is sent as the `{type}` on the "data" table passed to the callback function.

It triggers when the initial request is sent (`{type}` == `pending`) and when the LSP server responds (`{type}` == `complete`). If a cancellation is requested using `client.cancel_request(request_id)`, then this event will trigger with `{type}` == `cancel`.

The Lua handler [event-data](https://neovim.io/doc/user/api/#event-data) argument has the client ID, request ID, and request (described at [vim.lsp.Client](https://neovim.io/doc/user/lsp/#vim.lsp.Client), `{requests}` field). If the request type is `complete`, the request will be deleted from the client's pending requests table after processing the event handlers.

Example:
```lua
vim.api.nvim_create_autocmd('LspRequest', {
  callback = function(ev)
    local bufnr = ev.buf
    local client_id = ev.data.client_id
    local request_id = ev.data.request_id
    local request = ev.data.request
    if request.type == 'pending' then
      -- do something with pending requests
      track_pending(client_id, bufnr, request_id, request)
    elseif request.type == 'cancel' then
      -- do something with pending cancel requests
      track_canceling(client_id, bufnr, request_id, request)
    elseif request.type == 'complete' then
      -- do something with finished requests. this pending
      -- request entry is about to be removed since it is complete
      track_finish(client_id, bufnr, request_id, request)
    end
  end,
})
```

LspTokenUpdate [LspTokenUpdate](#LspTokenUpdate)  
When a visible semantic token is sent or updated by the LSP server, or when an existing token becomes visible for the first time. The [autocmd-pattern](https://neovim.io/doc/user/autocmd/#autocmd-pattern) is the buffer name. The Lua handler [event-data](https://neovim.io/doc/user/api/#event-data) argument has the client ID and token (see [vim.lsp.semantic\_tokens.get\_at\_pos()](https://neovim.io/doc/user/lsp/#vim.lsp.semantic_tokens.get_at_pos\(\))).

Example:
```lua
vim.api.nvim_create_autocmd('LspTokenUpdate', {
  callback = function(ev)
    local token = ev.data.token
    if token.type == 'variable' and not token.modifiers.readonly then
      vim.lsp.semantic_tokens.highlight_token(
        token, ev.buf, ev.data.client_id, 'MyMutableVariableHighlight'
      )
    end
  end,
})
```

**Note:** doing anything other than calling [vim.lsp.semantic\_tokens.highlight\_token()](https://neovim.io/doc/user/lsp/#vim.lsp.semantic_tokens.highlight_token\(\)) is considered experimental.

## Lua module: vim.lsp

`{cmd}?` (`string[]|fun(dispatchers: vim.lsp.rpc.Dispatchers, config: vim.lsp.ClientConfig): vim.lsp.rpc.Client`) See `cmd` in [vim.lsp.ClientConfig](https://neovim.io/doc/user/lsp/#vim.lsp.ClientConfig). See also `reuse_client` to dynamically decide (per-buffer) when `cmd` should be re-invoked.

`{filetypes}?` (`string[]`) Filetypes the client will attach to, or `nil` for ALL filetypes. To match files by name, pattern, or contents, you can define a custom filetype using [vim.filetype.add()](https://neovim.io/doc/user/lua/#vim.filetype.add\(\)):
```lua
vim.filetype.add({
  filename = {
    ['my_filename'] = 'my_filetype1',
  },
  pattern = {
    ['.*/etc/my_file_pattern/.*'] = 'my_filetype2',
  },
})
vim.lsp.config('…', {
  filetypes = { 'my_filetype1', 'my_filetype2' },
})
```

`{reuse_client}?` (`fun(client: vim.lsp.Client, config: vim.lsp.ClientConfig): boolean`) Predicate which decides if a client should be re-used. Used on all running clients. The default implementation re-uses a client if name and root\_dir matches.

`{root_dir}?` (`string|fun(bufnr: integer, on_dir:fun(root_dir?:string))`) [lsp-root\_dir()](#lsp-root_dir\(\)) Decides the workspace root: the directory where the LSP server will base its workspaceFolders, rootUri, and rootPath on initialization. The function form must call the `on_dir` callback to provide the root dir, or LSP will not be activated for the buffer. Thus a `root_dir()` function can dynamically decide per-buffer whether to activate (or skip) LSP. See example at [vim.lsp.enable()](https://neovim.io/doc/user/lsp/#vim.lsp.enable\(\)).

`{root_markers}?` (`(string|string[])[]`) [lsp-root\_markers](#lsp-root_markers)  
Filename(s) (".git/", "package.json", …) used to decide the workspace root. Unused if `root_dir` is defined. The list order decides priority. To indicate "equal priority", specify names in a nested list `{ { 'a.txt', 'b.lua' }, ... }`.

For each item, Nvim will search upwards (from the buffer file) for that marker, or list of markers; search stops at the first directory containing that marker, and the directory is used as the root dir (workspace folder).

Example: Find the first ancestor directory containing file or directory "stylua.toml"; if not found, find the first ancestor containing ".git":
```
root_markers = { 'stylua.toml', '.git' }
```

Example: Find the first ancestor directory containing EITHER "stylua.toml" or ".luarc.json"; if not found, find the first ancestor containing ".git":
```
root_markers = { { 'stylua.toml', '.luarc.json' }, '.git' }
```

buf\_attach\_client(`{bufnr}`, `{client_id}`) [vim.lsp.buf\_attach\_client()](#vim.lsp.buf_attach_client\(\))  
Implements the `textDocument/did…` notifications required to track a buffer for any language server.

Without calling this, the server won't be notified of changes to a buffer.

Parameters:

`{bufnr}` (`integer`) Buffer handle, or 0 for current

`{client_id}` (`integer`) Client id

Return:

(`boolean`) success `true` if client was attached successfully; `false` otherwise

buf\_detach\_client(`{bufnr}`, `{client_id}`) [vim.lsp.buf\_detach\_client()](#vim.lsp.buf_detach_client\(\))  
Detaches client from the specified buffer. **Note:** While the server is notified that the text document (buffer) was closed, it is still able to send notifications should it ignore this notification.

Parameters:

`{bufnr}` (`integer`) Buffer handle, or 0 for current

`{client_id}` (`integer`) Client id

buf\_is\_attached(`{bufnr}`, `{client_id}`) [vim.lsp.buf\_is\_attached()](#vim.lsp.buf_is_attached\(\))  
Checks if a buffer is attached for a particular client.

Parameters:

`{bufnr}` (`integer`) Buffer handle, or 0 for current

`{client_id}` (`integer`) the client id

buf\_notify(`{bufnr}`, `{method}`, `{params}`) [vim.lsp.buf\_notify()](#vim.lsp.buf_notify\(\))  
Send a notification to a server

Parameters:

`{bufnr}` (`integer?`) The number of the buffer

`{method}` (`string`) Name of the request method

`{params}` (`any`) Arguments to send to the server

Return:

(`boolean`) success true if any client returns true; false otherwise

[vim.lsp.buf\_request\_all()](#vim.lsp.buf_request_all\(\))  
buf\_request\_all(`{bufnr}`, `{method}`, `{params}`, `{handler}`) Sends an async request for all active clients attached to the buffer and executes the `handler` callback with the combined result.

Parameters:

`{bufnr}` (`integer`) Buffer handle, or 0 for current.

`{method}` (`string`) LSP method name

`{params}` (`table|(fun(client: vim.lsp.Client, bufnr: integer): table?)?`) Parameters to send to the server. Can also be passed as a function that returns the params table for cases where parameters are specific to the client.

`{handler}` (`function`) Handler called after all requests are completed. Server results are passed as a `client_id:result` map.

Return:

(`function`) cancel Function that cancels all requests.

[vim.lsp.buf\_request\_sync()](#vim.lsp.buf_request_sync\(\))  
buf\_request\_sync(`{bufnr}`, `{method}`, `{params}`, `{timeout_ms}`) Sends a request to all server and waits for the response of all of them.

Calls [vim.lsp.buf\_request\_all()](https://neovim.io/doc/user/lsp/#vim.lsp.buf_request_all\(\)) but blocks Nvim while awaiting the result. Parameters are the same as [vim.lsp.buf\_request\_all()](https://neovim.io/doc/user/lsp/#vim.lsp.buf_request_all\(\)) but the result is different. Waits a maximum of `{timeout_ms}`.

Parameters:

`{bufnr}` (`integer`) Buffer handle, or 0 for current.

`{method}` (`string`) LSP method name

`{params}` (`table|(fun(client: vim.lsp.Client, bufnr: integer): table?)?`) Parameters to send to the server. Can also be passed as a function that returns the params table for cases where parameters are specific to the client.

`{timeout_ms}` (`integer?`, default: `1000`) Maximum time in milliseconds to wait for a result.

Return (multiple):

(`table<integer, {error: lsp.ResponseError?, result: any}>?`) result Map of client\_id:request\_result. (`string?`) err On timeout, cancel, or error, `err` is a string describing the failure reason, and `result` is nil.

commands [vim.lsp.commands](#vim.lsp.commands)  
Map of client-defined handlers implementing custom (off-spec) commands which a server may invoke. Each key is a unique command name; each value is a function which is called when an LSP action (code action, code lenses, …) requests it by name.

If an LSP response requests a command not defined client-side, Nvim will forward it to the server as `workspace/executeCommand`.

Argument 1 is the `Command`:
```
Command
title: String
command: String
arguments?: any[]
```

Argument 2 is the [lsp-handler](https://neovim.io/doc/user/lsp/#lsp-handler) `ctx`.

Example:
```lua
vim.lsp.commands['java.action.generateToStringPrompt'] = function(_, ctx)
  require("jdtls.async").run(function()
    local _, result = request(ctx.bufnr, 'java/checkToStringStatus', ctx.params)
    local fields = ui.pick_many(result.fields, 'Include item in toString?', function(x)
      return string.format('%s: %s', x.name, x.type)
    end)
    local _, edit = request(ctx.bufnr, 'java/generateToString', { context = ctx.params; fields = fields; })
    vim.lsp.util.apply_workspace_edit(edit, offset_encoding)
  end)
end
```

config(`{name}`, `{cfg}`) [vim.lsp.config()](#vim.lsp.config\(\))  
Sets the default configuration for an LSP client (or all clients if the special name "\*" is used).

Can also be accessed by table-indexing (`vim.lsp.config[…]`) to get the resolved config, or redefine the config (instead of "merging" with the config chain).

Examples:

Add root markers for ALL clients:
```lua
vim.lsp.config('*', {
  root_markers = { '.git', '.hg' },
})
```

Add capabilities to ALL clients:
```lua
vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  }
})
```

Add root markers and capabilities for "clangd":
```lua
vim.lsp.config('clangd', {
  root_markers = { '.clang-format', 'compile_commands.json' },
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
        }
      }
    }
  }
})
```

(Re-)define the "clangd" configuration (overrides the resolved chain):
```lua
vim.lsp.config.clangd = {
  cmd = {
    'clangd',
    '--clang-tidy',
    '--background-index',
    '--offset-encoding=utf-8',
  },
  root_markers = { '.clangd', 'compile_commands.json' },
  filetypes = { 'c', 'cpp' },
}
```

Get the resolved configuration for "lua\_ls":
```lua
local cfg = vim.lsp.config.lua_ls
```

Parameters:

`{name}` (`string`)

`{cfg}` (`vim.lsp.Config`) See [vim.lsp.Config](https://neovim.io/doc/user/lsp/#vim.lsp.Config).

enable(`{name}`, `{enable}`) [vim.lsp.enable()](#vim.lsp.enable\(\))  
Auto-activates LSP in each buffer based on the [lsp-config](https://neovim.io/doc/user/lsp/#lsp-config) `filetypes`, `root_markers`, and `root_dir`.

To disable, pass `enable=false`: Stops related clients and servers (force-stops servers after a timeout, unless `exit_timeout=false`).

Raises an error under the following conditions:

`{name}` is not a valid LSP config name (for example, `'*'`).

`{name}` corresponds to an LSP config file which raises an error.

If an error is raised when multiple names are provided, this function will have no side-effects; it will not enable/disable any configs, including ones which contain no errors.

Examples:
```lua
vim.lsp.enable('clangd')
vim.lsp.enable({'lua_ls', 'pyright'})
```

Example: To dynamically decide whether LSP is activated, define a [lsp-root\_dir()](https://neovim.io/doc/user/lsp/#lsp-root_dir\(\)) function which calls `on_dir()` only when you want that config to activate:
```lua
vim.lsp.config('lua_ls', {
  root_dir = function(bufnr, on_dir)
    if vim.fs.ext(vim.fn.bufname(bufnr)) ~= 'txt' then
      on_dir(vim.fn.getcwd())
    end
  end
})
```

Parameters:

`{name}` (`string|string[]`) Name(s) of client(s) to enable.

`{enable}` (`boolean?`) If `true|nil`, enables auto-activation of the given LSP config on current and future buffers. If `false`, disables auto-activation and stops related LSP clients and servers (force-stops servers after `exit_timeout` milliseconds).

foldclose(`{kind}`, `{winid}`) [vim.lsp.foldclose()](#vim.lsp.foldclose\(\))  
Close all `{kind}` of folds in the the window with `{winid}`.

To automatically fold imports when opening a file, you can use an autocmd:
```lua
vim.api.nvim_create_autocmd('LspNotify', {
  callback = function(ev)
    if ev.data.method == 'textDocument/didOpen' then
      vim.lsp.foldclose('imports', vim.fn.bufwinid(ev.buf))
    end
  end,
})
```

Parameters:

`{kind}` (`lsp.FoldingRangeKind`) Kind to close, one of "comment", "imports" or "region".

`{winid}` (`integer?`) Defaults to the current window.

foldexpr(`{lnum}`) [vim.lsp.foldexpr()](#vim.lsp.foldexpr\(\))  
Provides an interface between the built-in client and a `foldexpr` function.

To use, set ['foldmethod'](https://neovim.io/doc/user/options/#'foldmethod) to "expr" and set the value of ['foldexpr'](https://neovim.io/doc/user/options/#'foldexpr):
```lua
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.lsp.foldexpr()'
```

Or use it only when supported by checking for the "textDocument/foldingRange" capability in an [LspAttach](https://neovim.io/doc/user/lsp/#LspAttach) autocommand. Example:
```lua
vim.o.foldmethod = 'expr'
-- Default to treesitter folding
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- Prefer LSP folding if client supports it
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/foldingRange') then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
  end,
})
```

Parameters:

`{lnum}` (`integer`) line number

foldtext() [vim.lsp.foldtext()](#vim.lsp.foldtext\(\))  
Provides a `foldtext` function that shows the `collapsedText` retrieved, defaults to the first folded line if `collapsedText` is not provided.

formatexpr(`{opts}`) [vim.lsp.formatexpr()](#vim.lsp.formatexpr\(\))  
Provides an interface between the built-in client and a `formatexpr` function.

Currently only supports a single client. This can be set via `setlocal formatexpr=v:lua.vim.lsp.formatexpr()` or (more typically) in `on_attach` via `vim.bo[bufnr].formatexpr = 'v:lua.vim.lsp.formatexpr(#{timeout_ms:250})'`.

Parameters:

`{opts}` (`table?`) A table with the following fields:

`{timeout_ms}` (`integer`, default: 500ms) The timeout period for the formatting request..

get\_client\_by\_id(`{client_id}`) [vim.lsp.get\_client\_by\_id()](#vim.lsp.get_client_by_id\(\))  
Gets a client by id, or nil if the id is invalid or the client was stopped. The returned client may not yet be fully initialized.

Parameters:

`{client_id}` (`integer`) client id

Return:

(`vim.lsp.Client?`) client rpc object. See [vim.lsp.Client](https://neovim.io/doc/user/lsp/#vim.lsp.Client).

get\_clients(`{filter}`) [vim.lsp.get\_clients()](#vim.lsp.get_clients\(\))  
Gets active clients.

Parameters:

`{filter}` (`table?`) Key-value pairs used to filter the returned clients.

`{id}?` (`integer`) Only return clients with the given id

`{bufnr}?` (`integer`) Only return clients attached to this buffer

`{name}?` (`string`) Only return clients with the given name

`{method}?` (`string`) Only return clients supporting the given method

Return:

(`vim.lsp.Client[]`) List of [vim.lsp.Client](https://neovim.io/doc/user/lsp/#vim.lsp.Client) objects

get\_configs(`{filter}`) [vim.lsp.get\_configs()](#vim.lsp.get_configs\(\))  
Gets LSP configs.

See also [vim.lsp.get\_clients()](https://neovim.io/doc/user/lsp/#vim.lsp.get_clients\(\)) to get the runtime values of dynamic fields like `root_dir`, which depend on the current buffer/workspace/etc.

**WARNING:** May eagerly (prematurely!) evaluate config files in ['runtimepath'](https://neovim.io/doc/user/options/#'runtimepath).

Parameters:

`{filter}` (`table?`) Key-value pairs used to filter the returned configs.

`{enabled}?` (`boolean`) If true, only return enabled configs. If false, only return configs that aren't enabled.

`{filetype}?` (`string`) Only return configs which attach to the given filetype.

Return:

(`vim.lsp.Config[]`) List of [vim.lsp.Config](https://neovim.io/doc/user/lsp/#vim.lsp.Config) objects

is\_enabled(`{name}`) [vim.lsp.is\_enabled()](#vim.lsp.is_enabled\(\))  
Checks if the given LSP config is enabled (globally, not per-buffer).

Unlike `vim.lsp.config['…']`, this does not have the side-effect of resolving the config.

Parameters:

`{name}` (`string`) Config name

Return:

(`boolean`)

omnifunc(`{findstart}`, `{base}`) [vim.lsp.omnifunc()](#vim.lsp.omnifunc\(\))  
Implements ['omnifunc'](https://neovim.io/doc/user/options/#'omnifunc) compatible LSP completion.

Parameters:

`{findstart}` (`integer`) 0 or 1, decides behavior

`{base}` (`integer`) findstart=0, text to match against

Return:

(`integer|table`) Decided by `{findstart}`:

findstart=1: column where the completion starts, or -2 or -3

findstart=0: list of matches (actually just calls [complete()](https://neovim.io/doc/user/vimfn/#complete\(\)))

start(`{config}`, `{opts}`) [vim.lsp.start()](#vim.lsp.start\(\))  
Create a new LSP client and start a language server or reuses an already running client if one is found matching `name` and `root_dir`. Attaches the current buffer to the client.

Example:
```lua
vim.lsp.start({
   name = 'my-server-name',
   cmd = {'name-of-language-server-executable'},
   root_dir = vim.fs.root(0, {'pyproject.toml', 'setup.py'}),
})
```

See [vim.lsp.ClientConfig](https://neovim.io/doc/user/lsp/#vim.lsp.ClientConfig) for all available options. The most important are:

`name` arbitrary name for the LSP client. Should be unique per language server.

`cmd` command string\[\] or function.

`root_dir` path to the project root. By default this is used to decide if an existing client should be re-used. The example above uses [vim.fs.root()](https://neovim.io/doc/user/lua/#vim.fs.root\(\)) to detect the root by traversing the file system upwards starting from the current directory until either a `pyproject.toml` or `setup.py` file is found.

`workspace_folders` list of `{ uri:string, name: string }` tables specifying the project root folders used by the language server. If `nil` the property is derived from `root_dir` for convenience.

Language servers use this information to discover metadata like the dependencies of your project and they tend to index the contents within the project folder.

To ensure a language server is only started for languages it can handle, make sure to call [vim.lsp.start()](https://neovim.io/doc/user/lsp/#vim.lsp.start\(\)) within a [FileType](https://neovim.io/doc/user/autocmd/#FileType) autocmd. Either use [:au](https://neovim.io/doc/user/autocmd/#%3Aau), [nvim\_create\_autocmd()](https://neovim.io/doc/user/api/#nvim_create_autocmd\(\)) or put the call in a `ftplugin/<filetype_name>.lua` (See [ftplugin-name](https://neovim.io/doc/user/usr_05/#ftplugin-name))

Parameters:

`{config}` (`vim.lsp.ClientConfig`) Configuration for the server. See [vim.lsp.ClientConfig](https://neovim.io/doc/user/lsp/#vim.lsp.ClientConfig).

`{opts}` (`table?`) Optional keyword arguments.

`{reuse_client}?` (`fun(client: vim.lsp.Client, config: vim.lsp.ClientConfig): boolean`) Predicate used to decide if a client should be re-used. Used on all running clients. The default implementation re-uses a client if it has the same name and if the given workspace folders (or root\_dir) are all included in the client's workspace folders.

`{bufnr}?` (`integer`) Buffer handle to attach to if starting or re-using a client (0 for current).

`{attach}?` (`boolean`) Whether to attach the client to a buffer (default true). If set to `false`, `reuse_client` and `bufnr` will be ignored.

`{silent}?` (`boolean`) Suppress error reporting if the LSP server fails to start (default false).

Return:

(`integer?`) client\_id

status() [vim.lsp.status()](#vim.lsp.status\(\))  
Consumes the latest progress messages from all clients and formats them as a string. Empty if there are no clients or if no new messages

Return:

(`string`)

tagfunc(`{pattern}`, `{flags}`) [vim.lsp.tagfunc()](#vim.lsp.tagfunc\(\))  
Provides an interface between the built-in client and ['tagfunc'](https://neovim.io/doc/user/options/#'tagfunc).

When used with normal mode commands (e.g. [CTRL-\]](https://neovim.io/doc/user/tagsrch/#CTRL-%5D)) this will invoke the "textDocument/definition" LSP method to find the tag under the cursor. Otherwise, uses "workspace/symbol". If no results are returned from any LSP servers, falls back to using built-in tags.

Parameters:

`{pattern}` (`string`) Pattern used to find a workspace symbol

`{flags}` (`string`) See [tag-function](https://neovim.io/doc/user/tagsrch/#tag-function)

Return:

(`table[]`) tags A list of matching tags

## Lua module: vim.lsp.buf

The `vim.lsp.buf_…` functions perform operations for LSP clients attached to the current buffer.

`{on_list}?` (`fun(t: vim.lsp.ListOpts.OnList)`) list-handler replacing the default handler. Called for any non-empty result. This table can be used with [setqflist()](https://neovim.io/doc/user/vimfn/#setqflist\(\)) or [setloclist()](https://neovim.io/doc/user/vimfn/#setloclist\(\)). E.g.:
```lua
local function on_list(options)
  vim.fn.setqflist({}, ' ', options)
  vim.cmd.cfirst()
end
vim.lsp.buf.definition({ on_list = on_list })
vim.lsp.buf.references(nil, { on_list = on_list })
```

`{loclist}?` (`boolean`) Whether to use the [location-list](https://neovim.io/doc/user/quickfix/#location-list) or the [quickfix](https://neovim.io/doc/user/quickfix/#quickfix) list in the default handler.
```lua
vim.lsp.buf.definition({ loclist = true })
vim.lsp.buf.references(nil, { loclist = false })
```

Fields:

`{items}` (`vim.quickfix.entry[]`) See [setqflist-what](https://neovim.io/doc/user/vimfn/#setqflist-what)

`{title}?` (`string`) Title for the list.

`{context}?` (`{ bufnr: integer, method: string }`) Subset of `ctx` from [lsp-handler](https://neovim.io/doc/user/lsp/#lsp-handler).

Fields:

`{silent}?` (`boolean`)

Fields:

`{silent}?` (`boolean`)

[vim.lsp.buf.add\_workspace\_folder()](#vim.lsp.buf.add_workspace_folder\(\))  
add\_workspace\_folder(`{workspace_folder}`) Add the folder at path to the workspace folders. If `{path}` is not provided, the user will be prompted for a path using [input()](https://neovim.io/doc/user/vimfn/#input\(\)).

Parameters:

`{workspace_folder}` (`string?`)

clear\_references() [vim.lsp.buf.clear\_references()](#vim.lsp.buf.clear_references\(\))  
Removes document highlights from current buffer.

code\_action(`{opts}`) [vim.lsp.buf.code\_action()](#vim.lsp.buf.code_action\(\))  
Selects a code action (LSP: "textDocument/codeAction" request) available at cursor position.

Parameters:

`{opts}` (`table?`) A table with the following fields:

`{context}?` (`lsp.CodeActionContext`) Corresponds to `CodeActionContext` of the LSP specification:

`{diagnostics}?` (`table`) LSP `Diagnostic[]`. Inferred from the current position if not provided.

`{only}?` (`table`) List of LSP `CodeActionKind` s used to filter the code actions. Most language servers support values like `refactor` or `quickfix`.

`{triggerKind}?` (`integer`) The reason why code actions were requested.

`{filter}?` (`fun(x: lsp.CodeAction|lsp.Command, client_id: integer):boolean`) Predicate taking a code action or command and the provider's ID. If it returns false, the action is filtered out.

`{apply}?` (`boolean`) When set to `true`, and there is just one remaining action (after filtering), the action is applied without user query.

`{range}?` (`{start: integer[], end: integer[]}`) Range for which code actions should be requested. If in visual mode this defaults to the active selection. Table must contain `start` and `end` keys with `{row,col}` tuples using mark-like indexing. See [api-indexing](https://neovim.io/doc/user/api/#api-indexing)

declaration(`{opts}`) [vim.lsp.buf.declaration()](#vim.lsp.buf.declaration\(\))  
Jumps to the declaration of the symbol under the cursor.

**Note:**

Many servers do not implement this method. Generally, see [vim.lsp.buf.definition()](https://neovim.io/doc/user/lsp/#vim.lsp.buf.definition\(\)) instead.

Parameters:

`{opts}` (`vim.lsp.ListOpts?`) See [vim.lsp.ListOpts](https://neovim.io/doc/user/lsp/#vim.lsp.ListOpts).

definition(`{opts}`) [vim.lsp.buf.definition()](#vim.lsp.buf.definition\(\))  
Jumps to the definition of the symbol under the cursor.

Parameters:

`{opts}` (`vim.lsp.ListOpts?`) See [vim.lsp.ListOpts](https://neovim.io/doc/user/lsp/#vim.lsp.ListOpts).

document\_highlight()  
Send request to the server to resolve document highlights for the current text document position. This request can be triggered by a key mapping or by events such as `CursorHold`, e.g.:
```
autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
```

**Note:** Usage of [vim.lsp.buf.document\_highlight()](https://neovim.io/doc/user/lsp/#vim.lsp.buf.document_highlight\(\)) requires the following highlight groups to be defined or you won't be able to see the actual highlights. [hl-LspReferenceText](https://neovim.io/doc/user/lsp/#hl-LspReferenceText) [hl-LspReferenceRead](https://neovim.io/doc/user/lsp/#hl-LspReferenceRead) [hl-LspReferenceWrite](https://neovim.io/doc/user/lsp/#hl-LspReferenceWrite)

document\_symbol(`{opts}`) [vim.lsp.buf.document\_symbol()](#vim.lsp.buf.document_symbol\(\))  
Lists all symbols in the current buffer in the [location-list](https://neovim.io/doc/user/quickfix/#location-list).

Parameters:

`{opts}` (`vim.lsp.ListOpts?`) See [vim.lsp.ListOpts](https://neovim.io/doc/user/lsp/#vim.lsp.ListOpts).

format(`{opts}`) [vim.lsp.buf.format()](#vim.lsp.buf.format\(\))  
Formats a buffer using the attached (and optionally filtered) language server clients.

`{opts}` (`table?`) A table with the following fields:

`{formatting_options}?` (`lsp.FormattingOptions`) Can be used to specify FormattingOptions. Some unspecified options will be automatically derived from the current Nvim options. See [https://microsoft.github.io/language-server-protocol/specification/#formattingOptions](https://microsoft.github.io/language-server-protocol/specification/#formattingOptions)

`{timeout_ms}?` (`integer`, default: `1000`) Time in milliseconds to block for formatting requests. No effect if async=true.

`{bufnr}?` (`integer`, default: current buffer) Restrict formatting to the clients attached to the given buffer.

`{filter}?` (`fun(client: vim.lsp.Client): boolean?`) Predicate used to filter clients. Receives a client as argument and must return a boolean. Clients matching the predicate are included. Example:
```lua
-- Never request typescript-language-server for formatting
vim.lsp.buf.format {
  filter = function(client) return client.name ~= "ts_ls" end
}
```

`{async}?` (`boolean`, default: false) If true the method won't block. Editing the buffer while formatting asynchronous can lead to unexpected changes.

`{id}?` (`integer`) Restrict formatting to the client with ID (client.id) matching this field.

`{name}?` (`string`) Restrict formatting to the client with name (client.name) matching this field.

`{range}?` (`{start:[integer,integer],end:[integer, integer]}|{start:[integer,integer],end:[integer,integer]}[]`, default: current selection in visual mode, `nil` in other modes, formatting the full buffer) Range to format. Table must contain `start` and `end` keys with `{row,col}` tuples using (1,0) indexing. Can also be a list of tables that contain `start` and `end` keys as described above, in which case `textDocument/rangesFormatting` support is required.

hover(`{config}`) [vim.lsp.buf.hover()](#vim.lsp.buf.hover\(\))  
Displays hover information about the symbol under the cursor in a floating window. The window will be dismissed on cursor move. Calling the function twice will jump into the floating window (thus by default, "KK" will open the hover window and focus it). In the floating window, all commands and mappings are available as usual, except that "q" dismisses the window. You can scroll the contents the same as you would any other buffer.

**Note:** to disable hover highlights, add the following to your config:
```lua
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    vim.api.nvim_set_hl(0, 'LspReferenceTarget', {})
  end,
})
```

Parameters:

`{config}` (`vim.lsp.buf.hover.Opts?`) See [vim.lsp.buf.hover.Opts](https://neovim.io/doc/user/lsp/#vim.lsp.buf.hover.Opts).

implementation(`{opts}`) [vim.lsp.buf.implementation()](#vim.lsp.buf.implementation\(\))  
Lists all the implementations for the symbol under the cursor in the quickfix window.

Parameters:

`{opts}` (`vim.lsp.ListOpts?`) See [vim.lsp.ListOpts](https://neovim.io/doc/user/lsp/#vim.lsp.ListOpts).

incoming\_calls() [vim.lsp.buf.incoming\_calls()](#vim.lsp.buf.incoming_calls\(\))  
Lists all the call sites of the symbol under the cursor in the [quickfix](https://neovim.io/doc/user/quickfix/#quickfix) window. If the symbol can resolve to multiple items, the user can pick one in the [inputlist()](https://neovim.io/doc/user/vimfn/#inputlist\(\)).

outgoing\_calls() [vim.lsp.buf.outgoing\_calls()](#vim.lsp.buf.outgoing_calls\(\))  
Lists all the items that are called by the symbol under the cursor in the [quickfix](https://neovim.io/doc/user/quickfix/#quickfix) window. If the symbol can resolve to multiple items, the user can pick one in the [inputlist()](https://neovim.io/doc/user/vimfn/#inputlist\(\)).

references(`{context}`, `{opts}`) [vim.lsp.buf.references()](#vim.lsp.buf.references\(\))  
Lists all the references to the symbol under the cursor in the quickfix window.

Parameters:

`{context}` (`lsp.ReferenceContext?`) Context for the request

`{opts}` (`vim.lsp.ListOpts?`) See [vim.lsp.ListOpts](https://neovim.io/doc/user/lsp/#vim.lsp.ListOpts).

[vim.lsp.buf.remove\_workspace\_folder()](#vim.lsp.buf.remove_workspace_folder\(\))  
remove\_workspace\_folder(`{workspace_folder}`) Remove the folder at path from the workspace folders. If `{path}` is not provided, the user will be prompted for a path using [input()](https://neovim.io/doc/user/vimfn/#input\(\)).

Parameters:

`{workspace_folder}` (`string?`)

rename(`{new_name}`, `{opts}`) [vim.lsp.buf.rename()](#vim.lsp.buf.rename\(\))  
Renames all references to the symbol under the cursor.

Parameters:

`{new_name}` (`string?`) If not provided, the user will be prompted for a new name using [vim.ui.input()](https://neovim.io/doc/user/lua/#vim.ui.input\(\)).

`{opts}` (`table?`) Additional options:

`{filter}?` (`fun(client: vim.lsp.Client): boolean?`) Predicate used to filter clients. Receives a client as argument and must return a boolean. Clients matching the predicate are included.

`{name}?` (`string`) Restrict clients used for rename to ones where client.name matches this field.

`{bufnr}?` (`integer`) (default: current buffer)

[vim.lsp.buf.selection\_range()](#vim.lsp.buf.selection_range\(\))  
selection\_range(`{direction}`, `{timeout_ms}`) Perform an incremental selection at the cursor position based on ranges given by the LSP. The `direction` parameter specifies the number of times to expand the selection. Negative values will shrink the selection.

Parameters:

`{direction}` (`integer`)

`{timeout_ms}` (`integer?`) (default: `1000`) Maximum time (milliseconds) to wait for a result.

signature\_help(`{config}`) [vim.lsp.buf.signature\_help()](#vim.lsp.buf.signature_help\(\))  
Displays signature information about the symbol under the cursor in a floating window. Allows cycling through signature overloads with `<C-s>`, which can be remapped via `<Plug>(nvim.lsp.ctrl-s)`

Example:
```lua
vim.keymap.set('n', '<C-b>', '<Plug>(nvim.lsp.ctrl-s)')
```

Parameters:

`{config}` (`vim.lsp.buf.signature_help.Opts?`) See [vim.lsp.buf.signature\_help.Opts](https://neovim.io/doc/user/lsp/#vim.lsp.buf.signature_help.Opts).

type\_definition(`{opts}`) [vim.lsp.buf.type\_definition()](#vim.lsp.buf.type_definition\(\))  
Jumps to the definition of the type of the symbol under the cursor.

Parameters:

`{opts}` (`vim.lsp.ListOpts?`) See [vim.lsp.ListOpts](https://neovim.io/doc/user/lsp/#vim.lsp.ListOpts).

typehierarchy(`{kind}`) [vim.lsp.buf.typehierarchy()](#vim.lsp.buf.typehierarchy\(\))  
Lists all the subtypes or supertypes of the symbol under the cursor in the [quickfix](https://neovim.io/doc/user/quickfix/#quickfix) window. If the symbol can resolve to multiple items, the user can pick one using [vim.ui.select()](https://neovim.io/doc/user/lua/#vim.ui.select\(\)).

Parameters:

`{kind}` (`"subtypes"|"supertypes"`)

workspace\_diagnostics(`{opts}`) [vim.lsp.buf.workspace\_diagnostics()](#vim.lsp.buf.workspace_diagnostics\(\))  
Request workspace-wide diagnostics.

Parameters:

`{opts}` (`table?`) A table with the following fields:

`{client_id}?` (`integer`) Only request diagnostics from the indicated client. If nil, the request is sent to all clients.

workspace\_symbol(`{query}`, `{opts}`) [vim.lsp.buf.workspace\_symbol()](#vim.lsp.buf.workspace_symbol\(\))  
Lists all symbols in the current workspace in the quickfix window.

The list is filtered against `{query}`; if the argument is omitted from the call, the user is prompted to enter a string on the command line. An empty string means no filtering is done.

Parameters:

`{query}` (`string?`) optional

`{opts}` (`vim.lsp.ListOpts?`) See [vim.lsp.ListOpts](https://neovim.io/doc/user/lsp/#vim.lsp.ListOpts).

## Lua module: vim.lsp.client

Fields:

`{attached_buffers}` (`table<integer,true>`)

`{capabilities}` (`lsp.ClientCapabilities`) Capabilities provided by the client (editor or tool), at startup.

`{commands}` (`table<string,fun(command: lsp.Command, ctx: table)>`) Client commands. See [vim.lsp.ClientConfig](https://neovim.io/doc/user/lsp/#vim.lsp.ClientConfig).

`{config}` (`vim.lsp.ClientConfig`) Copy of the config passed to [vim.lsp.start()](https://neovim.io/doc/user/lsp/#vim.lsp.start\(\)). See [vim.lsp.ClientConfig](https://neovim.io/doc/user/lsp/#vim.lsp.ClientConfig).

`{dynamic_capabilities}` (`lsp.DynamicCapabilities`) Capabilities provided at runtime (after startup).

`{exit_timeout}` (`integer|boolean`, default: `false`) See [vim.lsp.ClientConfig](https://neovim.io/doc/user/lsp/#vim.lsp.ClientConfig).

`{flags}` (`table`) Experimental client flags:

`{allow_incremental_sync}?` (`boolean`, default: `true`) Allow using incremental sync for buffer edits

`{debounce_text_changes}?` (`integer`, default: `150`) Debounce `didChange` notifications to the server by the given number in milliseconds.

`{get_language_id}` (`fun(bufnr: integer, filetype: string): string`) See [vim.lsp.ClientConfig](https://neovim.io/doc/user/lsp/#vim.lsp.ClientConfig).

`{handlers}` (`table<string,lsp.Handler>`) See [vim.lsp.ClientConfig](https://neovim.io/doc/user/lsp/#vim.lsp.ClientConfig).

`{id}` (`integer`) The id allocated to the client.

`{initialized}` (`true?`)

`{name}` (`string`) See [vim.lsp.ClientConfig](https://neovim.io/doc/user/lsp/#vim.lsp.ClientConfig).

`{offset_encoding}` (`'utf-8'|'utf-16'|'utf-32'`) See [vim.lsp.ClientConfig](https://neovim.io/doc/user/lsp/#vim.lsp.ClientConfig).

`{progress}` (`vim.lsp.Client.Progress`) A ring buffer ([vim.ringbuf()](https://neovim.io/doc/user/lua/#vim.ringbuf\(\))) containing progress messages sent by the server. See [vim.lsp.Client.Progress](https://neovim.io/doc/user/lsp/#vim.lsp.Client.Progress).

`{requests}` (`table<integer,{ type: string, bufnr: integer, method: string}?>`) The current pending requests in flight to the server. Entries are key-value pairs with the key being the request id while the value is a table with `type`, `bufnr`, and `method` key-value pairs. `type` is either "pending" for an active request, or "cancel" for a cancel request. It will be "complete" ephemerally while executing [LspRequest](https://neovim.io/doc/user/lsp/#LspRequest) autocmds when replies are received from the server.

`{root_dir}` (`string?`) See [vim.lsp.ClientConfig](https://neovim.io/doc/user/lsp/#vim.lsp.ClientConfig).

`{rpc}` (`vim.lsp.rpc.Client`) RPC client object, for low level interaction with the client. See [vim.lsp.rpc.start()](https://neovim.io/doc/user/lsp/#vim.lsp.rpc.start\(\)).

`{server_capabilities}` (`lsp.ServerCapabilities?`) Response from the server sent on `initialize` describing the server's capabilities.

`{server_info}` (`lsp.ServerInfo?`) Response from the server sent on `initialize` describing server information (e.g. version).

`{settings}` (`lsp.LSPObject`) See [vim.lsp.ClientConfig](https://neovim.io/doc/user/lsp/#vim.lsp.ClientConfig).

`{workspace_folders}` (`lsp.WorkspaceFolder[]?`) See [vim.lsp.ClientConfig](https://neovim.io/doc/user/lsp/#vim.lsp.ClientConfig).

`{request}` (`fun(self: vim.lsp.Client, method: string, params: table?, handler: lsp.Handler?, bufnr: integer?): boolean, integer?`) See [Client:request()](https://neovim.io/doc/user/lsp/#Client%3Arequest\(\)).

`{request_sync}` (`fun(self: vim.lsp.Client, method: string, params: table, timeout_ms: integer?, bufnr: integer?): {err: lsp.ResponseError?, result:any}?, string?`) See [Client:request\_sync()](https://neovim.io/doc/user/lsp/#Client%3Arequest_sync\(\)).

`{notify}` (`fun(self: vim.lsp.Client, method: string, params: table?): boolean`) See [Client:notify()](https://neovim.io/doc/user/lsp/#Client%3Anotify\(\)).

`{cancel_request}` (`fun(self: vim.lsp.Client, id: integer): boolean`) See [Client:cancel\_request()](https://neovim.io/doc/user/lsp/#Client%3Acancel_request\(\)).

`{stop}` (`fun(self: vim.lsp.Client, force: integer|boolean?)`) See [Client:stop()](https://neovim.io/doc/user/lsp/#Client%3Astop\(\)).

`{is_stopped}` (`fun(self: vim.lsp.Client): boolean`) See [Client:is\_stopped()](https://neovim.io/doc/user/lsp/#Client%3Ais_stopped\(\)).

`{exec_cmd}` (`fun(self: vim.lsp.Client, command: lsp.Command, context: {bufnr?: integer}?, handler: lsp.Handler?)`) See [Client:exec\_cmd()](https://neovim.io/doc/user/lsp/#Client%3Aexec_cmd\(\)).

`{on_attach}` (`fun(self: vim.lsp.Client, bufnr: integer)`) See [Client:on\_attach()](https://neovim.io/doc/user/lsp/#Client%3Aon_attach\(\)).

`{supports_method}` (`fun(self: vim.lsp.Client, method: string|string, bufnr: integer?): boolean`) See [Client:supports\_method()](https://neovim.io/doc/user/lsp/#Client%3Asupports_method\(\)).

Fields:

`{pending}` (`table<lsp.ProgressToken,lsp.LSPAny>`)

Fields:

`{before_init}?` (`fun(params: lsp.InitializeParams, config: vim.lsp.ClientConfig)`) Callback which can modify parameters before they are sent to the server. Invoked before LSP "initialize" phase (after `cmd` is invoked), where `params` is the parameters being sent to the server and `config` is the config passed to [vim.lsp.start()](https://neovim.io/doc/user/lsp/#vim.lsp.start\(\)).

Hint: use [vim.tbl\_deep\_extend()](https://neovim.io/doc/user/lua/#vim.tbl_deep_extend\(\)) to set nested fields easily.
```lua
before_init = function(_, config)
  config.settings = vim.tbl_deep_extend('force',
    config.settings,
    { tailwindCSS = { experimental = { configFile = find_tailwind_global_css() } } }
  )
end
```

`{capabilities}?` (`lsp.ClientCapabilities`) Map overriding the default capabilities defined by [vim.lsp.protocol.make\_client\_capabilities()](https://neovim.io/doc/user/lsp/#vim.lsp.protocol.make_client_capabilities\(\)), passed to the language server on initialization. Hint: use make\_client\_capabilities() and modify its result.

**Note:** To send an empty dictionary use [vim.empty\_dict()](https://neovim.io/doc/user/lua/#vim.empty_dict\(\)), else it will be encoded as an array.

`{cmd}` (`string[]|fun(dispatchers: vim.lsp.rpc.Dispatchers, config: vim.lsp.ClientConfig): vim.lsp.rpc.Client`) Command `string[]` that launches the language server (treated as in [jobstart()](https://neovim.io/doc/user/vimfn/#jobstart\(\)), must be absolute or on `$PATH`, shell constructs like "~" are not expanded), or function that creates an RPC client. Function receives a `dispatchers` table and the resolved `config`, and must return a table with member functions `request`, `notify`, `is_closing` and `terminate`. See [vim.lsp.rpc.request()](https://neovim.io/doc/user/lsp/#vim.lsp.rpc.request\(\)), [vim.lsp.rpc.notify()](https://neovim.io/doc/user/lsp/#vim.lsp.rpc.notify\(\)). For TCP there is a builtin RPC client factory: [vim.lsp.rpc.connect()](https://neovim.io/doc/user/lsp/#vim.lsp.rpc.connect\(\))

`{cmd_cwd}?` (`string`, default: cwd) Directory to launch the `cmd` process. Not related to `root_dir`.

`{cmd_env}?` (`table`) Environment variables passed to the LSP process on spawn. Non-string values are coerced to string. Example:
```lua
{ PORT = 8080, HOST = '0.0.0.0' }
```

`{commands}?` (`table<string,fun(command: lsp.Command, ctx: table)>`) Map of client-defined commands overriding the global [vim.lsp.commands](https://neovim.io/doc/user/lsp/#vim.lsp.commands).

`{detached}?` (`boolean`, default: `true`) Daemonize the server process so that it runs in a separate process group from Nvim. Nvim will shutdown the process on exit, but if Nvim fails to exit cleanly this could leave behind orphaned server processes.

`{exit_timeout}?` (`integer|boolean`, default: `false`) Decides if/when to force-stop the server after sending the "shutdown" request. See [Client:stop()](https://neovim.io/doc/user/lsp/#Client%3Astop\(\)). **Note:** when Nvim itself is exiting,

`false`: Nvim will not force-stop LSP server(s).

`true`: Nvim will force-stop LSP server(s) that did not comply with the "shutdown" request.

`number`: Nvim will wait up to `exit_timeout` milliseconds before performing force-stop.

`{flags}?` (`table`) Experimental client flags:

`{allow_incremental_sync}?` (`boolean`, default: `true`) Allow using incremental sync for buffer edits

`{debounce_text_changes}?` (`integer`, default: `150`) Debounce `didChange` notifications to the server by the given number in milliseconds.

`{get_language_id}?` (`fun(bufnr: integer, filetype: string): string`) Language ID as string. Defaults to the buffer filetype.

`{handlers}?` (`table<string,function>`) Map of LSP method names to [lsp-handler](https://neovim.io/doc/user/lsp/#lsp-handler) s.

`{init_options}?` (`lsp.LSPObject`) Values to pass in the initialization request as `initializationOptions`. See `initialize` in the LSP spec.

`{name}?` (`string`, default: client-id) Name in logs and user messages.

`{offset_encoding}?` (`'utf-8'|'utf-16'|'utf-32'`) Called "position encoding" in LSP spec. The encoding that the LSP server expects, used for communication. Not validated. Can be modified in `on_init` before text is sent to the server.

`{on_attach}?` (`elem_or_list<fun(client: vim.lsp.Client, bufnr: integer)>`) Callback invoked when client attaches to a buffer.

`{on_error}?` (`fun(code: integer, err: string)`) Callback invoked when the client operation throws an error. `code` is a number describing the error. Other arguments may be passed depending on the error kind. See `vim.lsp.rpc.client_errors` for possible errors. Use `vim.lsp.rpc.client_errors[code]` to get human-friendly name.

`{on_exit}?` (`elem_or_list<fun(code: integer, signal: integer, client_id: integer)>`) Callback invoked on client exit.

code: exit code of the process

signal: number describing the signal used to terminate (if any)

client\_id: client handle

`{on_init}?` (`elem_or_list<fun(client: vim.lsp.Client, init_result: lsp.InitializeResult)>`) Callback invoked after LSP "initialize", where `result` is a table of `capabilities` and anything else the server may send. For example, clangd sends `init_result.offsetEncoding` if `capabilities.offsetEncoding` was sent to it. You can only modify the `client.offset_encoding` here before any notifications are sent.

`{root_dir}?` (`string`) Directory where the LSP server will base its workspaceFolders, rootUri, and rootPath on initialization.

`{settings}?` (`lsp.LSPObject`) Map of language server-specific settings, decided by the client. Sent to the LS if requested via `workspace/configuration`. Keys are case-sensitive.

`{trace}?` (`'off'|'messages'|'verbose'`, default: "off") Passed directly to the language server in the initialize request. Invalid/empty values will

`{workspace_folders}?` (`lsp.WorkspaceFolder[]`) List of workspace folders passed to the language server. For backwards compatibility rootUri and rootPath are derived from the first workspace folder in this list. Can be `null` if the client supports workspace folders but none are configured. See `workspaceFolders` in LSP spec.

`{workspace_required}?` (`boolean`, default: `false`) Server requires a workspace (no "single file" support). **Note:** Without a workspace, cross-file features (navigation, hover) may or may not work depending on the language server, even if the server doesn't require a workspace.

Client:cancel\_request(`{id}`) [Client:cancel\_request()](#Client%3Acancel_request\(\))  
Cancels a request with a given request id.

Parameters:

`{id}` (`integer`) id of request to cancel

Return:

(`boolean`) status indicating if the notification was successful.

Client:exec\_cmd(`{command}`, `{context}`, `{handler}`) [Client:exec\_cmd()](#Client%3Aexec_cmd\(\))  
Execute a lsp command, either via client command function (if available) or via workspace/executeCommand (if supported by the server)

Parameters:

`{command}` (`lsp.Command`)

`{context}` (`{bufnr?: integer}?`)

`{handler}` (`lsp.Handler?`) only called if a server command

Client:is\_stopped() [Client:is\_stopped()](#Client%3Ais_stopped\(\))  
Checks whether a client is stopped.

Return:

(`boolean`) true if client is stopped or in the process of being stopped; false otherwise

Client:notify(`{method}`, `{params}`) [Client:notify()](#Client%3Anotify\(\))  
Sends a notification to an LSP server.

Parameters:

`{method}` (`string`) LSP method name.

`{params}` (`table?`) LSP request params.

Return:

(`boolean`) status indicating if the notification was successful. If it is false, then the client has shutdown.

Client:on\_attach(`{bufnr}`) [Client:on\_attach()](#Client%3Aon_attach\(\))  
Runs the on\_attach function from the client's config if it was defined. Useful for buffer-local setup.

Parameters:

`{bufnr}` (`integer`) Buffer number

[Client:request()](#Client%3Arequest\(\))  
Client:request(`{method}`, `{params}`, `{handler}`, `{bufnr}`) Sends a request to the server.

This is a thin wrapper around `{client.rpc.request}` with some additional checks for capabilities and handler availability.

Parameters:

`{method}` (`string`) LSP method name.

`{params}` (`table?`) LSP request params.

`{handler}` (`lsp.Handler?`) Response [lsp-handler](https://neovim.io/doc/user/lsp/#lsp-handler) for this method.

`{bufnr}` (`integer?`) (default: 0) Buffer handle, or 0 for current.

Return (multiple):

(`boolean`) status indicates whether the request was successful. If it is `false`, then it will always be `false` (the client has shutdown). (`integer?`) request\_id Can be used with [Client:cancel\_request()](https://neovim.io/doc/user/lsp/#Client%3Acancel_request\(\)). `nil` is request failed.

[Client:request\_sync()](#Client%3Arequest_sync\(\))  
Client:request\_sync(`{method}`, `{params}`, `{timeout_ms}`, `{bufnr}`) Sends a request to the server and synchronously waits for the response.

This is a wrapper around [Client:request()](https://neovim.io/doc/user/lsp/#Client%3Arequest\(\))

Parameters:

`{method}` (`string`) LSP method name.

`{params}` (`table`) LSP request params.

`{timeout_ms}` (`integer?`) Maximum time in milliseconds to wait for a result. Defaults to 1000

`{bufnr}` (`integer?`) (default: 0) Buffer handle, or 0 for current.

Return (multiple):

(`{err: lsp.ResponseError?, result:any}?`) `result` and `err` from the [lsp-handler](https://neovim.io/doc/user/lsp/#lsp-handler). `nil` is the request was unsuccessful (`string?`) err On timeout, cancel or error, where `err` is a string describing the failure reason.

Client:stop(`{force}`) [Client:stop()](#Client%3Astop\(\))  
Stops a client, optionally with force after a timeout.

By default this sends a "shutdown" request to the server, escalating to force-stop if the server has not exited after `self.exit_timeout` milliseconds (unless `exit_timeout=false`). Calling stop() on a client that was previously requested to shutdown, will escalate to force-stop immediately, regardless of `force` (or `self.exit_timeout` if `force=nil`).

**Note:** Forcing shutdown while a server is busy writing out project or index files can lead to file corruption.

Parameters:

`{force}` (`integer|boolean?`) (default: `self.exit_timeout`) Decides whether to force-stop the server.

`nil`: Defaults to `exit_timeout` from [vim.lsp.ClientConfig](https://neovim.io/doc/user/lsp/#vim.lsp.ClientConfig).

`true`: Force-stop after "shutdown" request.

`false`: Do not force-stop after "shutdown" request.

number: Wait up to `force` milliseconds before force-stop.

Client:supports\_method(`{method}`, `{bufnr}`) [Client:supports\_method()](#Client%3Asupports_method\(\))  
Checks if a client supports a given method. Always returns true for unknown off-spec methods.

**Note:** Some language server capabilities can be file specific.

Parameters:

`{method}` (`string|string`)

`{bufnr}` (`integer?`)

Return:

(`boolean`)

## Lua module: vim.lsp.codelens

enable(`{enable}`, `{filter}`) [vim.lsp.codelens.enable()](#vim.lsp.codelens.enable\(\))  
Enables or disables code lens for the `{filter}` ed scope.

To "toggle", pass the inverse of `is_enabled()`:
```lua
vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled())
```

To run a code lens, see [vim.lsp.codelens.run()](https://neovim.io/doc/user/lsp/#vim.lsp.codelens.run\(\)).

Parameters:

`{enable}` (`boolean?`) true/nil to enable, false to disable

`{filter}` (`table?`) Optional filters [kwargs](https://neovim.io/doc/user/lua/#kwargs),

`{bufnr}?` (`integer`, default: all) Buffer number, or 0 for current buffer, or nil for all.

`{client_id}?` (`integer`, default: all) Client ID, or nil for all.

get(`{filter}`) [vim.lsp.codelens.get()](#vim.lsp.codelens.get\(\))  
Get all code lenses in the `{filter}` ed scope.

Parameters:

`{filter}` (`table?`) Optional filters [kwargs](https://neovim.io/doc/user/lua/#kwargs):

`{bufnr}?` (`integer`, default: 0) Buffer handle, or 0 for current.

`{client_id}?` (`integer`, default: all) Client ID, or nil for all.

Return:

(`table[]`) A list of objects with the following fields:

`{client_id}` (`integer`)

`{lens}` (`lsp.CodeLens`)

is\_enabled(`{filter}`) [vim.lsp.codelens.is\_enabled()](#vim.lsp.codelens.is_enabled\(\))  
Query whether code lens is enabled in the `{filter}` ed scope

Parameters:

`{filter}` (`table?`) Optional filters [kwargs](https://neovim.io/doc/user/lua/#kwargs),

`{bufnr}?` (`integer`, default: all) Buffer number, or 0 for current buffer, or nil for all.

`{client_id}?` (`integer`, default: all) Client ID, or nil for all.

Return:

(`boolean`) whether code lens is enabled.

run(`{opts}`) [vim.lsp.codelens.run()](#vim.lsp.codelens.run\(\))  
Run code lens at the current cursor position.

Parameters:

`{opts}` (`table?`) Optional parameters [kwargs](https://neovim.io/doc/user/lua/#kwargs):

`{client_id}?` (`integer`, default: all) Client ID, or nil for all.

## Lua module: vim.lsp.completion

The `vim.lsp.completion` module enables insert-mode completion driven by an LSP server. Call `enable()` to make it available through Nvim builtin completion (via the [CompleteDone](https://neovim.io/doc/user/autocmd/#CompleteDone) event). Specify `autotrigger=true` to activate "auto-completion" when you type any of the server-defined `triggerCharacters`. Use `CTRL-Y` to select an item from the completion menu. [complete\_CTRL-Y](https://neovim.io/doc/user/insert/#complete_CTRL-Y)

Example: activate LSP-driven auto-completion:
```lua
-- Works best if 'completeopt' has "noselect".
-- Use CTRL-Y to select an item. |complete_CTRL-Y|
vim.cmd[[set completeopt+=menuone,noselect,popup]]
vim.lsp.start({
  name = 'ts_ls',
  cmd = …,
  on_attach = function(client, bufnr)
    vim.lsp.completion.enable(true, client.id, bufnr, {
      autotrigger = true,
      convert = function(item)
        return { abbr = item.label:gsub('%b()', '') }
      end,
    })
  end,
})
```

The LSP `triggerCharacters` field decides when to trigger autocompletion. If you want to trigger on EVERY keypress you can either:

Extend `client.server_capabilities.completionProvider.triggerCharacters` on `LspAttach`, before you call `vim.lsp.completion.enable(… {autotrigger=true})`. See the [lsp-attach](https://neovim.io/doc/user/lsp/#lsp-attach) example.

Call `vim.lsp.completion.get()` from an [InsertCharPre](https://neovim.io/doc/user/autocmd/#InsertCharPre) autocommand.

[vim.lsp.completion.enable()](#vim.lsp.completion.enable\(\))  
enable(`{enable}`, `{client_id}`, `{bufnr}`, `{opts}`) Enables or disables completions from the given language client in the given buffer. Effects of enabling completions are:

Calling [vim.lsp.completion.get()](https://neovim.io/doc/user/lsp/#vim.lsp.completion.get\(\)) uses the enabled clients to retrieve completion candidates.

Selecting a completion item shows a preview popup ("completionItem/resolve") if ['completeopt'](https://neovim.io/doc/user/options/#'completeopt) has "popup".

Accepting a completion item using `<c-y>` applies side effects like expanding snippets, text edits (e.g. insert import statements) and executing associated commands. This works for completions triggered via autotrigger, ['omnifunc'](https://neovim.io/doc/user/options/#'omnifunc) or [vim.lsp.completion.get()](https://neovim.io/doc/user/lsp/#vim.lsp.completion.get\(\)).

**Note:** the behavior of `autotrigger=true` is controlled by the LSP `triggerCharacters` field. You can override it on LspAttach, see [lsp-autocompletion](https://neovim.io/doc/user/lsp/#lsp-autocompletion).

Parameters:

`{enable}` (`boolean`) True to enable, false to disable

`{client_id}` (`integer`) Client ID

`{bufnr}` (`integer`) Buffer handle, or 0 for the current buffer

`{opts}` (`table?`) A table with the following fields:

`{autotrigger}?` (`boolean`) (default: false) When true, completion triggers automatically based on the server's `triggerCharacters`.

`{convert}?` (`fun(item: lsp.CompletionItem): table`) Transforms an LSP CompletionItem to [complete-items](https://neovim.io/doc/user/insert/#complete-items).

`{cmp}?` (`fun(a: table, b: table): boolean`) Comparator for sorting merged completion items from all servers.

get(`{opts}`) [vim.lsp.completion.get()](#vim.lsp.completion.get\(\))  
Triggers LSP completion once in the current buffer, if LSP completion is enabled (see [lsp-attach](https://neovim.io/doc/user/lsp/#lsp-attach) [lsp-completion](https://neovim.io/doc/user/lsp/#lsp-completion)).

To invoke manually with `CTRL-s` pace, use this mapping:
```lua
-- Use CTRL-space to trigger LSP completion.
-- Use CTRL-Y to select an item. |complete_CTRL-Y|
vim.keymap.set('i', '<c-space>', function()
  vim.lsp.completion.get()
end)
```

Parameters:

`{opts}` (`table?`) A table with the following fields:

`{ctx}?` (`lsp.CompletionContext`) Completion context. Defaults to a trigger kind of `invoked`.

## Lua module: vim.lsp.diagnostic

This module provides functionality for requesting LSP diagnostics for a document/workspace and populating them using [vim.Diagnostic](https://neovim.io/doc/user/diagnostic/#vim.Diagnostic) s. `DiagnosticRelatedInformation` is supported: it is included in the window shown by [vim.diagnostic.open\_float()](https://neovim.io/doc/user/diagnostic/#vim.diagnostic.open_float\(\)). When the cursor is on a line with related information, [gf](https://neovim.io/doc/user/editing/#gf) jumps to the problem location.

from(`{diagnostics}`) [vim.lsp.diagnostic.from()](#vim.lsp.diagnostic.from\(\))  
Converts the input `vim.Diagnostic` s to LSP diagnostics.

Parameters:

`{diagnostics}` (`vim.Diagnostic[]`)

Return:

(`lsp.Diagnostic[]`)

[vim.lsp.diagnostic.get\_namespace()](#vim.lsp.diagnostic.get_namespace\(\))  
get\_namespace(`{client_id}`, `{is_pull}`, `{pull_id}`) Get the diagnostic namespace associated with an LSP client [vim.diagnostic](https://neovim.io/doc/user/diagnostic/#vim.diagnostic) for diagnostics

Parameters:

`{client_id}` (`integer`) The id of the LSP client

`{is_pull}` (`boolean?`) Whether the namespace is for a pull or push client. Defaults to `false` (push).

`{pull_id}` (`string?`) (default: nil) Optional identifier for pull diagnostic providers. Only used if `is_pull` is `true`.

[vim.lsp.diagnostic.on\_diagnostic()](#vim.lsp.diagnostic.on_diagnostic\(\))  
on\_diagnostic(`{error}`, `{result}`, `{ctx}`) [lsp-handler](https://neovim.io/doc/user/lsp/#lsp-handler) for the method "textDocument/diagnostic"

Parameters:

`{error}` (`lsp.ResponseError?`)

`{result}` (`lsp.DocumentDiagnosticReport`)

`{ctx}` (`lsp.HandlerContext`)

[vim.lsp.diagnostic.on\_publish\_diagnostics()](#vim.lsp.diagnostic.on_publish_diagnostics\(\))  
on\_publish\_diagnostics(`{_}`, `{params}`, `{ctx}`) [lsp-handler](https://neovim.io/doc/user/lsp/#lsp-handler) for the method "textDocument/publishDiagnostics"

Parameters:

`{params}` (`lsp.PublishDiagnosticsParams`)

`{ctx}` (`lsp.HandlerContext`)

## Lua module: vim.lsp.document\_color

This module provides LSP support for highlighting color references in a document. Highlighting is enabled by default.

color\_presentation() [vim.lsp.document\_color.color\_presentation()](#vim.lsp.document_color.color_presentation\(\))  
Select from a list of presentations for the color under the cursor.

enable(`{enable}`, `{filter}`, `{opts}`) [vim.lsp.document\_color.enable()](#vim.lsp.document_color.enable\(\))  
Enables or disables document color highlighting for the `{filter}` ed scope.

To "toggle", pass the inverse of `is_enabled()`:
```lua
vim.lsp.document_color.enable(not vim.lsp.document_color.is_enabled())
```

Parameters:

`{enable}` (`boolean?`) True to enable, false to disable. (default: `true`)

`{filter}` (`table?`) Optional filters [kwargs](https://neovim.io/doc/user/lua/#kwargs),

`{bufnr}?` (`integer`, default: all) Buffer number, or 0 for current buffer, or nil for all.

`{client_id}?` (`integer`, default: all) Client ID, or nil for all.

`{opts}` (`table?`) A table with the following fields:

`{style}?` (`'background'|'foreground'|'virtual'|string|fun(bufnr: integer, range: vim.Range, hex_code: string)`) Highlight style. It can be one of the pre-defined styles, a string to be used as virtual text, or a function that receives the buffer handle, the range (start line, start col, end line, end col) and the resolved hex color. (default: `'background'`)

is\_enabled(`{filter}`) [vim.lsp.document\_color.is\_enabled()](#vim.lsp.document_color.is_enabled\(\))  
Query whether document colors are enabled in the `{filter}` ed scope.

Parameters:

`{filter}` (`table?`) Optional filters [kwargs](https://neovim.io/doc/user/lua/#kwargs),

`{bufnr}?` (`integer`, default: all) Buffer number, or 0 for current buffer, or nil for all.

`{client_id}?` (`integer`, default: all) Client ID, or nil for all.

Return:

(`boolean`)

## Lua module: vim.lsp.inlay\_hint

enable(`{enable}`, `{filter}`) [vim.lsp.inlay\_hint.enable()](#vim.lsp.inlay_hint.enable\(\))  
Enables or disables inlay hints for the `{filter}` ed scope.

To "toggle", pass the inverse of `is_enabled()`:
```lua
vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
```

Parameters:

`{enable}` (`boolean?`) true/nil to enable, false to disable

`{filter}` (`table?`) Optional filters [kwargs](https://neovim.io/doc/user/lua/#kwargs), or `nil` for all.

`{bufnr}` (`integer?`) Buffer number, or 0 for current buffer, or nil for all.

get(`{filter}`) [vim.lsp.inlay\_hint.get()](#vim.lsp.inlay_hint.get\(\))  
Get the list of inlay hints, (optionally) restricted by buffer or range.

Example usage:
```lua
local hint = vim.lsp.inlay_hint.get({ bufnr = 0 })[1] -- 0 for current buffer
local client = vim.lsp.get_client_by_id(hint.client_id)
local resp = client:request_sync('inlayHint/resolve', hint.inlay_hint, 100, 0)
local resolved_hint = assert(
  resp and resp.result,
  resp and resp.err and vim.lsp.rpc.format_rpc_error(resp.err) or 'request failed'
)
vim.lsp.util.apply_text_edits(resolved_hint.textEdits, 0, client.encoding)
location = resolved_hint.label[1].location
client:request('textDocument/hover', {
  textDocument = { uri = location.uri },
  position = location.range.start,
})
```

Parameters:

`{filter}` (`table?`) Optional filters [kwargs](https://neovim.io/doc/user/lua/#kwargs):

`{bufnr}` (`integer?`)

`{range}` (`lsp.Range?`)

Return:

(`table[]`) A list of objects with the following fields:

`{bufnr}` (`integer`)

`{client_id}` (`integer`)

`{inlay_hint}` (`lsp.InlayHint`)

is\_enabled(`{filter}`) [vim.lsp.inlay\_hint.is\_enabled()](#vim.lsp.inlay_hint.is_enabled\(\))  
Query whether inlay hint is enabled in the `{filter}` ed scope

Parameters:

`{filter}` (`table?`) Optional filters [kwargs](https://neovim.io/doc/user/lua/#kwargs), or `nil` for all.

`{bufnr}` (`integer?`) Buffer number, or 0 for current buffer, or nil for all.

Return:

(`boolean`)

## Lua module: vim.lsp.inline\_completion

This module provides the LSP "inline completion" feature, for completing multiline text (e.g., whole methods) instead of just a word or line, which may result in "syntactically or semantically incorrect" code. Unlike regular completion, this is typically presented as overlay text instead of a menu of completion candidates.

To try it out, here is a quickstart example using Copilot:

Install Copilot:
```sh
npm install --global @github/copilot-language-server
```

Define a config, (or copy `lsp/copilot.lua` from [https://github.com/neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)):
```lua
vim.lsp.config('copilot', {
  cmd = { 'copilot-language-server', '--stdio' },
  root_markers = { '.git' },
   init_options = {
     editorInfo = {
       name = 'Neovim', version = tostring(vim.version()) },
       editorPluginInfo = { name = 'Neovim', version = tostring(vim.version()) },
     },
})
```

Activate the config:
```lua
vim.lsp.enable('copilot')
```

Sign in to Copilot, or use the `:LspCopilotSignIn` command from [https://github.com/neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)

Enable inline completion:
```lua
vim.lsp.inline_completion.enable()
```

Set a keymap for `vim.lsp.inline_completion.get()` and invoke the keymap.

Fields:

`{client_id}` (`integer`) Client ID

`{insert_text}` (`string|lsp.StringValue`) The text to be inserted, can be a snippet.

`{range}?` (`vim.Range`) Which range it be applied.

`{command}?` (`lsp.Command`) Corresponding server command.

enable(`{enable}`, `{filter}`) [vim.lsp.inline\_completion.enable()](#vim.lsp.inline_completion.enable\(\))  
Enables or disables inline completion for the `{filter}` ed scope, inline completion will automatically be refreshed when you are in insert mode.

To "toggle", pass the inverse of `is_enabled()`:
```lua
vim.lsp.inline_completion.enable(not vim.lsp.inline_completion.is_enabled())
```

Parameters:

`{enable}` (`boolean?`) true/nil to enable, false to disable

`{filter}` (`table?`) Optional filters [kwargs](https://neovim.io/doc/user/lua/#kwargs),

`{bufnr}?` (`integer`, default: all) Buffer number, or 0 for current buffer, or nil for all.

`{client_id}?` (`integer`, default: all) Client ID, or nil for all.

get(`{opts}`) [vim.lsp.inline\_completion.get()](#vim.lsp.inline_completion.get\(\))  
Accept the currently displayed completion candidate to the buffer.

It returns false when no candidate can be accepted, so you can use the return value to implement a fallback:
```lua
vim.keymap.set('i', '<Tab>', function()
  if not vim.lsp.inline_completion.get() then
    return '<Tab>'
  end
end, { expr = true, desc = 'Accept the current inline completion' })
```

Parameters:

`{opts}` (`table?`) A table with the following fields:

`{bufnr}?` (`integer`, default: 0) Buffer handle, or 0 for current.

`{on_accept}?` (`fun(item: vim.lsp.inline_completion.Item): vim.lsp.inline_completion.Item?`) A callback triggered when a completion item is accepted. You can use it to modify the completion item that is about to be accepted and return it to apply the changes, or return `nil` to prevent the changes from being applied to the buffer so you can implement custom behavior.

Return:

(`boolean`) `true` if a completion was applied, else `false`.

is\_enabled(`{filter}`) [vim.lsp.inline\_completion.is\_enabled()](#vim.lsp.inline_completion.is_enabled\(\))  
Query whether inline completion is enabled in the `{filter}` ed scope

Parameters:

`{filter}` (`table?`) Optional filters [kwargs](https://neovim.io/doc/user/lua/#kwargs),

`{bufnr}?` (`integer`, default: all) Buffer number, or 0 for current buffer, or nil for all.

`{client_id}?` (`integer`, default: all) Client ID, or nil for all.

select(`{opts}`) [vim.lsp.inline\_completion.select()](#vim.lsp.inline_completion.select\(\))  
Switch between available inline completion candidates.

Parameters:

`{opts}` (`table?`) A table with the following fields:

`{bufnr}?` (`integer`) (default: current buffer)

`{count}?` (`integer`, default: v:count1) The number of candidates to move by. A positive integer moves forward by `{count}` candidates, while a negative integer moves backward by `{count}` candidates.

`{wrap}?` (`boolean`, default: `true`) Whether to loop around file or not. Similar to ['wrapscan'](https://neovim.io/doc/user/options/#'wrapscan).

## Lua module: vim.lsp.linked\_editing\_range

The `vim.lsp.linked_editing_range` module enables "linked editing" via a language server's `textDocument/linkedEditingRange` request. Linked editing ranges are synchronized text regions, meaning changes in one range are mirrored in all the others. This is helpful in HTML files for example, where the language server can update the text of a closing tag if its opening tag was changed.

enable(`{enable}`, `{filter}`)  
Enable or disable a linked editing session globally or for a specific client. The following is a practical usage example:
```lua
vim.lsp.start({
  name = 'html',
  cmd = '…',
  on_attach = function(client)
    vim.lsp.linked_editing_range.enable(true, { client_id = client.id })
  end,
})
```

Parameters:

`{enable}` (`boolean?`) `true` or `nil` to enable, `false` to disable.

`{filter}` (`table?`) Optional filters [kwargs](https://neovim.io/doc/user/lua/#kwargs):

`{client_id}` (`integer?`) Client ID, or `nil` for all.

## Lua module: vim.lsp.log

The `vim.lsp.log` module provides logging for the Nvim LSP client.

When debugging language servers, it is helpful to enable extra-verbose logging of the LSP client RPC events. Example:
```lua
vim.lsp.log.set_level 'trace'
vim.lsp.log.set_format_func(vim.inspect)
```

Then try to run the language server, and open the log with:
```
:log lsp
```

**Note:**

Remember to DISABLE verbose logging ("debug" or "trace" level), else you may encounter performance issues.

"ERROR" messages containing "stderr" only indicate that the log was sent to stderr. Many servers send harmless messages via stderr.

get\_filename() [vim.lsp.log.get\_filename()](#vim.lsp.log.get_filename\(\))  
Returns the log filename.

Return:

(`string`) log filename

get\_level() [vim.lsp.log.get\_level()](#vim.lsp.log.get_level\(\))  
Gets the current log level.

Return:

(`integer`) current log level

set\_format\_func(`{handle}`) [vim.lsp.log.set\_format\_func()](#vim.lsp.log.set_format_func\(\))  
Sets the formatting function used to format logs. If the formatting function returns nil, the entry won't be written to the log file.

Parameters:

`{handle}` (`fun(level:string, ...): string?`) Function to apply to log entries. The default will log the level, date, source and line number of the caller, followed by the arguments.

set\_level(`{level}`) [vim.lsp.log.set\_level()](#vim.lsp.log.set_level\(\))  
Sets the current log level.

Parameters:

`{level}` (`string|integer`) One of [vim.log.levels](https://neovim.io/doc/user/lua/#vim.log.levels)

## Lua module: vim.lsp.on\_type\_formatting

enable(`{enable}`, `{filter}`)  
Enables/disables on-type formatting globally or for the `{filter}` ed scope. The following are some practical usage examples:
```lua
-- Enable for all clients
vim.lsp.on_type_formatting.enable()
-- Enable for a specific client
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client_id = ev.data.client_id
    local client = assert(vim.lsp.get_client_by_id(client_id))
    if client.name == 'rust-analyzer' then
      vim.lsp.on_type_formatting.enable(true, { client_id = client_id })
    end
  end,
})
```

Parameters:

`{enable}` (`boolean?`) true/nil to enable, false to disable.

`{filter}` (`table?`) Optional filters [kwargs](https://neovim.io/doc/user/lua/#kwargs):

`{client_id}` (`integer?`) Client ID, or `nil` for all.

## Lua module: vim.lsp.rpc

Fields:

`{request}` (`fun(method: string, params: table?, callback: fun(err?: lsp.ResponseError, result: any, request_id: integer), notify_reply_callback?: fun(message_id: integer)):boolean,integer?`) See [vim.lsp.rpc.request()](https://neovim.io/doc/user/lsp/#vim.lsp.rpc.request\(\))

`{notify}` (`fun(method: string, params: any): boolean`) See [vim.lsp.rpc.notify()](https://neovim.io/doc/user/lsp/#vim.lsp.rpc.notify\(\))

`{is_closing}` (`fun(): boolean`) Indicates if the RPC is closing.

`{terminate}` (`fun()`) Terminates the RPC client.

connect(`{host_or_path}`, `{port}`) [vim.lsp.rpc.connect()](#vim.lsp.rpc.connect\(\))  
Create a LSP RPC client factory that connects to either:

a named pipe (windows)

a domain socket (unix)

a host and port via TCP

Return a function that can be passed to the `cmd` field for [vim.lsp.start()](https://neovim.io/doc/user/lsp/#vim.lsp.start\(\)).

Parameters:

`{host_or_path}` (`string`) host to connect to or path to a pipe/domain socket

`{port}` (`integer?`) TCP port to connect to. If absent the first argument must be a pipe

Return:

(`fun(dispatchers: vim.lsp.rpc.Dispatchers): vim.lsp.rpc.Client`)

format\_rpc\_error(`{err}`) [vim.lsp.rpc.format\_rpc\_error()](#vim.lsp.rpc.format_rpc_error\(\))  
Constructs an error message from an LSP error object.

Parameters:

`{err}` (`table`) The error object

Return:

(`string`) error\_message The formatted error message

notify(`{method}`, `{params}`) [vim.lsp.rpc.notify()](#vim.lsp.rpc.notify\(\))  
Sends a notification to the LSP server.

Parameters:

`{method}` (`string`) The invoked LSP method

`{params}` (`table?`) Parameters for the invoked LSP method

Return:

(`boolean`) `true` if notification could be sent, `false` if not

[vim.lsp.rpc.request()](#vim.lsp.rpc.request\(\))  
request(`{method}`, `{params}`, `{callback}`, `{notify_reply_callback}`) Sends a request to the LSP server and runs `{callback}` upon response.

Parameters:

`{method}` (`string`) The invoked LSP method

`{params}` (`table?`) Parameters for the invoked LSP method

`{callback}` (`fun(err: lsp.ResponseError?, result: any)`) Callback to invoke

`{notify_reply_callback}` (`fun(message_id: integer)?`) Callback to invoke as soon as a request is no longer pending

Return (multiple):

(`boolean`) success `true` if request could be sent, `false` if not (`integer?`) message\_id if request could be sent, `nil` if not

[vim.lsp.rpc.rpc\_response\_error()](#vim.lsp.rpc.rpc_response_error\(\))  
rpc\_response\_error(`{code}`, `{message}`, `{data}`) Creates an RPC response table `error` to be sent to the LSP response.

Parameters:

`{code}` (`integer`) RPC error code defined, see `vim.lsp.protocol.ErrorCodes`

`{message}` (`string?`) arbitrary message to send to server

`{data}` (`any?`) arbitrary data to send to server

Return:

(`lsp.ResponseError`)

See also:

lsp.ErrorCodes See `vim.lsp.protocol.ErrorCodes`

start(`{cmd}`, `{dispatchers}`, `{extra_spawn_params}`) [vim.lsp.rpc.start()](#vim.lsp.rpc.start\(\)) Starts an LSP server process and create an LSP RPC client object to interact with it. Communication with the spawned process happens via stdio. For communication via TCP, spawn a process manually and use [vim.lsp.rpc.connect()](https://neovim.io/doc/user/lsp/#vim.lsp.rpc.connect\(\))

Parameters:

`{cmd}` (`string[]`) Command to start the LSP server.

`{dispatchers}` (`table?`) Dispatchers for LSP message types.

`{notification}` (`fun(method: string, params: table)`)

`{server_request}` (`fun(method: string, params: table): any?, lsp.ResponseError?`)

`{on_exit}` (`fun(code: integer, signal: integer)`)

`{on_error}` (`fun(code: integer, err: any)`)

`{extra_spawn_params}` (`table?`) Additional context for the LSP server process.

`{cwd}?` (`string`) Working directory for the LSP server process

`{detached}?` (`boolean`) Detach the LSP server process from the current process

`{env}?` (`table<string,string>`) Additional environment variables for LSP server process. See [vim.system()](https://neovim.io/doc/user/lua/#vim.system\(\))

Return:

(`vim.lsp.rpc.Client`) See [vim.lsp.rpc.Client](https://neovim.io/doc/user/lsp/#vim.lsp.rpc.Client).

## Lua module: vim.lsp.semantic\_tokens

enable(`{enable}`, `{filter}`) [vim.lsp.semantic\_tokens.enable()](#vim.lsp.semantic_tokens.enable\(\))  
Enables or disables semantic tokens for the `{filter}` ed scope.

To "toggle", pass the inverse of `is_enabled()`:
```lua
vim.lsp.semantic_tokens.enable(not vim.lsp.semantic_tokens.is_enabled())
```

Parameters:

`{enable}` (`boolean?`) true/nil to enable, false to disable

`{filter}` (`table?`) Optional filters [kwargs](https://neovim.io/doc/user/lua/#kwargs),

`{bufnr}?` (`integer`, default: all) Buffer number, or 0 for current buffer, or nil for all.

`{client_id}?` (`integer`, default: all) Client ID, or nil for all.

force\_refresh(`{bufnr}`) [vim.lsp.semantic\_tokens.force\_refresh()](#vim.lsp.semantic_tokens.force_refresh\(\))  
Force a refresh of all semantic tokens

Only has an effect if the buffer is currently active for semantic token highlighting ([vim.lsp.semantic\_tokens.enable()](https://neovim.io/doc/user/lsp/#vim.lsp.semantic_tokens.enable\(\)) has been called for it)

Parameters:

`{bufnr}` (`integer?`) filter by buffer. All buffers if nil, current buffer if 0

[vim.lsp.semantic\_tokens.get\_at\_pos()](#vim.lsp.semantic_tokens.get_at_pos\(\))  
get\_at\_pos(`{bufnr}`, `{row}`, `{col}`) Return the semantic token(s) at the given position. If called without arguments, returns the token under the cursor.

Parameters:

`{bufnr}` (`integer?`) Buffer number (0 for current buffer, default)

`{row}` (`integer?`) Position row (default cursor position)

`{col}` (`integer?`) Position column (default cursor position)

Return:

(`table?`) List of tokens at position. Each token has the following fields:

line (integer) line number, 0-based

start\_col (integer) start column, 0-based

end\_line (integer) end line number, 0-based

end\_col (integer) end column, 0-based

type (string) token type as string, e.g. "variable"

modifiers (table) token modifiers as a set. E.g., { static = true, readonly = true }

client\_id (integer)

[vim.lsp.semantic\_tokens.highlight\_token()](#vim.lsp.semantic_tokens.highlight_token\(\))  
highlight\_token(`{token}`, `{bufnr}`, `{client_id}`, `{hl_group}`, `{opts}`) Highlight a semantic token.

Apply an extmark with a given highlight group for a semantic token. The mark will be deleted by the semantic token engine when appropriate; for example, when the LSP sends updated tokens. This function is intended for use inside [LspTokenUpdate](https://neovim.io/doc/user/lsp/#LspTokenUpdate) callbacks.

Parameters:

`{token}` (`table`) Semantic token, provided as `ev.data.token` in [LspTokenUpdate](https://neovim.io/doc/user/lsp/#LspTokenUpdate)

`{bufnr}` (`integer`) Buffer to highlight, or `0` for current buffer.

`{client_id}` (`integer`) ID of the [vim.lsp.Client](https://neovim.io/doc/user/lsp/#vim.lsp.Client)

`{hl_group}` (`string`) Highlight group name

`{opts}` (`table?`) Optional parameters:

`{priority}?` (`integer`, default: `vim.hl.priorities.semantic_tokens + 3`) Priority for the applied extmark.

is\_enabled(`{filter}`) [vim.lsp.semantic\_tokens.is\_enabled()](#vim.lsp.semantic_tokens.is_enabled\(\))  
Query whether semantic tokens is enabled in the `{filter}` ed scope

Parameters:

`{filter}` (`table?`) Optional filters [kwargs](https://neovim.io/doc/user/lua/#kwargs),

`{bufnr}?` (`integer`, default: all) Buffer number, or 0 for current buffer, or nil for all.

`{client_id}?` (`integer`, default: all) Client ID, or nil for all.

## Lua module: vim.lsp.util

Fields:

`{height}?` (`integer`) Height of floating window

`{width}?` (`integer`) Width of floating window

`{wrap}?` (`boolean`, default: `true`) Wrap long lines

`{wrap_at}?` (`integer`) Character to wrap at for computing height when wrap is enabled

`{max_width}?` (`integer`) Maximal width of floating window

`{max_height}?` (`integer`) Maximal height of floating window

`{focus_id}?` (`string`) If a popup with this id is opened, then focus it

`{close_events}?` (`table`) List of events that closes the floating window

`{focusable}?` (`boolean`, default: `true`) Make float focusable.

`{focus}?` (`boolean`, default: `true`) If `true`, and if `{focusable}` is also `true`, focus an existing floating window with the same `{focus_id}`

`{offset_x}?` (`integer`) offset to add to `col`

`{offset_y}?` (`integer`) offset to add to `row`

`{border}?` (`string|(string|[string,string])[]`) override `border`

`{zindex}?` (`integer`) override `zindex`, defaults to 50

`{title}?` (`string|[string,string][]`)

`{title_pos}?` (`'left'|'center'|'right'`)

`{relative}?` (`'mouse'|'cursor'|'editor'`) (default: `'cursor'`)

`{anchor_bias}?` (`'auto'|'above'|'below'`, default: `'auto'`) Adjusts placement relative to cursor.

"auto": place window based on which side of the cursor has more lines

"above": place the window above the cursor unless there are not enough lines to display the full window height.

"below": place the window below the cursor unless there are not enough lines to display the full window height.

[vim.lsp.util.apply\_text\_document\_edit()](#vim.lsp.util.apply_text_document_edit\(\))  
apply\_text\_document\_edit(`{text_document_edit}`, `{index}`, `{position_encoding}`, `{change_annotations}`) Applies a `TextDocumentEdit`, which is a list of changes to a single document.

Parameters:

`{text_document_edit}` (`lsp.TextDocumentEdit`)

`{index}` (`integer?`) Optional index of the edit, if from a list of edits (or nil, if not from a list)

`{position_encoding}` (`'utf-8'|'utf-16'|'utf-32'?`)

`{change_annotations}` (`table<string, lsp.ChangeAnnotation>?`)

[vim.lsp.util.apply\_text\_edits()](#vim.lsp.util.apply_text_edits\(\))  
apply\_text\_edits(`{text_edits}`, `{bufnr}`, `{position_encoding}`, `{change_annotations}`) Applies a list of text edits to a buffer.

Parameters:

`{text_edits}` (`(lsp.TextEdit|lsp.AnnotatedTextEdit)[]`)

`{bufnr}` (`integer`) Buffer id

`{position_encoding}` (`'utf-8'|'utf-16'|'utf-32'`)

`{change_annotations}` (`table<string, lsp.ChangeAnnotation>?`)

[vim.lsp.util.apply\_workspace\_edit()](#vim.lsp.util.apply_workspace_edit\(\))  
apply\_workspace\_edit(`{workspace_edit}`, `{position_encoding}`) Applies a `WorkspaceEdit`.

Parameters:

`{workspace_edit}` (`lsp.WorkspaceEdit`)

`{position_encoding}` (`'utf-8'|'utf-16'|'utf-32'`) (required)

buf\_clear\_references(`{bufnr}`) [vim.lsp.util.buf\_clear\_references()](#vim.lsp.util.buf_clear_references\(\))  
Removes document highlights from a buffer.

Parameters:

`{bufnr}` (`integer?`) Buffer id

[vim.lsp.util.buf\_highlight\_references()](#vim.lsp.util.buf_highlight_references\(\))  
buf\_highlight\_references(`{bufnr}`, `{references}`, `{position_encoding}`) Shows a list of document highlights for a certain buffer.

Parameters:

`{bufnr}` (`integer`) Buffer id

`{references}` (`lsp.DocumentHighlight[]`) objects to highlight

`{position_encoding}` (`'utf-8'|'utf-16'|'utf-32'`)

[vim.lsp.util.character\_offset()](#vim.lsp.util.character_offset\(\))  
character\_offset(`{buf}`, `{row}`, `{col}`, `{offset_encoding}`) Returns the UTF-32 and UTF-16 offsets for a position in a certain buffer.

Parameters:

`{buf}` (`integer`) buffer number (0 for current)

`{row}` (`integer`) 0-indexed line

`{col}` (`integer`) 0-indexed byte offset in line

`{offset_encoding}` (`'utf-8'|'utf-16'|'utf-32'?`) defaults to `offset_encoding` of first client of `buf`

Return:

(`integer`) `offset_encoding` index of the character in line `{row}` column `{col}` in buffer `{buf}`

[vim.lsp.util.convert\_input\_to\_markdown\_lines()](#vim.lsp.util.convert_input_to_markdown_lines\(\))  
convert\_input\_to\_markdown\_lines(`{input}`, `{contents}`) Converts any of `MarkedString` | `MarkedString[]` | `MarkupContent` into a list of lines containing valid markdown. Useful to populate the hover window for `textDocument/hover`, for parsing the result of `textDocument/signatureHelp`, and potentially others.

Note that if the input is of type `MarkupContent` and its kind is `plaintext`, then the corresponding value is returned without further modifications.

Parameters:

`{input}` (`lsp.MarkedString|lsp.MarkedString[]|lsp.MarkupContent`)

`{contents}` (`string[]?`) List of strings to extend with converted lines. Defaults to {}.

Return:

(`string[]`) extended with lines of converted markdown.

[vim.lsp.util.convert\_signature\_help\_to\_markdown\_lines()](#vim.lsp.util.convert_signature_help_to_markdown_lines\(\))  
convert\_signature\_help\_to\_markdown\_lines(`{signature_help}`, `{ft}`, `{triggers}`) Converts `textDocument/signatureHelp` response to markdown lines.

Parameters:

`{signature_help}` (`lsp.SignatureHelp`) Response of `textDocument/SignatureHelp`

`{ft}` (`string?`) filetype that will be use as the `lang` for the label markdown code block

`{triggers}` (`string[]?`) list of trigger characters from the lsp server. used to better determine parameter offsets

Return (multiple):

(`string[]?`) lines of converted markdown. (`Range4?`) highlight range for the active parameter

get\_effective\_tabstop(`{bufnr}`) [vim.lsp.util.get\_effective\_tabstop()](#vim.lsp.util.get_effective_tabstop\(\))  
Returns indentation size.

Parameters:

`{bufnr}` (`integer?`) Buffer handle, defaults to current

Return:

(`integer`) indentation size

[vim.lsp.util.locations\_to\_items()](#vim.lsp.util.locations_to_items\(\))  
locations\_to\_items(`{locations}`, `{position_encoding}`) Returns the items with the byte position calculated correctly and in sorted order, for display in quickfix and location lists.

The `user_data` field of each resulting item will contain the original `Location` or `LocationLink` it was computed from.

The result can be passed to the `{list}` argument of [setqflist()](https://neovim.io/doc/user/vimfn/#setqflist\(\)) or [setloclist()](https://neovim.io/doc/user/vimfn/#setloclist\(\)).

Parameters:

`{locations}` (`lsp.Location[]|lsp.LocationLink[]`)

`{position_encoding}` (`'utf-8'|'utf-16'|'utf-32'?`) default to first client of buffer

Return:

(`vim.quickfix.entry[]`) See [setqflist()](https://neovim.io/doc/user/vimfn/#setqflist\(\)) for the format

[vim.lsp.util.make\_floating\_popup\_options()](#vim.lsp.util.make_floating_popup_options\(\))  
make\_floating\_popup\_options(`{width}`, `{height}`, `{opts}`) Creates a table with sensible default options for a floating window. The table can be passed to [nvim\_open\_win()](https://neovim.io/doc/user/api/#nvim_open_win\(\)).

Parameters:

`{width}` (`integer`) window width (in character cells)

`{height}` (`integer`) window height (in character cells)

`{opts}` (`vim.lsp.util.open_floating_preview.Opts?`) See [vim.lsp.util.open\_floating\_preview.Opts](https://neovim.io/doc/user/lsp/#vim.lsp.util.open_floating_preview.Opts).

Return:

(`vim.api.keyset.win_config`)

[vim.lsp.util.make\_formatting\_params()](#vim.lsp.util.make_formatting_params\(\))  
make\_formatting\_params(`{options}`) Creates a `DocumentFormattingParams` object for the current buffer and cursor position.

Parameters:

`{options}` (`lsp.FormattingOptions?`) with valid `FormattingOptions` entries

Return:

(`lsp.DocumentFormattingParams`) object

[vim.lsp.util.make\_given\_range\_params()](#vim.lsp.util.make_given_range_params\(\))  
make\_given\_range\_params(`{start_pos}`, `{end_pos}`, `{bufnr}`, `{position_encoding}`) Using the given range in the current buffer, creates an object that is similar to [vim.lsp.util.make\_range\_params()](https://neovim.io/doc/user/lsp/#vim.lsp.util.make_range_params\(\)).

Parameters:

`{start_pos}` (`[integer,integer]?`) `{row,col}` mark-indexed position. Defaults to the start of the last visual selection.

`{end_pos}` (`[integer,integer]?`) `{row,col}` mark-indexed position. Defaults to the end of the last visual selection.

`{bufnr}` (`integer?`) buffer handle or 0 for current, defaults to current

`{position_encoding}` (`'utf-8'|'utf-16'|'utf-32'`)

Return:

(`{ textDocument: { uri: lsp.DocumentUri }, range: lsp.Range }`)

[vim.lsp.util.make\_position\_params()](#vim.lsp.util.make_position_params\(\))  
make\_position\_params(`{window}`, `{position_encoding}`) Creates a `TextDocumentPositionParams` object for the current buffer and cursor position.

Parameters:

`{window}` (`integer?`) [window-ID](https://neovim.io/doc/user/windows/#window-ID) or 0 for current, defaults to current

`{position_encoding}` (`'utf-8'|'utf-16'|'utf-32'`)

Return:

(`lsp.TextDocumentPositionParams`)

[vim.lsp.util.make\_range\_params()](#vim.lsp.util.make_range_params\(\))  
make\_range\_params(`{window}`, `{position_encoding}`) Using the current position in the current buffer, creates an object that can be used as a building block for several LSP requests, such as `textDocument/codeAction`, `textDocument/colorPresentation`, `textDocument/rangeFormatting`.

Parameters:

`{window}` (`integer?`) [window-ID](https://neovim.io/doc/user/windows/#window-ID) or 0 for current, defaults to current

`{position_encoding}` (`"utf-8"|"utf-16"|"utf-32"`)

Return:

(`{ textDocument: { uri: lsp.DocumentUri }, range: lsp.Range }`)

[vim.lsp.util.make\_text\_document\_params()](#vim.lsp.util.make_text_document_params\(\))  
make\_text\_document\_params(`{bufnr}`) Creates a `TextDocumentIdentifier` object for the current buffer.

Parameters:

`{bufnr}` (`integer?`) Buffer handle, defaults to current

Return:

(`lsp.TextDocumentIdentifier`)

[vim.lsp.util.make\_workspace\_params()](#vim.lsp.util.make_workspace_params\(\))  
make\_workspace\_params(`{added}`, `{removed}`) Create the workspace params

Parameters:

`{added}` (`lsp.WorkspaceFolder[]`)

`{removed}` (`lsp.WorkspaceFolder[]`)

Return:

(`lsp.DidChangeWorkspaceFoldersParams`)

[vim.lsp.util.open\_floating\_preview()](#vim.lsp.util.open_floating_preview\(\))  
open\_floating\_preview(`{contents}`, `{syntax}`, `{opts}`) Shows contents in a floating window.

Parameters:

`{contents}` (`table`) of lines to show in window

`{syntax}` (`string`) of syntax to set for opened buffer

`{opts}` (`vim.lsp.util.open_floating_preview.Opts?`) with optional fields (additional keys are filtered with [vim.lsp.util.make\_floating\_popup\_options()](https://neovim.io/doc/user/lsp/#vim.lsp.util.make_floating_popup_options\(\)) before they are passed on to [nvim\_open\_win()](https://neovim.io/doc/user/api/#nvim_open_win\(\))). See [vim.lsp.util.open\_floating\_preview.Opts](https://neovim.io/doc/user/lsp/#vim.lsp.util.open_floating_preview.Opts).

Return (multiple):

(`integer`) bufnr of newly created float window (`integer`) winid of newly created float window preview window

preview\_location(`{location}`, `{opts}`) [vim.lsp.util.preview\_location()](#vim.lsp.util.preview_location\(\))  
Previews a location in a floating window

behavior depends on type of location:

for Location, range is shown (e.g., function definition)

for LocationLink, targetRange is shown (e.g., body of function definition)

Parameters:

`{location}` (`lsp.Location|lsp.LocationLink`)

`{opts}` (`vim.lsp.util.open_floating_preview.Opts?`) See [vim.lsp.util.open\_floating\_preview.Opts](https://neovim.io/doc/user/lsp/#vim.lsp.util.open_floating_preview.Opts).

Return (multiple):

(`integer?`) buffer id of float window (`integer?`) window id of float window

rename(`{old_fname}`, `{new_fname}`, `{opts}`) [vim.lsp.util.rename()](#vim.lsp.util.rename\(\))  
Rename old\_fname to new\_fname

Existing buffers are renamed as well, while maintaining their bufnr.

It deletes existing buffers that conflict with the renamed file name only when

`opts` requests overwriting; or

the conflicting buffers are not loaded, so that deleting them does not result in data loss.

Parameters:

`{old_fname}` (`string`)

`{new_fname}` (`string`)

`{opts}` (`table?`) Options:

`{overwrite}?` (`boolean`)

`{ignoreIfExists}?` (`boolean`)

[vim.lsp.util.show\_document()](#vim.lsp.util.show_document\(\))  
show\_document(`{location}`, `{position_encoding}`, `{opts}`) Shows document and optionally jumps to the location.

Parameters:

`{location}` (`lsp.Location|lsp.LocationLink`)

`{position_encoding}` (`'utf-8'|'utf-16'|'utf-32'?`)

`{opts}` (`table?`) A table with the following fields:

`{reuse_win}?` (`boolean`) Jump to existing window if buffer is already open.

`{focus}?` (`boolean`) Whether to focus/jump to location if possible. (defaults: true)

Return:

(`boolean`) `true` if succeeded

[vim.lsp.util.symbols\_to\_items()](#vim.lsp.util.symbols_to_items\(\))  
symbols\_to\_items(`{symbols}`, `{bufnr}`, `{position_encoding}`) Converts symbols to quickfix list items.

Parameters:

`{symbols}` (`lsp.DocumentSymbol[]|lsp.SymbolInformation[]|lsp.WorkspaceSymbol[]`) list of symbols

`{bufnr}` (`integer?`) buffer handle or 0 for current, defaults to current

`{position_encoding}` (`'utf-8'|'utf-16'|'utf-32'?`) default to first client of buffer

Return:

(`vim.quickfix.entry[]`) See [setqflist()](https://neovim.io/doc/user/vimfn/#setqflist\(\)) for the format

## Lua module: vim.lsp.protocol

[vim.lsp.protocol.make\_client\_capabilities()](#vim.lsp.protocol.make_client_capabilities\(\))  
make\_client\_capabilities() Gets a new ClientCapabilities object describing the LSP client capabilities.

Return:

(`lsp.ClientCapabilities`)

[vim.lsp.protocol.resolve\_capabilities()](#vim.lsp.protocol.resolve_capabilities\(\))  
resolve\_capabilities(`{server_capabilities}`) Creates a normalized object describing LSP server capabilities.

Parameters:

`{server_capabilities}` (`table`) Table of capabilities supported by the server

Return:

(`lsp.ServerCapabilities?`) Normalized table of capabilities