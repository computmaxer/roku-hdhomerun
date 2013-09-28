'*************************************************************
'** Everything needed to build the settings screens
'*************************************************************


' Get the list of menu items to show on the Settings screen
Function getSettingsList() As Dynamic
    currentServerAddress = RegRead("server_address", "preferences", "Not Set")
    currentServerPort = RegRead("server_port", "preferences", "Not Set")

    settingsList = [
        {
            Title:"Server Address",
            ID:"1",
            ShortDescriptionLine1: currentServerAddress
        },
        {
            Title:"Server Port",
            ID:"2",
            ShortDescriptionLine1: currentServerPort
        }
    ]
    return settingsList
End Function


' Display the settings screen.  Blocking function to call when
' the user selects "Settings" on the main grid screen.
Function showSettingsScreen() As Object

    screen = CreateObject("roListScreen")
    screen.SetContent(getSettingsList())
    port = CreateObject("roMessagePort")
    screen.SetMessagePort(port)
    screen.SetHeader("Settings")

    ' Standard properties for all our screen types
    screen.show()

    menuSelections = [ShowSetServer, ShowSetPort]

    while(true)
        msg = wait(0,port)
        if msg.isScreenClosed() then 'ScreenClosed event
            print "Closing video screen"
            exit while
        else if (type(msg) = "roListScreenEvent")
            print "list screen event"
            if(msg.isListItemFocused())
                print "focused"
            endif
            if(msg.isListItemSelected())
                print "selected"
                menuSelections[msg.GetIndex()]()
                screen.SetContent(getSettingsList())
            endif
        endif
    end while

    return ""
End Function


' Show the keyboard to allow the user to enter the server IP or Hostname
Function ShowSetServer() as void
    screen = createObject("roKeyboardScreen")
    screen.setText(RegRead("server_address", "preferences", "172.16."))
    screen.addButton(1, "save")
    screen.addButton(2, "cancel")
    screen.setDisplayText("Server Address")
    port = CreateObject("roMessagePort")
    screen.SetMessagePort(port)
    screen.show()
    while(true)
        msg = wait(0,port)
        if type(msg) = "roKeyboardScreenEvent"
             if msg.isScreenClosed()
                 return 
             else if msg.isButtonPressed() then
                 print "Evt:"; msg.GetMessage ();" idx:"; msg.GetIndex()
                 if msg.GetIndex() = 1
                     searchText = screen.GetText()
                     print "new ip address = "; searchText
                     RegWrite("server_address", searchText, "preferences")
                     return
                 endif
             endif
         endif
    end while

End Function


' Show the keyboard to allow the user to enter the server port
Function ShowSetPort() as void
    screen = createObject("roKeyboardScreen")
    screen.setText(RegRead("server_port", "preferences", "8888"))
    screen.addButton(1, "save")
    screen.addButton(2, "cancel")
    screen.setDisplayText("Server Port")
    port = CreateObject("roMessagePort")
    screen.SetMessagePort(port)
    screen.show()
    while(true)
        msg = wait(0,port)
        if type(msg) = "roKeyboardScreenEvent"
             if msg.isScreenClosed()
                 return 
             else if msg.isButtonPressed() then
                 print "Evt:"; msg.GetMessage ();" idx:"; msg.GetIndex()
                 if msg.GetIndex() = 1
                     searchText = screen.GetText()
                     print "new port = "; searchText
                     RegWrite("server_port", searchText, "preferences")
                     return
                 endif
             endif
         endif
    end while

End Function
