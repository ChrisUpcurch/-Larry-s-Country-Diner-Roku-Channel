Function preShowPosterScreen(breadA=invalid, breadB=invalid) As Object

    if validateParam(breadA, "roString", "preShowPosterScreen", true) = false return -1
    if validateParam(breadB, "roString", "preShowPosterScreen", true) = false return -1

    port=CreateObject("roMessagePort")
    screen = CreateObject("roPosterScreen")
    screen.SetMessagePort(port)
    if breadA<>invalid and breadB<>invalid then
        screen.SetBreadcrumbText(breadA, breadB)
    end if

    screen.SetListStyle("arced-landscape")

    return screen

End Function

Function showPosterScreen(screen As Object, category As Object) As Integer

    if validateParam(screen, "roPosterScreen", "showPosterScreen") = false return -1
    if validateParam(category, "roAssociativeArray", "showPosterScreen") = false return -1

    m.curCategory = 0
    m.curShow     = 0
    temp=getcategorylist(category)
    
    
    if temp.count() > 1 then
    	screen.SetListNames(temp)
    	?temp.count();" categories"
    	else 
    	?"only ";temp.count();" category"
    end if
    screen.SetContentList(getShowsForCategoryItem(category, m.curCategory))
    screen.Show()

    while true
        msg = wait(0, screen.GetMessagePort())
        if type(msg) = "roPosterScreenEvent" then
            print "showPosterScreen | msg = "; msg.GetMessage() " | index = "; msg.GetIndex()
            if msg.isListFocused() then
                m.curCategory = msg.GetIndex()
                m.curShow = 0
                screen.setcontentlist([])
                screen.SetFocusedListItem(m.curShow)
                screen.showmessage("Retrieving")
                screen.SetContentList(getShowsForCategoryItem(category, m.curCategory))
                screen.clearmessage()
				print "list focused | current category = "; m.curCategory
            else if msg.isListItemSelected() then
                m.curShow = msg.GetIndex()
                print "list item selected | current show = "; m.curShow
                m.curShow = displayShowDetailScreen(category, m.curShow)
                screen.SetFocusedListItem(m.curShow)
                print "list item updated  | new show = "; m.curShow
            else if msg.isScreenClosed() then
                return -1
            end if
        end If
    end while


End Function

Function displayShowDetailScreen(category as Object, showIndex as Integer) As Integer
	
    if validateParam(category, "roAssociativeArray", "displayShowDetailScreen") = false return -1

    shows = getShowsForCategoryItem(category, m.curCategory)
    screen = preShowDetailScreen(category.Title, category.kids[m.curCategory].Title)
    showIndex = showDetailScreen(screen, shows, showIndex)

    return showIndex
End Function

Function getCategoryList(topCategory As Object) As Object

    if validateParam(topCategory, "roAssociativeArray", "getCategoryList") = false return -1

    if type(topCategory) <> "roAssociativeArray" then
        print "incorrect type passed to getCategoryList"
        return -1
    endif

    categoryList = CreateObject("roArray", 100, true)
    for each subCategory in topCategory.Kids
        categoryList.Push(subcategory.Title)
    next
    return categoryList

End Function

Function getShowsForCategoryItem(category As Object, item As Integer) As Object

    if validateParam(category, "roAssociativeArray", "getCategoryList") = false return invalid 

    conn = InitShowFeedConnection(category.kids[item])
    showList = conn.LoadShowFeed(conn)
    return showList

End Function
