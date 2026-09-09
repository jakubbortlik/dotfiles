-- ~/.config/jjui/config.lua -- custom jjui actions.
--
-- Open the file under the cursor in the details listing in neovim.
--
-- When jjui runs inside neovim's built-in terminal (e.g., a Snacks.terminal float),
-- neovim exports $NVIM pointing at the parent instance's RPC socket. In that case
-- the file is handed to the parent over --remote-expr and jjui quits, which lets the
-- float close itself -- the same net behaviour as lazygit's `nvim-remote`
-- editPreset. Outside neovim, nvim simply takes over the terminal, and control returns
-- to jjui after quitting Neovim.

local EDITOR = "nvim"

---Quote a string as a single POSIX shell word.
---@param s string
---@return string
local function shell_quote(s)
  return "'" .. s:gsub("'", "'\\''") .. "'"
end

---Quote a string as a vimscript single-quoted literal.
---@param s string
---@return string
local function vim_quote(s)
  return "'" .. s:gsub("'", "''") .. "'"
end

local function file_exists(path)
   local f = io.open(path)
   if not f then
      return false
   else
      f:close()
   end
   return true
end

---Absolute path of the file under the cursor.
---
---jjui reports repository-relative paths, while the parent neovim resolves relative
---paths against its own directory, so anchor them to the repository root.
---@param repo_root string
---@return string? path
---@return string? reason Why there is no path (nil on success)
local function selected_file_path(repo_root)
  local file = context.file()
  if not file or file == "" then
    return nil, "no file under the cursor"
  end
  if repo_root == "" then
    return nil, "repository root is unknown"
  end

  local file_path = file:sub(1, 1) == "/" and file or repo_root .. "/" .. file
  if not file_exists(file_path) then
    return nil, "file doesn't exist: " .. file_path
  end

  return file_path
end

-- Lua expression evaluated by the *parent* neovim, with `_A` bound to
-- [edit_cmd, path]. `win_execute()` deliberately leaves the cursor where it is, so
-- focus the window first and then run the command there like a user would.
--
-- $NVIM_LAST_WIN is read here rather than in jjui, because Snacks reuses a terminal
-- for the same command: a jjui process started from one window keeps that window id
-- in its environment forever, while the parent's `vim.env` is always current.
--
-- Kept single-line and free of single quotes so it survives the vimscript literal.
local REMOTE_OPEN = table.concat({
  '(function(a)',
  '  local function usable(w)',
  '    return vim.api.nvim_win_is_valid(w)',
  '      and vim.api.nvim_win_get_config(w).relative == ""',
  '      and vim.bo[vim.api.nvim_win_get_buf(w)].buftype == ""',
  '  end',
  '  local target = tonumber(vim.env.NVIM_LAST_WIN)',
  '  if not (target and usable(target)) then',
  '    target = nil',
  '    for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do',
  '      if usable(w) then target = w break end',
  '    end',
  '  end',
  '  if target then vim.api.nvim_set_current_win(target) end',
  '  vim.cmd((target and a[1] or "tabedit") .. " " .. vim.fn.fnameescape(a[2]))',
  '  return 1',
  'end)(_A)',
}, " ")

---@param repo_root string
---@param edit_cmd? string Ex command the parent opens the file with, default `edit`
local function open_in_editor(repo_root, edit_cmd)
  edit_cmd = edit_cmd or "edit"
  return function()
    local path, reason = selected_file_path(repo_root)
    if not path then
      flash({ text = reason or "something went wrong", error = true })
      return
    end

    local server = os.getenv("NVIM")
    if not server or server == "" then
      -- Standalone: hand the terminal over and come back once nvim exits.
      exec_shell(EDITOR .. " -- " .. shell_quote(path))
      return
    end

    -- Inside neovim's terminal: talk to the parent instead of nesting an editor.
    --
    -- os.execute rather than exec_shell, because exec_shell releases the terminal to
    -- the child and then stops for "press enter to continue" on anything that exits
    -- within 5s without touching tty raw mode -- which is exactly this call.
    --
    -- All three of the child's descriptors have to be detached from jjui's tty: the
    -- nvim client puts O_NONBLOCK on them while starting up, and that flag lives on
    -- the shared open file description, so jjui's own reads start failing with
    -- EAGAIN and bubbletea dies with a non-zero exit status.
    --
    -- --remote-expr, not --remote-send: it is evaluated over RPC and returns only
    -- once the parent is done, so it neither depends on the float being in terminal
    -- mode nor races with jjui quitting underneath the queued keys.
    local expr = table.concat({
      "luaeval(",
      vim_quote(REMOTE_OPEN),
      ", [",
      vim_quote(edit_cmd),
      ", ",
      vim_quote(path),
      "])",
    })
    local cmd = table.concat({
      EDITOR,
      "--server",
      shell_quote(server),
      "--remote-expr",
      shell_quote(expr),
      "</dev/null >/dev/null 2>&1",
    }, " ")
    if os.execute(cmd) ~= 0 then
      flash({ text = "could not reach neovim at " .. server, error = true })
      return
    end

    -- Quitting is what closes the Snacks float, so it has to come after the file is
    -- already open in the parent.
    jjui.ui.quit()
  end
end

function setup(config)
  -- jjui resolves the repository root at startup, so take it from here rather than
  -- shelling out to `jj root` on every keypress.
  local function open(edit_cmd)
    return open_in_editor(config.repo, edit_cmd)
  end

  config.action("open_in_editor", open(), {
    key = "e",
    scope = "revisions.details",
    desc = "open in editor",
  })
  config.action("open_in_vertical_split", open("vne"), {
    key = "ctrl+v",
    scope = "revisions.details",
    desc = "open in vertical split",
  })
  config.action("open_in_split", open("new"), {
    key = "ctrl+x",
    scope = "revisions.details",
    desc = "open in split",
  })
  config.action("open_in_new_tab", open("tab new"), {
    key = "ctrl+t",
    scope = "revisions.details",
    desc = "open in new tab",
  })
  -- diffs against whatever $NVIM_LAST_WIN holds, i.e. the buffer jjui was opened from
  config.action("open_in_diff", open("vertical diffsplit"), {
    key = "ctrl+d",
    scope = "revisions.details",
    desc = "open in diff",
  })
end
