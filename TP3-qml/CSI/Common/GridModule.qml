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
  property int zoom: 0
  
  Defines.Settings  {id: settings}
  
  property string propertiesPath: ""

  property real tempoChange: (settings.tempoRangeChangeAmount / 100)
  
  AppProperty { id: isPlayingProp; path: "app.traktor.decks." + deckIdx + ".play"}
  AppProperty { id: isLoadedProp; path: "app.traktor.decks." + deckIdx + ".is_loaded"}
  property bool isPlaying: isPlayingProp.value
  property bool isLoaded: isLoadedProp.value


  WiresGroup
  {
    enabled: active 

      Wire { enabled: !module.shift; from: "%surface%.pads.1"; to: RelativePropertyAdapter { path: "app.traktor.decks." + deckIdx + ".track.waveform_zoom"; step: 0.25; mode: RelativeMode.Increment; output: false } }
      Wire { enabled: !module.shift; from: "%surface%.pads.5"; to: RelativePropertyAdapter { path: "app.traktor.decks." + deckIdx + ".track.waveform_zoom"; step: 0.25; mode: RelativeMode.Decrement; output: false } }

	  Wire { enabled: module.shift; from: "%surface%.pads.1"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".track.waveform_zoom"; value: (settings.shiftZoom1/50)-1; output: false } }
	  Wire { enabled: module.shift; from: "%surface%.pads.5"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".track.waveform_zoom"; value: (settings.shiftZoom2/50)-1; output: false } }
	        
      Wire { enabled: !module.shift; from: "%surface%.pads.4"; to: RelativePropertyAdapter { path: "app.traktor.decks." + deckIdx + ".tempo.range_value"; step: module.tempoChange; mode: RelativeMode.Increment; output: false } }
      Wire { enabled: !module.shift; from: "%surface%.pads.8"; to: RelativePropertyAdapter { path: "app.traktor.decks." + deckIdx + ".tempo.range_value"; step: module.tempoChange; mode: RelativeMode.Decrement; output: false } }
	  
	  Wire { enabled: module.shift; from: "%surface%.pads.4"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".tempo.range_value"; value: settings.shiftRange1/100; output: false } }
	  Wire { enabled: module.shift; from: "%surface%.pads.8"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".tempo.range_value"; value: settings.shiftRange2/100; output: false } }
	  
	  Wire { from: "%surface%.pads.2"; to: TogglePropertyAdapter { path: "app.traktor.decks." + deckIdx + ".track.grid.enable_tick"; output: true; color: S4MK3Functions.colorForDeckSingle(settings.tickColour)} }
	  Wire { enabled: isLoaded && !isPlaying; from: "%surface%.pads.3"; to: TriggerPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".unload"; output: false } }

      Wire { enabled: isLoaded; from: "%surface%.pads.7"; to: TriggerPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".analyze"; output: false } }
      Wire { from: "%surface%.pads.6"; to: TriggerPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".track.grid.tap"; output: false} }
      
      Wire { 
      	from: "%surface%.pads.1"; 
      	to: ButtonScriptAdapter 
      	{ 
      		onPress: {brightness = 1.0} onRelease: {brightness = 0.0}
      		brightness: 0.0;
      		color: S4MK3Functions.colorForDeckSingle(settings.waveformZoomInColour); 
      	}
	  }
	  Wire { 
      	from: "%surface%.pads.3"; 
      	to: ButtonScriptAdapter 
      	{ 
      		onPress: {brightness = 1.0} onRelease: {brightness = 0.0}
      		brightness: 0.0;
      		color: isLoaded && !isPlaying ? S4MK3Functions.colorForDeckSingle(settings.unloadAvailableColour) : S4MK3Functions.colorForDeckSingle(settings.unloadUnavailableColour); 
      	}
	  }
	  Wire { 
      	from: "%surface%.pads.5"; 
      	to: ButtonScriptAdapter 
      	{ 
      		onPress: {brightness = 1.0} onRelease: {brightness = 0.0}
      		brightness: 0.0;
      		color: S4MK3Functions.colorForDeckSingle(settings.waveformZoomOutColour); 
      	}
	  }
	  Wire { 
      	from: "%surface%.pads.6"; 
      	to: ButtonScriptAdapter 
      	{ 
      		onPress: {brightness = 1.0} onRelease: {brightness = 0.0}
      		brightness: 0.0;
      		color: S4MK3Functions.colorForDeckSingle(settings.tapColour); 
      	}
	  }
	  Wire { 
      	from: "%surface%.pads.7"; 
      	to: ButtonScriptAdapter 
      	{ 
      		onPress: {brightness = 1.0} onRelease: {brightness = 0.0}
      		brightness: 0.0;
      		color: isLoaded ? S4MK3Functions.colorForDeckSingle(settings.analyseAvailableColour) : S4MK3Functions.colorForDeckSingle(settings.analyseUnavailableColour); 
      	}
	  }
	  
	  Wire { 
      	from: "%surface%.pads.4"; 
      	to: ButtonScriptAdapter 
      	{ 
      		onPress: {brightness = 1.0} onRelease: {brightness = 0.0}
      		brightness: 0.0;
      		color: S4MK3Functions.colorForDeckSingle(settings.tempoRangeUpColour); 
      	}
	  }
	  Wire { 
      	from: "%surface%.pads.8"; 
      	to: ButtonScriptAdapter 
      	{ 
      		onPress: {brightness = 1.0} onRelease: {brightness = 0.0}
      		brightness: 0.0;
      		color: S4MK3Functions.colorForDeckSingle(settings.tempoRangeDownColour); 
      	}
	  }
  }
}
