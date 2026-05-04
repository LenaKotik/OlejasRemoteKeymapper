/**
 * This file is part of the (modified) FakeInput library (https://github.com/uiii/FakeInput)
 *
 * Copyright (C) 2011 by Richard Jedlicka <uiii.dev@gmail.com>
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#include "CBindFakeInput.h"

unsigned long translateKey(KeyType key)
{
    return keyTable[key];
}

void sendKeyEvent_(Key key, int isPress)
{
    if(key.code == 0)
    {
        fprintf(stderr, "Cannot send <no key> event\n");
    }
    else
    {
        INPUT input;
        ZeroMemory(&input, sizeof(INPUT));
        input.type = INPUT_KEYBOARD;
        input.ki.wVk = key.virtualKey;
        input.ki.dwFlags = (isPress) ? 0 : KEYEVENTF_KEYUP;
        SendInput(1, &input, sizeof(INPUT));
    }
}

void press_key(const Key* k)
{
    sendKeyEvent_(*k, 1);
}
void release_key(const Key* k)
{
    sendKeyEvent_(*k, 0);
}
Key* make_key_from_type(KeyType type)
{
    Key* new; 
    if(type == Key_NoKey)
    {
        new = malloc(sizeof(Key));
        new->virtualKey = 0;
        new->code = 0;
        new->name = "<no key>";
    }
    else
    {
        new = make_key((WORD) translateKey(type));
    }
    return new;
}
Key* make_key(WORD virtualKey)
{
    Key* new = malloc(sizeof(Key));
    new->virtualKey = virtualKey;
    new->code = MapVirtualKey(virtualKey, MAPVK_VK_TO_VSC);
    LONG lParam = new->code;
    switch (virtualKey)
    {
        case VK_LEFT: case VK_UP: case VK_RIGHT: case VK_DOWN: // arrow keys
        case VK_PRIOR: case VK_NEXT: // page up and page down
        case VK_END: case VK_HOME:
        case VK_INSERT: case VK_DELETE:
        case VK_DIVIDE: // numpad slash
        case VK_NUMLOCK:
        {
            lParam |= 0x100; // set extended bit
            break;
        }
    }

    char name[128];
    if(GetKeyNameText(lParam << 16, name, 128))
    {
        new->name = name;
    }
    else
    {
        fprintf(stderr, "Cannot get key name for: %d", virtualKey);
        new->name = "<unknown key>";
    }
    return new;
}

/*
int main()
{
    FakeInput::Key* k = make_key(FakeInput::KeyType::Key_A);
    press_key(k);
    delete k;
}
*/ 