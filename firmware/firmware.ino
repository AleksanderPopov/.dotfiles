// -*- mode: c++

#ifndef BUILD_INFORMATION
#define BUILD_INFORMATION "locally built"
#endif

#include "Kaleidoscope.h"
#include "Kaleidoscope-EEPROM-Settings.h"
#include "Kaleidoscope-EEPROM-Keymap.h"
#include "Kaleidoscope-FocusSerial.h"
#include "Kaleidoscope-HostOS.h"

#include "Kaleidoscope-LED-Palette-Theme.h"
#include "Kaleidoscope-Colormap.h"
#include "Kaleidoscope-IdleLEDs.h"
#include "Kaleidoscope-Syster.h"

#include "Kaleidoscope-Macros.h"
#include "Kaleidoscope-Qukeys.h"


enum { MACRO_SCREEN };

enum { WORKMAN, FUNCTION };

// *INDENT-OFF*
KEYMAPS(
  [WORKMAN] = KEYMAP_STACKED (
    XXX,           Key_1, Key_2, Key_3, Key_4, Key_5, XXX,
    Key_Backtick,  Key_Q, Key_D, Key_R, Key_W, Key_B, Key_LeftBracket,
    Key_Tab,       Key_A, Key_S, Key_H, Key_T, Key_G,
    Key_Backslash, Key_Z, Key_X, Key_M, Key_C, Key_V, XXX,
    LT(FUNCTION, Enter), Key_Backspace, GUI_T(RightBracket), Key_LeftControl,
    LSHIFT(Key_9),

    XXX,          Key_6, Key_7, Key_8,     Key_9,      Key_0,     XXX,
    Key_RBracket, Key_J, Key_F, Key_U,     Key_P,      Key_Quote, Key_Semicolon,
                  Key_Y, Key_N, Key_E,     Key_O,      Key_I,     Key_Minus,
    XXX,          Key_K, Key_L, Key_Comma, Key_Period, Key_Slash, Key_Equals,
    Key_RightAlt, GUI_T(LeftBracket), Key_Spacebar, LT(FUNCTION, Escape),
    LSHIFT(Key_0)
  ),
  [FUNCTION] = KEYMAP_STACKED (
    XXX, Key_F1,        Key_F2,       Key_F3,        Key_F4,        Key_F5, Key_VolumeUp,
    XXX, Key_1,         Key_2,        Key_3,         Key_4,         XXX,    XXX,
    XXX, Key_Backslash, Key_Backtick, Key_LeftArrow, Key_Semicolon, Key_5,
    XXX, XXX,           XXX,          XXX,           XXX,           XXX,    Key_VolumeDown,
    ___, ___, ___, ___,
    ___,

    Key_Mute,        Key_F6,        Key_F7,         Key_F8,       Key_F9,     Key_F10, Key_LEDEffectNext,
    XXX,             Key_DownArrow, Key_7,          Key_8,        Key_9,      Key_0,   XXX,
                     Key_6,         Key_LBracket,   Key_RBracket, Key_Equals, XXX,     XXX,
    M(MACRO_SCREEN), Key_UpArrow,   Key_RightArrow, XXX,          XXX,        XXX,     XXX,
    ___, ___, ___, ___,
    ___
  )
)
// *INDENT-ON*

const macro_t *macroAction(uint8_t macroIndex, uint8_t keyState) {
  switch (macroIndex) {
    case MACRO_SCREEN:
      // print screen
      return MACRODOWN(D(LeftGui), D(LeftShift), T(4), U(LeftShift), U(LeftGui));
    }
  return MACRO_NONE;
}

KALEIDOSCOPE_INIT_PLUGINS(
  LEDControl,
  LEDOff,
  HostOS,
  EEPROMSettings,
  EEPROMKeymap,
  LEDPaletteTheme,
  IdleLEDs,
  ColormapEffect,

  Syster,
  Focus,

  Macros,
  Qukeys
);

void setup() {
  Kaleidoscope.setup();

  QUKEYS(
    kaleidoscope::plugin::Qukey(0, KeyAddr(3, 6), Key_LeftShift),      // (/Shift
    kaleidoscope::plugin::Qukey(0, KeyAddr(3, 9), Key_RightControl),   // )/Control
  )
  Qukeys.setHoldTimeout(250);
  Qukeys.setOverlapThreshold(30);

  ColormapEffect.max_layers(2);
  ColormapEffect.activate();

  // turn off led's after 10 minutes of inactivity
  IdleLEDs.setIdleTimeoutSeconds(10 * 60);
  // To make the keymap editable without flashing new firmware, we store
  // additional layers in EEPROM. For now, we reserve space for five layers. If
  // one wants to use these layers, just set the default layer to one in EEPROM,
  // by using the `settings.defaultLayer` Focus command.
  EEPROMKeymap.setup(2, EEPROMKeymap.Mode::EXTEND);
}

void loop() {
  Kaleidoscope.loop();
}
