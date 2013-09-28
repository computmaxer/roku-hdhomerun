'******************************************************
' Most of this is based on the grid example in the 
' ROKU SDK
'******************************************************

' Perform any startup/initialization stuff prior to 
' initially showing the screen.  
Function preShowGridScreen() As Object

    m.port=CreateObject("roMessagePort")
    screen = CreateObject("roGridScreen")
    screen.SetMessagePort(m.port)
    screen.SetDisplayMode("scale-to-fill")

    screen.SetGridStyle("Flat-Movie")
    return screen

End Function

' Display the gird screen and wait for events from 
' the screen. The screen will show retreiving while
' we fetch and parse the feeds for the show posters
Function showGridScreen(screen As Object) As string

    categoryList = getCategoryList()
    screen.setupLists(categoryList.count())
    screen.SetListNames(categoryList)
    showArray = []

    for i = 0 to categoryList.count()-1
        channels = getShowsForCategoryItem(categoryList[i])
        showArray[i] = channels
        screen.SetContentList(i, channels)
    end for
    screen.Show()

    while true
        print "Waiting for message"
        msg = wait(0, m.port)
        'msg = wait(0, screen.GetMessagePort())     ' getmessageport does not work on gridscreen
        print "Got Message:";type(msg)
        if type(msg) = "roGridScreenEvent" then
            print "msg= "; msg.GetMessage() " , index= "; msg.GetIndex(); " data= "; msg.getData()
            if msg.isListItemFocused() then
                print"list item focused | current show = "; msg.GetIndex()
            else if msg.isListItemSelected() then
                row = msg.GetIndex()
                selection = msg.getData()
                print "list item selected row= "; row; " selection= "; selection

                ' Did we get a selection from settings row?
                if (row = 2)
                    ' open settings screen
                    print "Settings screen opened"
                    showSettingsScreen()
                    return "yes"
                else
                    chanNum = showArray[row][selection].chanNum
                    print "Getting ready to view chanNum="; chanNum
                    tuneChannel(chanNum)
                    displayVideo(chanNum, "")
                    return "yes"
                endif

            else if msg.isScreenClosed() then
                return ""
            end if
        end If
    end while


End Function


' Return the list of categories to display in the filter
' banner. The result is an roArray containing the names of 
' all of the categories. All just static data for the example.
Function getCategoryList() As Object

    if RegRead("server_address", "preferences", invalid) = invalid OR RegRead("server_port", "preferences", invalid) = invalid then
        categoryList = ["Settings"]
    else
        categoryList = [ "Favorites", "All Channels", "Settings"]
    end if
    return categoryList

End Function


' Given the category from the filter banner, return an array 
' of ContentMetaData objects (roAssociativeArray's) representing 
' the shows for the category. For this example, we just cheat and
' create and return a static array with just the minimal items
' set, but ideally, you'd go to a feed service, fetch and parse
' this data dynamically, so content for each category is dynamic
Function getShowsForCategoryItem(category As Object) As Object

    print "getting shows for category "; category

    if category = "Settings" then
        showList = [
            {
              Title: "Settings",
            }
        ]
    else if category = "Favorites" then
        showList = []
        channels = getChannelsFromApi(true)
        for i = 0 to channels.count() - 1
            channel = channels[i]
            showList.Push({
                Title: channel.GuideNumber + " " + channel.GuideName,
                chanNum: channel.GuideNumber,
                chanName: channel.GuideName,
                HDPosterUrl: channel.LogoUrl,
                SDPosterUrl: channel.LogoUrl
            })
        end for
    else
        showList = []
        channels = getChannelsFromApi(false)
        for i = 0 to channels.count() - 1
            channel = channels[i]
            showList.Push({
                Title: channel.GuideNumber + " " + channel.GuideName,
                chanNum: channel.GuideNumber,
                chanName: channel.GuideName,
                HDPosterUrl: channel.LogoUrl,
                SDPosterUrl: channel.LogoUrl
            })
        end for
    end if
    ' for reference
    '     {
    '         Title: category + ": Header",
    '         releaseDate: "1976",
    '         length: 3600-600,
    '         Description:"This row is category " + category,
    '         hdBranded: true,
    '         HDPosterUrl:"http://upload.wikimedia.org/wikipedia/commons/4/43/Gold_star_on_blue.gif",
    '         SDPosterUrl:"http://upload.wikimedia.org/wikipedia/commons/4/43/Gold_star_on_blue.gif",
    '         Description:"Short Synopsis #1",
    '         Synopsis:"Length",
    '         StarRating:10,
    '     }

    return showList
End Function
