'*************************************************************
'** Logic for displaying the streaming video.
'*************************************************************

Function displayVideo(channel As string, args As Dynamic)
    print "Displaying video: " + channel
    p = CreateObject("roMessagePort")
    video = CreateObject("roVideoScreen")
    video.setMessagePort(p)

    baseUrl = "http://" + RegRead("server_address", "preferences") +":" + RegRead("server_port", "preferences")
    url = baseUrl + "/channels/" + channel + ".m3u8"
    
    videoclip = CreateObject("roAssociativeArray")
    videoclip.StreamBitrates = [0]   'adaptive bitrate
    videoclip.StreamUrls = [url]
    videoclip.StreamQualities = ["HD"]
    videoclip.StreamFormat = "hls"
    videoclip.Title = channel
    video.SetContent(videoclip)
    video.show()

    lastSavedPos   = 0
    statusInterval = 10 'position must change by more than this number of seconds before saving

    while true
        msg = wait(0, video.GetMessagePort())
        if type(msg) = "roVideoScreenEvent"
            if msg.isScreenClosed() then 'ScreenClosed event
                print "Closing video screen"
                stopChannel(channel)
                exit while
            else if msg.isPlaybackPosition() then
                nowpos = msg.GetIndex()
                if nowpos > 10000
                    
                end if
                if nowpos > 0
                    if abs(nowpos - lastSavedPos) > statusInterval
                        lastSavedPos = nowpos
                    end if
                end if
            else if msg.isRequestFailed()
                print "play failed: "; msg.GetMessage()
            else
                print "Unknown event: "; msg.GetType(); " msg: "; msg.GetMessage()
            endif
        end if
    end while
End Function
