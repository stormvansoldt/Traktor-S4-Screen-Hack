import CSI 1.0
import "S4MK3Functions.js" as S4MK3Functions
import '../../Screens/Defines' as Defines

Module
{
  id: module
  property bool shift: false
  property int index: 1
  
  // helpers
  readonly property string surface_prefix: "s4mk3.mixer.channels." + module.index + "." 
  readonly property string app_prefix: "app.traktor.mixer.channels." + module.index + "."

  AppProperty { id: deckType; path: "app.traktor.decks." + module.index + ".type"; }

  AppProperty { id: playingProp; path: "app.traktor.decks." + module.index + ".play"; }
  property bool isPlaying: playingProp.value
  
  property bool faderStart: false

  AppProperty { id: volumeProp; path: "app.traktor.mixer.channels." + module.index + ".volume"; }
  property real volume: volumeProp.value
  onVolumeChanged: {
  	settings.faderStartEnable && faderStart && !isPlaying && (volume > 0) ? 
  		playingProp.value = true : faderStart = false
  		
  	faderStart && isPlaying ? faderStart = false : faderStart = false
  }
  
  MappingPropertyDescriptor 
  {
  	id: fader_start
  	path: "mapping.state.mixer." + index + ".fader_start";
  	value: module.faderStart;
  	type: MappingPropertyDescriptor.Boolean
  }
  
  
  // input select
  Wire 
  { 
    from: surface_prefix + "input";  
    to: ButtonScriptAdapter 
    { 
      onPress: 
      {
        if(!module.shift && !isPlaying)
        {
          deckType.value = (deckType.value == DeckType.Live) ? 
            DeckType.Track : (deckType.value == DeckType.Track) ? 
			DeckType.Remix : (deckType.value == DeckType.Remix) ? 
			DeckType.Stem : (deckType.value == DeckType.Stem) ? 
			DeckType.Live : S4MK3Functions.defaultTypeForDeck(module.index)
        }
		brightness: 1.0
      }
      brightness: (deckType.value == DeckType.Live) ? 1.0 : 0.0
    } 
  }

  LEDLevelMeter { name: "meter"; segments: 15 } 
  Wire { from: surface_prefix + "level_meter"; to: "meter" }
  Wire { from: "meter.level"; to: DirectPropertyAdapter { path: app_prefix + "level.prefader.linear.meter"; input: false } }
  
  AppProperty { id: fxMode; path: "app.traktor.fx.4fx_units" }
  
  // channel strip
  Wire { from: surface_prefix + "volume";               to: DirectPropertyAdapter { path: app_prefix + "volume"         } }
  Wire { from: surface_prefix + "gain";                 to: DirectPropertyAdapter { path: app_prefix + "gain"           } }
  Wire { from: surface_prefix + "eq.high";              to: DirectPropertyAdapter { path: app_prefix + "eq.high"        } }
  Wire { from: surface_prefix + "eq.mid";               to: DirectPropertyAdapter { path: app_prefix + "eq.mid"         } }
  Wire { from: surface_prefix + "eq.low";               to: DirectPropertyAdapter { path: app_prefix + "eq.low"         } }
  Wire { enabled: settings.faderStartEnable ? !shift : true; from: surface_prefix + "cue";                  to: TogglePropertyAdapter { path: app_prefix + "cue"            } }
  Wire { enabled: settings.faderStartEnable ? shift : false; from: surface_prefix + "cue";                  to: ButtonScriptAdapter { onPress: {!module.isPlaying && module.volume == 0 ? faderStart = !faderStart : faderStart = false} brightness: faderStart ? 1.0 : 0.0 } }
  Wire { enabled: (fxMode.value == FxMode.FourFxUnits) ? !shift : true; from: surface_prefix + "deck_fx_assign.1";     to: TogglePropertyAdapter { path: app_prefix + "fx.assign.1"    } }
  Wire { enabled: (fxMode.value == FxMode.FourFxUnits) ? !shift : true; from: surface_prefix + "deck_fx_assign.2";     to: TogglePropertyAdapter { path: app_prefix + "fx.assign.2"    } }
  Wire { enabled: (fxMode.value == FxMode.FourFxUnits) ? shift : false; from: surface_prefix + "deck_fx_assign.1";     to: TogglePropertyAdapter { path: app_prefix + "fx.assign.3"    } }
  Wire { enabled: (fxMode.value == FxMode.FourFxUnits) ? shift : false; from: surface_prefix + "deck_fx_assign.2";     to: TogglePropertyAdapter { path: app_prefix + "fx.assign.4"    } }
  
  Wire { 
  	enabled: settings.fxAssign1SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.1.type"; value: settings.fxAssign1Type; output: false} 
  }
  
  Wire { 
  	enabled: settings.fxAssign1SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.1.select.1"; value: settings.fxAssign1Effect1ID; output: false} 
  }
  
  Wire { 
  	enabled: (settings.fxAssign1Type == 0) && settings.fxAssign1SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.1.select.2"; value: settings.fxAssign1Effect2ID; output: false} 
  }
  
  Wire { 
  	enabled: (settings.fxAssign1Type == 0) && settings.fxAssign1SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.1.select.3"; value: settings.fxAssign1Effect3ID; output: false} 
  }
    
  Wire { 
  	enabled: (settings.fxAssign1Type == 0) && settings.fxAssign1SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.1.buttons.1"; value: settings.fxAssign1Enable1; output: false} 
  }
  
  Wire { 
  	enabled: (settings.fxAssign1Type == 0) && settings.fxAssign1SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.1.buttons.2"; value: settings.fxAssign1Enable2; output: false} 
  }
  
  Wire { 
  	enabled: (settings.fxAssign1Type == 0) && settings.fxAssign1SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.1.buttons.3"; value: settings.fxAssign1Enable3; output: false} 
  }
  
  Wire { 
  	enabled: settings.fxAssign1SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.1.dry_wet"; value: (settings.fxAssign1DryWet/100); output: false} 
  }
  
  Wire { 
  	enabled: settings.fxAssign1SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.1.knobs.1"; value: (settings.fxAssign1Parameter1/100); output: false} 
  }
  
  Wire { 
  	enabled: settings.fxAssign1SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.1.knobs.2"; value: (settings.fxAssign1Parameter2/100); output: false} 
  }
  
  Wire { 
  	enabled: settings.fxAssign1SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.1.knobs.3"; value: (settings.fxAssign1Parameter3/100); output: false} 
  }
  
  Wire { 
  	enabled: (settings.fxAssign1Type == 1) && settings.fxAssign1SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.1.enabled"; value: settings.fxAssign1Enable1; output: false} 
  }
  
  
  
  Wire { 
  	enabled: settings.fxAssign2SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.2.type"; value: settings.fxAssign2Type; output: false} 
  }
  
  Wire { 
  	enabled: settings.fxAssign2SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.2.select.1"; value: settings.fxAssign2Effect1ID; output: false} 
  }
  
  Wire { 
  	enabled: (settings.fxAssign2Type == 0) && settings.fxAssign2SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.2.select.2"; value: settings.fxAssign2Effect2ID; output: false} 
  }
  
  Wire { 
  	enabled: (settings.fxAssign2Type == 0) && settings.fxAssign2SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.2.select.3"; value: settings.fxAssign2Effect3ID; output: false} 
  }
    
  Wire { 
  	enabled: (settings.fxAssign2Type == 0) && settings.fxAssign2SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.2.buttons.1"; value: settings.fxAssign2Enable1; output: false} 
  }
  
  Wire { 
  	enabled: (settings.fxAssign2Type == 0) && settings.fxAssign2SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.2.buttons.2"; value: settings.fxAssign2Enable2; output: false} 
  }
  
  Wire { 
  	enabled: (settings.fxAssign2Type == 0) && settings.fxAssign2SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.2.buttons.3"; value: settings.fxAssign2Enable3; output: false} 
  }
  
  Wire { 
  	enabled: settings.fxAssign2SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.2.dry_wet"; value: (settings.fxAssign2DryWet/100); output: false} 
  }
  
  Wire { 
  	enabled: settings.fxAssign2SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.2.knobs.1"; value: (settings.fxAssign2Parameter1/100); output: false} 
  }
  
  Wire { 
  	enabled: settings.fxAssign2SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.2.knobs.2"; value: (settings.fxAssign2Parameter2/100); output: false} 
  }
  
  Wire { 
  	enabled: (settings.fxAssign2Type == 0) && settings.fxAssign2SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.2.knobs.3"; value: (settings.fxAssign2Parameter3/100); output: false} 
  }
  
  Wire { 
  	enabled: (settings.fxAssign2Type == 1) && settings.fxAssign2SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? !shift : true); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.2.enabled"; value: settings.fxAssign2Enable1; output: false} 
  }
  
  
  
  Wire { 
  	enabled: settings.fxAssign3SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.3.type"; value: settings.fxAssign3Type; output: false} 
  }
  
  Wire { 
  	enabled: settings.fxAssign3SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.3.select.1"; value: settings.fxAssign3Effect1ID; output: false} 
  }
  
  Wire { 
  	enabled: (settings.fxAssign3Type == 0) && settings.fxAssign3SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.3.select.2"; value: settings.fxAssign3Effect2ID; output: false} 
  }
  
  Wire { 
  	enabled: (settings.fxAssign3Type == 0) && settings.fxAssign3SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.3.select.3"; value: settings.fxAssign3Effect3ID; output: false} 
  }
    
  Wire { 
  	enabled: (settings.fxAssign3Type == 0) && settings.fxAssign3SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.3.buttons.1"; value: settings.fxAssign3Enable1; output: false} 
  }
  
  Wire { 
  	enabled: (settings.fxAssign3Type == 0) && settings.fxAssign3SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.3.buttons.2"; value: settings.fxAssign3Enable2; output: false} 
  }
  
  Wire { 
  	enabled: (settings.fxAssign3Type == 0) && settings.fxAssign3SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.3.buttons.3"; value: settings.fxAssign3Enable3; output: false} 
  }
  
  Wire { 
  	enabled: settings.fxAssign3SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.3.dry_wet"; value: (settings.fxAssign3DryWet/100); output: false} 
  }
  
  Wire { 
  	enabled: settings.fxAssign3SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.3.knobs.1"; value: (settings.fxAssign3Parameter1/100); output: false} 
  }
  
  Wire { 
  	enabled: settings.fxAssign3SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.3.knobs.2"; value: (settings.fxAssign3Parameter2/100); output: false} 
  }
  
  Wire { 
  	enabled: settings.fxAssign3SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.3.knobs.3"; value: (settings.fxAssign3Parameter3/100); output: false} 
  }
  
  Wire { 
  	enabled: (settings.fxAssign3Type == 1) && settings.fxAssign3SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.1"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.3.enabled"; value: settings.fxAssign3Enable1; output: false} 
  }
  
  
  Wire { 
  	enabled: settings.fxAssign4SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.4.type"; value: settings.fxAssign4Type; output: false} 
  }
  
  Wire { 
  	enabled: settings.fxAssign4SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.4.select.1"; value: settings.fxAssign4Effect1ID; output: false} 
  }
  
  Wire { 
  	enabled: (settings.fxAssign4Type == 0) && settings.fxAssign4SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.4.select.2"; value: settings.fxAssign4Effect2ID; output: false} 
  }
  
  Wire { 
  	enabled: (settings.fxAssign4Type == 0) && settings.fxAssign4SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.4.select.3"; value: settings.fxAssign4Effect3ID; output: false} 
  }
    
  Wire { 
  	enabled: (settings.fxAssign4Type == 0) && settings.fxAssign4SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.4.buttons.1"; value: settings.fxAssign4Enable1; output: false} 
  }
  
  Wire { 
  	enabled: (settings.fxAssign4Type == 0) && settings.fxAssign4SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.4.buttons.2"; value: settings.fxAssign4Enable2; output: false} 
  }
  
  Wire { 
  	enabled: (settings.fxAssign4Type == 0) && settings.fxAssign4SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.4.buttons.3"; value: settings.fxAssign4Enable3; output: false} 
  }
  
  Wire { 
  	enabled: settings.fxAssign4SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.4.dry_wet"; value: (settings.fxAssign4DryWet/100); output: false} 
  }
  
  Wire { 
  	enabled: settings.fxAssign4SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.4.knobs.1"; value: (settings.fxAssign4Parameter1/100); output: false} 
  }
  
  Wire { 
  	enabled: settings.fxAssign4SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.4.knobs.2"; value: (settings.fxAssign4Parameter2/100); output: false} 
  }
  
  Wire { 
  	enabled: settings.fxAssign4SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.4.knobs.3"; value: (settings.fxAssign4Parameter3/100); output: false} 
  }
  
  Wire { 
  	enabled: (settings.fxAssign4Type == 1) && settings.fxAssign4SetEffect && ((fxMode.value == FxMode.FourFxUnits) ? shift : false); 
  	from: surface_prefix + "deck_fx_assign.2"; 
  	to: SetPropertyAdapter { path: "app.traktor.fx.4.enabled"; value: settings.fxAssign4Enable1; output: false} 
  }
  
  
  
  // xfader assign
  Wire { from: surface_prefix + "xfader_assign.left";  to: DirectPropertyAdapter { path: app_prefix + "xfader_assign.left"   } }
  Wire { from: surface_prefix + "xfader_assign.right"; to: DirectPropertyAdapter { path: app_prefix + "xfader_assign.right"  } }
}
