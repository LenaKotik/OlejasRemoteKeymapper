// CBindFakeInput.h : Include file for standard system include files,
// or project specific include files.

#pragma once
#include <windows.h>
#include <stdio.h>

typedef struct {
    int code;
    WORD virtualKey;
    const char* name;
} Key;

static long keyTable[] = {
        0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, // A - I
        0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F, 0x50, 0x51, 0x52, // J - R
        0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, // S - Z

        0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, // 0 - 9

        VK_F1, VK_F2, VK_F3, VK_F4, VK_F5, VK_F6, VK_F7, VK_F8, VK_F9, VK_F10, VK_F11, VK_F12,
        VK_F13, VK_F14, VK_F15, VK_F16, VK_F17, VK_F18, VK_F19, VK_F20, VK_F21, VK_F22, VK_F23, VK_F24,

        VK_ESCAPE,
        VK_SPACE,
        VK_RETURN,
        VK_BACK,
        VK_TAB,

        VK_LSHIFT,
        VK_RSHIFT,
        VK_LCONTROL,
        VK_RCONTROL,
        VK_LMENU,
        VK_RMENU,
        VK_LWIN,
        VK_RWIN,
        VK_APPS,

        VK_CAPITAL,
        VK_NUMLOCK,
        VK_SCROLL,

        VK_SNAPSHOT,
        VK_PAUSE,

        VK_INSERT,
        VK_DELETE,
        VK_PRIOR,
        VK_NEXT,
        VK_HOME,
        VK_END,

        VK_LEFT,
        VK_UP,
        VK_RIGHT,
        VK_DOWN,

        VK_NUMPAD0,
        VK_NUMPAD1,
        VK_NUMPAD2,
        VK_NUMPAD3,
        VK_NUMPAD4,
        VK_NUMPAD5,
        VK_NUMPAD6,
        VK_NUMPAD7,
        VK_NUMPAD8,
        VK_NUMPAD9,

        VK_ADD,
        VK_SUBTRACT,
        VK_MULTIPLY,
        VK_DIVIDE,
        VK_DECIMAL,
        VK_RETURN
};
typedef enum{
        Key_NoKey = -1,

        Key_A, Key_B, Key_C, Key_D, Key_E, Key_F,
        Key_G, Key_H, Key_I, Key_J, Key_K, Key_L,
        Key_M, Key_N, Key_O, Key_P, Key_Q, Key_R,
        Key_S, Key_T, Key_U, Key_V, Key_W, Key_X,
        Key_Y, Key_Z, 

        Key_0, Key_1, Key_2, Key_3, Key_4, Key_5, Key_6, Key_7, Key_8, Key_9,

        Key_F1, Key_F2, Key_F3, Key_F4, Key_F5, Key_F6, Key_F7, Key_F8,
        Key_F9, Key_F10, Key_F11, Key_F12, Key_F13, Key_F14, Key_F15, Key_F16,
        Key_F17, Key_F18, Key_F19, Key_F20, Key_F21, Key_F22, Key_F23, Key_F24,

        Key_Escape,
        Key_Space,
        Key_Return,
        Key_Backspace,
        Key_Tab,
        
        Key_Shift_L,
        Key_Shift_R,
        Key_Control_L,
        Key_Control_R,
        Key_Alt_L,
        Key_Alt_R,
        Key_Win_L,
        Key_Win_R,
        Key_Apps,

        Key_CapsLock,
        Key_NumLock,
        Key_ScrollLock,

        Key_PrintScreen,
        Key_Pause,

        Key_Insert,
        Key_Delete,
        Key_PageUP,
        Key_PageDown,
        Key_Home,
        Key_End,

        Key_Left,
        Key_Right,
        Key_Up,
        Key_Down,

        Key_Numpad0,
        Key_Numpad1,
        Key_Numpad2,
        Key_Numpad3,
        Key_Numpad4,
        Key_Numpad5,
        Key_Numpad6,
        Key_Numpad7,
        Key_Numpad8,
        Key_Numpad9,

        Key_NumpadAdd,
        Key_NumpadSubtract,
        Key_NumpadMultiply,
        Key_NumpadDivide,
        Key_NumpadDecimal,
        Key_NumpadEnter
} KeyType;

void press_key(const Key* k);
void release_key(const Key* k);
Key* make_key_from_type(KeyType type);
Key* make_key(WORD virtualKey);