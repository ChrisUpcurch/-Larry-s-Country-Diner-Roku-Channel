Function preShowDetailScreen(breadA=invalid, breadB=invalid) As Object
    port=CreateObject("roMessagePort")
    screen = CreateObject("roSpringboardScreen")
	screen.SetStaticRatingEnabled(false) 
    screen.SetDescriptionStyle("video") 
    screen.SetMessagePort(port)
    if breadA<>invalid and breadB<>invalid then
        screen.SetBreadcrumbText(breadA, breadB)
    end if

    return screen
End Function

Function showDetailScreen(screen As Object, showList As Object, showIndex as Integer) As Integer

    if validateParam(screen, "roSpringboardScreen", "showDetailScreen") = false return -1
    if validateParam(showList, "roArray", "showDetailScreen") = false return -1

    refreshShowDetail(screen, showList, showIndex)

    'remote key id's for left/right navigation
    remoteKeyLeft  = 4
    remoteKeyRight = 5
 
    while true
        msg = wait(0, screen.GetMessagePort())

        if type(msg) = "roSpringboardScreenEvent" then
            if msg.isScreenClosed()
                print "Screen closed"
                exit while
            else if msg.isRemoteKeyPressed() 
                print "Remote key pressed"
                if msg.GetIndex() = remoteKeyLeft then
                        showIndex = getPrevShow(showList, showIndex)
                        if showIndex <> -1
                            refreshShowDetail(screen, showList, showIndex)
                        end if
                else if msg.GetIndex() = remoteKeyRight
                    showIndex = getNextShow(showList, showIndex)
                        if showIndex <> -1
                           refreshShowDetail(screen, showList, showIndex)
                        end if
                endif
            else if msg.isButtonPressed() 
                print "ButtonPressed"
                print "ButtonPressed"
                if msg.GetIndex() = 1
                    PlayStart = RegRead(showList[showIndex].ContentId)
                    if PlayStart <> invalid then
                        showList[showIndex].PlayStart = PlayStart.ToInt()
                    endif
                    showVideoScreen(showList[showIndex])
                    refreshShowDetail(screen,showList,showIndex)
                endif
                if msg.GetIndex() = 2
                    showList[showIndex].PlayStart = 0
                    showVideoScreen(showList[showIndex])
                    refreshShowDetail(screen,showList,showIndex)
                endif
                if msg.GetIndex() = 3
                endif
                print "Button pressed: "; msg.GetIndex(); " " msg.GetData()
            end if
        else
            print "Unexpected message class: "; type(msg)
        end if
    end while

    return showIndex

End Function

Function refreshShowDetail(screen As Object, showList As Object, showIndex as Integer) As Integer

    if validateParam(screen, "roSpringboardScreen", "refreshShowDetail") = false return -1
    if validateParam(showList, "roArray", "refreshShowDetail") = false return -1

    show = showList[showIndex]

    'Uncomment this statement to dump the details for each show
    'PrintAA(show)

    screen.ClearButtons()
    if regread(show.contentid) <> invalid and regread(show.contentid).toint() >=30 then
    screen.AddButton(1, "Resume playing")    
    screen.AddButton(2, "Play from beginning")    
    else
    screen.addbutton(2,"Play")
    end if
    screen.SetContent(show)
    screen.Show()

End Function

Function getNextShow(showList As Object, showIndex As Integer) As Integer
    if validateParam(showList, "roArray", "getNextShow") = false return -1

    nextIndex = showIndex + 1
    if nextIndex >= showList.Count() or nextIndex < 0 then
       nextIndex = 0 
    end if

    show = showList[nextIndex]
    if validateParam(show, "roAssociativeArray", "getNextShow") = false return -1 

    return nextIndex
End Function

Function getPrevShow(showList As Object, showIndex As Integer) As Integer
    if validateParam(showList, "roArray", "getPrevShow") = false return -1 

    prevIndex = showIndex - 1
    if prevIndex < 0 or prevIndex >= showList.Count() then
        if showList.Count() > 0 then
            prevIndex = showList.Count() - 1 
        else
            return -1
        end if
    end if

    show = showList[prevIndex]
    if validateParam(show, "roAssociativeArray", "getPrevShow") = false return -1 

    return prevIndex
End Function
