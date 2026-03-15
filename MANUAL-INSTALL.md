# Step-by-step Installation

Use this guide if the quick install didn't work, or if you prefer to set things up manually.

---

## Step 1 — Create the sounds folder

Open PowerShell and run:

```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\sounds"
```

---

## Step 2 — Copy the files

Move `sound.mp3` and `play.ps1` into the folder you just created:

```
C:\Users\YOUR_USERNAME\.claude\sounds\
```

---

## Step 3 — Update settings.json

Open `C:\Users\YOUR_USERNAME\.claude\settings.json` and add the `hooks` block.

If the file is empty or doesn't exist, paste this:

```json
{
  "hooks": {
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File \"%USERPROFILE%\\.claude\\sounds\\play.ps1\""
          }
        ]
      }
    ],
    "PermissionRequest": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File \"%USERPROFILE%\\.claude\\sounds\\play.ps1\""
          }
        ]
      }
    ]
  }
}
```

If the file already has other settings, add only the `"hooks"` block inside the existing `{}` — don't replace what's already there.

---

## Step 4 — Test it

Run this in PowerShell to confirm everything works:

```powershell
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.claude\sounds\play.ps1"
```

If you hear the sound, you're done. If not, double-check that `sound.mp3` is in the correct folder.

---

## Why Stop and PermissionRequest?

- `Stop` fires when Claude finishes a response or asks you a question
- `PermissionRequest` fires when Claude needs your approval to run a command

The `Notification` hook also exists but includes an `idle_prompt` event that triggers while Claude is just waiting — not useful here.

---

## Adjust volume

Edit `play.ps1` and change the number in `setaudio mp3 volume to`:

| Value  | Level             |
|--------|-------------------|
| `50`   | Very low          |
| `150`  | Low (recommended) |
| `500`  | Medium            |
| `1000` | Maximum           |

---

## Change or mute the sound

- **Change sound:** replace `sound.mp3` with any other MP3 using the same filename
- **Mute temporarily:** rename `sound.mp3` to `sound.mp3.off`

---

## Compatibility

This guide is **Windows only**. If you're on Mac or Linux, you can adapt it to your system in a single conversation with Claude — just share the files in this repo as context and ask it to port the scripts and installer to your OS.
