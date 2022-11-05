hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

local isLaptop = hs.battery.name() ~= nil
local soco = os.getenv("HOME") .. "/.local/bin/soco"
local speaker = 'Office'
local volumeLow = '5'
local volumeHigh = '10'

function _() end

function volumeUp()
    hs.task.new(soco, nil, _, {speaker, 'volume', volumeHigh}):start()
end

function volumeDown()
    hs.task.new(soco, nil, _, {speaker, 'volume', volumeLow}):start()
end

function play()
    hs.task.new(soco, nil, _, {speaker, 'play'}):start()
end

function pause()
    hs.task.new(soco, nil, _, {speaker, 'pause'}):start()
end

function sleepWatch(eventType)
    if eventType == hs.caffeinate.watcher.systemWillSleep then
        if isLaptop then
            hs.wifi.setPower(false)
        end

        if not isLaptop then
            pause()
        end
    elseif eventType == hs.caffeinate.watcher.systemDidWake then
        if isLaptop then
            hs.wifi.setPower(true)
        end

        if not isLaptop then
            play()
        end
    elseif eventType == hs.caffeinate.watcher.screensDidLock then
        volumeDown()
    elseif eventType == hs.caffeinate.watcher.screensDidUnlock then
        volumeUp()
    end
end

hs.caffeinate.watcher.new(sleepWatch):start()

zoom_meeting = hs.window.filter.new(false):setAppFilter('zoom.us', {allowTitles={'Zoom Meeting', 'zoom share'}})
zoom_meeting:subscribe(hs.window.filter.windowCreated, volumeDown)
zoom_meeting:subscribe(hs.window.filter.windowDestroyed, volumeUp)
