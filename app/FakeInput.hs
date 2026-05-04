{-# LANGUAGE EmptyDataDecls, CPP, ForeignFunctionInterface #-}
module FakeInput
(
    Key(Key),
    press,
    release,
    translateKey
) where

import Foreign
import Foreign.C.Types
import qualified Graphics.UI.GLFW as G

-- #include "../CBindFakeInput/CBindFakeInput.h"

newtype Key = Key {getKey::Int}
data CKey
foreign import ccall unsafe "CBindFakeInput.h press_key"
    c_press_key::Ptr CKey -> IO ()

foreign import ccall unsafe "CBindFakeInput.h release_key"
    c_release_key::Ptr CKey -> IO ()

foreign import ccall unsafe "CBindFakeInput.h make_key_from_type"
    c_make_key_from_type::CInt -> IO (Ptr CKey)

withCKey::Key->(Ptr CKey -> IO a)->IO a 
withCKey k f = do
    key_ptr <- c_make_key_from_type . fromIntegral . getKey $ k
    res <- f key_ptr
    res <$ free key_ptr
    {-
    fptr <- newForeignPtr finalizerFree key_ptr
    withForeignPtr fptr f
    -}

press, release::Key -> IO()
press k = withCKey k c_press_key
release k = withCKey k c_release_key

translateKey::G.Key->Key
translateKey G.Key'Unknown = Key (-1)
translateKey G.Key'Space = Key 61
--translateKey G.Key'Apostrophe = Key 
--translateKey G.Key'Comma = Key 61
translateKey G.Key'Minus = Key 100 -- idk
--translateKey G.Key'Period = Key
translateKey G.Key'Slash = Key 102 -- idk
translateKey G.Key'0 = Key 26
translateKey G.Key'1 = Key 27
translateKey G.Key'2 = Key 28
translateKey G.Key'3 = Key 29
translateKey G.Key'4 = Key 30
translateKey G.Key'5 = Key 31
translateKey G.Key'6 = Key 32
translateKey G.Key'7 = Key 33
translateKey G.Key'8 = Key 34
translateKey G.Key'9 = Key 35
--translateKey G.Key'Semicolon = Key 
--translateKey G.Key'Equal = Key
translateKey G.Key'A = Key 0
translateKey G.Key'B = Key 1
translateKey G.Key'C = Key 2
translateKey G.Key'D = Key 3
translateKey G.Key'E = Key 4
translateKey G.Key'F = Key 5
translateKey G.Key'G = Key 6
translateKey G.Key'H = Key 7
translateKey G.Key'I = Key 8
translateKey G.Key'J = Key 9
translateKey G.Key'K = Key 10
translateKey G.Key'L = Key 11
translateKey G.Key'M = Key 12
translateKey G.Key'N = Key 13
translateKey G.Key'O = Key 14
translateKey G.Key'P = Key 15
translateKey G.Key'Q = Key 16
translateKey G.Key'R = Key 17
translateKey G.Key'S = Key 18
translateKey G.Key'T = Key 19
translateKey G.Key'U = Key 20
translateKey G.Key'V = Key 21
translateKey G.Key'W = Key 22
translateKey G.Key'X = Key 23
translateKey G.Key'Y = Key 24
translateKey G.Key'Z = Key 25
--translateKey G.Key'LeftBracket = Key 
--translateKey G.Key'Backslash = Key 
--translateKey G.Key'RightBracket = Key 
--translateKey G.Key'GraveAccent = Key 
--translateKey G.Key'World1 = Key 
--translateKey G.Key'World2 = Key 
translateKey G.Key'Escape = Key 60
translateKey G.Key'Enter = Key 62
translateKey G.Key'Tab = Key 64
translateKey G.Key'Backspace = Key 63
translateKey G.Key'Insert = Key 79
translateKey G.Key'Delete = Key 80
translateKey G.Key'Right = Key 86
translateKey G.Key'Left = Key 85
translateKey G.Key'Down = Key 88
translateKey G.Key'Up = Key 87
translateKey G.Key'PageUp = Key 81
translateKey G.Key'PageDown = Key 82
translateKey G.Key'Home = Key 83
translateKey G.Key'End = Key 84
translateKey G.Key'CapsLock = Key 74
translateKey G.Key'ScrollLock = Key 76
translateKey G.Key'NumLock = Key 75
translateKey G.Key'PrintScreen = Key 77
translateKey G.Key'Pause = Key 78
translateKey G.Key'F1 = Key 36
translateKey G.Key'F2 = Key 37
translateKey G.Key'F3 = Key 38
translateKey G.Key'F4 = Key 39
translateKey G.Key'F5 = Key 40
translateKey G.Key'F6 = Key 41
translateKey G.Key'F7 = Key 42
translateKey G.Key'F8 = Key 43
translateKey G.Key'F9 = Key 44
translateKey G.Key'F10 = Key 45
translateKey G.Key'F11 = Key 46
translateKey G.Key'F12 = Key 47
translateKey G.Key'F13 = Key 48
translateKey G.Key'F14 = Key 49
translateKey G.Key'F15 = Key 50
translateKey G.Key'F16 = Key 51
translateKey G.Key'F17 = Key 52
translateKey G.Key'F18 = Key 53
translateKey G.Key'F19 = Key 54
translateKey G.Key'F20 = Key 55
translateKey G.Key'F21 = Key 56
translateKey G.Key'F22 = Key 57
translateKey G.Key'F23 = Key 58
translateKey G.Key'F24 = Key 59
--translateKey G.Key'F25 = Key
translateKey G.Key'Pad0 = Key 89
translateKey G.Key'Pad1 = Key 90
translateKey G.Key'Pad2 = Key 91
translateKey G.Key'Pad3 = Key 92
translateKey G.Key'Pad4 = Key 93
translateKey G.Key'Pad5 = Key 94
translateKey G.Key'Pad6 = Key 95
translateKey G.Key'Pad7 = Key 96
translateKey G.Key'Pad8 = Key 97
translateKey G.Key'Pad9 = Key 98
translateKey G.Key'PadDecimal = Key 103
translateKey G.Key'PadDivide = Key 102
translateKey G.Key'PadMultiply = Key 101
translateKey G.Key'PadSubtract = Key 100
translateKey G.Key'PadAdd = Key 99
translateKey G.Key'PadEnter = Key 104
--translateKey G.Key'PadEqual = Key 
translateKey G.Key'LeftShift = Key 65
translateKey G.Key'LeftControl = Key 67
translateKey G.Key'LeftAlt = Key 69
translateKey G.Key'LeftSuper = Key 71
translateKey G.Key'RightShift = Key 66
translateKey G.Key'RightControl = Key 68
translateKey G.Key'RightAlt = Key 70
translateKey G.Key'RightSuper = Key 72
translateKey G.Key'Menu = Key 73
translateKey _ = Key (-1)