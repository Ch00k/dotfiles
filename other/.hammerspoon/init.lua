local wf = hs.window.filter
wf_alacritty = wf.new{'Alacritty'}
wf_alacritty:subscribe(wf.windowFocused, function(window, title)
    hs.keycodes.setLayout('U.S.')
end)
