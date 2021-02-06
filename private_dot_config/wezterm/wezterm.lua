local wezterm = require 'wezterm';

return {
  font = wezterm.font("JetBrainsMono Nerd Font Mono"),
  -- The font size, measured in points
  font_size = 11.0,

  -- The DPI to assume, measured in dots-per-inch
  -- This is not automatically probed!  If you experience blurry text
  -- or notice slight differences when comparing with other terminal
  -- emulators, you may wish to tune this value!
  dpi = 96.0,

  -- (available starting in version 20210203-095643-70a364eb)
  -- Scale the effective cell height.
  -- The cell height is computed based on your selected font_size
  -- and dpi and then multiplied by line_height.  Setting it to
  -- eg: 1.2 will result in the spacing between lines being 20%
  -- larger than the distance specified by the font author.
  -- Setting it to eg: 0.9 will make it 10% smaller.
  line_height = 1.0,

  -- When true (the default), text that is set to ANSI color
  -- indices 0-7 will be shifted to the corresponding brighter
  -- color index (8-15) when the intensity is set to Bold.
  --
  -- This brightening effect doesn't occur when the text is set
  -- to the default foreground color!
  --
  -- This defaults to true for better compatibility with a wide
  -- range of mature software; for instance, a lot of software
  -- assumes that Black+Bold renders as a Dark Grey which is
  -- legible on a Black background, but if this option is set to
  -- false, it would render as Black on Black.
  bold_brightens_ansi_colors = true,
  font_antialias = "Greyscale", -- None, Greyscale, Subpixel
  font_hinting = "Full",  -- None, Vertical, VerticalSubpixel, Full
  color_scheme = "SpaceLight",
  -- Enable the scrollbar.
  -- It will occupy the right window padding space.
  -- If right padding is set to 0 then it will be increased
  -- to a single cell width
  enable_scroll_bar = true,
}
