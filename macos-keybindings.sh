#!/usr/bin/env bash

# We need the bundleid for each app
get_bundle_id(){
    mdls -raw -name kMDItemCFBundleIdentifier "$1"
}

# make life easier
cmd="@"
ctrl="^"
opt="~"
shift="$"

bundleid=$(get_bundle_id /Applications/iTerm.app)

defaults write "$bundleid" NSUserKeyEquivalents "{}"
defaults read "$bundleid" NSUserKeyEquivalents; echo

defaults write "$bundleid" NSUserKeyEquivalents '{
    "Add Annotation at Cursor"				= "\0";
    "Add Trigger..."					= "\0";
    "Advanced Paste..."					= "\0";
    "Alert on Next Mark"				= "\0";
    "Auto Command Completion"				= "\0";
    "Broadcast Input to All Panes in All Tabs"		= "\0";
    "Broadcast Input to All Panes in Current Tab"	= "\0";
    "Buffer"						= "\0";
    "Bury Session"					= "\0";
    "Capture GPU Frame"					= "\0";
    "Clear Buffer"					= "\0";
    "Clear Scrollback Buffer"				= "\0";
    "Close All Panes in Tab"				= "\0";
    "Close Terminal Window"				= "\0";
    "Close"						= "\0";
    "Composer"						= "\0";
    "Console"						= "\0";
    "Copy Mode"						= "\0";
    "Copy with Control Sequences"			= "\0";
    "Copy with Styles"					= "\0";
    "Copy"						= "^$C";
    "Cut"						= "^$X";
    "Dashboard"						= "\0";
    "Detach"						= "\0";
    "Duplicate Tab"					= "\0";
    "Edit Session..."					= "\0";
    "Emoji & Symbols"					= "\0";
    "Find Cursor"					= "\0";
    "Find Globally..."					= "\0";
    "Find Next"						= "\0";
    "Find Previous"					= "\0";
    "Find URLs"						= "\0";
    "Find..."						= "\0";
    "Force Detach"					= "\0";
    "Hide Others"					= "\0";
    "Hide iTerm2"					= "\0";
    "Jump to Mark"					= "\0";
    "Jump to Selection"					= "\0";
    "Make Terminal Default Term"			= "\0";
    "Make Text Bigger"					= "\0";
    "Make Text Normal Size"				= "\0";
    "Make Text Smaller"					= "\0";
    "Make iTerm2 Default Term"				= "\0";
    "Maximize Active Pane"				= "\0";
    "Minimize All"					= "\0";
    "Minimize"						= "\0";
    "New Tab with Current Profile"			= "\0";
    "New Tab"						= "^$T";
    "New Tmux Tab"					= "\0";
    "New Tmux Window"					= "\0";
    "New Window with Current Profile"			= "\0";
    "New Window"					= "\0";
    "Next Annotation"					= "\0";
    "Next Mark"						= "\0";
    "Open Autocomplete..."				= "\0";
    "Open Command History..."				= "\0";
    "Open Paste History..."				= "\0";
    "Open Profiles..."					= "\0";
    "Open Quickly"					= "\0";
    "Open Recent Directories..."			= "\0";
    "Open Selection"					= "\0";
    "Page Setup..."					= "\0";
    "Password Manager"					= "\0";
    "Paste Selection"					= "\0";
    "Paste"						= "^$V";
    "Pause Pane"					= "\0";
    "Pin Hotkey Window"					= "\0";
    "Preferences..."					= "\0";
    "Previous Annotation"				= "\0";
    "Previous Mark"					= "\0";
    "Quit iTerm2"					= "@Q";
    "Redo"						= "\0";
    "Reset Character Set"				= "\0";
    "Reset"						= "\0";
    "Restart Session"					= "\0";
    "Restore Text and Session Size"			= "\0";
    "Run Coprocess..."					= "\0";
    "Save Current Window as Arrangement"		= "\0";
    "Save Selected Text..."				= "\0";
    "Save Window Arrangement"				= "\0";
    "Screen"						= "\0";
    "Secure Keyboard Entry"				= "\0";
    "Select All"					= "\0";
    "Select Next Tab"					= "\0";
    "Select Output of Last Command"			= "\0";
    "Select Previous Tab"				= "\0";
    "Selection Respects Soft Boundaries"		= "\0";
    "Selection"						= "\0";
    "Send Input to Current Session Only"		= "\0";
    "Set Mark"						= "\0";
    "Show Annotations"					= "\0";
    "Show Cursor Guide"					= "\0";
    "Show Tabs in Fullscreen"				= "\0";
    "Show Timestamps"					= "\0";
    "Show Toolbelt"					= "\0";
    "Size Changes Update Profile"			= "\0";
    "Split Horizontally with Current Profile"		= "\0";
    "Split Horizontally..."				= "\0";
    "Split Vertically with Current Profile"		= "\0";
    "Split Vertically..."				= "\0";
    "Start Dictation..."					= "\0";
    "Start Instant Replay"				= "\0";
    "Stop Coprocess"					= "\0";
    "Toggle Broadcast Input to Current Session"		= "\0";
    "Toggle Full Screen"				= "\0";
    "Undo Close Session"				= "\0";
    "Use Selection for Find"				= "\0";
    "Use Transparency"					= "\0";
    "Zoom In on Selection"				= "\0";
    "Zoom Out"						= "\0";
    "Zoom"						= "\0";
    "iTerm2 Help"					= "\0";
}'
defaults read "$bundleid" NSUserKeyEquivalents; echo



