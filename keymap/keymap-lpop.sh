#!/bin/bash


# This command remaps keys from a French-Canadian Mac keyboard to English.  The
# mappings can be reverted to system defaults with:
#   hidutil property --get "UserKeyMapping"


# Key mappings do not persist after reboot, but this script can be added as
# a login hook to reset mappings on login.
#   sudo defaults write com.apple.loginwindow LoginHook /path/to/keymap.sh


# The keycodes can be obtained from Apple's Technical Note 2450 (TN-2450):
# https://developer.apple.com/library/archive/technotes/tn2450/_index.html

# This is also a useful reference:
# https://stackoverflow.com/questions/127591/using-caps-lock-as-esc-in-mac-os-x


# All mappings must be expressed as a single command.  Listed in order:
#   \ and / -> ` and ~ (upper left key)
#   À -> Return
#   Return -> \ and |
#   Ù -> Left Shift
hidutil property --set '{"UserKeyMapping":[
    {"HIDKeyboardModifierMappingSrc":0x700000031,"HIDKeyboardModifierMappingDst":0x700000028},
    {"HIDKeyboardModifierMappingSrc":0x700000028,"HIDKeyboardModifierMappingDst":0x700000031},
    {"HIDKeyboardModifierMappingSrc":0x700000035,"HIDKeyboardModifierMappingDst":0x7000000e1},
    {"HIDKeyboardModifierMappingSrc":0x700000064,"HIDKeyboardModifierMappingDst":0x700000035}
]}'
