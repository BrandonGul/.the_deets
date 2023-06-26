-- Volume Widget
-- Imports

local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local naughty = require("naughty")

-- locals

local shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 25) end

local brightnessIcon= wibox.widget {
  markup = '<span font="SFMono 12" color="#000000">󰉄 </span><span color="#000000">0</span>',
  font = 'SFMono 10',
  widget = wibox.widget.textbox,
}

local volumePopupText = wibox.widget {
  markup = '<span font="SFMono 12" color="#000000">󰉄 </span>',
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

BrightnessTimer = gears.timer {
  timeout   = 4,
  callback  = function()
    volumePopup.visible = false
  end
}

local function updateBrightnessIcon(value)
  if value == 0 then
    volumeIcon.markup = '<span color="#000000">󰸈 </span>'
  elseif value < 33 then
    volumeIcon.markup = '<span color="#000000">󰕿 </span>'
  elseif value < 66 then
    volumeIcon.markup = '<span color="#000000">󰖀 </span>'
  else
    volumeIcon.markup = '<span color="#000000">󰕾 </span>'
  end
end

local function updateBrightness(value)
  awful.spawn.easy_async(
    value,
    function(stdout)
      awful.spawn.easy_async(
        "light -G",
        function(test)
          local brightness = test
          volumePopupText.markup = '<span font="SFMono 12" color="#000000">󰉄 </span>'

          if tonumber(brightness) >= 10 then
            volumePopupProgress.value = math.floor(brightness)
          else
            volumePopupProgress.value = 0
          end
        end
      )
    end
  )
end

local function displayPopup()
  if volumePopup.visible == false then
    volumePopup.visible = true
    BrightnessTimer:start()
  else
    volumePopup.visible = true
    BrightnessTimer:again()
  end
end

-- Widget 

local brightness= {}

function brightness:new()
  function self:up()
    updateBrightness("light -A 5")
    displayPopup()
  end

  function self:down()
    updateBrightness("light -U 5")
    displayPopup()
  end

  return self
end

return setmetatable(brightness, {
    __call = brightness.new,
})
