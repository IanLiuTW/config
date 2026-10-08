# PowerShell profile

[`$PROFILE`](%24PROFILE) is a PowerShell profile script. PowerShell runs it at the start of each session.

## What it sets up

- **PSReadLine:** predictions from history in a list view, and Windows edit mode.
- **Key bindings:**

  | Key | Action |
  |---|---|
  | `Ctrl+D` | Exit PowerShell |
  | `Ctrl+W` | Delete the previous word |
  | `Ctrl+A` / `Ctrl+E` | Move to the start / end of the line |
  | `F7` | Search the full command history in a grid view, and insert the selected command |
  | `F1` | Open help for the command under the cursor |

- **Smart editing:** typing a quote or an opening bracket inserts the pair; typing the closing character skips over an existing one; `Backspace` between an empty pair deletes both.
- **Completion:** argument completion for `winget` and `dotnet`.
- **Aliases:** removes the built-in `curl` and `wget` aliases, so those names run the real programs.
- **Functions:** `hosts` opens the hosts file in Notepad. `New-Password` generates a random password (10 characters by default; `-Length` sets 8 to 255).

The comments in the file are in Traditional Chinese.

## Install

1. Open the profile. PowerShell creates the path if it does not exist:

   ```powershell
   if (-not (Test-Path $PROFILE)) { New-Item -Path $PROFILE -ItemType File -Force }
   notepad $PROFILE
   ```

2. Paste the content of [`$PROFILE`](%24PROFILE) and save.
3. If PowerShell refuses to run the profile, allow local scripts for your user:

   ```powershell
   Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
   ```

4. Open a new PowerShell window.

`$PROFILE` points to a different file in Windows PowerShell 5.1 and in PowerShell 7. Install the profile in each one you use.
