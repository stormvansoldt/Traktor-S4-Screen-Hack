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
  onActiveChanged: ((active == true) && (settings.autoEnableFlux == true) ? fluxProp.value = true : fluxProp.value = false)
  property string deckPropertiesPath: ""
  
  AppProperty { id: fluxProp; path: "app.traktor.decks." + deckIdx + ".flux.enabled" }
  
  property var rollColor: S4MK3Functions.colorForDeckSingle(settings.rollPadColour)
  
  AppProperty { id: loopSizePos; path: "app.traktor.decks." + deckIdx + ".loop.size"} 
  property int loopSize: loopSizePos.value

  AppProperty { id: loopEnabled; path: "app.traktor.decks." + deckIdx + ".loop.active" }
  property bool loopActive: loopEnabled.value
  
  AppProperty { id: fluxEnabled; path: "app.traktor.decks." + deckIdx + ".flux.state" }
  property int fluxActive: fluxEnabled.value

  AppProperty { id: propIsPlaying;               path: "app.traktor.decks." + deckIdx + ".play" }
  readonly property bool isPlaying: propIsPlaying.value

  
  
  // LED Brightness ----------------------
  readonly property real onBrightness:     1.0
  readonly property real dimmedBrightness: 0

    WiresGroup
    {
      enabled:  active
	  
	  WiresGroup
	  {
		  enabled:  (fluxActive != 0)
		  
		  Wire {
			from: "%surface%.pads.1";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: 10; output: false}
		  }
		  Wire {
			from: "%surface%.pads.1";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: settings.rollSizePad1; output: false}
		  }
		  Wire {
			from: "%surface%.pads.1";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto"; output: false}
		  }
		  Wire {
			from: "%surface%.pads.1";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.active"; output: false}
		  }
		  Wire {
			from: "%surface%.pads.1";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".flux.active"; value: true; output: false}
		  }
		  
		  Wire {
			from: "%surface%.pads.2";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: 10; output: false}
		  }
		  Wire {
			from: "%surface%.pads.2";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: settings.rollSizePad2; output: false}
		  }
		  Wire {
			from: "%surface%.pads.2";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto"; output: false}
		  }
		  Wire {
			from: "%surface%.pads.2";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.active"; output: false}
		  }
		  Wire {
			from: "%surface%.pads.2";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".flux.active"; value: true; output: false}
		  }
		  
		  Wire {
			from: "%surface%.pads.3";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: 10; output: false}
		  }
		  Wire {
			from: "%surface%.pads.3";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: settings.rollSizePad3; output: false}
		  }
		  Wire {
			from: "%surface%.pads.3";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto"; output: false}
		  }
		  Wire {
			from: "%surface%.pads.3";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.active"; output: false}
		  }
		  Wire {
			from: "%surface%.pads.3";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".flux.active"; value: true; output: false}
		  }
		  
		  Wire {
			from: "%surface%.pads.4";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: 10; output: false}
		  }
		  Wire {
			from: "%surface%.pads.4";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: settings.rollSizePad4; output: false}
		  }
		  Wire {
			from: "%surface%.pads.4";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto"; output: false}
		  }
		  Wire {
			from: "%surface%.pads.4";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.active"; output: false}
		  }
		  Wire {
			from: "%surface%.pads.4";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".flux.active"; value: true; output: false}
		  }
		  
		  Wire {
			from: "%surface%.pads.5";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: 10; output: false}
		  }
		  Wire {
			from: "%surface%.pads.5";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: settings.rollSizePad5; output: false}
		  }
		  Wire {
			from: "%surface%.pads.5";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto"; output: false}
		  }
		  Wire {
			from: "%surface%.pads.5";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.active"; output: false}
		  }
		  Wire {
			from: "%surface%.pads.5";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".flux.active"; value: true; output: false}
		  }
		  
		  Wire {
			from: "%surface%.pads.6";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: 10; output: false}
		  }
		  Wire {
			from: "%surface%.pads.6";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: settings.rollSizePad6; output: false}
		  }
		  Wire {
			from: "%surface%.pads.6";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto"; output: false}
		  }
		  Wire {
			from: "%surface%.pads.6";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.active"; output: false}
		  }
		  Wire {
			from: "%surface%.pads.6";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".flux.active"; value: true; output: false}
		  }
		  
		  Wire {
			from: "%surface%.pads.7";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: 10; output: false}
		  }
		  Wire {
			from: "%surface%.pads.7";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: settings.rollSizePad7; output: false}
		  }
		  Wire {
			from: "%surface%.pads.7";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto"; output: false}
		  }
		  Wire {
			from: "%surface%.pads.7";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.active"; output: false}
		  }
		  Wire {
			from: "%surface%.pads.7";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".flux.active"; value: true; output: false}
		  }
		  
		  Wire {
			from: "%surface%.pads.8";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: 10; output: false}
		  }
		  Wire {
			from: "%surface%.pads.8";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: settings.rollSizePad8; output: false}
		  }
		  Wire {
			from: "%surface%.pads.8";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto"; output: false}
		  }
		  Wire {
			from: "%surface%.pads.8";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.active"; output: false}
		  }
		  Wire {
			from: "%surface%.pads.8";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".flux.active"; value: true; output: false}
		  }
	  }
	  
	  WiresGroup
	  {
	      enabled: (fluxActive == 0)
		  
		  Wire {
			from: "%surface%.pads.1";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: 10; output: false}
		  }
		  Wire {
			from: "%surface%.pads.1";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size"; value: settings.rollSizePad1; output: false}
		  }
		  Wire {
			from: "%surface%.pads.1";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.active"; output: false}
		  }
		  Wire {
			from: "%surface%.pads.2";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: 10; output: false}
		  }
		  Wire {
			from: "%surface%.pads.2";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size"; value: settings.rollSizePad2; output: false}
		  }
		  Wire {
			from: "%surface%.pads.2";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.active"; output: false}
		  }
		  Wire {
			from: "%surface%.pads.3";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: 10; output: false}
		  }
		  Wire {
			from: "%surface%.pads.3";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size"; value: settings.rollSizePad3; output: false}
		  }
		  Wire {
			from: "%surface%.pads.3";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.active"; output: false}
		  }
		  Wire {
			from: "%surface%.pads.4";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: 10; output: false}
		  }
		  Wire {
			from: "%surface%.pads.4";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size"; value: settings.rollSizePad4; output: false}
		  }
		  Wire {
			from: "%surface%.pads.4";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.active"; output: false}
		  }
		  Wire {
			from: "%surface%.pads.5";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: 10; output: false}
		  }
		  Wire {
			from: "%surface%.pads.5";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size"; value: settings.rollSizePad5; output: false}
		  }
		  Wire {
			from: "%surface%.pads.5";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.active"; output: false}
		  }
		  Wire {
			from: "%surface%.pads.6";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: 10; output: false}
		  }
		  Wire {
			from: "%surface%.pads.6";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size"; value: settings.rollSizePad6; output: false}
		  }
		  Wire {
			from: "%surface%.pads.6";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.active"; output: false}
		  }
		  Wire {
			from: "%surface%.pads.7";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: 10; output: false}
		  }
		  Wire {
			from: "%surface%.pads.7";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size"; value: settings.rollSizePad7; output: false}
		  }
		  Wire {
			from: "%surface%.pads.7";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.active"; output: false}
		  }
		  Wire {
			from: "%surface%.pads.8";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.size"; value: 10; output: false}
		  }
		  Wire {
			from: "%surface%.pads.8";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.set.auto_with_size"; value: settings.rollSizePad8; output: false}
		  }
		  Wire {
			from: "%surface%.pads.8";
			to: HoldPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".loop.active"; output: false}
		  }
	  }
	  
	  
	  
	  Wire {
		from: "%surface%.pads.1";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.rollSizePad1) && loopActive ? onBrightness : dimmedBrightness; color: rollColor }
	  }
	  Wire {
		from: "%surface%.pads.2";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.rollSizePad2) && loopActive ? onBrightness : dimmedBrightness; color: rollColor }
	  }
	  Wire {
		from: "%surface%.pads.3";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.rollSizePad3) && loopActive ? onBrightness : dimmedBrightness; color: rollColor }
	  }
	  Wire {
		from: "%surface%.pads.4";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.rollSizePad4) && loopActive ? onBrightness : dimmedBrightness; color: rollColor }
	  }
	  Wire {
		from: "%surface%.pads.5";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.rollSizePad5) && loopActive ? onBrightness : dimmedBrightness; color: rollColor }
	  }
	  Wire {
		from: "%surface%.pads.6";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.rollSizePad6) && loopActive ? onBrightness : dimmedBrightness; color: rollColor }
	  }
	  Wire {
		from: "%surface%.pads.7";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.rollSizePad7) && loopActive ? onBrightness : dimmedBrightness; color: rollColor }
	  }
	  Wire {
		from: "%surface%.pads.8";
		to: ButtonScriptAdapter { brightness: (loopSize == settings.rollSizePad8) && loopActive ? onBrightness : dimmedBrightness; color: rollColor }
	  }
	  
	  WiresGroup {
		
		  enabled: settings.rollPadPlay
		  
		  Wire {
			enabled: !isPlaying
			from: "%surface%.pads.1";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".play"; value: true; output: false }
		  }
		  Wire {
			enabled: !isPlaying
			from: "%surface%.pads.2";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".play"; value: true; output: false }
		  }
		  Wire {
			enabled: !isPlaying
			from: "%surface%.pads.3";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".play"; value: true; output: false }
		  }
		  Wire {
			enabled: !isPlaying
			from: "%surface%.pads.4";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".play"; value: true; output: false }
		  }
		  Wire {
			enabled: !isPlaying
			from: "%surface%.pads.5";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".play"; value: true; output: false }
		  }
		  Wire {
			enabled: !isPlaying
			from: "%surface%.pads.6";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".play"; value: true; output: false }
		  }
		  Wire {
			enabled: !isPlaying
			from: "%surface%.pads.7";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".play"; value: true; output: false }
		  }
		  Wire {
			enabled: !isPlaying
			from: "%surface%.pads.8";
			to: SetPropertyAdapter { path:"app.traktor.decks."+ deckIdx + ".play"; value: true; output: false }
		  }
		}
    }
}
