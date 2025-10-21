import CSI 1.0
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
  property bool forward: true
  
  property var loopColor: S4MK3Functions.colorForDeckSingle(settings.loopPadColour)
  property var loopBackColor: S4MK3Functions.colorForDeckSingle(settings.loopBackPadColour)

  AppProperty { id: loopSizePos; path: "app.traktor.decks." + deckIdx + ".loop.size"} 
  property int loopSize: loopSizePos.value

  AppProperty { id: loopEnabled; path: "app.traktor.decks." + deckIdx + ".loop.active" }
  property bool loopActive: loopEnabled.value
  property bool isPlaying: deckInfo.isPlaying

  Wire {
		from: "s4mk3." + side + ".shift";
		to: ButtonScriptAdapter 
		{
			onPress: 
			{ 
				module.active && !module.loopActive ? (module.forward == true ? module.forward = false : module.forward = true) : "" 
			}
		}
		
	}
  
  
  // LED Brightness ----------------------
  readonly property real onBrightness:     1.0
  readonly property real dimmedBrightness: 0

  
  WiresGroup
  {
    enabled: active 

    WiresGroup
    {
      enabled:  loopActive ? true : forward

	  Wire {
		from: "%surface%.pads.1";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size"; value: settings.loopSizePad1; output: false}
	  }
	  Wire {
		from: "%surface%.pads.2";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size"; value: settings.loopSizePad2; output: false}
	  }
	  Wire {
		from: "%surface%.pads.3";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size"; value: settings.loopSizePad3; output: false }
	  }
	  Wire {
		from: "%surface%.pads.4";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size"; value: settings.loopSizePad4; output: false }
	  }
	  Wire {
		from: "%surface%.pads.5";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size"; value: settings.loopSizePad5; output: false}
	  }
	  Wire {
		from: "%surface%.pads.6";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size"; value: settings.loopSizePad6; output: false }
	  }
	  Wire {
		from: "%surface%.pads.7";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size"; value: settings.loopSizePad7; output: false }
	  }
	  Wire {
		from: "%surface%.pads.8";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size"; value: settings.loopSizePad8; output: false }
	  }
	  Wire {
		from: "%surface%.pads.1";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.loopSizePad1) && loopActive ? onBrightness : dimmedBrightness; color: loopColor }
	  }
	  Wire {
		from: "%surface%.pads.2";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.loopSizePad2) && loopActive ? onBrightness : dimmedBrightness; color: loopColor }
	  }
	  Wire {
		from: "%surface%.pads.3";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.loopSizePad3) && loopActive ? onBrightness : dimmedBrightness; color: loopColor }
	  }
	  Wire {
		from: "%surface%.pads.4";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.loopSizePad4) && loopActive ? onBrightness : dimmedBrightness; color: loopColor }
	  }
	  Wire {
		from: "%surface%.pads.5";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.loopSizePad5) && loopActive ? onBrightness : dimmedBrightness; color: loopColor }
	  }
	  Wire {
		from: "%surface%.pads.6";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.loopSizePad6) && loopActive ? onBrightness : dimmedBrightness; color: loopColor }
	  }
	  Wire {
		from: "%surface%.pads.7";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.loopSizePad7) && loopActive ? onBrightness : dimmedBrightness; color: loopColor }
	  }
	  Wire {
		from: "%surface%.pads.8";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.loopSizePad8) && loopActive ? onBrightness : dimmedBrightness; color: loopColor }
	  }
	  
    }
	
	WiresGroup
    {
      enabled:  !forward && !loopActive

	  Wire {
		from: "%surface%.pads.1";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size_backward"; value: settings.loopSizePad1; output: false}
	  }
	  Wire {
		from: "%surface%.pads.2";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size_backward"; value: settings.loopSizePad2; output: false}
	  }
	  Wire {
		from: "%surface%.pads.3";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size_backward"; value: settings.loopSizePad3; output: false }
	  }
	  Wire {
		from: "%surface%.pads.4";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size_backward"; value: settings.loopSizePad4; output: false }
	  }
	  Wire {
		from: "%surface%.pads.5";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size_backward"; value: settings.loopSizePad5; output: false}
	  }
	  Wire {
		from: "%surface%.pads.6";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size_backward"; value: settings.loopSizePad6; output: false }
	  }
	  Wire {
		from: "%surface%.pads.7";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size_backward"; value: settings.loopSizePad7; output: false }
	  }
	  Wire {
		from: "%surface%.pads.8";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size_backward"; value: settings.loopSizePad8; output: false }
	  }
	  Wire {
		from: "%surface%.pads.1";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.loopSizePad1) && loopActive ? onBrightness : dimmedBrightness; color: loopBackColor }
	  }
	  Wire {
		from: "%surface%.pads.2";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.loopSizePad2) && loopActive ? onBrightness : dimmedBrightness; color: loopBackColor }
	  }
	  Wire {
		from: "%surface%.pads.3";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.loopSizePad3) && loopActive ? onBrightness : dimmedBrightness; color: loopBackColor }
	  }
	  Wire {
		from: "%surface%.pads.4";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.loopSizePad4) && loopActive ? onBrightness : dimmedBrightness; color: loopBackColor }
	  }
	  Wire {
		from: "%surface%.pads.5";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.loopSizePad5) && loopActive ? onBrightness : dimmedBrightness; color: loopBackColor }
	  }
	  Wire {
		from: "%surface%.pads.6";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.loopSizePad6) && loopActive ? onBrightness : dimmedBrightness; color: loopBackColor }
	  }
	  Wire {
		from: "%surface%.pads.7";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.loopSizePad7) && loopActive ? onBrightness : dimmedBrightness; color: loopBackColor }
	  }
	  Wire {
		from: "%surface%.pads.8";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.loopSizePad8) && loopActive ? onBrightness : dimmedBrightness; color: loopBackColor }
	  }
    }
	
	WiresGroup {
	  enabled: !isPlaying && settings.loopPadPlay
	  
	  Wire {
		from: "%surface%.pads.1";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".play"; value: true; output: false }
	  }
	  Wire {
		from: "%surface%.pads.2";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".play"; value: true; output: false }
	  }
	  Wire {
		from: "%surface%.pads.3";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".play"; value: true; output: false }
	  }
	  Wire {
		from: "%surface%.pads.4";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".play"; value: true; output: false }
	  }
	  Wire {
		from: "%surface%.pads.5";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".play"; value: true; output: false }
	  }
	  Wire {
		from: "%surface%.pads.6";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".play"; value: true; output: false }
	  }
	  Wire {
		from: "%surface%.pads.7";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".play"; value: true; output: false }
	  }
	  Wire {
		from: "%surface%.pads.8";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".play"; value: true; output: false }
	  }
	}
  }
}
