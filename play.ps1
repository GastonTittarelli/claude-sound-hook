$soundPath = Join-Path $env:USERPROFILE ".claude\sounds\sound.mp3"

Add-Type -TypeDefinition @"
using System.Runtime.InteropServices;
using System.Text;
public class MCI {
    [DllImport("winmm.dll")]
    public static extern int mciSendString(string command, StringBuilder returnValue, int returnLength, System.IntPtr winHandle);
}
"@
[MCI]::mciSendString("open `"$soundPath`" type mpegvideo alias mp3", $null, 0, [System.IntPtr]::Zero)
[MCI]::mciSendString('setaudio mp3 volume to 150', $null, 0, [System.IntPtr]::Zero)
[MCI]::mciSendString('play mp3 wait', $null, 0, [System.IntPtr]::Zero)
[MCI]::mciSendString('close mp3', $null, 0, [System.IntPtr]::Zero)
