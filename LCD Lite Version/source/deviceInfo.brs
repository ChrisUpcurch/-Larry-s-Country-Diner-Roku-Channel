
Function GetDeviceVersion()
    return CreateObject("roDeviceInfo").GetVersion()
End Function


Function GetDeviceESN()
    return CreateObject("roDeviceInfo").GetDeviceUniqueId()
End Function
