#Requires AutoHotkey v2.0

#HotIf WinActive("ahk_class XamlExplorerHostIslandWindow")
!h::Send("{Blind}{Left}")
!j::Send("{Blind}{Down}")
!k::Send("{Blind}{Up}")
!l::Send("{Blind}{Right}")

#HotIf WinActive("ahk_class MultitaskingViewFrame")
!h::Send("{Blind}{Left}")
!j::Send("{Blind}{Down}")
!k::Send("{Blind}{Up}")
!l::Send("{Blind}{Right}")
