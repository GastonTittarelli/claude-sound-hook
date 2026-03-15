# Claude Code Sound Hook - Windows Installer

$soundsDir = Join-Path $env:USERPROFILE ".claude\sounds"
$settingsPath = Join-Path $env:USERPROFILE ".claude\settings.json"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "Installing Claude Code Sound Hook..."

# 1. Create sounds directory
New-Item -ItemType Directory -Force -Path $soundsDir | Out-Null

# 2. Copy files
Get-ChildItem (Join-Path $scriptDir "*.mp3") | ForEach-Object { Copy-Item $_.FullName $soundsDir -Force }
Copy-Item (Join-Path $scriptDir "play.ps1") $soundsDir -Force
Copy-Item (Join-Path $scriptDir "config.ps1") $soundsDir -Force

Write-Host "Files copied to $soundsDir"

# 3. Patch settings.json
$hookCommand = "powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$soundsDir\play.ps1`""

$hookEntry = @(
    [PSCustomObject]@{
        matcher = ""
        hooks   = @([PSCustomObject]@{ type = "command"; command = $hookCommand })
    }
)

$hooksObj = [PSCustomObject]@{
    Stop              = $hookEntry
    PermissionRequest = $hookEntry
}

if (Test-Path $settingsPath) {
    $raw = Get-Content $settingsPath -Raw -Encoding UTF8
    try {
        $settings = $raw | ConvertFrom-Json
    } catch {
        Write-Host "ERROR: Could not parse $settingsPath. Fix the JSON and re-run." -ForegroundColor Red
        exit 1
    }
} else {
    New-Item -ItemType Directory -Force -Path (Split-Path $settingsPath) | Out-Null
    $settings = [PSCustomObject]@{}
}

if ($settings.PSObject.Properties["hooks"]) {
    Write-Host ""
    Write-Host "WARNING: 'hooks' already exists in settings.json. Skipping to avoid overwriting." -ForegroundColor Yellow
    Write-Host "Add this manually to your hooks block:" -ForegroundColor Yellow
    Write-Host "  Stop + PermissionRequest -> $hookCommand" -ForegroundColor Yellow
} else {
    $settings | Add-Member -NotePropertyName "hooks" -NotePropertyValue $hooksObj
    $settings | ConvertTo-Json -Depth 10 | Set-Content $settingsPath -Encoding UTF8
    Write-Host "settings.json updated."
}

# 4. Test
Write-Host ""
Write-Host "Done! Testing sound..."
powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File "$soundsDir\play.ps1"
Write-Host "If you heard a sound, everything is working."
