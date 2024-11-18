Notify.Show('Notify Title',,,,, 'dur=0 pos=bc tag=myTAG')
Sleep(3000)
Notify.Destroy('myTAG')

;==============================================

Notify.Show('Notify GUI 1',,,,, 'dur=0 tag=thisTag')
Sleep(3000)
Notify.Show('Notify GUI 2',,,,, 'dur=0 dg=5 tag=thisTag')
Sleep(3000)
Notify.Destroy('thisTag')

/*
    DG - Destroy GUIs before creating the new GUI.
        5 - Destroy all GUIs containing the tag.
*/