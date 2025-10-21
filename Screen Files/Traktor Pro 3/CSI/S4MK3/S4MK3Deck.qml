import CSI 1.0
import QtQuick 2.5
import "../../Defines"
import '../../Screens/Defines' as Defines2
import "../Common"
import "S4MK3Functions.js" as S4MK3Functions


Module
{
  id: module
  
  property int deckA: settings.deckAColour
  property int deckB: settings.deckBColour
  property int deckC: settings.deckCColour
  property int deckD: settings.deckDColour
  property int jogA: settings.jogAColour
  property int jogB: settings.jogBColour
  property int jogC: settings.jogCColour
  property int jogD: settings.jogDColour
  property bool jogFlash: settings.jogwheelEndFlashing
  
  property bool fx1Active: false
  property bool fx2Active: false
    
  // LED Brightness ----------------------
  readonly property real onBrightness:     1.0
  readonly property real dimmedBrightness: 0
  
  property bool active: false

  AppProperty { id: fxMode; path: "app.traktor.fx.4fx_units" }
  
  property bool enablePads: false
  property bool shift: false
  property bool view: browse.browseLED
  
  property bool bottomRemix: false
  
  property string surface: ""
  property string deckPropertiesPath: ""
  property int padsMode: 0
  property int deckIdx: 0
  property int prevPadsMode: 0
  
  property bool buttonPressed: false

  property int deckType: deckTypeProp.value

  property bool deckPlaying: deckPlayingProp.value
  property bool deckCueing: deckCueingProp.value

  property bool isEncoderInUse: samples.isSlotSelected || stems.isStemSelected
  property bool isLinkedDeckEncoderInUse: false
  property var deckColor: S4MK3Functions.colorForDeck(deckIdx,deckA,deckB,deckC,deckD)
  property var jogColor: S4MK3Functions.colorForDeck(deckIdx,jogA,jogB,jogC,jogD)
  property var blackColor: S4MK3Functions.colorForDeckSingle(16)
  property bool hapticHotcuesEnabled: true
  
  AppProperty { id: propTrackEndWarning; path: "app.traktor.decks." + deckIdx + ".track.track_end_warning" }
  AppProperty { id: propLoaded; 	  			path: "app.traktor.decks." + focusedDeckIdx + ".content.entry_key" }
  property int isLoaded: propLoaded.value
  
  AppProperty { id: loopEnabled; path: "app.traktor.decks." + deckIdx + ".loop.active" }
  property bool loopActive: loopEnabled.value

  readonly property bool showBrowser: browse.viewVal
  
  readonly property bool hotcuesEnabled: hotcues.enabled;
  
  property int activeSlot: samples.activeSlot
  property bool activeStem: stems.isStemSelected
  
  
  AppProperty { id: loopSize; path: "app.traktor.decks." + deckIdx + ".loop.size" }
  
  AppProperty { id: propEnabled; 	  			path: "app.traktor.decks." + focusedDeckIdx + ".freeze.enabled" }
  readonly property bool 	slicerEnabled: 	      propEnabled.value
  
  Timer {
          id: trackEndBlinkTimer
          property bool  blink: false

          interval: 250
          repeat:   true
          running:  jogFlash? propTrackEndWarning.value : false

          onTriggered: {
            blink = !blink;
          }

          onRunningChanged: {
            blink = running;
          }
  }

  MappingPropertyDescriptor {
    id: deckColorProp
    path: deckPropertiesPath + ".deck_color"
    type: MappingPropertyDescriptor.Integer
    value: module.deckColor
  }

  MappingPropertyDescriptor {
    id: jogColorProp
    path: deckPropertiesPath + ".jog_color"
    type: MappingPropertyDescriptor.Integer
    value: trackEndBlinkTimer.blink ? Color.Black : module.jogColor
  }
  
  AppProperty
  {
    id: deckTypeProp;
    path: "app.traktor.decks." + deckIdx + ".type";
  }

  AppProperty
  {
    id: deckPlayingProp;
    path: "app.traktor.decks." + deckIdx + ".play";
  }
  
  AppProperty
  {
    id: deckCueingProp;
    path: "app.traktor.decks." + deckIdx + ".cue";
  }

  AppProperty { id: gridAdjust; path: "app.traktor.decks." + module.deckIdx + ".track.gridmarker.move" ; }
  AppProperty { id: enableTick; path: "app.traktor.decks." + module.deckIdx + ".track.grid.enable_tick"; }
  AppProperty { id: gridLockedProp; path: "app.traktor.decks." + module.deckIdx + ".track.grid.lock_bpm" }

  MappingPropertyDescriptor 
  { 
    id: gridAdjustEnableProp; 
    path: deckPropertiesPath + ".grid_adjust"; 
    type: MappingPropertyDescriptor.Boolean; 
    value: false;
    onValueChanged: { enableTick.value = gridAdjustEnableProp.value; } 
  }
  
  property bool gridAdjustEnabled: module.active && gridAdjustEnableProp.value

  //----------------------------------- Grid Adjust------------------------------------//

  readonly property bool gridAdjustAvailable: jogMode.value === JogwheelMode.Jogwheel
                                              && S4MK3Functions.deckTypeSupportsGridAdjust(deckType)
                                              && !gridLockedProp.value;
  
  Timer {
          id: gridEnabledTimer
          property bool  blink: false

          interval: 250
          repeat:   true
          running:  gridAdjustEnabled

          onTriggered: {
            blink = !blink;
          }

          onRunningChanged: {
            blink = running;
          }
  }
  
  AppProperty { id: gridDelete; path: "app.traktor.decks." + module.deckIdx + ".track.gridmarker.delete"; }
  AppProperty { id: gridSet; path: "app.traktor.decks." + module.deckIdx + ".track.gridmarker.set"; }
  
  Timer {
          id: shiftEnabledTimer
          property bool  blink: false

          interval: 250
          repeat:   true
          running:  module.active && ((module.shift && settings.shiftFluxReverseSetsMarkers) || gridAdjustEnabled)

          onTriggered: {
            blink = !blink;
          }

          onRunningChanged: {
            blink = running;
          }
  }

  Wire { enabled: module.active && ((module.shift && settings.shiftFluxReverseSetsMarkers) || gridAdjustEnabled); from: "%surface%.flux";      to: DirectPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.gridmarker.set"; output:false} }
  Wire { enabled: module.active && ((module.shift && settings.shiftFluxReverseSetsMarkers) || gridAdjustEnabled); from: "%surface%.reverse";      to: DirectPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.gridmarker.delete"; output:false} }
  Wire
  { 
    enabled: module.active && ((module.shift && settings.shiftFluxReverseSetsMarkers) || gridAdjustEnabled)
    from: "%surface%.reverse"; 
    to: ButtonScriptAdapter 
    { 
    	brightness: shiftEnabledTimer.blink ? 1.0 : 0.0
    }
  }
  Wire
  { 
    enabled: module.active && ((module.shift && settings.shiftFluxReverseSetsMarkers) || gridAdjustEnabled)
    from: "%surface%.flux"; 
    to: ButtonScriptAdapter 
    { 
    	brightness: shiftEnabledTimer.blink ? 1.0 : 0.0
    }
  }
  
  Wire
  { 
    enabled: module.active && settings.disableGridEditToggle && (settings.shiftGridSetsMarker ? !shift : true)
    from: "%surface%.grid_adjust"; 
    to: HoldPropertyAdapter { path: deckPropertiesPath + ".grid_adjust"; value: true; output: false; }
  }  

  
  Wire
  { 
    enabled: module.active && ((deckType == 0) || (deckType == 2)) && settings.shiftGridSetsMarker ? shift : false
    from: "%surface%.grid_adjust"; 
    to: ButtonScriptAdapter 
    { 
    	onPress: 
    	{ 
    		brightness = 1.0
    		gridDelete.value = 1; 
    	}
    	onRelease:
    	{
    		brightness = 0.0
    		gridSet.value = 1;
    	}
    	brightness: 0.0
    }
  }
  
  Wire
  { 
  	enabled: module.active && settings.shiftGridSetsMarker ? !shift : true
    from: "%surface%.grid_adjust"; 
    to: ButtonScriptAdapter { 
    	brightness: gridEnabledTimer.blink ? onBrightness : dimmedBrightness;
    	color: !gridAdjustAvailable ? S4MK3Functions.colorForDeckSingle(0) : S4MK3Functions.colorForDeck(deckIdx,jogA,jogB,jogC,jogD);
    }
  }
  
  Wire
  { 
    enabled: module.active && !settings.disableGridEditToggle && (settings.shiftGridSetsMarker ? !shift : true);
    from: "%surface%.grid_adjust"; 
    to: TogglePropertyAdapter { path: deckPropertiesPath + ".grid_adjust"; output: false}
  }
  

  
  
  WiresGroup {
  enabled: !module.isEncoderInUse && !module.isLinkedDeckEncoderInUse
  Wire { enabled: gridAdjustEnabled && !gridLockedProp.value && !shift; from: "%surface%.loop_size.turn"; to: RelativePropertyAdapter { path: "app.traktor.decks." + deckIdx + ".track.grid.adjust_bpm"; step: 0.1; mode: RelativeMode.Stepped } }
  Wire { enabled: gridAdjustEnabled && !gridLockedProp.value && shift; from: "%surface%.loop_size.turn"; to: RelativePropertyAdapter { path: "app.traktor.decks." + deckIdx + ".track.grid.adjust_bpm"; step: 0.01; mode: RelativeMode.Stepped } }
  Wire { enabled: gridAdjustEnabled && !gridLockedProp.value; from: "%surface%.loop_size.push"; to: TriggerPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".track.grid.reset_bpm"; } }

  Wire { enabled: gridAdjustEnabled && !gridLockedProp.value && !shift; from: "%surface%.loop_move.turn"; to: RelativePropertyAdapter { path: "app.traktor.decks." + deckIdx + ".track.gridmarker.move"; step: 1; mode: RelativeMode.Stepped } }
  Wire { enabled: gridAdjustEnabled && !gridLockedProp.value && shift; from: "%surface%.loop_move.turn"; to: RelativePropertyAdapter { path: "app.traktor.decks." + deckIdx + ".track.gridmarker.move"; step: 0.2; mode: RelativeMode.Stepped } }
  Wire { enabled: gridAdjustEnabled && !gridLockedProp.value; from: "%surface%.loop_move.push"; to: TriggerPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".track.grid.set_autogrid"; } }
  }
  Wire
  {
    enabled: module.active && gridAdjustAvailable && gridAdjustEnableProp.value;
    from: "%surface%.jogwheel.rotation"; 
    to: EncoderScriptAdapter 
    {
      onTick: 
      { 
        const minimalTickValue = 0.0035;
        const rotationScaleFactor = 20;
        if (value < -minimalTickValue || value > minimalTickValue)
          gridAdjust.value = value * rotationScaleFactor; 
      }
    }
  }
  
  Wire
  { 
    enabled: module.active && gridAdjustEnabled && !gridLockedProp.value && !shift;
    from: "%surface%.sync"; 
    to: ButtonScriptAdapter
    { 
    	onPress: {brightness = 1.0} onRelease: {brightness = 0.0}
    	
    	brightness: dimmedBrightness; 
    	color: S4MK3Functions.colorForDeckSingle(0); 
    }
  }
  
  Wire
  { 
    enabled: module.active && gridAdjustEnabled && !gridLockedProp.value && !shift;
    from: "%surface%.master"; 
    to: ButtonScriptAdapter
    { 
    	onPress: {brightness = 1.0} onRelease: {brightness = 0.0}
    	
    	brightness: dimmedBrightness; 
    	color: S4MK3Functions.colorForDeckSingle(6);
    }
  }
  
  Wire
  { 
    enabled: module.active && gridAdjustEnabled && !shift && !gridLockedProp.value;
    from: "%surface%.sync"; 
    to: DirectPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".track.grid.half_bpm"; output: false}
  }
  
  Wire
  { 
    enabled: module.active && gridAdjustEnabled && !shift && !gridLockedProp.value;
    from: "%surface%.master"; 
    to: DirectPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".track.grid.double_bpm"; output: false}
  }
  
  Wire
  { 
    enabled: module.active && gridAdjustEnabled && shift;
    from: "%surface%.sync"; 
    to: TogglePropertyAdapter { path: "app.traktor.decks." + deckIdx + ".track.grid.lock_bpm"; color: S4MK3Functions.colorForDeckSingle(3) }
  }
  
  Wire
  { 
    enabled: module.active && gridAdjustEnabled && shift && !gridLockedProp.value;
    from: "%surface%.master"; 
    to: TriggerPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".track.grid.reset_bpm"; color: S4MK3Functions.colorForDeckSingle(3) }
  }
  
  Wire { enabled: module.active && gridAdjustEnabled && !shift; from: "%surface%.play";     to: TogglePropertyAdapter { path: "app.traktor.decks." + deckIdx + ".play"; color: S4MK3Functions.colorForDeckSingle(7) } }
  Wire { enabled: module.active && gridAdjustEnabled && !shift; from: "%surface%.cue";      to: HoldPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".cue"; color: deckColor; } }



  
  //-----------------------------------JogWheel------------------------------------//


  MappingPropertyDescriptor {
    id: jogMode
    path: deckPropertiesPath + ".jog_mode"
    type: MappingPropertyDescriptor.Integer
  }

  Turntable
  {
      name: "turntable"
      channel: module.deckIdx
  }

  WiresGroup
  {
      enabled: module.active

      Wire
      {
          from: "%surface%.jogwheel"
          to: "turntable"
          enabled: !(gridAdjustAvailable && gridAdjustEnableProp.value)
      }
      
      Wire { from: "%surface%.jogwheel.mode";     to: "turntable.mode"     }
      Wire { from: "%surface%.jogwheel.mode";     to: DirectPropertyAdapter { path: deckPropertiesPath + ".jog_mode" }    }
      Wire { from: "%surface%.jogwheel.pitch";    to: "turntable.pitch"    }
      Wire { from: "%surface%.shift";             to: "turntable.shift"    }
      Wire { from: "%surface%.jogwheel.timeline"; to: "turntable.timeline"; enabled: module.hapticHotcuesEnabled }

      Wire
      {
          from: DirectPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".play" }
          to: "%surface%.jogwheel.motor_on"
		  enabled: deckPlaying
          // motor_on is currenty also used to tell the HWS if taktor is playing in Jog Mode.
      }

	Wire
      {
          from: DirectPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".cue" }
          to: "%surface%.jogwheel.motor_on"
		  enabled: !deckPlaying && deckCueing && settings.jogwheelLedCue
          // motor_on is currenty also used to tell the HWS if taktor is playing in Jog Mode.
      }


      Wire {
          from: "%surface%.play";
          to: "%surface%.jogwheel.motor_off";
          enabled: module.shift && deckPlaying
      }
      

      //Wire { from: "%surface%.jogwheel.motor_on"; to: "turntable.motor_on" }

      Wire {
        from: "%surface%.jogwheel.haptic_ticks"
        to: DirectPropertyAdapter { path: "mapping.settings.haptic.ticks_density"; input: false }
        enabled: (jogMode.value === JogwheelMode.Jogwheel || jogMode.value === JogwheelMode.CDJ) && !module.shift
      }

      Wire
      {
          from: DirectPropertyAdapter { path: deckPropertiesPath + ".jog_color"; input: false }
          to: "%surface%.jogwheel.led_color"
      }

      Wire
      {
          from: "%surface%.pitch.fader"
          to: "%surface%.jogwheel.tempo"
      }

      Wire
      {
          from: "%surface%.jogwheel.platter_speed"
          to:   DirectPropertyAdapter{ path: "mapping.settings.haptic.platter_speed"; input: false}
      }
  }

  //------------------------------------Key lock and adjust------------------------------------//
 
  KeyControl { name: "key_control"; channel: deckIdx }
  Wire { from: "%surface%.loop_size";  to: "key_control.coarse"; enabled: !module.isEncoderInUse && module.shift && module.active && !((padsMode== PadsMode.loop) && loopActive) && !gridAdjustEnabled && !(module.showBrowser && settings.enableBrowserMode)}
  
  //-----------------------------Duplicate-----------------//
  
  AppProperty { id: loaded1; path: "app.traktor.decks.1.is_loaded" }
  AppProperty { id: loaded2; path: "app.traktor.decks.2.is_loaded" }
  AppProperty { id: loaded3; path: "app.traktor.decks.3.is_loaded" }
  AppProperty { id: loaded4; path: "app.traktor.decks.4.is_loaded" }
  AppProperty { id: isLoaded; path: "app.traktor.decks." + module.deckIdx + ".is_loaded" }


  
  AppProperty { id: type1; path: "app.traktor.decks.1.type" }
  AppProperty { id: type2; path: "app.traktor.decks.2.type" }
  AppProperty { id: type3; path: "app.traktor.decks.3.type" }
  AppProperty { id: type4; path: "app.traktor.decks.4.type" }
  
  AppProperty { id: typeCurrent; path: "app.traktor.decks." + module.deckIdx + ".type" }
  
  readonly property bool isLoadable1: (type1.value == 0) || (type1.value == 2) ? true : false 
  readonly property bool isLoadable2: (type2.value == 0) || (type2.value == 2) ? true : false 
  readonly property bool isLoadable3: (type3.value == 0) || (type3.value == 2) ? true : false 
  readonly property bool isLoadable4: (type4.value == 0) || (type4.value == 2) ? true : false 
  readonly property bool isLoadableCurrent: (typeCurrent.value == 0) || (typeCurrent.value == 2) ? true : false 
  
  WiresGroup
  {
  enabled: settings.enableDuplicate;
  
  WiresGroup
  {
  enabled: !settings.duplicateTo
  Wire
  {
    enabled: (module.deckIdx != 1) && shift && module.active
    from: "s4mk3.left.top_deck";
    to: TriggerPropertyAdapter  { path: "app.traktor.decks." + module.deckIdx + ".track.duplicate_deck.1"; color: (loaded1.value && isLoadable1 ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(0)) }
  }
  Wire
  {
    enabled: (module.deckIdx == 1) && shift && module.active
    from: "s4mk3.left.top_deck";
    to: ButtonScriptAdapter  { onPress: {brightness = 1.0} onRelease: {brightness = 0.0} brightness: offBrightness; color: S4MK3Functions.colorForDeckSingle(0) }
  }
  Wire
  {
    enabled: (module.deckIdx != 2) && shift && module.active
    from: "s4mk3.right.top_deck";
    to: TriggerPropertyAdapter  { path: "app.traktor.decks." + module.deckIdx + ".track.duplicate_deck.2"; color: (loaded2.value && isLoadable2 ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(0)) }
  }
   Wire
  {
    enabled: (module.deckIdx == 2) && shift && module.active
    from: "s4mk3.right.top_deck";
    to: ButtonScriptAdapter  { onPress: {brightness = 1.0} onRelease: {brightness = 0.0} brightness: offBrightness; color: S4MK3Functions.colorForDeckSingle(0) }
  }
  Wire
  {
    enabled: (module.deckIdx != 3) && shift && module.active
    from: "s4mk3.left.bottom_deck";
    to: TriggerPropertyAdapter  { path: "app.traktor.decks." + module.deckIdx + ".track.duplicate_deck.3"; color: (loaded3.value && isLoadable3 ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(0)) }
  }
  Wire
  {
    enabled: (module.deckIdx == 3) && shift && module.active
    from: "s4mk3.left.bottom_deck";
    to: ButtonScriptAdapter  { onPress: {brightness = 1.0} onRelease: {brightness = 0.0} brightness: offBrightness; color: S4MK3Functions.colorForDeckSingle(0) }
  }
  Wire
  {
    enabled: (module.deckIdx != 4) && shift && module.active
    from: "s4mk3.right.bottom_deck";
    to: TriggerPropertyAdapter  { path: "app.traktor.decks." + module.deckIdx + ".track.duplicate_deck.4"; color: (loaded4.value && isLoadable4 ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(0)) }
  }
  Wire
  {
    enabled: (module.deckIdx == 4) && shift && module.active
    from: "s4mk3.right.bottom_deck";
    to: ButtonScriptAdapter  { onPress: {brightness = 1.0} onRelease: {brightness = 0.0} brightness: offBrightness; color: S4MK3Functions.colorForDeckSingle(0) }
  }
  
  }
  
  WiresGroup
  {
  enabled: settings.duplicateTo
  
  Wire
  {
    enabled: (module.deckIdx != 1) && shift && module.active
    from: "s4mk3.left.top_deck";
    to: TriggerPropertyAdapter  { path: "app.traktor.decks.1.track.duplicate_deck." + module.deckIdx; color: (isLoaded.value && isLoadableCurrent ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(0)) }
  }
  Wire
  {
    enabled: (module.deckIdx == 1) && shift && module.active
    from: "s4mk3.left.top_deck";
    to: ButtonScriptAdapter  { onPress: {brightness = 1.0} onRelease: {brightness = 0.0}brightness: offBrightness; color: S4MK3Functions.colorForDeckSingle(0) }
  }
  Wire
  {
    enabled: (module.deckIdx != 2) && shift && module.active
    from: "s4mk3.right.top_deck";
    to: TriggerPropertyAdapter  { path: "app.traktor.decks.2.track.duplicate_deck." + module.deckIdx; color: (isLoaded.value && isLoadableCurrent ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(0)) }
  }
   Wire
  {
    enabled: (module.deckIdx == 2) && shift && module.active
    from: "s4mk3.right.top_deck";
    to: ButtonScriptAdapter  { onPress: {brightness = 1.0} onRelease: {brightness = 0.0}brightness: offBrightness; color: S4MK3Functions.colorForDeckSingle(0) }
  }
  Wire
  {
    enabled: (module.deckIdx != 3) && shift && module.active
    from: "s4mk3.left.bottom_deck";
    to: TriggerPropertyAdapter  { path: "app.traktor.decks.3.track.duplicate_deck." + module.deckIdx; color: (isLoaded.value && isLoadableCurrent ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(0)) }
  }
  Wire
  {
    enabled: (module.deckIdx == 3) && shift && module.active
    from: "s4mk3.left.bottom_deck";
    to: ButtonScriptAdapter  { onPress: {brightness = 1.0} onRelease: {brightness = 0.0}brightness: offBrightness; color: S4MK3Functions.colorForDeckSingle(0) }
  }
  Wire
  {
    enabled: (module.deckIdx != 4) && shift && module.active
    from: "s4mk3.right.bottom_deck";
    to: TriggerPropertyAdapter  { path: "app.traktor.decks.4.track.duplicate_deck." + module.deckIdx; color: (isLoaded.value && isLoadableCurrent ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(0)) }
  }
  Wire
  {
    enabled: (module.deckIdx == 4) && shift && module.active
    from: "s4mk3.right.bottom_deck";
    to: ButtonScriptAdapter  { onPress: {brightness = 1.0} onRelease: {brightness = 0.0}brightness: offBrightness; color: S4MK3Functions.colorForDeckSingle(0) }
  }
  
  }
  
  }
  
  //------------------------------------LOOP-----------------------------------------------//
  
  Loop { name: "loop";  channel: deckIdx }
  
  AppProperty { id: moveMode; path: "app.traktor.decks." + deckIdx + ".move.mode" }
  AppProperty { id: moveSize; path: "app.traktor.decks." + deckIdx + ".move.size" }
  AppProperty { id: quantProp; path: "app.traktor.quant" }
  readonly property bool quant: quantProp.value

  WiresGroup
  {
    // only enable loop control when the deck is in focus and no stem or slot is selected for either deck.
    enabled: module.active && !module.isLinkedDeckEncoderInUse && (!settings.resetLoopKnobs ? !(padsMode == PadsMode.loop) : "true") && !module.gridAdjustEnabled && !(module.showBrowser && settings.enableBrowserMode) && !module.isEncoderInUse
    
    WiresGroup
    {
      enabled: !module.shift && !module.view
      Wire { from: "%surface%.loop_size"; to: "loop.autoloop"; }
      Wire { from: "%surface%.loop_move"; to: "loop.move";     } 
    }
  
    Wire { from: "%surface%.loop_move"; to: "loop.one_beat_move"; enabled:  module.shift && !module.view }
  }
  
  WiresGroup
  {
    // only enable loop control when the deck is in focus and no stem or slot is selected for either deck.
    enabled: module.active  && !module.isLinkedDeckEncoderInUse && (padsMode == PadsMode.loop) && !module.gridAdjustEnabled && !(module.showBrowser && settings.enableBrowserMode) && !module.isEncoderInUse && !settings.resetLoopKnobs

	WiresGroup
    {
    	enabled: loopActive
    	
    	Wire { 
			from: "%surface%.loop_size.is_turned"; 
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".move.mode"; value: 3 } 
		}
		
		Wire { 
			enabled: !module.shift && module.quant
			from: "%surface%.loop_size.is_turned"; 
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".move.size"; value: 6 } 
		}
		
		Wire { 
			enabled: !module.shift && !module.quant
			from: "%surface%.loop_size.is_turned"; 
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".move.size"; value: 2 } 
		}
		
		Wire { 
			enabled: module.shift
			from: "%surface%.loop_size.is_turned"; 
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".move.size"; value: 1 } 
		}
		
		
		
		Wire { 
			from: "%surface%.loop_move.is_turned"; 
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".move.mode"; value: 2 } 
		}
		
		Wire { 
			enabled: !module.shift && module.quant
			from: "%surface%.loop_move.is_turned"; 
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".move.size"; value: 6 } 
		}
		
		Wire { 
			enabled: !module.shift && !module.quant
			from: "%surface%.loop_move.is_turned"; 
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".move.size"; value: 2 } 
		}
		
		Wire { 
			enabled: module.shift
			from: "%surface%.loop_move.is_turned"; 
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".move.size"; value: 1 } 
		}
	
		

		Wire { from: "%surface%.loop_size.turn"; to: RelativePropertyAdapter { path: "app.traktor.decks." + deckIdx + ".move"; step: 1; mode: RelativeMode.Stepped } }
		Wire { from: "%surface%.loop_move.turn"; to: RelativePropertyAdapter { path: "app.traktor.decks." + deckIdx + ".move"; step: 1; mode: RelativeMode.Stepped } }

    }
    
    WiresGroup
    {
    	enabled: !loopActive
	
		Wire { 
			from: "%surface%.loop_move.is_turned"; 
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".move.mode"; value: 0 } 
		}
		
		Wire { 
			enabled: !module.shift
			from: "%surface%.loop_move.is_turned"; 
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".move.size"; value: 12 } 
		}
		
		Wire { 
			enabled: module.shift
			from: "%surface%.loop_move.is_turned"; 
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".move.size"; value: 6 } 
		}
		
		Wire { enabled: !shift; from: "%surface%.loop_size.turn"; to: RelativePropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.size"; step: 1; mode: RelativeMode.Stepped } }
		Wire { from: "%surface%.loop_move.turn"; to: RelativePropertyAdapter { path: "app.traktor.decks." + deckIdx + ".move"; step: 1; mode: RelativeMode.Stepped } }

    }
    
    Wire { enabled: shift; from: "%surface%.loop_move.push"; to: TriggerPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.set.auto" } }	
    Wire { enabled: !shift; from: "%surface%.loop_move.push"; to: TriggerPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.set.in" } }
    Wire { enabled: !shift; from: "%surface%.loop_size.push"; to: TriggerPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.set.out" } }
  }

  //------------------------------------SUBMODULES------------------------------------------//

  property bool triggered: false
  
  readonly property string side: (deckIdx == 1 || deckIdx == 3) ? "left" : "right";
  
  
  //timers 
  
  Timer {
          id: slicerEnabledTimer
          property bool  blink: false

          interval: 250
          repeat:   true
          running:  propEnabled.value && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled

          onTriggered: {
            blink = !blink;
			module.triggered = true;
          }

          onRunningChanged: {
            blink = running;
            running == false ? module.triggered = false : module.triggered = module.triggered;
          }
  }
	
  Timer {
          id: loopEnabledTimer
          property bool  blink: false

          interval: 250
          repeat:   true
          running:  (loopEnabled.value && !(module.showBrowser && settings.enableBrowserMode)) && !module.gridAdjustEnabled

          onTriggered: {
            blink = !blink;
          }

          onRunningChanged: {
            blink = running;
          }
  }
   
  Timer {
          id: toneEnabledTimer
          property bool  blink: false

          interval: 250
          repeat:   true
          running:  (padsMode == settings.cueButton) && !module.gridAdjustEnabled

          onTriggered: {
            blink = !blink;
          }

          onRunningChanged: {
            blink = running;
          }
  }
  
  //fx bank settings
  
  	//samples button
  	WiresGroup
  	{
  		enabled: settings.samplesButton == 9 ? true : false;
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.samplesButton, deckType) && !(deckType == DeckType.Remix) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.bottomRemix && !module.gridAdjustEnabled;
    		from: "%surface%.samples";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx1unit + ".type"; value: 0; output: false}
  		}
  	
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.samplesButton, deckType) && !(deckType == DeckType.Remix) && !(module.showBrowser && settings.enableBrowserMode) && module.active && module.bottomRemix && !shift && !module.gridAdjustEnabled;
    		from: "%surface%.samples";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx1unit + ".type"; value: 0; output: false}
  		}
  	
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.samplesButton, deckType) && (deckType == DeckType.Remix) && !(module.showBrowser && settings.enableBrowserMode) && module.active && shift && !module.gridAdjustEnabled;
    		from: "%surface%.samples";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx1unit + ".type"; value: 0; output: false}
  		}
  	}
  	
  	WiresGroup
  	{
  		enabled: settings.samplesButton == 10 ? true : false;
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.samplesButton, deckType) && !(deckType == DeckType.Remix) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.bottomRemix && !module.gridAdjustEnabled;
    		from: "%surface%.samples";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx2unit + ".type"; value: 0; output: false}
  		}
  	
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.samplesButton, deckType) && !(deckType == DeckType.Remix) && !(module.showBrowser && settings.enableBrowserMode) && module.active && module.bottomRemix && !shift && !module.gridAdjustEnabled;
    		from: "%surface%.samples";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx2unit + ".type"; value: 0; output: false}
  		}
  	
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.samplesButton, deckType) && (deckType == DeckType.Remix) && !(module.showBrowser && settings.enableBrowserMode) && module.active && shift && !module.gridAdjustEnabled;
    		from: "%surface%.samples";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx2unit + ".type"; value: 0; output: false}
  		}
  	}
  	
  	//mute button
  	WiresGroup
  	{
  		enabled: settings.muteButton == 9 ? true : false;

  	
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.muteButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && !(padsMode == PadsMode.remix);
    		from: "%surface%.mute";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx1unit + ".type"; value: 0; output: false}
  		}
  		
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.muteButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && (padsMode == PadsMode.remix) && shift;
    		from: "%surface%.mute";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx1unit + ".type"; value: 0; output: false}
  		}

  	}
  	
  	WiresGroup
  	{
  		enabled: settings.muteButton == 10 ? true : false;
  		
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.muteButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && !(padsMode == PadsMode.remix);
    		from: "%surface%.mute";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx2unit + ".type"; value: 0; output: false}
  		}
  		
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.muteButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && (padsMode == PadsMode.remix) && shift;
    		from: "%surface%.mute";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx2unit + ".type"; value: 0; output: false}
  		}

  	}
  	
  	//record button
  	WiresGroup
  	{
  		enabled: settings.recordButton == 9 ? true : false;

  	
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.recordButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && !(padsMode == PadsMode.remix);
    		from: "%surface%.record";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx1unit + ".type"; value: 0; output: false}
  		}
  		
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.recordButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && (padsMode == PadsMode.remix) && shift;
    		from: "%surface%.record";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx1unit + ".type"; value: 0; output: false}
  		}

  	}
  	
  	WiresGroup
  	{
  		enabled: settings.recordButton == 10 ? true : false;
  		
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.recordButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && !(padsMode == PadsMode.remix);
    		from: "%surface%.record";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx2unit + ".type"; value: 0; output: false}
  		}
  		
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.recordButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && (padsMode == PadsMode.remix) && shift;
    		from: "%surface%.record";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx2unit + ".type"; value: 0; output: false}
  		}
  	}
  	
  	//stems button
  	WiresGroup
  	{
  		enabled: settings.stemsButton == 9 ? true : false;

  	
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.stemsButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && !(deckType == DeckType.stems)
    		from: "%surface%.stems";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx1unit + ".type"; value: 0; output: false}
  		}
  		
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.stemsButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && !(deckType == DeckType.stems) && shift
    		from: "%surface%.record";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx1unit + ".type"; value: 0; output: false}
  		}

  	}
  	
  	WiresGroup
  	{
  		enabled: settings.stemsButton == 10 ? true : false;
  		
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.stemsButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && !(deckType == DeckType.stems);
    		from: "%surface%.record";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx2unit + ".type"; value: 0; output: false}
  		}
  		
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.stemsButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && !(deckType == DeckType.stems) && shift;
    		from: "%surface%.record";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx2unit + ".type"; value: 0; output: false}
  		}
  	}
  	
  	//cue button
  	WiresGroup
  	{
  		enabled: settings.cueButton == 9 ? true : false;

  	
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.cueButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && shift;
    		from: "s4mk3." + side + ".cue";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx1unit + ".type"; value: 0; output: false}
  		}

  	}
  	
  	WiresGroup
  	{
  		enabled: settings.cueButton == 10 ? true : false;
  		
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.cueButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && shift;
    		from: "s4mk3." + side + ".cue";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx2unit + ".type"; value: 0; output: false}
  		}

  	}
  	
  	//left fx button
  	WiresGroup
  	{
  		enabled: settings.fxLeftButton == 9 ? true : false;

  	
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.fxLeftButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && shift;
    		from: "s4mk3.left.fx.buttons.1";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx1unit + ".type"; value: 0; output: false}
  		}

  	}
  	
  	WiresGroup
  	{
  		enabled: settings.fxLeftButton == 10 ? true : false;
  		
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.fxLeftButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && shift;
    		from: "s4mk3.left.fx.buttons.1";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx2unit + ".type"; value: 0; output: false}
  		}

  	}
  
    //right fx button
  	WiresGroup
  	{
  		enabled: settings.fxRightButton == 9 ? true : false;

  	
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.fxRightButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && shift;
    		from: "s4mk3.right.fx.buttons.1";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx1unit + ".type"; value: 0; output: false}
  		}

  	}
  	
  	WiresGroup
  	{
  		enabled: settings.fxRightButton == 10 ? true : false;
  		
  		Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.fxRightButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && shift;
    		from: "s4mk3.right.fx.buttons.1";
    		to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx2unit + ".type"; value: 0; output: false}
  		}

  	}
  
  //freeze button functions
  	
  	//samples button
  	
  	WiresGroup
  	{
  		enabled: settings.samplesButton == 4 ? true : false;
  	
  		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.samplesButton, deckType) && slicerEnabled && (padsMode == settings.samplesButton) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.bottomRemix && !module.gridAdjustEnabled;
    		from: "%surface%.samples";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.enabled"; value: false; output: false  }
  		}
  
  		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.samplesButton, deckType) && slicerEnabled && (padsMode == settings.samplesButton) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.shift && module.bottomRemix && !module.gridAdjustEnabled;
   		 	from: "%surface%.samples";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.enabled"; value: false; output: false  }
  		}
  
  		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.samplesButton, deckType) && !slicerEnabled && !(module.showBrowser && settings.enableBrowserMode) && module.active && (settings.enableSlicerOnFirstPress ? true : (padsMode == PadsMode.freeze)) && !module.bottomRemix && !module.gridAdjustEnabled;
    		from: "%surface%.samples";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.enabled"; value: true; output: false }
  		}	
  
  		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.samplesButton, deckType) && !slicerEnabled && !(module.showBrowser && settings.enableBrowserMode) && module.active && (settings.enableSlicerOnFirstPress ? true : (padsMode == PadsMode.freeze)) && !module.shift && module.bottomRemix && !module.gridAdjustEnabled;
    		from: "%surface%.samples";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.enabled"; value: true; output: false }
  		}	
  
  		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.samplesButton, deckType) && !slicerEnabled && !(module.showBrowser && settings.enableBrowserMode) && module.active && !shift && !module.gridAdjustEnabled;
    		from: "%surface%.samples";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.slice_count"; value: settings.defaultSlicerSize; output: false  }
  		}
  
  		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.samplesButton, deckType) && !slicerEnabled && !(module.showBrowser && settings.enableBrowserMode) && module.active && shift && !module.gridAdjustEnabled;
    		from: "%surface%.samples";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.slice_count"; value: settings.defaultSlicerSizeShift; output: false  }
  		}
  
   		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.samplesButton, deckType) && slicerEnabled && !(module.showBrowser && settings.enableBrowserMode) && module.active && shift && !module.gridAdjustEnabled;
    		from: "%surface%.samples";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.enabled"; value: false; output: false }
  		}
  	
  	}
  	
  	//mute button
  	
  	WiresGroup
  	{
  		enabled: settings.muteButton == 4 ? true : false;
  	
  		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.muteButton, deckType) && slicerEnabled && (padsMode == settings.muteButton) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled;
    		from: "%surface%.mute";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.enabled"; value: false; output: false  }
  		} 
  	
  		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.muteButton, deckType) && !slicerEnabled && !(padsMode == PadsMode.remix) && (settings.enableSlicerOnFirstPress ? true : (padsMode == settings.muteButton)) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled;
    		from: "%surface%.mute";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.enabled"; value: true; output: false  }
  		}
  	
  		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.muteButton, deckType) && !slicerEnabled && (padsMode == settings.muteButton) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && !shift
    		from: "%surface%.mute";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.slice_count"; value: settings.defaultSlicerSize; output: false  }
  		}	
  	
  		Wire
  		{	
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.muteButton, deckType) && !slicerEnabled && (padsMode == settings.muteButton) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && shift
    		from: "%surface%.mute";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.slice_count"; value: settings.defaultSlicerSizeShift; output: false  }
  		}
  		
  	}
  	
  	//record button
  	
  	WiresGroup
  	{
  		enabled: settings.recordButton == 4 ? true : false;
  		
		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.recordButton, deckType) && slicerEnabled && (padsMode == settings.recordButton) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled;
    		from: "%surface%.record";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.enabled"; value: false; output: false  }
  		} 
  	
  		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.recordButton, deckType) && !slicerEnabled && !(padsMode == PadsMode.remix) && (settings.enableSlicerOnFirstPress ? true : (padsMode == settings.recordButton)) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled;
    		from: "%surface%.record";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.enabled"; value: true; output: false  }
  		}
  	
  		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.recordButton, deckType) && !slicerEnabled && (padsMode == settings.recordButton) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && !shift
    		from: "%surface%.record";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.slice_count"; value: settings.defaultSlicerSize; output: false  }
  		}
  	
  		Wire
  		{	
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.recordButton, deckType) && !slicerEnabled && (padsMode == settings.recordButton) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && shift
   		 	from: "%surface%.record";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.slice_count"; value: settings.defaultSlicerSizeShift; output: false  }
  		}
  	
  	}
  	
  	//stems button
  	
  	WiresGroup
  	{
  		enabled: settings.stemsButton == 4 ? true : false;
  	
 	 	Wire
		{
    		enabled: PadsMode.isPadsModeSupported(settings.stemsButton , deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !(deckType == DeckType.Stem) && !module.gridAdjustEnabled;
    		from: "%surface%.stems";
    		to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: settings.stemsButton; color: (settings.stemsButtonColour == 18 ? module.deckColor : S4MK3Functions.colorForDeckSingle(settings.stemsButtonColour))	}
  		}
    
  		Wire
  		{
    		enabled: PadsMode.isPadsModeSupported(settings.stemsButton , deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && shift && (deckType == DeckType.Stem) && !(padsMode == settings.stemsButton) && !module.gridAdjustEnabled;
    		from: "%surface%.stems";
    		to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: settings.stemsButton; color: (settings.stemsButtonColour == 18 ? module.deckColor : S4MK3Functions.colorForDeckSingle(settings.stemsButtonColour))	}
  		}
  		Wire
  		{
    		enabled: PadsMode.isPadsModeSupported(PadsMode.stems , deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && (deckType == DeckType.Stem) && (padsMode == settings.stemsButton) && !module.gridAdjustEnabled;
    		from: "%surface%.stems";
    		to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: settings.stemsButton; color: (settings.stemsButtonColour == 18 ? module.deckColor : S4MK3Functions.colorForDeckSingle(settings.stemsButtonColour))	}
  		}

  		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.stemsButton, deckType) && slicerEnabled && (padsMode == settings.stemsButton) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled;
    		from: "%surface%.stems";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.enabled"; value: false; output: false  }
  		} 
  	
  		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.stemsButton, deckType) && !slicerEnabled && (padsMode == settings.stemsButton) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled;
    		from: "%surface%.stems";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.enabled"; value: true; output: false  }
  		}
  	
  		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.stemsButton, deckType) && !slicerEnabled && (padsMode == settings.stemsButton) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && !shift
    		from: "%surface%.stems";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.slice_count"; value: settings.defaultSlicerSize; output: false  }
  		}
  	
  		Wire
  		{	
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.stemsButton, deckType) && !slicerEnabled && (padsMode == settings.stemsButton) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && shift
   		 	from: "%surface%.stems";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.slice_count"; value: settings.defaultSlicerSizeShift; output: false  }
  		}
  	
  	}
  	
  	//cue button
  	WiresGroup
  	{
  		enabled: settings.cueButton == 4 ? true : false;
  		
  		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.cueButton, deckType) && slicerEnabled && (padsMode == settings.cueButton) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && shift
    		from: "s4mk3." + side + ".cue";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.enabled"; value: false; output: false  }
  		} 
  	
  		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.cueButton, deckType) && !slicerEnabled && (padsMode == settings.cueButton) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && shift
    		from: "s4mk3." + side + ".cue";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.enabled"; value: true; output: false  }
  		}
  	
  		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.cueButton, deckType) && !slicerEnabled && (padsMode == settings.cueButton) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && shift
    		from: "s4mk3." + side + ".cue";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.slice_count"; value: settings.defaultSlicerSize; output: false  }
  		}
  	
  	}
  	
  	//left fx button
  	WiresGroup
  	{
  		enabled: settings.fxLeftButton == 4 ? true : false;
  		
  		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.fxLeftButton, deckType) && slicerEnabled && (padsMode == settings.fxLeftButton) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && shift
    		from: "s4mk3.left.fx.buttons.1";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.enabled"; value: false; output: false  }
  		} 
  	
  		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.fxLeftButton, deckType) && !slicerEnabled && (padsMode == settings.fxLeftButton) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && shift
    		from: "s4mk3.left.fx.buttons.1";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.enabled"; value: true; output: false  }
  		}
  	
  		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.fxLeftButton, deckType) && !slicerEnabled && (padsMode == settings.fxLeftButton) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && shift
    		from: "s4mk3.left.fx.buttons.1";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.slice_count"; value: settings.defaultSlicerSize; output: false  }
  		}
  	
  	}
  	
  	//right fx button
  	WiresGroup
  	{
  		enabled: settings.fxRightButton == 4 ? true : false;
  		
  		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.fxRightButton, deckType) && slicerEnabled && (padsMode == settings.fxRightButton) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && shift
    		from: "s4mk3.right.fx.buttons.1";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.enabled"; value: false; output: false  }
  		} 
  	
  		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.fxRightButton, deckType) && !slicerEnabled && (padsMode == settings.fxRightButton) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && shift
    		from: "s4mk3.right.fx.buttons.1";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.enabled"; value: true; output: false  }
  		}
  	
  		Wire
  		{
			enabled: enablePads && PadsMode.isPadsModeSupported(settings.fxRightButton, deckType) && !slicerEnabled && (padsMode == settings.fxRightButton) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled && shift
    		from: "s4mk3.right.fx.buttons.1";
			to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".freeze.slice_count"; value: settings.defaultSlicerSize; output: false  }
  		}
  	
  	}
  
  //loop button functions
  
  	//samplesButton
  	
  	WiresGroup
  	{
  		enabled: settings.samplesButton == 5 ? true : false;
  		
  		Wire 
   		{ 
	  		enabled: enablePads && PadsMode.isPadsModeSupported(settings.samplesButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.bottomRemix && !module.gridAdjustEnabled;
      		from: "%surface%.samples";   
      		to: ButtonScriptAdapter 
      		{ 
        		brightness: loopEnabledTimer.blink ? dimmedBrightness : ((padsMode == settings.samplesButton) ? onBrightness : (padsMode != settings.samplesButton && loopEnabledTimer.running ? onBrightness : dimmedBrightness))
      		}
    	}
    	
    	Wire 
   		{ 
	  		enabled: enablePads && PadsMode.isPadsModeSupported(settings.samplesButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.shift && module.bottomRemix && !module.gridAdjustEnabled;
      		from: "%surface%.samples";   
      		to: ButtonScriptAdapter 
      		{ 
        		brightness: loopEnabledTimer.blink ? dimmedBrightness : ((padsMode == settings.samplesButton) ? onBrightness : (padsMode != settings.samplesButton && loopEnabledTimer.running ? onBrightness : dimmedBrightness))
      		}
    	}		
    	
    	Wire 
    	{ 
	  		enabled: loopEnabled.value && (padsMode == settings.samplesButton) && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled && (module.bottomRemix ? !shift : true)
      		from: "%surface%.samples";   
      		to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.active"; value: false; output: false  }
    	}
  
   		Wire 
    	{ 
	  		enabled: !loopEnabled.value && (padsMode == settings.samplesButton) && module.active && !(module.showBrowser && settings.enableBrowserMode) && !settings.customAutoLoop && !module.gridAdjustEnabled && (module.bottomRemix ? !shift : true)
      		from: "%surface%.samples";   
      		to: TriggerPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.set.auto"; output: false  }
    	}
  
    	Wire 
    	{ 
	 	 	enabled: !loopEnabled.value && (padsMode == settings.samplesButton) && module.active && !(module.showBrowser && settings.enableBrowserMode) && settings.customAutoLoop && !module.gridAdjustEnabled && (module.bottomRemix ? !shift : true)
     	 	from: "%surface%.samples";   
     	 	to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.set.auto_with_size"; value: settings.stemButtonLoopSize ; output: false  }
    	}
  	}
  	
  	
  	//mute button
  	
  	WiresGroup
  	{
  		enabled: settings.muteButton == 5 ? true : false;
  		
  		Wire
  		{
  			enabled: enablePads && PadsMode.isPadsModeSupported(settings.muteButton , deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active  && !(deckType == DeckType.Remix) && !module.gridAdjustEnabled;
      		from: "%surface%.mute";   
      		to: ButtonScriptAdapter 
      		{ 
        		brightness: loopEnabledTimer.blink ? dimmedBrightness : ((padsMode == settings.muteButton) ? onBrightness : (padsMode != settings.muteButton && loopEnabledTimer.running ? onBrightness : dimmedBrightness))
      		}
      	}
      	
      	Wire
  		{
  			enabled: !enablePads && PadsMode.isPadsModeSupported(settings.muteButton , deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active  && !(deckType == DeckType.Remix) && module.shift && !module.gridAdjustEnabled;
      		from: "%surface%.mute";   
      		to: ButtonScriptAdapter 
      		{ 
        		brightness: loopEnabledTimer.blink ? dimmedBrightness : ((padsMode == settings.muteButton) ? onBrightness : (padsMode != settings.muteButton && loopEnabledTimer.running ? onBrightness : dimmedBrightness))
      		}
      	}
      	
      	Wire 
    	{ 
	  		enabled: loopEnabled.value && (padsMode == settings.muteButton) && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled
      		from: "%surface%.mute";   
      		to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.active"; value: false; output: false  }
    	}
  
   		Wire 
    	{ 
	  		enabled: !loopEnabled.value && (padsMode == settings.muteButton) && module.active && !(module.showBrowser && settings.enableBrowserMode) && !settings.customAutoLoop && !module.gridAdjustEnabled
      		from: "%surface%.mute";   
      		to: TriggerPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.set.auto"; output: false  }
    	}
  
    	Wire 
    	{ 
	 	 enabled: !loopEnabled.value && (padsMode == settings.muteButton) && module.active && !(module.showBrowser && settings.enableBrowserMode) && settings.customAutoLoop && !module.gridAdjustEnabled
     	 from: "%surface%.mute";   
     	 to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.set.auto_with_size"; value: settings.stemButtonLoopSize ; output: false  }
    	}
      	
  	}
  
  
    //cue button
    
    WiresGroup
    {
    	enabled: settings.cueButton == 5 ? true : false
    	
     	Wire
  		{
    		enabled: enablePads && PadsMode.isPadsModeSupported(settings.cueButton, deckType) && (padsMode == settings.cueButton) && !module.gridAdjustEnabled;
    		from: "s4mk3." + side + ".cue";
    		to: ButtonScriptAdapter { brightness: toneEnabledTimer.blink ? 1.0 : 0.0; color: toneEnabledTimer.blink ? (loopEnabledTimer.running == true ? S4MK3Functions.colorForDeckSingle(settings.loopPadColour) : S4MK3Functions.colorForDeckSingle(3)) : S4MK3Functions.colorForDeck(focusedDeckIdx,deckA,deckB,deckC,deckD) }
  		}
  		
  		Wire 
    	{ 
	  		enabled: enablePads && PadsMode.isPadsModeSupported(settings.cueButton, deckType) && loopEnabled.value && (padsMode == settings.cueButton) && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled && shift
      		from: "s4mk3." + side + ".cue";   
      		to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.active"; value: false; output: false  }
    	}
  
   		Wire 
    	{ 
	  		enabled: enablePads && PadsMode.isPadsModeSupported(settings.cueButton, deckType) && !loopEnabled.value && (padsMode == settings.cueButton) && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled && shift
      		from: "s4mk3." + side + ".cue";   
      		to: TriggerPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.set.auto"; output: false  }
    	}
    	
    	Wire 
    	{ 
	 	 enabled: enablePads && PadsMode.isPadsModeSupported(settings.cueButton, deckType) && !loopEnabled.value && (padsMode == settings.cueButton) && module.active && !(module.showBrowser && settings.enableBrowserMode) && settings.customAutoLoop && !module.gridAdjustEnabled
     	 from: "s4mk3." + side + ".cue";
     	 to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.set.auto_with_size"; value: settings.stemButtonLoopSize ; output: false  }
    	}
    }
  
  	//record button
  	WiresGroup
  	{
  		enabled: settings.recordButton == 5 ? true : false
  		Wire 
    	{ 
	  		enabled: enablePads && PadsMode.isPadsModeSupported(settings.recordButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && (deckType != DeckType.Remix) && !module.gridAdjustEnabled;
      		from: "%surface%.record";   
      		to: ButtonScriptAdapter 
      		{ 
        		brightness: loopEnabledTimer.blink ? dimmedBrightness : ((padsMode == settings.recordButton) ? onBrightness : (padsMode != settings.recordButton && loopEnabledTimer.running ? onBrightness : dimmedBrightness))
      		}
    	}
    	
    	Wire 
    	{ 
	  		enabled: enablePads && PadsMode.isPadsModeSupported(settings.recordButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && (deckType == DeckType.Remix) && shift && !module.gridAdjustEnabled;
      		from: "%surface%.record";   
      		to: ButtonScriptAdapter 
      		{ 
        		brightness: loopEnabledTimer.blink ? dimmedBrightness : ((padsMode == settings.recordButton) ? onBrightness : (padsMode != settings.recordButton && loopEnabledTimer.running ? onBrightness : dimmedBrightness))
      		}
    	}
    	
    	Wire 
    	{ 
	  		enabled: enablePads && PadsMode.isPadsModeSupported(settings.recordButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && (deckType == DeckType.Remix) && (padsMode == settings.recordButton) && !shift && !module.gridAdjustEnabled;
      		from: "%surface%.record";   
      		to: ButtonScriptAdapter 
      		{ 
        		brightness: loopEnabledTimer.blink ? dimmedBrightness : ((padsMode == settings.recordButton) ? onBrightness : (padsMode != settings.recordButton && loopEnabledTimer.running ? onBrightness : dimmedBrightness))
      		}
    	}
    	
    	Wire 
    	{ 
	  		enabled: !enablePads && PadsMode.isPadsModeSupported(settings.recordButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && !(deckType == DeckType.Remix) && module.active && module.shift && !module.gridAdjustEnabled;
      		from: "%surface%.record";   
      		to: ButtonScriptAdapter 
      		{ 
        		brightness: loopEnabledTimer.blink ? dimmedBrightness : ((padsMode == settings.recordButton) ? onBrightness : (padsMode != settings.recordButton && loopEnabledTimer.running ? onBrightness : dimmedBrightness))
      		}
    	}
    	
    	Wire 
    	{ 
	  		enabled: enablePads && PadsMode.isPadsModeSupported(settings.recordButton, deckType) && loopEnabled.value && (padsMode == settings.recordButton) && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled
      		from: "%surface%.record";   
      		to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.active"; value: false; output: false  }
    	}
  
   		Wire 
    	{ 
	  		enabled: enablePads && PadsMode.isPadsModeSupported(settings.recordButton, deckType) && !loopEnabled.value && (padsMode == settings.recordButton) && module.active && !(module.showBrowser && settings.enableBrowserMode) && !settings.customAutoLoop && !module.gridAdjustEnabled
      		from: "%surface%.record";   
      		to: TriggerPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.set.auto"; output: false  }
    	}
  
    	Wire 
    	{ 
	 	 	enabled: enablePads && PadsMode.isPadsModeSupported(settings.recordButton, deckType) && !loopEnabled.value && (padsMode == settings.recordButton) && module.active && !(module.showBrowser && settings.enableBrowserMode) && settings.customAutoLoop && !module.gridAdjustEnabled
     	 	from: "%surface%.record";   
     	 	to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.set.auto_with_size"; value: settings.stemButtonLoopSize ; output: false  }
    	}
  	
  	}
  	
  
  	//stems button
  WiresGroup
  {
  	enabled: settings.stemsButton == 5 ? true : false
    Wire 
    { 
	  enabled: PadsMode.isPadsModeSupported(settings.stemsButton, deckType) && ((deckType == DeckType.Stem) ? ((padsMode == settings.stemsButton) ? true  : false) : true) && module.active && !(module.showBrowser && settings.enableBrowserMode) && !(deckType == DeckType.Live) && !module.gridAdjustEnabled
      from: "%surface%.stems";   
      to: ButtonScriptAdapter 
      { 
        brightness: loopEnabledTimer.blink ? dimmedBrightness : ((padsMode == settings.stemsButton) ? onBrightness : (padsMode != settings.stemsButton && loopEnabledTimer.running ? onBrightness : dimmedBrightness))
		color: S4MK3Functions.colorForDeckSingle(settings.stemsButtonColour)
      }
    }
  
    Wire 
    { 
	  enabled: PadsMode.isPadsModeSupported(settings.stemsButton, deckType) && ((padsMode == settings.stemsButton) ? true : false) && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled
      from: "%surface%.stems";   
      to: ButtonScriptAdapter 
      { 
        brightness: onBrightness
		color: S4MK3Functions.colorForDeckSingle(settings.stemsButtonColour)
      }
    }
  
    Wire 
    { 
	  enabled: PadsMode.isPadsModeSupported(settings.stemsButton, deckType) && !((padsMode == settings.stemsButton) ? true : false) && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled
      from: "%surface%.stems";   
      to: ButtonScriptAdapter 
      { 
        brightness: dimmedBrightness
		color: S4MK3Functions.colorForDeckSingle(settings.stemsButtonColour)
      }
    }
  
    Wire 
    { 
	  enabled: PadsMode.isPadsModeSupported(settings.stemsButton, deckType) && loopEnabled.value && ((deckType == DeckType.Stem) ? ((padsMode == settings.stemsButton) ? true : false) : (padsMode == PadsMode.loop)) && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled
      from: "%surface%.stems";   
      to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.active"; value: false; output: false  }
    }
  
    Wire 
    { 
	  enabled: PadsMode.isPadsModeSupported(settings.stemsButton, deckType) && !loopEnabled.value && (padsMode == settings.stemsButton) && module.active && !(module.showBrowser && settings.enableBrowserMode) && !settings.customAutoLoop && !module.gridAdjustEnabled
      from: "%surface%.stems";   
      to: TriggerPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.set.auto"; output: false  }
    }
  
    Wire 
    { 
	  enabled: PadsMode.isPadsModeSupported(settings.stemsButton, deckType) && !loopEnabled.value && (padsMode == settings.stemsButton) && module.active && !(module.showBrowser && settings.enableBrowserMode) && settings.customAutoLoop && !module.gridAdjustEnabled
      from: "%surface%.stems";   
      to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.set.auto_with_size"; value: settings.stemButtonLoopSize ; output: false  }
    }
  
    Wire 
    { 
	  enabled: PadsMode.isPadsModeSupported(settings.stemsButton, deckType) && loopEnabled.value && (deckType == DeckType.Stem) && !(padsMode == settings.stemsButton) && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled
      from: "%surface%.stems";   
      to: ButtonScriptAdapter 
      { 
        brightness: onBrightness
		color: loopEnabledTimer.blink ? deckColor : S4MK3Functions.colorForDeckSingle(settings.loopPadColour)
      }
    }
  }
  
  	//left fx button
  	WiresGroup
  	{
  		enabled: settings.fxLeftButton == 5 ? true : false;
  		
  		Wire 
    	{ 
	  		enabled: PadsMode.isPadsModeSupported(settings.fxLeftButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && module.shift && !settings.resetFXFunctions && !module.gridAdjustEnabled;
      		from: "s4mk3.left.fx.buttons.1";
      		to: ButtonScriptAdapter 
      		{ 
        		brightness: loopEnabledTimer.blink ? dimmedBrightness : ((padsMode == settings.fxLeftButton) ? onBrightness : (padsMode != settings.fxLeftButton && loopEnabledTimer.running ? onBrightness : dimmedBrightness))
      		}
    	}
    	
    	Wire 
    	{ 
	  		enabled: enablePads && PadsMode.isPadsModeSupported(settings.fxLeftButton, deckType) && loopEnabled.value && (padsMode == settings.fxLeftButton) && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled && shift && !settings.resetFXFunctions
      		from: "s4mk3.left.fx.buttons.1";  
      		to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.active"; value: false; output: false  }
    	}
  
   		Wire 
    	{ 
	  		enabled: enablePads && PadsMode.isPadsModeSupported(settings.fxLeftButton, deckType) && !loopEnabled.value && (padsMode == settings.fxLeftButton) && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled && shift && !settings.resetFXFunctions && !settings.customAutoLoop
      		from: "s4mk3.left.fx.buttons.1";
      		to: TriggerPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.set.auto"; output: false  }
    	}
    	
    	Wire 
    	{ 
	 	 	enabled: enablePads && PadsMode.isPadsModeSupported(settings.fxLeftButton, deckType) && !loopEnabled.value && (padsMode == settings.fxLeftButton) && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled && shift && !settings.resetFXFunctions && settings.customAutoLoop
     	 	from: "s4mk3.left.fx.buttons.1";
     	 	to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.set.auto_with_size"; value: settings.stemButtonLoopSize ; output: false  }
    	}
  	}
  	
  	//right fx button
  	WiresGroup
  	{
  		enabled: settings.fxRightButton == 5 ? true : false;
  		
  		Wire 
    	{ 
	  		enabled: PadsMode.isPadsModeSupported(settings.fxRightButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && module.shift && !settings.resetFXFunctions && !module.gridAdjustEnabled;
      		from: "s4mk3.right.fx.buttons.1";
      		to: ButtonScriptAdapter 
      		{ 
        		brightness: loopEnabledTimer.blink ? dimmedBrightness : ((padsMode == settings.fxRightButton) ? onBrightness : (padsMode != settings.fxRightButton && loopEnabledTimer.running ? onBrightness : dimmedBrightness))
      		}
    	}
    	
    	Wire 
    	{ 
	  		enabled: enablePads && PadsMode.isPadsModeSupported(settings.fxRightButton, deckType) && loopEnabled.value && (padsMode == settings.fxRightButton) && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled && shift && !settings.resetFXFunctions
      		from: "s4mk3.right.fx.buttons.1";  
      		to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.active"; value: false; output: false  }
    	}
  
   		Wire 
    	{ 
	  		enabled: enablePads && PadsMode.isPadsModeSupported(settings.fxRightButton, deckType) && !loopEnabled.value && (padsMode == settings.fxRightButton) && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled && shift && !settings.resetFXFunctions && !settings.customAutoLoop
      		from: "s4mk3.right.fx.buttons.1";
      		to: TriggerPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.set.auto"; output: false  }
    	}
    	
    	Wire 
    	{ 
	 	 	enabled: enablePads && PadsMode.isPadsModeSupported(settings.fxRightButton, deckType) && !loopEnabled.value && (padsMode == settings.fxRightButton) && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled && shift && !settings.resetFXFunctions && settings.customAutoLoop
     	 	from: "s4mk3.right.fx.buttons.1";
     	 	to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".loop.set.auto_with_size"; value: settings.stemButtonLoopSize ; output: false  }
    	}
  	}
  
  
  
  
  
  //PAD TYPE SELECTORS
  
  //stems button

  Wire
  {
    enabled: PadsMode.isPadsModeSupported(settings.stemsButton , deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !(deckType == DeckType.Stem) && !module.gridAdjustEnabled;
    from: "%surface%.stems";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: settings.stemsButton; color: (settings.stemsButtonColour == 18 ? module.deckColor : S4MK3Functions.colorForDeckSingle(settings.stemsButtonColour))	}
  }
    
  Wire
  {
    enabled: PadsMode.isPadsModeSupported(settings.stemsButton , deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && shift && (deckType == DeckType.Stem) && (settings.shiftStemPads ? true : (padsMode != PadsMode.stems ? true : false )) && !(padsMode == settings.stemsButton) && !module.gridAdjustEnabled;
    from: "%surface%.stems";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: settings.stemsButton; color: (settings.stemsButtonColour == 18 ? module.deckColor : S4MK3Functions.colorForDeckSingle(settings.stemsButtonColour))	}
  }
  Wire
  {
    enabled: PadsMode.isPadsModeSupported(PadsMode.stems , deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && (deckType == DeckType.Stem) && (padsMode == settings.stemsButton) && !module.gridAdjustEnabled;
    from: "%surface%.stems";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: settings.stemsButton; color: (settings.stemsButtonColour == 18 ? module.deckColor : S4MK3Functions.colorForDeckSingle(settings.stemsButtonColour))	}
  }
  Wire
  {
    enabled: PadsMode.isPadsModeSupported(PadsMode.stems , deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && (settings.stemsButton == 0 ? true : (padsMode == PadsMode.stems ? true : !shift)) && (deckType == DeckType.Stem) && !(padsMode == settings.stemsButton) && !module.gridAdjustEnabled;
    from: "%surface%.stems";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: PadsMode.stems; color: module.deckColor  }
  }   
  
  //mute button
  
  Wire
  {
    enabled: enablePads && PadsMode.isPadsModeSupported(settings.muteButton , deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active  && !(deckType == DeckType.Remix) && !module.gridAdjustEnabled;
    from: "%surface%.mute";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: settings.muteButton;}
  }
  
  Wire
  {
    enabled: !enablePads && PadsMode.isPadsModeSupported(settings.muteButton , deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active  && !(deckType == DeckType.Remix) && module.shift && !module.gridAdjustEnabled;
    from: "%surface%.mute";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: settings.muteButton;}
  }
  
  
  //hotcues button
  
  Wire
  {
	enabled: PadsMode.isPadsModeSupported(PadsMode.hotcues, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.gridAdjustEnabled;
    from: "%surface%.hotcues";
	to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: PadsMode.hotcues; color: deckColor   }
  }
  
  //record button
  
  Wire
  {
    enabled: enablePads && PadsMode.isPadsModeSupported(settings.recordButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && (deckType != DeckType.Remix) && !module.gridAdjustEnabled;
    from: "%surface%.record";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: settings.recordButton; color: deckColor }
  } 
  
  Wire
  {
    enabled: enablePads && PadsMode.isPadsModeSupported(settings.recordButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && (deckType == DeckType.Remix) && shift && !module.gridAdjustEnabled;
    from: "%surface%.record";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: settings.recordButton; color: deckColor   }
  }
  
  Wire
  {
    enabled: !enablePads && PadsMode.isPadsModeSupported(settings.recordButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && !(deckType == DeckType.Remix) && module.active && module.shift && !module.gridAdjustEnabled;
    from: "%surface%.record";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: settings.recordButton; color: deckColor   }
  }
  
  
  //samples button
  
  Wire
  {
    enabled: enablePads && PadsMode.isPadsModeSupported(settings.samplesButton , deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !(slicerEnabled && shift) && !module.bottomRemix && !module.gridAdjustEnabled;
    from: "%surface%.samples";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: settings.samplesButton;  }
  } 
  
  Wire
  {
    enabled: enablePads && PadsMode.isPadsModeSupported(settings.samplesButton , deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && !module.shift && module.bottomRemix && !module.gridAdjustEnabled;
    from: "%surface%.samples";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: settings.samplesButton;  }
  } 
  
  Wire
  {
    enabled: enablePads && PadsMode.isPadsModeSupported(PadsMode.remix, bottomDeck.deckType) && module.shift && module.bottomRemix && settings.enableSlicerPads && !module.gridAdjustEnabled && (deckType != DeckType.Remix);
    from: "%surface%.samples";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: PadsMode.remix; color: S4MK3Functions.colorForDeck(focusedDeckIdx,deckA,deckB,deckC,deckD) }
  }
  
  Wire
  {
    enabled: enablePads && PadsMode.isPadsModeSupported(PadsMode.remix, bottomDeck.deckType) && module.bottomRemix && !settings.enableSlicerPads && !module.gridAdjustEnabled && (deckType != DeckType.Remix);
    from: "%surface%.samples";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: PadsMode.remix; color: S4MK3Functions.colorForDeck(focusedDeckIdx,deckA,deckB,deckC,deckD) }
  }
  
  Wire
  {
    enabled: !enablePads && PadsMode.isPadsModeSupported(PadsMode.remix, bottomDeck.deckType) && module.bottomRemix && !module.gridAdjustEnabled;
    from: "%surface%.samples";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: PadsMode.remix; color: S4MK3Functions.colorForDeck(focusedDeckIdx,deckA,deckB,deckC,deckD) }
  }
  
  Wire
  {
    enabled: PadsMode.isPadsModeSupported(PadsMode.remix, deckType) && !(module.showBrowser && settings.enableBrowserMode) && (deckType == DeckType.Remix) && module.active && !module.gridAdjustEnabled
    from: "%surface%.samples";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: PadsMode.remix; color: S4MK3Functions.colorForDeck(focusedDeckIdx,deckA,deckB,deckC,deckD) }
  }
  
  
  //left fx button 1

  Wire
  {
    enabled: PadsMode.isPadsModeSupported(settings.fxLeftButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && module.shift && !settings.resetFXFunctions && !module.gridAdjustEnabled;
    from: "s4mk3.left.fx.buttons.1";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: settings.fxLeftButton;}
  }
  
  Wire
  {
    enabled: PadsMode.isPadsModeSupported(settings.fxLeftButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && module.shift && !settings.resetFXFunctions && !module.gridAdjustEnabled;
    from: "s4mk3.left.fx.buttons.1";
    to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx1unit + ".type"; value: 0; output: false}
  }  
  
  
  //right fx button 1
  
  Wire
  {
    enabled: PadsMode.isPadsModeSupported(settings.fxRightButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && module.shift && !settings.resetFXFunctions && !module.gridAdjustEnabled;
    from: "s4mk3.right.fx.buttons.1";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: settings.fxRightButton;}
  }

  Wire 
  {
    enabled: PadsMode.isPadsModeSupported(settings.fxRightButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && module.shift && !settings.resetFXFunctions && !module.gridAdjustEnabled;
    from: "s4mk3.right.fx.buttons.1";
    to: SetPropertyAdapter  { path: "app.traktor.fx." + settings.fx2unit + ".type"; value: 0; output: false}
  }
  
  
  //left fx button 4
  
  Wire
  {
    enabled: PadsMode.isPadsModeSupported(PadsMode.fxBank1, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && module.shift && !settings.resetFXFunctions && !module.gridAdjustEnabled && fx1Active;
    from: "s4mk3.left.fx.buttons.4";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: PadsMode.fxBank1; color: S4MK3Functions.colorForDeck(focusedDeckIdx,deckA,deckB,deckC,deckD) }
  }
  
  Wire
  {
    enabled: PadsMode.isPadsModeSupported(PadsMode.fxBank3, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && module.shift && !settings.resetFXFunctions && !module.gridAdjustEnabled && !fx1Active;
    from: "s4mk3.left.fx.buttons.4";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: PadsMode.fxBank3; color: S4MK3Functions.colorForDeck(focusedDeckIdx,deckA,deckB,deckC,deckD) }
  }
  
  
  //right fx button 4
  
  Wire
  {
    enabled: PadsMode.isPadsModeSupported(PadsMode.fxBank2, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && module.shift && !settings.resetFXFunctions && !module.gridAdjustEnabled && fx2Active;
    from: "s4mk3.right.fx.buttons.4";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: PadsMode.fxBank2; color: S4MK3Functions.colorForDeck(focusedDeckIdx,deckA,deckB,deckC,deckD) }
  }
  
  Wire
  {
    enabled: PadsMode.isPadsModeSupported(PadsMode.fxBank4, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && module.shift && !settings.resetFXFunctions && !module.gridAdjustEnabled && !fx2Active;
    from: "s4mk3.right.fx.buttons.4";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: PadsMode.fxBank4; color: S4MK3Functions.colorForDeck(focusedDeckIdx,deckA,deckB,deckC,deckD) }
  }
  
  
  //cue button
  WiresGroup
  {
  	enabled: settings.cueButton != 0 ? true : false
  	Wire
  	{
    	enabled: module.shift && !module.gridAdjustEnabled;
    	from: "s4mk3." + side + ".cue";
   	 	to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: settings.cueButton;}
 	}
  
  	Wire
  	{
    	enabled: (padsMode == settings.cueButton) && !module.shift && !module.gridAdjustEnabled;
    	from: "s4mk3." + side + ".cue";
    	to: HoldPropertyAdapter  { path: "app.traktor.decks." + deckIdx + ".cue"; value: true;}
  	}
  
  	Wire
  	{
    	enabled: PadsMode.isPadsModeSupported(settings.cueButton, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && module.shift && !module.gridAdjustEnabled;
    	from: "s4mk3." + side + ".cue";
    	to: ButtonScriptAdapter { brightness: (padsMode == settings.cueButton) ? 1.0 : 0.0; }
  	}
  
  	Wire
  	{
    	enabled: settings.cueButton != 5 ? ((padsMode == settings.cueButton) && !module.gridAdjustEnabled) : false;
    	from: "s4mk3." + side + ".cue";
    	to: ButtonScriptAdapter { brightness: toneEnabledTimer.blink ? 1.0 : 0.0; color: toneEnabledTimer.blink ? S4MK3Functions.colorForDeckSingle(3) : S4MK3Functions.colorForDeck(focusedDeckIdx,deckA,deckB,deckC,deckD) }
  	}
  
  	Wire
  	{
    	enabled: !(padsMode == settings.cueButton) && !module.shift
    	from: "s4mk3." + side + ".cue";
    	to: ButtonScriptAdapter { brightness: 0.0; color: S4MK3Functions.colorForDeck(focusedDeckIdx,deckA,deckB,deckC,deckD); onPress: { brightness: 1.0} }
  	}
  }
  
  //Waveform Zoom
  
  MappingPropertyDescriptor
  {
    id: zoomLevel;
    path: "mapping.state." + module.deckIdx + ".zoom_level";
    type: MappingPropertyDescriptor.Integer;
    value: (9-(9*((waveformZoom+1)/2)+1.1111111111111111111111))+1
  }
  
  AppProperty { id: propWaveformZoom; path: "app.traktor.decks." + module.deckIdx + ".track.waveform_zoom"}
  property real waveformZoom: propWaveformZoom.value
  onWaveformZoomChanged: {
  	zoomLevel.value = (9 - (9 * ((waveformZoom+1)/2)+1.1111111111111111111111))+1
  }
  
  
  //SUBMODULES
  
  MappingPropertyDescriptor
  {
    id: waveZoom;
    path: "mapping.state." + module.deckIdx + ".waveZoom";
    type: MappingPropertyDescriptor.Float;
    value: waveformZoom.value
  }  

  HotcuesModule
  {
    id: hotcues
    name: "hotcues"
    shift: module.shift
    surface: module.surface
    deckIdx:  module.deckIdx
    browser:  browse.viewVal
    active: padsMode == PadsMode.hotcues && module.enablePads && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled
  }
  
  GridModule
  {
    name: "grid"
    shift: module.shift
    surface: module.surface
    zoom: module.zoomLevel.value
    propertiesPath: "mapping.state." + module.deckIdx
    deckIdx:  module.deckIdx
    active: module.enablePads && module.active && !(module.showBrowser && settings.enableBrowserMode) && module.gridAdjustEnabled
  }
  
  FavoritesModule
  {
	name: "favorites"
	shift: module.shift
	deckPropertiesPath: module.deckPropertiesPath
    surface: module.surface
    active: (module.showBrowser && settings.enableBrowserMode) && module.active
  }
  
  FreezeModule
  {
	name: "freeze"
	shift: module.shift
	deckIdx: module.deckIdx
    surface: module.surface
    active: padsMode == PadsMode.freeze && module.enablePads && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled
  }

  LoopModule
  {
	name: "loop"
	shift: module.shift
	deckIdx: module.deckIdx
    surface: module.surface
    active: padsMode == PadsMode.loop && module.enablePads && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled
  }
  
  EffectsModule1
  {
	name: "fx1"
	shift: module.shift
    surface: module.surface
    fxUnit: settings.fx1unit
    deckIdx: module.deckIdx
    active: padsMode == PadsMode.fx1 && module.enablePads && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled
  }
  
  EffectsModule2
  {
	name: "fx2"
	shift: module.shift
    surface: module.surface
    fxUnit: settings.fx2unit
    deckIdx: module.deckIdx
    active: padsMode == PadsMode.fx2 && module.enablePads && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled
  }
  
  RollModule
  {
	name: "loop"
	shift: module.shift
	deckIdx: module.deckIdx
    surface: module.surface
    active: padsMode == PadsMode.roll && module.enablePads && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled
  }

  JumpModule
  {
	name: "jump"
	shift: module.shift
	deckIdx: module.deckIdx
    surface: module.surface
    active: padsMode == PadsMode.jump && module.enablePads && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled
  }

  ToneModule
  {
  	name: "tone"
	shift: module.shift
	deckIdx: module.deckIdx
    surface: module.surface
    active: padsMode == PadsMode.tone && module.enablePads && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled
    side: module.side
  }
  
  BankModule
  {
  	name: "bank1"
	shift: module.shift
	deckIdx: module.deckIdx
    surface: module.surface
    active: padsMode == PadsMode.fxBank1 && module.enablePads && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled
  	fxBank: 1
  }
  
  BankModule
  {
  	name: "bank2"
	shift: module.shift
	deckIdx: module.deckIdx
    surface: module.surface
    active: padsMode == PadsMode.fxBank2 && module.enablePads && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled
  	fxBank: 2
  }
  
  BankModule
  {
  	name: "bank3"
	shift: module.shift
	deckIdx: module.deckIdx
    surface: module.surface
    active: padsMode == PadsMode.fxBank3 && module.enablePads && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled
  	fxBank: 3
  }
  
  BankModule
  {
  	name: "bank4"
	shift: module.shift
	deckIdx: module.deckIdx
    surface: module.surface
    active: padsMode == PadsMode.fxBank4 && module.enablePads && module.active && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled
  	fxBank: 4
  }
  
  S4MK3Stems
  {  
    id: stems
    name: "stems"
    surface: module.surface
    deckPropertiesPath: module.deckPropertiesPath
    deckIdx: module.deckIdx
    active: padsMode == PadsMode.stems && module.enablePads && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled
    shift: module.shift
  }

  S4MK3Samples
  {  
    id: samples
    name: "samples"
    shift: module.shift
    surface: module.surface
    deckPropertiesPath: module.deckPropertiesPath
    deckIdx: module.deckIdx
    active: padsMode == PadsMode.remix && module.enablePads && !(module.showBrowser && settings.enableBrowserMode) && !module.gridAdjustEnabled
  }

  S4MK3TransportButtons
  {  
    name: "transport"
    surface: module.surface
    deckIdx: module.deckIdx
    active: module.active && !gridAdjustEnabled
    propertiesPath: module.deckPropertiesPath
    shift: module.shift
    tonePads: settings.cueButton != 0 ? true : false
    isSupported: PadsMode.isPadsModeSupported(PadsMode.tone, deckType) && !(module.showBrowser && settings.enableBrowserMode) && module.active && module.shift
    isEnabled: padsMode == PadsMode.tone
  }

  S4MK3TempoControl
  {
    name: "TempoControl"
    surface: module.surface
    deckIdx: module.deckIdx
    active: module.active && !module.gridAdjustEnabled
    shift: module.shift
    canLock: jogMode.value != JogwheelMode.Turntable
  }

  S4MK3Browse
  {
	id: browse
    name: "browse"
    surface: module.surface
    deckPropertiesPath: module.deckPropertiesPath
    deckIdx: module.deckIdx
	shift: module.shift
    active: module.active && !samples.isSlotSelected && !module.isLinkedDeckEncoderInUse && !stems.isStemSelected
  }
}
