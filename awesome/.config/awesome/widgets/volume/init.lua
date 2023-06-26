-- Volume Widget
-- Imports

local awful                    = require("awful")
local gears                    = require("gears")
local wibox                    = require("wibox")
local watch                    = require("awful.widget.watch")

local function getVolumeCMD    () return 'amixer -D pulse sget Master' end
local function upVolumeCMD     (value) return 'amixer sset Master ' .. value.. '%+' end
local function downVolumeCMD   (value) return 'amixer sset Master ' .. value.. '%-' end
local function toggleVolumeCMD () return 'amixer sset Master toggle' end

-- locals

local shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 25) end

local volumeIcon = wibox.widget {
  markup = '<span color="#000000">󰕾 </span>',
  font = 'SFMono 12',
  widget = wibox.widget.textbox,
}

local volumePopupText = wibox.widget {
  markup = '<span color="#000000">󰕾 </span>',
  font = 'SFMono 10',
  widget = wibox.widget.textbox
}

local volumePopupProgress = wibox.widget {
  value         = 0,
  max_value     = 100,
  forced_height = 25,
  forced_width  = 200,
  widget        = wibox.widget.progressbar,
  shape         = shape,
  bar_shape     = shape,
  paddings      = 3,
  border_width  = 1,
  border_color  = '#000000',
  background_color = '#00000000',
  color         = '#000000',
  margins       = {
      left = 15,
      right = 35,
      bottom = 5,
      top = 5,
  },
}

local volumePopup = awful.popup({
  height = 25,
  bg = "#00000000",
  ontop = true,
  visible = false,
  placement = awful.placement.centered,
  widget = {
    widget = wibox.container.background,
    bg = '#E9DCC9',
    spacing = 5,
    shape = shape,
    {
      {
          widget = wibox.container.margin,
          left = 35,
          volumePopupText
      },
      volumePopupProgress,
      layout = wibox.layout.fixed.horizontal,
    },
  }
})

VolumeTimer = gears.timer {
  timeout   = 4,
  callback  = function()
    volumePopup.visible = false
  end
}

local function displayPopup()
  if volumePopup.visible == false then
    volumePopup.visible = true
    VolumeTimer:start()
  else
    volumePopup.visible = true
    VolumeTimer:again()
  end
end

local function updateVolumeIcon(value)
  if value == 0 then
    volumeIcon.markup = '<span color="#000000">󰸈 </span>'
    volumePopupText.markup = '<span color="#000000">󰸈 </span>'
  elseif value < 33 then
    volumeIcon.markup = '<span color="#000000">󰕿 </span>'
    volumePopupText.markup = '<span color="#000000">󰕿 </span>'
  elseif value < 66 then
    volumeIcon.markup = '<span color="#000000">󰖀 </span>'
    volumePopupText.markup = '<span color="#000000">󰖀 </span>'
  else
    volumeIcon.markup = '<span color="#000000">󰕾 </span>'
    volumePopupText.markup = '<span color="#000000">󰕾 </span>'
  end
end

local function muteIcons()
  volumeIcon.markup = '<span color="#000000">󰸈 </span>'
  volumePopupText.markup = '<span color="#000000">󰸈 </span>'
end

local function unMuteIcons()
  volumeIcon.markup = '<span color="#000000">󰕾 </span>'
  volumePopupText.markup = '<span color="#000000">󰕾 </span>'
end

local function newVolume(cmd)
  awful.spawn.easy_async(
    cmd,
    function(stdout)
      local volume_level = string.match(stdout, "(%d?%d?%d)%%")
      volume_level = tonumber(string.format("% 3d", volume_level))

      local mute = string.match(stdout, "%[(o%D%D?)%]")

      if mute == 'off' then
        muteIcons()
        volumePopupProgress:set_value(0)
      elseif mute == 'on' then
        unMuteIcons()
        volumePopupProgress:set_value(volume_level)
        updateVolumeIcon(volume_level)
      end
    end
  )
end

-- Widget 

local volume = {}

function volume:new()
  function self:up()
    newVolume(upVolumeCMD("5"))
    displayPopup()
  end

  function self:down()
    newVolume(downVolumeCMD("5"))
    displayPopup()
  end

  function self:mute()
    newVolume(toggleVolumeCMD())
    displayPopup()
  end

  self.widget = volumeIcon

  watch(getVolumeCMD(),
    1,
    function()
      newVolume(getVolumeCMD())
    end,
    self.widget
  )

  return self
end


return setmetatable(volume, {
    __call = volume.new,
})
