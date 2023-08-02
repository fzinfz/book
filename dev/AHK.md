<!-- TOC -->

- [V2](#v2)
- [Keys](#keys)
- [Functions](#functions)
    - [SendKeys](#sendkeys)
- [JoyStick](#joystick)
    - [Debug](#debug)
    - [x360](#x360)
- [Keyboard](#keyboard)
- [Mouse](#mouse)

<!-- /TOC -->

# V2
v2.0.0 was released on 2022-12-20: https://www.autohotkey.com/v2/

# Keys

| Key | Name |
| -- | -- |
| ^ | Ctrl
| ! | Alt
| + | Shift
| # | Win
| {+} | +

# Functions
- `SetTimer Function, Period(ms), Priority` | repeatedly/asynchronously | https://www.autohotkey.com/docs/v2/lib/SetTimer.htm
  - Period > 0: default 250
  - Period < 0: run only once
  - Period = 0: deleted after the thread finishes

## SendKeys
https://www.autohotkey.com/docs/v2/howto/SendKeys.htm

    ^3::{
        SendText "Double quote: `""
        SendText 'Single quote: `''
    }

# JoyStick
https://www.autohotkey.com/docs/v2/KeyList.htm#Controller

- Joy1 through Joy32
- used with `GetKeyState`:

    JoyX, JoyY, and JoyZ: The X (horizontal), Y (vertical), and Z (altitude/depth) axes of the controller.
    JoyR: The rudder(舵) or 4th axis of the controller.
    JoyU and JoyV: The 5th and 6th axes of the controller.
    JoyPOV: The point-of-view (hat) control.
    JoyName: The name of the controller or its driver.
    JoyButtons: The number of buttons supported by the controller (not always accurate).
    JoyAxes: The number of axes supported by the controller.
    JoyInfo: Example string: ZRUVPD
      - Z (has Z axis), R (has R axis), U (has U axis), V (has V axis)
      - P (has POV control),
        - D (the POV control has a limited number of discrete/distinct settings)
        - C (the POV control is continuous/fine). 

## Debug
- Windows Start keyword : 'joy'
- .ahk : https://www.autohotkey.com/docs/v1/scripts/index.htm#ControllerTest

## x360

x360 | Default | Range
-- | -- | --
Left Stick / XY | 50 | Left/Up 0 - Right/Down 100
D-Pad/hat / POV | -1 | POV0 - POV31500
Right Stick / XY Rotation | U50 R50 | 0-100
ABXY | 1234
LB/LeftBumper RB | 5 6
Back ; Start | 7 8
LT/LeftTrigger  Z | Z50 | - Z100
RT/RightTrigger Z | Z50 | - Z0

# Keyboard
https://www.autohotkey.com/docs/v2/KeyList.htm

```
Joy2::Send "{w}"
```

# Mouse

```
Joy1::
{
    Send "{LButton down}"   ; Hold down the left mouse button.
    ; SetTimer WaitForButtonUp3, 10
}
```
