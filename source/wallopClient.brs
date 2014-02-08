'******************************************************
' This file holds functions responsible for interacting
' with the Wallop API specifically, which is defined at
' https://github.com/maddox/wallop/tree/master/docs
'******************************************************


' Gets a list of channels from Wallop.  Takes a boolean
' argument favorites to filter the results further.
function getChannelsFromApi(favorites As Boolean) As Object
    request = CreateObject("roUrlTransfer")
    url = getBaseWallopUrl() + "/channels"
    if favorites = true then
        url = url + "?type=favorites"
    end if
    request.SetUrl(url)
    html = request.GetToString()
    data = html.Trim() 
    json = ParseJSON(data)

    if json <> invalid then
        return json.channels
    else
        return []
    end if

End Function


' Tells Wallop to tune to a specified channel number.
' This function will block until Wallop reports that
' the channel is ready.
'
' #TODO handle wallop timing out and getting stuck in
' this while loop.
function tuneChannel(channelNum As string)
    request = CreateObject("roUrlTransfer")
    url = getBaseWallopUrl() + "/channels/" + channelNum + "/tune"
    request.SetUrl(url)
    request.PostFromString("")
    sleep(500)

    waiting = true
    while waiting
        print "Waiting on channel to be ready"
        request = CreateObject("roUrlTransfer")
        url = getBaseWallopUrl() + "/channels/" + channelNum + "/status"
        request.SetUrl(url)
        response = request.GetToString()
        data = response.Trim() 
        json = ParseJSON(data)
        if json = invalid OR json.ready <> true then
            ' Wait and ask again
            sleep(500)
        else
            ' Done waiting, exit the while loop.
            waiting = false
        end if
    end while
    print "DONE tuning channel"

End Function

' Tells Wallop to stop the specified channel number.
function stopChannel(channelNum As string)
    request = CreateObject("roUrlTransfer")
    url = getBaseWallopUrl() + "/channels/" + channelNum + "/stop"
    request.SetUrl(url)
    request.PostFromString("")
End Function

' Simple helper method for building the Wallop server 
' path defined in the user settings
function getBaseWallopUrl() As string
    url = "http://" + RegRead("server_address", "preferences") +":" + RegRead("server_port", "preferences")
    return url
End Function
