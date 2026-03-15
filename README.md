# Claude Code Sound Hook

Plays a sound whenever Claude finishes a response, asks a question, or requests permission to run a command.

No more staring at a silent terminal — you'll hear it the moment Claude needs you.

---

## Install

```powershell
git clone https://github.com/gaston-tittarelli/claude-sound-hook
cd claude-sound-hook
powershell -ExecutionPolicy Bypass -File install.ps1
```

That's it. The installer copies the files and updates your `~/.claude/settings.json` automatically.

> If something goes wrong, see the [step-by-step guide](MANUAL-INSTALL.md).

---

## How it works

Claude Code supports [hooks](https://docs.anthropic.com/en/docs/claude-code/hooks) — shell commands that run on specific events. This project uses two:

- `Stop` — fires when Claude finishes a response or asks a question
- `PermissionRequest` — fires when Claude needs approval to run a command

---

## Customize

**Change the sound:** replace `%USERPROFILE%\.claude\sounds\sound.mp3` with any MP3.

**Mute temporarily:** rename `sound.mp3` to `sound.mp3.off`.

**Adjust volume:** edit `%USERPROFILE%\.claude\sounds\play.ps1` and change the number in `setaudio mp3 volume to`:

| Value  | Level              |
|--------|--------------------|
| `50`   | Very low           |
| `150`  | Low (recommended)  |
| `500`  | Medium             |
| `1000` | Maximum            |

---

## Uninstall

Delete the sounds folder and remove the `hooks` block from `%USERPROFILE%\.claude\settings.json`:

```powershell
Remove-Item -Recurse -Force "$env:USERPROFILE\.claude\sounds"
```

---

## Compatibility

This project is currently **Windows only**. If you're on Mac or Linux, you can adapt it to your system in a single conversation with Claude — just share the files in this repo as context and ask it to port the scripts and installer to your OS.
