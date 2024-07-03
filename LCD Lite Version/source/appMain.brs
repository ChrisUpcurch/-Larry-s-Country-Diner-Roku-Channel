Sub Main()

    'initialize theme attributes like titles, logos and overhang color
    initTheme()

    'prepare the screen for display and get ready to begin
    screen=preShowHomeScreen("", "")
    if screen=invalid then
        print "unexpected error in preShowHomeScreen"
        return
    end if

    'set to go, time to get started
    showHomeScreen(screen)

End Sub

Sub initTheme()

    app = CreateObject("roAppManager")
    theme = CreateObject("roAssociativeArray")

    theme.OverhangOffsetSD_X = "72"
    theme.OverhangOffsetSD_Y = "31"
    theme.OverhangSliceSD = "pkg:/images/Overhang_Background_SD.png"
    theme.OverhangLogoSD  = "pkg:/images/Overhang_Logo_SD.png"
	' Red Background Color
	' theme.BackgroundColor = "#910E0E"
	' Blue Background Color
	theme.BackgroundColor = "#003F87"
	' Blue Breadcrumb Color
	theme.BreadcrumbTextRight = "#003F87"
	' Light Blue Breadcrumb
	theme.BreadcrumbTextLeft = "#0276FD"
	' Dialog Text
	theme.DialogBodyText = "#FFFFFF"
	' Screen Text 
	theme.TextScreenBodyText = "#FFFFFF"
	theme.TextScreenScrollThumbColor = "#FFFFFF"
	
	' Springboard Settings
	theme.SpringboardTitleText = "#FFFFFF"
	theme.SpringboardSynopsisColor = "#FFFFFF"
	theme.SpringboardRuntimeColor = "#FFFFFF"
    theme.SpringboardGenreColor = "#FFFFFF"
	theme.SpringboardDirectorPrefixText = "#FFFFFF"
	theme.ButtonHighlightColor = "#FFFFFF"
	theme.ButtonMenuHighlightText = "#FFFFFF"
	theme.ListScreenDescriptionText = "#FFFFFF"
	theme.ListScreenTitleColor = "#FFFFFF"
	theme.ListScreenDescriptionText = "#FFFFFF"
	theme.ListScreenTitleColor = "#FFFFFF"
	theme.ListItemText = "#FFFFFF"
	theme.ListItemHighlightText = "#FFFFFF"
	theme.ListScreenDescriptionText = "#FFFFFF"
	theme.ListScreenTitleColor = "#FFFFFF"
	theme.SpringboardDirectorPrefixText = "#FFFFFF"
	theme.SpringboardDirectorLabelColor = "#FFFFFF"
	theme.SpringboardDirectorLabel = "#FFFFFF"
	theme.SpringboardDirectorLabel = "#FFFFFF"
	theme.SpringboardDirectorColor = "#FFFFFF"
    theme.BreadcrumbDelimiter = "#FFFFFF"
	
	theme.OverhangOffsetHD_X = "35"
    theme.OverhangOffsetHD_Y = "10"
    theme.OverhangSliceHD = "pkg:/images/Overhang_Background_HD.png"
    theme.OverhangLogoHD  = "pkg:/images/Overhang_Logo_HD.png"

    app.SetTheme(theme)

End Sub
