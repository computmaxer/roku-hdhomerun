' ********************************************************************
' **  HDHomeRun PRIME via Wallop
' **  Roku app for streaming live TV from an HDHomerun Tuner
' **
' **  Submit issues to: https://github.com/computmaxer/roku-hdhomerun
' ********************************************************************


Sub Main(args As Dynamic)
    'Initialize the registry cache
    m.RegistryCache = CreateObject("roAssociativeArray")

    'Initialize theme attributes like titles, logos and overhang color
    initTheme()

    ' if type(args) = "roAssociativeArray" and type(args.url) = "roString" then
    '     displayVideo(args)
    ' end if
    ' print "Type args = "; type(args)
    ' print "Type args.url = "; type(args.url)

    'Has to live for the duration of the whole app to prevent flashing
    'back to the roku home screen.
    screenFacade = CreateObject("roPosterScreen")
    screenFacade.show()

    keep_going = "yes"
    'set to go, time to get started
    while keep_going <> ""
        screen = preShowGridScreen()
        keep_going = showGridScreen(screen)
    end while

    'exit the app gently so that the screen doesn't flash to black
    screenFacade.showMessage("")
    sleep(25)
End Sub


' Set the configurable theme attributes for the application
' Configure the custom overhang and Logo attributes
Sub initTheme()

    app = CreateObject("roAppManager")
    theme = CreateObject("roAssociativeArray")
    background = "#363636"

    theme.BackgroundColor = background

    theme.OverhangPrimaryLogoOffsetSD_X = "72"
    theme.OverhangPrimaryLogoOffsetSD_Y = "15"
    theme.OverhangSliceSD = "pkg:/images/Overhang_BackgroundSlice_SD43.png"
    theme.OverhangPrimaryLogoSD  = "pkg:/images/Logo_Overhang_SD43.png"

    theme.OverhangPrimaryLogoOffsetHD_X = "123"
    theme.OverhangPrimaryLogoOffsetHD_Y = "20"
    theme.OverhangSliceHD = "pkg:/images/Overhang_BackgroundSlice_HD.png"
    theme.OverhangPrimaryLogoHD  = "pkg:/images/Logo_Overhang_HD.png"

    'this is an optional theme attribute. the default subtitle color is yellow.
    theme.SubtitleColor = "#dc00dc"

    'Grid stuff
    theme.ThemeType = "generic-dark"

    ' All these are greyscales
    theme.GridScreenBackgroundColor = background
    theme.GridScreenMessageColor    = "#808080"
    theme.GridScreenRetrievingColor = "#CCCCCC"
    theme.GridScreenListNameColor   = "#FFFFFF"

    ' Color values work here
    theme.GridScreenDescriptionTitleColor    = "#001090"
    theme.GridScreenDescriptionDateColor     = "#FF005B"
    theme.GridScreenDescriptionRuntimeColor  = "#5B005B"
    theme.GridScreenDescriptionSynopsisColor = "#606000"
    
    'used in the Grid Screen
    theme.CounterTextLeft           = "#DEDEDE"
    theme.CounterSeparator          = "#999999"
    theme.CounterTextRight          = "#999999"
    
    theme.GridScreenLogoHD          = "pkg:/images/Overhang_Test_HD.png"

    theme.GridScreenLogoOffsetHD_X  = "0"
    theme.GridScreenLogoOffsetHD_Y  = "0"
    theme.GridScreenOverhangHeightHD = "99"

    theme.GridScreenLogoSD          = "pkg:/images/Overhang_Test_SD43.png"
    theme.GridScreenOverhangHeightSD = "66"
    theme.GridScreenLogoOffsetSD_X  = "0"
    theme.GridScreenLogoOffsetSD_Y  = "0"
    
    app.SetTheme(theme)

End Sub
