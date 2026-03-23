-- Alt + H/J/K/L でウィンドウ間のフォーカス移動 (Vim風)
hs.hotkey.bind({"alt"}, "H", function()
    local win = hs.window.focusedWindow()
    if win then win:focusWindowWest() end
end)

hs.hotkey.bind({"alt"}, "J", function()
    local win = hs.window.focusedWindow()
    if win then win:focusWindowSouth() end
end)

hs.hotkey.bind({"alt"}, "K", function()
    local win = hs.window.focusedWindow()
    if win then win:focusWindowNorth() end
end)

hs.hotkey.bind({"alt"}, "L", function()
    local win = hs.window.focusedWindow()
    if win then win:focusWindowEast() end
end)

-- 設定リロード時の通知
hs.alert.show("Hammerspoon config loaded")
