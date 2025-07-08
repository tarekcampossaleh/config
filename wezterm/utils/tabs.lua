---@diagnostic disable: undefined-field

local wezterm = require 'wezterm'

local process_icons = {
  ['vim'] = wezterm.nerdfonts.custom_vim,
  ['nvim'] = wezterm.nerdfonts.custom_vim,
  ['make'] = wezterm.nerdfonts.seti_makefile,
  ['lazygit'] = wezterm.nerdfonts.dev_git,
}

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = tab.active_pane.title
  local process_name = tab.active_pane.foreground_process_name

  if process_name then
    process_name = process_name:match("([^/]+)$") or process_name
  end


  local tab_number = 1
  for i, t in ipairs(tabs) do
    if t.tab_id == tab.tab_id then
      tab_number = i
      break
    end
  end

  local icon = ""
  if process_name and process_icons[process_name] then
    icon = process_icons[process_name] .. "  "
  end

  local display_title = title or ""
  if display_title:match("/") then
    display_title = display_title:match("([^/]+)$") or display_title
  end

  local formatted_title = tab_number .. ". " .. icon .. display_title


  return {
    { Text = " " .. formatted_title .. " " },
  }
end)

---@param wezterm_config Config The Wezterm configuration table to modify
---@param opts? table Optional configuration overrides
---@return nil
local function apply_tabs(wezterm_config, opts)
  assert(type(wezterm_config) == 'table', 'wezterm_config must be a table')

  wezterm_config.use_fancy_tab_bar = true
  wezterm_config.tab_bar_at_bottom = false
  wezterm_config.hide_tab_bar_if_only_one_tab = false
  wezterm_config.tab_max_width = 64
  wezterm_config.unzoom_on_switch_pane = true

  wezterm_config.window_frame = {
    -- Use SF Mono font for tab bar
    font = wezterm.font("SF Mono"),
    font_size = 12,
    inactive_titlebar_bg = "rgba(34, 39, 54, 0.85)", -- Tokyo Night Moon background
    active_titlebar_bg = "rgba(34, 39, 54, 0.85)",   -- Tokyo Night Moon background
    inactive_titlebar_fg = "#c8d3f5",                -- Tokyo Night Moon foreground
    active_titlebar_fg = "#c8d3f5",                  -- Tokyo Night Moon foreground
    inactive_titlebar_border_bottom = "#2d3f76",     -- Tokyo Night Moon border
    active_titlebar_border_bottom = "#2d3f76",       -- Tokyo Night Moon border
  }

  wezterm_config.colors = wezterm_config.colors or {}
  wezterm_config.colors.tab_bar = {
    background = "rgba(34, 39, 54, 0.85)",  -- Tokyo Night Moon background
    active_tab = {
      bg_color = "rgba(45, 63, 118, 0.85)", -- Tokyo Night Moon active tab
      fg_color = "#c8d3f5",                 -- Tokyo Night Moon foreground
    },
    inactive_tab = {
      bg_color = "rgba(34, 39, 54, 0.85)", -- Tokyo Night Moon background
      fg_color = "#828bb8",                -- Tokyo Night Moon muted foreground
    },
    inactive_tab_hover = {
      bg_color = "rgba(45, 63, 118, 0.5)", -- Tokyo Night Moon hover
      fg_color = "#c8d3f5",                -- Tokyo Night Moon foreground
    },
    new_tab = {
      bg_color = "rgba(34, 39, 54, 0.85)", -- Tokyo Night Moon background
      fg_color = "#828bb8",                -- Tokyo Night Moon muted foreground
    },
    new_tab_hover = {
      bg_color = "rgba(45, 63, 118, 0.5)", -- Tokyo Night Moon hover
      fg_color = "#c8d3f5",                -- Tokyo Night Moon foreground
    },
  }

  -- Apply any custom options
  if opts then
    for k, v in pairs(opts) do
      wezterm_config[k] = v
    end
  end
end

return apply_tabs
