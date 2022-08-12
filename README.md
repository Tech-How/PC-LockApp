# PC LockApp
An alternative to the Windows+L shortcut.
## Why?
This was originally created as a solution for programs I used that got interrupted by the Windows LockApp process. When you lock the computer with the Windows+L shortcut, or from the start menu, LockApp.exe starts and some processes running at the user-level are put into a suspension-like sate. (Razer Synapse, for example.) When waking your PC from the lock screen, these programs can become glitched or behave improperly. I made this so you can still hide your computer screen, but without pausing foreground programs.
## How?
This tool operates in a sort-of clever way. It's written in batch, and uses a maximized command window to block access to your computer. But can't someone just minimize, or click off the window? Or close it? Here are the safeguards put in place to prevent just that:
- Your mouse is locked: Only the keyboard can be accessed.
- If the window is minimized, it instantly pops back up.
- If the window is closed, it instantly restarts.
- The window is set to show on top of all other windows, preventing alt-tab or dragging other windows on top of it.

When LockApp starts, it opens supervising processes in the background, which are able to tell if the LockApp window is modified. This is how it can detect if the window is closed and restart it. When the correct password is entered, the batch file sends a call to the other supervising processes to queue them to stop. But if the window is killed or closed improperly, it starts right back up. And if the wrong password is entered, the attempts are logged for you to see when you return.
## Other Info
This is mainly just a hobby project, and if someone was really determined, there are ways around this. Don't open a super confidential document, and then run this and think it will be impossible to access. That being said, if you do find a way around it that you think is easy enough for people to figure out, feel free to leave a issue report and I'll take a look. There's a nice self-installing EXE under the releases tab.
## Credits
This program uses files from other projects, which are listed here:
- [BAT2EXE - Batch to EXE Converter](https://github.com/islamadel/bat2exe)
- [NirCmd - Windows Command-line Utility](https://www.nirsoft.net/utils/nircmd.html)
- [Fart - Find and Replace Text](http://fart-it.sourceforge.net/)
