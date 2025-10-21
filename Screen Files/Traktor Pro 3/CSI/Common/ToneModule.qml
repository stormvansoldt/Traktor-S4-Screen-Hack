import CSI 1.0
import "../S4MK3/S4MK3Functions.js" as S4MK3Functions
import '../../Screens/Defines' as Defines


Module
{
  id: module

  property bool shift: false
  property string surface: ""
  property int deckIdx: 0
  property bool active: false
  property string deckPropertiesPath: ""
  property bool forward: true
  property string side: ""
  
  MappingPropertyDescriptor 
  { 
    id: forwardProp; 
    path: "mapping.state." + module.deckIdx + ".forward"; 
    type: MappingPropertyDescriptor.Boolean; 
    value: module.forward;
  }

  property var forwardColor: S4MK3Functions.colorForDeckSingle(6)
  property var backColor: S4MK3Functions.colorForDeckSingle(0)
  property var whiteColor: S4MK3Functions.colorForDeckSingle(3)
  
  AppProperty { id: keyAdjust; path: "app.traktor.decks." + deckIdx + ".track.key.adjust"}
  
  
  // LED Brightness ----------------------
  readonly property real onBrightness:     1.0
  readonly property real dimmedBrightness: 0
  
  Wire {
		from: "s4mk3." + side + ".shift";
		to: ButtonScriptAdapter 
		{
			onPress: 
			{ 
				module.active ? (module.forward == true ? module.forward = false : module.forward = true) : "" 
			}
		}
		
	}

  
  WiresGroup
  {
    enabled: active 

    WiresGroup
    {
	  enabled: forward
	  
      Wire {
		from: "%surface%.pads.1";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: 0; output: true; color: whiteColor}
	  }
	  Wire {
	    enabled: keyAdjust.value != 0.0833199992775917;
		from: "%surface%.pads.2";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: 0.083320000191926956; output: true; color: forwardColor}
	  }
	  Wire {
	    enabled: keyAdjust.value != 0.16660000383853912;
		from: "%surface%.pads.3";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: 0.16660000383853912; output: true; color: forwardColor}
	  }
	  Wire {
	    enabled: keyAdjust.value != 0.25;
		from: "%surface%.pads.4";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: 0.25; output: true; color: forwardColor}
	  }
	  Wire {
	    enabled: keyAdjust.value != 0.33329999446868896;
		from: "%surface%.pads.5";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: 0.33329999446868896; output: true; color: forwardColor}
	  }
	  Wire {
	    enabled: keyAdjust.value != 0.41659998893737793;
		from: "%surface%.pads.6";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: 0.41659998893737793; output: true; color: forwardColor}
	  }
	  Wire {
	    enabled: keyAdjust.value != 0.5;
		from: "%surface%.pads.7";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: 0.5; output: true; color: forwardColor}
	  }
	  Wire {
	  	enabled: keyAdjust.value != 0.583299994468689;
		from: "%surface%.pads.8";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: 0.583299994468689; output: true; color: forwardColor}
	  }
	  
	  Wire {
	  	enabled: keyAdjust.value == 0.0833199992775917;
		from: "%surface%.pads.2";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: 0; output: false;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == 0.16660000383853912;
		from: "%surface%.pads.3";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: 0; output: false;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == 0.25;
		from: "%surface%.pads.4";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: 0; output: false;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == 0.33329999446868896;
		from: "%surface%.pads.5";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: 0; output: false;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == 0.41659998893737793;
		from: "%surface%.pads.6";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: 0; output: false;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == 0.5;
		from: "%surface%.pads.7";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: 0; output: false;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == 0.583299994468689;
		from: "%surface%.pads.8";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: 0; output: false;}
	  }
	  
	  Wire {
	  	enabled: keyAdjust.value == 0.0833199992775917;
		from: "%surface%.pads.2";
		to: ButtonScriptAdapter { color: forwardColor; brightness: 1.0;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == 0.16660000383853912;
		from: "%surface%.pads.3";
		to: ButtonScriptAdapter { color: forwardColor; brightness: 1.0;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == 0.25;
		from: "%surface%.pads.4";
		to: ButtonScriptAdapter { color: forwardColor; brightness: 1.0;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == 0.33329999446868896;
		from: "%surface%.pads.5";
		to: ButtonScriptAdapter { color: forwardColor; brightness: 1.0;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == 0.41659998893737793;
		from: "%surface%.pads.6";
		to: ButtonScriptAdapter { color: forwardColor; brightness: 1.0;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == 0.5;
		from: "%surface%.pads.7";
		to: ButtonScriptAdapter { color: forwardColor; brightness: 1.0;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == 0.583299994468689;
		from: "%surface%.pads.8";
		to: ButtonScriptAdapter { color: forwardColor; brightness: 1.0;}
	  }
	  
	  
    }
    
    WiresGroup
    {
	  enabled: !forward
	  
      Wire {
		from: "%surface%.pads.1";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: 0; output: true; color: whiteColor}
	  }
	  Wire {
	    enabled: keyAdjust.value != -0.0833199992775917;
		from: "%surface%.pads.2";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: -0.083320000191926956; output: true; color: backColor}
	  }
	  Wire {
	    enabled: keyAdjust.value != -0.16660000383853912;
		from: "%surface%.pads.3";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: -0.16660000383853912; output: true; color: backColor}
	  }
	  Wire {
	    enabled: keyAdjust.value != -0.25;
		from: "%surface%.pads.4";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: -0.25; output: true; color: backColor}
	  }
	  Wire {
	    enabled: keyAdjust.value != -0.33329999446868896;
		from: "%surface%.pads.5";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: -0.33329999446868896; output: true; color: backColor}
	  }
	  Wire {
	    enabled: keyAdjust.value != -0.41659998893737793;
		from: "%surface%.pads.6";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: -0.41659998893737793; output: true; color: backColor}
	  }
	  Wire {
	    enabled: keyAdjust.value != -0.5;
		from: "%surface%.pads.7";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: -0.5; output: true; color: backColor}
	  }
	  Wire {
	  	enabled: keyAdjust.value != -0.583299994468689;
		from: "%surface%.pads.8";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: -0.583299994468689; output: true; color: backColor}
	  }
	  
	  Wire {
	  	enabled: keyAdjust.value == -0.0833199992775917;
		from: "%surface%.pads.2";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: 0; output: false;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == -0.16660000383853912;
		from: "%surface%.pads.3";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: 0; output: false;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == -0.25;
		from: "%surface%.pads.4";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: 0; output: false;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == -0.33329999446868896;
		from: "%surface%.pads.5";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: 0; output: false;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == -0.41659998893737793;
		from: "%surface%.pads.6";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: 0; output: false;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == -0.5;
		from: "%surface%.pads.7";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: 0; output: false;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == -0.583299994468689;
		from: "%surface%.pads.8";
		to: SetPropertyAdapter { path:"app.traktor.decks." + deckIdx + ".track.key.adjust"; value: 0; output: false;}
	  }
	  
	  Wire {
	  	enabled: keyAdjust.value == -0.0833199992775917;
		from: "%surface%.pads.2";
		to: ButtonScriptAdapter { color: backColor; brightness: 1.0;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == -0.16660000383853912;
		from: "%surface%.pads.3";
		to: ButtonScriptAdapter { color: backColor; brightness: 1.0;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == -0.25;
		from: "%surface%.pads.4";
		to: ButtonScriptAdapter { color: backColor; brightness: 1.0;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == -0.33329999446868896;
		from: "%surface%.pads.5";
		to: ButtonScriptAdapter { color: backColor; brightness: 1.0;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == -0.41659998893737793;
		from: "%surface%.pads.6";
		to: ButtonScriptAdapter { color: backColor; brightness: 1.0;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == -0.5;
		from: "%surface%.pads.7";
		to: ButtonScriptAdapter { color: backColor; brightness: 1.0;}
	  }
	  Wire {
	  	enabled: keyAdjust.value == -0.583299994468689;
		from: "%surface%.pads.8";
		to: ButtonScriptAdapter { color: backColor; brightness: 1.0;}
	  }
    }
    
    
  }
}
