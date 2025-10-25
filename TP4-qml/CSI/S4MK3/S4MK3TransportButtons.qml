import CSI 1.0
import QtQuick 2.5

import "S4MK3Functions.js" as S4MK3Functions
import '../../Screens/Defines' as Defines

Module
{
  id: module
  property string surface: "" // e.g. "s4mk3.left"
  property int deckIdx: 0 // Traktor deck 1..4
  property bool active: false
  property int deckA: settings.deckAColour
  property int deckB: settings.deckBColour
  property int deckC: settings.deckCColour
  property int deckD: settings.deckDColour
  property var deckColor: S4MK3Functions.colorForDeck(deckIdx,deckA,deckB,deckC,deckD)
  property bool shift: false
  property bool tonePads: true
  property bool isSupported: false
  property bool isEnabled: false
  property bool breakEnabled: false
  property string propertiesPath: ""
  
  AppProperty { id: propTrackLength; path: "app.traktor.decks." + deckIdx + ".track.content.track_length"; }
  AppProperty { id: propFx4; path: "app.traktor.mixer.channels." + deckIdx + ".fx.assign.4"; }
  property int trackLength: propTrackLength.value
    
  onTrackLengthChanged: 
  {
  	settings.resetOnDeckLoad ? module.breakEnabled = false : breakEnabled = breakEnabled;
  	settings.resetOnDeckLoad ? propFx4.value = false : propFx4.value = propFx4.value;
  }

  
  MappingPropertyDescriptor 
  {
  	id: break_enabled
  	path: propertiesPath + ".break_enabled";
  	value: module.breakEnabled;
  	type: MappingPropertyDescriptor.Boolean
  }
  
  AppProperty { id: isPlayingProp; path: "app.traktor.decks." + deckIdx + ".play" }
  readonly property bool isPlaying: isPlayingProp.value
  
  AppProperty { id: fxEnabled; path: "app.traktor.fx.4.enabled" }

  AppProperty { id: fxValueProp; path: "app.traktor.fx.4.select.1" }
  readonly property int fxValue: fxValueProp.value
  
  AppProperty { id: typeProp; path: "app.traktor.fx.4.type"; }
  readonly property int type: typeProp.value
  
  Timer {
          id: breakEnabledTimer
          property bool  blink: false

          interval: fxEnabled.value ? 125 : 250
          repeat:   true
          running:  breakEnabled && isPlaying

          onTriggered: {
            blink = !blink;
          }

          onRunningChanged: {
            blink = running;
          }
  }
  
  
  // LED Brightness ----------------------
  readonly property real onBrightness:     1.0
  readonly property real dimmedBrightness: 0
  

  TransportSection
  {
    name: "transport"
    channel: module.deckIdx
    masterColor: module.deckColor
    syncColor: module.deckColor
    cueColor: module.deckColor
  }
  
  WiresGroup
  { 
    enabled: module.active && !settings.enableVinylBreakMode
        
    Wire { from: "%surface%.reverse";   to: "transport.flux_reverse"    }
    Wire { from: "%surface%.flux";      to: "transport.flux"            }
    Wire { from: "%surface%.play";      to: "transport.play"            }
    
    Wire { from: "%surface%.sync";      to: "transport.sync"              ; enabled: !module.shift  }
    Wire { from: "%surface%.master";    to: "transport.master"            ; enabled: !module.shift }
    Wire { from: "%surface%.cue";       to: "transport.cue"               ; enabled: !module.shift }
    Wire { from: "%surface%.cue";       to: "transport.return_to_zero"    ; enabled:  module.shift && !tonePads }
    

  }   
  
  WiresGroup
  { 
    enabled: module.active && settings.enableVinylBreakMode
        
    Wire { enabled: settings.shiftFluxReverseSetsMarkers ? !module.shift : true; from: "%surface%.reverse";   to: "transport.flux_reverse"    }
    Wire { enabled: settings.shiftFluxReverseSetsMarkers ? !module.shift : true; from: "%surface%.flux";      to: "transport.flux"            }
    Wire { from: "%surface%.play";      to: "transport.play"              ; enabled: !module.shift && !breakEnabled }
    Wire 
    { 
    	enabled: module.shift
    	from: "%surface%.play";      
    	to: ButtonScriptAdapter 
    	{ 
    		onPress: 
    		{ 
    			breakEnabled = !breakEnabled;
    		} 
    		brightness: breakEnabled ? 1.0 : 0.0;
    	}
    }
    
    Wire { enabled: !breakEnabled && module.shift; from: "%surface%.play"; to: SetPropertyAdapter { path: "app.traktor.mixer.channels." + deckIdx + ".fx.assign.4"; value: true; output: false}}
    Wire { enabled: breakEnabled && module.shift; from: "%surface%.play"; to: SetPropertyAdapter { path: "app.traktor.mixer.channels." + deckIdx + ".fx.assign.4"; value: false; output: false}}

    Wire { enabled: (type != 1) && !breakEnabled && module.shift; from: "%surface%.play"; to: SetPropertyAdapter { path: "app.traktor.fx.4.type"; value: "1"; output: false}}
    Wire { enabled: (fxValue != settings.turntableFxNumber) && !breakEnabled && module.shift; from: "%surface%.play"; to: SetPropertyAdapter { path: "app.traktor.fx.4.select.1"; value: settings.turntableFxNumber; output: false}}
    Wire { enabled: (fxValue != settings.turntableFxNumber) && !breakEnabled && module.shift; from: "%surface%.play"; to: TriggerPropertyAdapter { path: "app.traktor.fx.4.buttons.1"; output: false }}
    
    Wire { enabled: isPlaying && !fxEnabled.value && breakEnabled && !module.shift; from: "%surface%.play"; to: SetPropertyAdapter { path: "app.traktor.fx.4.dry_wet"; value: 1.0; output: false}}
    Wire { enabled: isPlaying && !fxEnabled.value && breakEnabled && !module.shift; from: "%surface%.play"; to: SetPropertyAdapter { path: "app.traktor.fx.4.enabled"; value: true; output: false}}
	Wire { enabled: isPlaying && fxEnabled.value && breakEnabled && !module.shift; from: "%surface%.play"; to: SetPropertyAdapter { path: "app.traktor.fx.4.enabled"; value: false; output: false}}

    Wire { enabled: !isPlaying && breakEnabled && !module.shift; from: "%surface%.play"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".play"; value: true; output: false}}

    Wire 
    { 
    	enabled: breakEnabled && !module.shift
    	from: "%surface%.play";      
    	to: ButtonScriptAdapter 
    	{ 
    		brightness: breakEnabledTimer.blink ? 1.0 : 0.0;
    	}
    }
    
    Wire { from: "%surface%.sync";      to: "transport.sync"              ; enabled: !module.shift }
    Wire { from: "%surface%.master";    to: "transport.master"            ; enabled: !module.shift }
    Wire { from: "%surface%.cue";       to: "transport.cue"               ; enabled: !module.shift }
    Wire { from: "%surface%.cue";       to: "transport.return_to_zero"    ; enabled:  module.shift && !tonePads }
    

  }   
}
