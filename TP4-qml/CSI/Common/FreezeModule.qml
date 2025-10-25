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
  
  property var deckColor: S4MK3Functions.colorForDeckSingle(settings.slicerPadColour)
  property var offColor: S4MK3Functions.colorForDeckSingle(16)

  AppProperty { id: propSlice; 	  			path: "app.traktor.decks." + deckIdx + ".freeze.current_slice" }
  readonly property int sliceNo: propSlice.value
  
  AppProperty { id: propSliceCount; path: "app.traktor.decks." + deckIdx + ".freeze.slice_count" }
  property int slicerSize: propSliceCount.value
  
  AppProperty { id: propEnabled; 	  			path: "app.traktor.decks." + deckIdx + ".freeze.enabled" }
  readonly property bool 	slicerEnabled: 	      propEnabled.value
  
    
  // LED Brightness ----------------------
  readonly property real onBrightness:     1.0
  readonly property real dimmedBrightness: 0

  
  WiresGroup
  {
    enabled: active 
	
	WiresGroup
	{
		enabled: !slicerEnabled
		Wire {
			from: "%surface%.pads.1";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.enabled"; value: true; output: false }
		}
		Wire {
			from: "%surface%.pads.2";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.enabled"; value: true; output: false }
		}
		Wire {
			from: "%surface%.pads.3";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.enabled"; value: true; output: false }
		}
		Wire {
			from: "%surface%.pads.4";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.enabled"; value: true; output: false }
		}
		Wire {
			from: "%surface%.pads.5";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.enabled"; value: true; output: false }
		}
		Wire {
			from: "%surface%.pads.6";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.enabled"; value: true; output: false }
		}
		Wire {
			from: "%surface%.pads.7";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.enabled"; value: true; output: false }
		}
		Wire {
			from: "%surface%.pads.8";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.enabled"; value: true; output: false }
		}
	}

    WiresGroup
    {
      enabled:  (((sliceNo <= 7 || sliceNo > 15) && (slicerSize > 8)) ||  (slicerSize <= 8))  && !shift && active

	  Wire {
		from: "%surface%.pads.1";
		to: TriggerPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.jump_to_slice.1"; output: false }
	  }
	  Wire {
		from: "%surface%.pads.2";
		to: TriggerPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.jump_to_slice.2"; output: false }
	  }
	  Wire {
		from: "%surface%.pads.3";
		to: TriggerPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.jump_to_slice.3"; output: false }
	  }
	  Wire {
		from: "%surface%.pads.4";
		to: TriggerPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.jump_to_slice.4"; output: false }
	  }
	  Wire {
		from: "%surface%.pads.5";
		to: TriggerPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.jump_to_slice.5"; output: false }
	  }
	  Wire {
		from: "%surface%.pads.6";
		to: TriggerPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.jump_to_slice.6"; output: false }
	  }
	  Wire {
		from: "%surface%.pads.7";
		to: TriggerPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.jump_to_slice.7"; output: false }
	  }
	  Wire {
		from: "%surface%.pads.8";
		to: TriggerPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.jump_to_slice.8"; output: false }
	  }
	  
	  Wire { 
		enabled: (slicerSize > 0) ? true : false
		from: "%surface%.pads.1";
		to: ButtonScriptAdapter
		{
		onPress:
		{
			brightness: onBrightness
		}
        brightness: (sliceNo == 0) ? onBrightness : dimmedBrightness
		color: (slicerSize >= 1) ? module.deckColor : module.offColor
        }
      }
	  Wire { 
		enabled: (slicerSize > 1) ? true : false
		from: "%surface%.pads.2";
		to: ButtonScriptAdapter
		{
		onPress:
		{
			brightness: onBrightness
		}
        brightness: (sliceNo == 1) ? onBrightness : dimmedBrightness
		color: (slicerSize >= 2) ? module.deckColor : module.offColor
        }
      }
	  Wire { 
		enabled: (slicerSize > 2)
		from: "%surface%.pads.3";
		to: ButtonScriptAdapter
		{
		onPress:
		{
			brightness: onBrightness
		}
        brightness: (sliceNo == 2) ? onBrightness : dimmedBrightness
		color: (slicerSize >= 3) ? module.deckColor : module.offColor
        }
      }
	  Wire { 
		enabled: (slicerSize > 3)
		from: "%surface%.pads.4";
		to: ButtonScriptAdapter
		{
		onPress:
		{
			brightness: onBrightness
		}
        brightness: (sliceNo == 3) ? onBrightness : dimmedBrightness
		color: (slicerSize >= 4) ? module.deckColor : module.offColor
        }
      }
	  Wire { 
		enabled: (slicerSize > 4)
		from: "%surface%.pads.5";
		to: ButtonScriptAdapter
		{
		onPress:
		{
			brightness: onBrightness
		}
        brightness: (sliceNo == 4) ? onBrightness : dimmedBrightness
		color: (slicerSize >= 5) ? module.deckColor : module.offColor
        }
      }
	  Wire { 
		enabled: (slicerSize > 5)
		from: "%surface%.pads.6";
		to: ButtonScriptAdapter
		{
		onPress:
		{
			brightness: onBrightness
		}
        brightness: (sliceNo == 5) ? onBrightness : dimmedBrightness
		color: (slicerSize >= 6) ? module.deckColor : module.offColor
        }
      }
	  Wire { 
		enabled: (slicerSize > 6)
		from: "%surface%.pads.7";
		to: ButtonScriptAdapter
		{
		onPress:
		{
			brightness: onBrightness
		}
        brightness: (sliceNo == 6) ? onBrightness : dimmedBrightness
		color: (slicerSize >= 7) ? module.deckColor : module.offColor
        }
      }
	  Wire { 
		enabled: (slicerSize > 7)
		from: "%surface%.pads.8";
		to: ButtonScriptAdapter
		{
		onPress:
		{
			brightness: onBrightness
		}
        brightness: (sliceNo == 7) ? onBrightness : dimmedBrightness
		color: (slicerSize >= 8) ? module.deckColor : module.offColor
        }
      }
	}
	
	WiresGroup
    {
      enabled:  ((sliceNo > 7 && sliceNo < 16) && (slicerSize > 8)) && !shift

	  Wire {
		from: "%surface%.pads.1";
		to: TriggerPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.jump_to_slice.9"; output: false }
	  }
	  Wire {
		from: "%surface%.pads.2";
		to: TriggerPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.jump_to_slice.10"; output: false }
	  }
	  Wire {
		from: "%surface%.pads.3";
		to: TriggerPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.jump_to_slice.11"; output: false }
	  }
	  Wire {
		from: "%surface%.pads.4";
		to: TriggerPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.jump_to_slice.12"; output: false }
	  }
	  Wire {
		from: "%surface%.pads.5";
		to: TriggerPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.jump_to_slice.13"; output: false }
	  }
	  Wire {
		from: "%surface%.pads.6";
		to: TriggerPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.jump_to_slice.14"; output: false }
	  }
	  Wire {
		from: "%surface%.pads.7";
		to: TriggerPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.jump_to_slice.15"; output: false }
	  }
	  Wire {
		from: "%surface%.pads.8";
		to: TriggerPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.jump_to_slice.16"; output: false }
	  }
	  
	  Wire { 
		from: "%surface%.pads.1";
		to: ButtonScriptAdapter
		{
		onPress:
		{
			brightness: onBrightness
		}
        brightness: (sliceNo == 8) ? onBrightness : dimmedBrightness
		color: module.deckColor
        }
      }
	  Wire { 
		from: "%surface%.pads.2";
		to: ButtonScriptAdapter
		{
		onPress:
		{
			brightness: onBrightness
		}
        brightness: (sliceNo == 9) ? onBrightness : dimmedBrightness
		color: module.deckColor
        }
      }
	  Wire { 
		from: "%surface%.pads.3";
		to: ButtonScriptAdapter
		{
		onPress:
		{
			brightness: onBrightness
		}
        brightness: (sliceNo == 10) ? onBrightness : dimmedBrightness
		color: module.deckColor
        }
      }
	  Wire { 
		from: "%surface%.pads.4";
		to: ButtonScriptAdapter
		{
		onPress:
		{
			brightness: onBrightness
		}
        brightness: (sliceNo == 11) ? onBrightness : dimmedBrightness
		color: module.deckColor
        }
      }
	  Wire { 
		from: "%surface%.pads.5";
		to: ButtonScriptAdapter
		{
		onPress:
		{
			brightness: onBrightness
		}
        brightness: (sliceNo == 12) ? onBrightness : dimmedBrightness
		color: module.deckColor
        }
      }
	  Wire { 
		from: "%surface%.pads.6";
		to: ButtonScriptAdapter
		{
		onPress:
		{
			brightness: onBrightness
		}
        brightness: (sliceNo == 13) ? onBrightness : dimmedBrightness
		color: module.deckColor
        }
      }
	  Wire { 
		from: "%surface%.pads.7";
		to: ButtonScriptAdapter
		{
		onPress:
		{
			brightness: onBrightness
		}
        brightness: (sliceNo == 14) ? onBrightness : dimmedBrightness
		color: module.deckColor
        }
      }
	  Wire { 
		from: "%surface%.pads.8";
		to: ButtonScriptAdapter
		{
		onPress:
		{
			brightness: onBrightness
		}
        brightness: (sliceNo == 15) ? onBrightness : dimmedBrightness
		color: module.deckColor
        }
      }
	}
	
	WiresGroup {
	
	  enabled: shift && active
	
	  Wire {
		enabled: !(settings.slicerSizePad1 == 0)
		from: "%surface%.pads.1";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.slice_count"; value: settings.slicerSizePad1; }
	  }
	  Wire {
	    enabled: !(settings.slicerSizePad2 == 0)
		from: "%surface%.pads.2";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.slice_count"; value: settings.slicerSizePad2; }
	  }
	  Wire {
	    enabled: !(settings.slicerSizePad3 == 0)
		from: "%surface%.pads.3";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.slice_count"; value: settings.slicerSizePad3; }
	  }
	  Wire {
	    enabled: !(settings.slicerSizePad4 == 0)
		from: "%surface%.pads.4";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.slice_count"; value: settings.slicerSizePad4; }
	  }
	  Wire {
	    enabled: !(settings.slicerSizePad5 == 0)
		from: "%surface%.pads.5";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.slice_count"; value: settings.slicerSizePad5; }
	  }
	  Wire {
	    enabled: !(settings.slicerSizePad6 == 0)
		from: "%surface%.pads.6";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.slice_count"; value: settings.slicerSizePad6; }
	  }
	  Wire {
	    enabled: !(settings.slicerSizePad7 == 0)
		from: "%surface%.pads.7";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.slice_count"; value: settings.slicerSizePad7; }
	  }
	  Wire {
	    enabled: !(settings.slicerSizePad8 == 0)
		from: "%surface%.pads.8";
		to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".freeze.slice_count"; value: settings.slicerSizePad8; }
	  }
	  
	}
  }
}
