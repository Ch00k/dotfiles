logger = hs.logger.new("init", "info")

local isLaptop = hs.battery.name() ~= nil
local caffeinate = "/usr/bin/caffeinate"
local wifiInterface = "en0"
local vpn = "/usr/local/bin/mullvad"

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

function runCaffeinate()
    hs.task.new(caffeinate, nil, _, {}):start()
end

function wifiUp()
    logger.i("Enabling WiFi power")
    hs.wifi.setPower(true)
end

function wifiDown()
    logger.i("Disabling WiFi power")
    hs.wifi.setPower(false)
end

function wifiStatus()
    wifiPower = hs.wifi.interfaceDetails(wifiInterface).power

    if wifiPower then
        status = "enabled"
    else
        status = "disabled"
    end

    logger.i("WiFi power " .. status)
end

function vpnConnect()
    logger.i("Connecting VPN")
    hs.task.new(vpn, nil, _, {"connect"}):start()
end

function vpnDisconnect()
    logger.i("Disconnecting VPN")
    hs.task.new(vpn, nil, _, {"disconnect"}):start()
end

function sleepWatch(eventType)
    if eventType == hs.caffeinate.watcher.systemWillSleep then
        logger.i("Will sleep")

        --vpnDisconnect()

        if isLaptop then
            wifiDown()
        end

        if not isLaptop then
            pause()
        end
    elseif eventType == hs.caffeinate.watcher.systemDidWake then
        logger.i("Woke up")

        if isLaptop then
            wifiStatus()
            wifiUp()
        end

        --vpnConnect()

        if not isLaptop then
            play()
        end
    elseif eventType == hs.caffeinate.watcher.screensDidLock then
        logger.i("Screen locked")

        if not isLaptop then
            volumeDown()
        end
    elseif eventType == hs.caffeinate.watcher.screensDidUnlock then
        logger.i("Screen unlocked")

        if not isLaptop then
            volumeUp()
        end
    end
end

runCaffeinate()
hs.caffeinate.watcher.new(sleepWatch):start()

if not isLaptop then
    zoom_meeting = hs.window.filter.new(false):setAppFilter('zoom.us', {allowTitles={'Zoom Meeting', 'zoom share'}})
    zoom_meeting:subscribe(hs.window.filter.windowCreated, volumeDown)
    zoom_meeting:subscribe(hs.window.filter.windowDestroyed, volumeUp)
end
