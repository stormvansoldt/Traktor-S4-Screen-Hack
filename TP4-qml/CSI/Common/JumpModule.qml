import CSI 1.0
import QtQuick 2.5
import "../S4MK3/S4MK3Functions.js" as S4MK3Functions
import '../../Screens/Defines' as Defines


Module
{
  id: module

  Defines.Settings  {id: settings}
  property int deckA: settings.deckAColour
  property int deckB: settings.deckBColour
  property int deckC: settings.deckCColour
  property int deckD: settings.deckDColour

  
  property bool shift: false
  property string surface: ""
  property int deckIdx: 0
  property bool active: false
  property string deckPropertiesPath: ""
  
  property bool moveForward: false
  property bool moveBack: false
  
  property bool repeats: settings.jumpRepeat
  property int jumpSize: 0
  
  AppProperty { id: jumpSizeProp; path:"app.traktor.decks."+ deckIdx + ".beatjump"}
  
  property var jumpColor: S4MK3Functions.colorForDeckSingle(settings.jumpPadColour)
  property var jumpBackColor: S4MK3Functions.colorForDeckSingle(settings.jumpBackPadColour)
  property var jumpOffColor: S4MK3Functions.colorForDeckSingle(16)
  
  
  // LED Brightness ----------------------
  readonly property real onBrightness:     1.0
  readonly property real dimmedBrightness: 0
  
  Timer {
          id: jumpTimer
          property bool blink: false

		  triggeredOnStart: !settings.repeatDelay
          interval: settings.repeatTimer
          repeat:   true
          running:  (module.jumpSize != 0) ? true : false 

          onTriggered: {
        	blink = !blink;
			blink == true ? jumpSizeProp.value = module.jumpSize : jumpSizeProp.value = 0;         
          }

          onRunningChanged: {
            blink = false;
          }
  }
  
  WiresGroup
  {
    enabled: active && !repeats

    WiresGroup
    {
      enabled:  !module.shift

	  Wire {
		from: "%surface%.pads.1";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.jumpSizePad1; output: true; color: (settings.jumpSizePad1 > 0 ? jumpColor : jumpBackColor)}
	  }
	  
	  Wire {
		from: "%surface%.pads.2";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.jumpSizePad2; output: true; color: (settings.jumpSizePad2 > 0 ? jumpColor : jumpBackColor)}
	  }
	  Wire {
		from: "%surface%.pads.3";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.jumpSizePad3; output: true; color: (settings.jumpSizePad3 > 0 ? jumpColor : jumpBackColor)}
	  }
	  Wire {
		from: "%surface%.pads.4";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.jumpSizePad4; output: true; color: (settings.jumpSizePad4 > 0 ? jumpColor : jumpBackColor)}
	  }
	  Wire {
		from: "%surface%.pads.5";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.jumpSizePad5; output: true; color: (settings.jumpSizePad5 > 0 ? jumpColor : jumpBackColor)}
	  }
	  Wire {
		from: "%surface%.pads.6";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.jumpSizePad6; output: true; color: (settings.jumpSizePad6 > 0 ? jumpColor : jumpBackColor)}
	  }
	  Wire {
		from: "%surface%.pads.7";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.jumpSizePad7; output: true; color: (settings.jumpSizePad7 > 0 ? jumpColor : jumpBackColor)}
	  }
	  Wire {
		from: "%surface%.pads.8";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.jumpSizePad8; output: true; color: (settings.jumpSizePad8 > 0 ? jumpColor : jumpBackColor)}
	  }
    }
	
	WiresGroup
    {
      enabled:  module.shift

	  Wire {
		from: "%surface%.pads.1";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.shiftJumpSizePad1; output: true; color: (settings.shiftJumpSizePad1 > 0 ? jumpColor : jumpBackColor)}
	  }
	  Wire {
		from: "%surface%.pads.2";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.shiftJumpSizePad2; output: true; color: (settings.shiftJumpSizePad2 > 0 ? jumpColor : jumpBackColor)}
	  }
	  Wire {
		from: "%surface%.pads.3";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.shiftJumpSizePad3; output: true; color: (settings.shiftJumpSizePad3 > 0 ? jumpColor : jumpBackColor)}
	  }
	  Wire {
		from: "%surface%.pads.4";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.shiftJumpSizePad4; output: true; color: (settings.shiftJumpSizePad4 > 0 ? jumpColor : jumpBackColor)}
	  }
	  Wire {
		from: "%surface%.pads.5";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.shiftJumpSizePad5; output: true; color: (settings.shiftJumpSizePad5 > 0 ? jumpColor : jumpBackColor)}
	  }
	  Wire {
		from: "%surface%.pads.6";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.shiftJumpSizePad6; output: true; color: (settings.shiftJumpSizePad6 > 0 ? jumpColor : jumpBackColor)}
	  }
	  Wire {
		from: "%surface%.pads.7";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.shiftJumpSizePad7; output: true; color: (settings.shiftJumpSizePad7 > 0 ? jumpColor : jumpBackColor)}
	  }
	  Wire {
		from: "%surface%.pads.8";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.shiftJumpSizePad8; output: true; color: (settings.shiftJumpSizePad8 > 0 ? jumpColor : jumpBackColor)}
	  }
    }
  }
  
  WiresGroup
  {
    enabled: active && repeats

    WiresGroup
    {
      enabled:  !module.shift
	  
	  Wire {
		from: "%surface%.pads.1";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.jumpSizePad1; output: true; color: (settings.jumpSizePad1 > 0 ? jumpColor : jumpBackColor)}
	  }

	  Wire {
		from: "%surface%.pads.1";
		to: ButtonScriptAdapter 
		{
			onPress: {
				module.jumpSize = settings.jumpSizePad1
			}	 
			
			onRelease: {
				module.jumpSize = 0
			}
			color: (settings.jumpSizePad1 > 0 ? jumpColor : jumpBackColor)
		}
	  }
	  
	  Wire {
		from: "%surface%.pads.2";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.jumpSizePad2; output: true; color: (settings.jumpSizePad2 > 0 ? jumpColor : jumpBackColor)}
	  }
	  
	  Wire {
		from: "%surface%.pads.2";
		to: ButtonScriptAdapter 
		{
			onPress: {
				module.jumpSize = settings.jumpSizePad2
			}	 
			
			onRelease: {
				module.jumpSize = 0
			}
			color: (settings.jumpSizePad2 > 0 ? jumpColor : jumpBackColor)
		}
	  }
	  
	  Wire {
		from: "%surface%.pads.3";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.jumpSizePad3; output: true; color: (settings.jumpSizePad3 > 0 ? jumpColor : jumpBackColor)}
	  }
	  
	  Wire {
		from: "%surface%.pads.3";
		to: ButtonScriptAdapter 
		{
			onPress: {
				module.jumpSize = settings.jumpSizePad3
			}	 
			
			onRelease: {
				module.jumpSize = 0
			}
			color: (settings.jumpSizePad3 > 0 ? jumpColor : jumpBackColor)
		}
	  }
	  
	  Wire {
		from: "%surface%.pads.4";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.jumpSizePad4; output: true; color: (settings.jumpSizePad4 > 0 ? jumpColor : jumpBackColor)}
	  }
	  
	  Wire {
		from: "%surface%.pads.4";
		to: ButtonScriptAdapter 
		{
			onPress: {
				module.jumpSize = settings.jumpSizePad4
			}	 
			
			onRelease: {
				module.jumpSize = 0
			}
			color: (settings.jumpSizePad4 > 0 ? jumpColor : jumpBackColor)
		}
	  }
	  
	  Wire {
		from: "%surface%.pads.5";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.jumpSizePad5; output: true; color: (settings.jumpSizePad5 > 0 ? jumpColor : jumpBackColor)}
	  }
	  
	  Wire {
		from: "%surface%.pads.5";
		to: ButtonScriptAdapter 
		{
			onPress: {
				module.jumpSize = settings.jumpSizePad5
			}	 
			
			onRelease: {
				module.jumpSize = 0
			}
			color: (settings.jumpSizePad5 > 0 ? jumpColor : jumpBackColor)
		}
	  }
	  
	  Wire {
		from: "%surface%.pads.6";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.jumpSizePad6; output: true; color: (settings.jumpSizePad6 > 0 ? jumpColor : jumpBackColor)}
	  }
	  
	  Wire {
		from: "%surface%.pads.6";
		to: ButtonScriptAdapter 
		{
			onPress: {
				module.jumpSize = settings.jumpSizePad6
			}	 
			
			onRelease: {
				module.jumpSize = 0
			}
			color: (settings.jumpSizePad6 > 0 ? jumpColor : jumpBackColor)
		}
	  }
	  
	  Wire {
		from: "%surface%.pads.7";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.jumpSizePad7; output: true; color: (settings.jumpSizePad7 > 0 ? jumpColor : jumpBackColor)}
	  }
	  
	  Wire {
		from: "%surface%.pads.7";
		to: ButtonScriptAdapter 
		{
			onPress: {
				module.jumpSize = settings.jumpSizePad7
			}	 
			
			onRelease: {
				module.jumpSize = 0
			}
			color: (settings.jumpSizePad7 > 0 ? jumpColor : jumpBackColor)
		}
	  }
	  
	  Wire {
		from: "%surface%.pads.8";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.jumpSizePad8; output: true; color: (settings.jumpSizePad8 > 0 ? jumpColor : jumpBackColor)}
	  }
	  
	  Wire {
		from: "%surface%.pads.8";
		to: ButtonScriptAdapter 
		{
			onPress: {
				module.jumpSize = settings.jumpSizePad8
			}	 
			
			onRelease: {
				module.jumpSize = 0
			}
			color: (settings.jumpSizePad8 > 0 ? jumpColor : jumpBackColor)
		}
	  }
	  
    }
	
	WiresGroup
    {
      enabled:  module.shift

	  Wire {
		from: "%surface%.pads.1";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.shiftJumpSizePad1; output: true; color: (settings.shiftJumpSizePad1 > 0 ? jumpColor : jumpBackColor)}
	  }
	  
	  Wire {
		from: "%surface%.pads.1";
		to: ButtonScriptAdapter 
		{
			onPress: {
				module.jumpSize = settings.shiftJumpSizePad1
			}	 
			
			onRelease: {
				module.jumpSize = 0
			}
			color: (settings.shiftJumpSizePad1 > 0 ? jumpColor : jumpBackColor)
		}
	  }
	  
	  Wire {
		from: "%surface%.pads.2";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.shiftJumpSizePad2; output: true; color: (settings.shiftJumpSizePad2 > 0 ? jumpColor : jumpBackColor)}
	  }
	  
	  Wire {
		from: "%surface%.pads.2";
		to: ButtonScriptAdapter 
		{
			onPress: {
				module.jumpSize = settings.shiftJumpSizePad2
			}	 
			
			onRelease: {
				module.jumpSize = 0
			}
			color: (settings.shiftJumpSizePad2 > 0 ? jumpColor : jumpBackColor)
		}
	  }
	  
	  Wire {
		from: "%surface%.pads.3";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.shiftJumpSizePad3; output: true; color: (settings.shiftJumpSizePad3 > 0 ? jumpColor : jumpBackColor)}
	  }
	  
	  Wire {
		from: "%surface%.pads.3";
		to: ButtonScriptAdapter 
		{
			onPress: {
				module.jumpSize = settings.shiftJumpSizePad3
			}	 
			
			onRelease: {
				module.jumpSize = 0
			}
			color: (settings.shiftJumpSizePad3 > 0 ? jumpColor : jumpBackColor)
		}
	  }
	  
	  Wire {
		from: "%surface%.pads.4";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.shiftJumpSizePad4; output: true; color: (settings.shiftJumpSizePad4 > 0 ? jumpColor : jumpBackColor)}
	  }
	  
	  Wire {
		from: "%surface%.pads.4";
		to: ButtonScriptAdapter 
		{
			onPress: {
				module.jumpSize = settings.shiftJumpSizePad4
			}	 
			
			onRelease: {
				module.jumpSize = 0
			}
			color: (settings.shiftJumpSizePad4 > 0 ? jumpColor : jumpBackColor)
		}
	  }
	  
	  Wire {
		from: "%surface%.pads.5";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.shiftJumpSizePad5; output: true; color: (settings.shiftJumpSizePad5 > 0 ? jumpColor : jumpBackColor)}
	  }
	  
	  Wire {
		from: "%surface%.pads.5";
		to: ButtonScriptAdapter 
		{
			onPress: {
				module.jumpSize = settings.shiftJumpSizePad5
			}	 
			
			onRelease: {
				module.jumpSize = 0
			}
			color: (settings.shiftJumpSizePad5 > 0 ? jumpColor : jumpBackColor)
		}
	  }
	  
	  Wire {
		from: "%surface%.pads.6";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.shiftJumpSizePad6; output: true; color: (settings.shiftJumpSizePad6 > 0 ? jumpColor : jumpBackColor)}
	  }
	  
	  Wire {
		from: "%surface%.pads.6";
		to: ButtonScriptAdapter 
		{
			onPress: {
				module.jumpSize = settings.shiftJumpSizePad6
			}	 
			
			onRelease: {
				module.jumpSize = 0
			}
			color: (settings.shiftJumpSizePad6 > 0 ? jumpColor : jumpBackColor)
		}
	  }
	  
	  Wire {
		from: "%surface%.pads.7";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.shiftJumpSizePad7; output: true; color: (settings.shiftJumpSizePad7 > 0 ? jumpColor : jumpBackColor)}
	  }
	  
	  Wire {
		from: "%surface%.pads.7";
		to: ButtonScriptAdapter 
		{
			onPress: {
				module.jumpSize = settings.shiftJumpSizePad7
			}	 
			
			onRelease: {
				module.jumpSize = 0
			}
			color: (settings.shiftJumpSizePad7 > 0 ? jumpColor : jumpBackColor)
		}
	  }
	  
	  Wire {
		from: "%surface%.pads.8";
		to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".beatjump"; value: settings.shiftJumpSizePad8; output: true; color: (settings.shiftJumpSizePad8 > 0 ? jumpColor : jumpBackColor)}
	  }
	
	Wire {
		from: "%surface%.pads.8";
		to: ButtonScriptAdapter 
		{
			onPress: {
				module.jumpSize = settings.shiftJumpSizePad8
			}	 
			
			onRelease: {
				module.jumpSize = 0
			}
			color: (settings.shiftJumpSizePad8 > 0 ? jumpColor : jumpBackColor)
		}
	}
	}  
  }
  
}
