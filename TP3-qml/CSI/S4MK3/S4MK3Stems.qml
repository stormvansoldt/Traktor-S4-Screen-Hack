import CSI 1.0
import "../S4MK3/S4MK3Functions.js" as S4MK3Functions

Module
{
  id: module
  property string surface: ""
  property int deckIdx: 0
  property bool active: false
  property bool shift: false 
  property string deckPropertiesPath: ""
  property bool isStemSelected: propActiveStem.value != 0 && module.active
  
  StemDeckStreams { name: "stems"; channel: deckIdx; encoderStep: 0.025 }

  MappingPropertyDescriptor { id: propActiveStem; path: deckPropertiesPath + ".stems.active_stem"; type: MappingPropertyDescriptor.Integer; value: 0; }
  
  AppProperty { id: stem1Level; path: "app.traktor.decks." + deckIdx + ".stems.1.level" }
  AppProperty { id: stem2Level; path: "app.traktor.decks." + deckIdx + ".stems.2.level" }
  AppProperty { id: stem3Level; path: "app.traktor.decks." + deckIdx + ".stems.3.level" }
  AppProperty { id: stem4Level; path: "app.traktor.decks." + deckIdx + ".stems.4.level" }
  
  AppProperty { id: stem1Muted; path: "app.traktor.decks." + deckIdx + ".stems.1.muted" }
  AppProperty { id: stem2Muted; path: "app.traktor.decks." + deckIdx + ".stems.2.muted" }
  AppProperty { id: stem3Muted; path: "app.traktor.decks." + deckIdx + ".stems.3.muted" }
  AppProperty { id: stem4Muted; path: "app.traktor.decks." + deckIdx + ".stems.4.muted" }
  
  AppProperty { id: stem1fxOn; path: "app.traktor.decks." + deckIdx + ".stems.1.fx_send_on" }
  AppProperty { id: stem2fxOn; path: "app.traktor.decks." + deckIdx + ".stems.2.fx_send_on" }
  AppProperty { id: stem3fxOn; path: "app.traktor.decks." + deckIdx + ".stems.3.fx_send_on" }
  AppProperty { id: stem4fxOn; path: "app.traktor.decks." + deckIdx + ".stems.4.fx_send_on" }
  
  readonly property bool stem1: stem1Muted.value
  readonly property bool stem2: stem2Muted.value
  readonly property bool stem3: stem3Muted.value
  readonly property bool stem4: stem4Muted.value
  
  readonly property bool stem1Isolated: (!stem1 && stem2 && stem3 && stem4) ? true : false
  readonly property bool stem2Isolated: (stem1 && !stem2 && stem3 && stem4) ? true : false
  readonly property bool stem3Isolated: (stem1 && stem2 && !stem3 && stem4) ? true : false
  readonly property bool stem4Isolated: (stem1 && stem2 && stem3 && !stem4) ? true : false
 

  WiresGroup
  {
    enabled: active

    //----------------------- Top Pads to stem mutes -----------------------------
	
	Wire { enabled: !settings.isolateStemsOnShift; from: "%surface%.pads.1"; to: "stems.1.muted" }
    Wire { enabled: !settings.isolateStemsOnShift; from: "%surface%.pads.2"; to: "stems.2.muted" }
    Wire { enabled: !settings.isolateStemsOnShift; from: "%surface%.pads.3"; to: "stems.3.muted" }
    Wire { enabled: !settings.isolateStemsOnShift; from: "%surface%.pads.4"; to: "stems.4.muted" }
	
    
    Wire { enabled: settings.isolateStemsOnShift && !shift; from: "%surface%.pads.1"; to: "stems.1.muted" }
    Wire { enabled: settings.isolateStemsOnShift && !shift; from: "%surface%.pads.2"; to: "stems.2.muted" }
    Wire { enabled: settings.isolateStemsOnShift && !shift; from: "%surface%.pads.3"; to: "stems.3.muted" }
    Wire { enabled: settings.isolateStemsOnShift && !shift; from: "%surface%.pads.4"; to: "stems.4.muted" }
	

	
	Wire { enabled: !module.stem1Isolated && settings.isolateStemsOnShift && shift; from: "%surface%.pads.1"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.1.muted"; value: false; output: false } }
	Wire { enabled: !module.stem1Isolated && settings.isolateStemsOnShift && shift; from: "%surface%.pads.1"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.2.muted"; value: true; output: false } }
	Wire { enabled: !module.stem1Isolated && settings.isolateStemsOnShift && shift; from: "%surface%.pads.1"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.3.muted"; value: true; output: false } }
	Wire { enabled: !module.stem1Isolated && settings.isolateStemsOnShift && shift; from: "%surface%.pads.1"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.4.muted"; value: true; output: false } }
	
	Wire { enabled: module.stem1Isolated && settings.isolateStemsOnShift && shift; from: "%surface%.pads.1"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.1.muted"; value: false; output: false } }
	Wire { enabled: module.stem1Isolated && settings.isolateStemsOnShift && shift; from: "%surface%.pads.1"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.2.muted"; value: false; output: false } }
	Wire { enabled: module.stem1Isolated && settings.isolateStemsOnShift && shift; from: "%surface%.pads.1"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.3.muted"; value: false; output: false } }
	Wire { enabled: module.stem1Isolated && settings.isolateStemsOnShift && shift; from: "%surface%.pads.1"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.4.muted"; value: false; output: false } }
	
	Wire
    {
       	enabled: settings.isolateStemsOnShift && shift
		from: "%surface%.pads.1";  
       	to: ButtonScriptAdapter
      	{
       		brightness: stem1Muted.value ? 0.0 : 1.0
			color: S4MK3Functions.colorForDeckSingle(1)
       	} 
			
    }
	
	Wire { enabled: settings.isolateStemsOnShift && shift; from: "%surface%.pads.2"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.1.muted"; value: true; output: false } }
	Wire { enabled: settings.isolateStemsOnShift && shift; from: "%surface%.pads.2"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.2.muted"; value: false; output: false } }
	Wire { enabled: settings.isolateStemsOnShift && shift; from: "%surface%.pads.2"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.3.muted"; value: true; output: false } }
	Wire { enabled: settings.isolateStemsOnShift && shift; from: "%surface%.pads.2"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.4.muted"; value: true; output: false } }
	
	Wire { enabled: module.stem2Isolated && settings.isolateStemsOnShift && shift; from: "%surface%.pads.2"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.1.muted"; value: false; output: false } }
	Wire { enabled: module.stem2Isolated && settings.isolateStemsOnShift && shift; from: "%surface%.pads.2"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.2.muted"; value: false; output: false } }
	Wire { enabled: module.stem2Isolated && settings.isolateStemsOnShift && shift; from: "%surface%.pads.2"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.3.muted"; value: false; output: false } }
	Wire { enabled: module.stem2Isolated && settings.isolateStemsOnShift && shift; from: "%surface%.pads.2"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.4.muted"; value: false; output: false } }
	
		Wire
    {
       	enabled: settings.isolateStemsOnShift && shift
		from: "%surface%.pads.2";  
       	to: ButtonScriptAdapter
      	{
       		brightness: stem2Muted.value ? 0.0 : 1.0
			color: S4MK3Functions.colorForDeckSingle(13)
       	} 
			
    }
	
	Wire { enabled: settings.isolateStemsOnShift && shift; from: "%surface%.pads.3"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.1.muted"; value: true; output: false } }
	Wire { enabled: settings.isolateStemsOnShift && shift; from: "%surface%.pads.3"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.2.muted"; value: true; output: false } }
	Wire { enabled: settings.isolateStemsOnShift && shift; from: "%surface%.pads.3"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.3.muted"; value: false; output: false } }
	Wire { enabled: settings.isolateStemsOnShift && shift; from: "%surface%.pads.3"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.4.muted"; value: true; output: false } }
	
	Wire { enabled: module.stem3Isolated && settings.isolateStemsOnShift && shift; from: "%surface%.pads.3"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.1.muted"; value: false; output: false } }
	Wire { enabled: module.stem3Isolated && settings.isolateStemsOnShift && shift; from: "%surface%.pads.3"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.2.muted"; value: false; output: false } }
	Wire { enabled: module.stem3Isolated && settings.isolateStemsOnShift && shift; from: "%surface%.pads.3"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.3.muted"; value: false; output: false } }
	Wire { enabled: module.stem3Isolated && settings.isolateStemsOnShift && shift; from: "%surface%.pads.3"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.4.muted"; value: false; output: false } }
	
	Wire
    {
		enabled: settings.isolateStemsOnShift && shift
       	from: "%surface%.pads.3";  
       	to: ButtonScriptAdapter
      	{
       		brightness: stem3Muted.value ? 0.0 : 1.0
			color: S4MK3Functions.colorForDeckSingle(6)
       	} 
			
    }
	
	Wire { enabled: settings.isolateStemsOnShift && shift; from: "%surface%.pads.4"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.1.muted"; value: true; output: false } }
	Wire { enabled: settings.isolateStemsOnShift && shift; from: "%surface%.pads.4"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.2.muted"; value: true; output: false } }
	Wire { enabled: settings.isolateStemsOnShift && shift; from: "%surface%.pads.4"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.3.muted"; value: true; output: false } }
	Wire { enabled: settings.isolateStemsOnShift && shift; from: "%surface%.pads.4"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.4.muted"; value: false; output: false } }
	
	Wire { enabled: module.stem4Isolated && settings.isolateStemsOnShift && shift; from: "%surface%.pads.4"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.1.muted"; value: false; output: false } }
	Wire { enabled: module.stem4Isolated && settings.isolateStemsOnShift && shift; from: "%surface%.pads.4"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.2.muted"; value: false; output: false } }
	Wire { enabled: module.stem4Isolated && settings.isolateStemsOnShift && shift; from: "%surface%.pads.4"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.3.muted"; value: false; output: false } }
	Wire { enabled: module.stem4Isolated && settings.isolateStemsOnShift && shift; from: "%surface%.pads.4"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.4.muted"; value: false; output: false } }
	
	Wire
    {
       	enabled: settings.isolateStemsOnShift && shift
		from: "%surface%.pads.4";  
       	to: ButtonScriptAdapter
      	{
       		brightness: stem4Muted.value ? 0.0 : 1.0
			color: S4MK3Functions.colorForDeckSingle(9)
       	} 
			
    }

    //------- Loop and beatjump to focused stem's volume and filter amount -------

    WiresGroup
    {
      enabled: !module.shift && active
    
      WiresGroup
      {
        enabled: propActiveStem.value == 1
        
        Wire { from: "%surface%.loop_move";     to: "stems.1.volume_stepped" }
        Wire { from: "%surface%.loop_size";     to: "stems.1.filter_stepped" }
        Wire { from: "%surface%.browse.add_to_list"; to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".stems.1.fx_send"; step: 1/10; mode: RelativeMode.Decrement; output: false } }
        Wire { from: "%surface%.browse.view"; to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".stems.1.fx_send"; step: 1/10; mode: RelativeMode.Increment; output: false } }
        Wire { from: "%surface%.browse.preview";  to: TogglePropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".stems.1.filter_on"; output: true} }
        Wire { from: "%surface%.browse.favorite";  to: TogglePropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".stems.1.fx_send_on"; output: true} }
        
      }
      WiresGroup
      {
        enabled: propActiveStem.value == 2
        
        Wire { from: "%surface%.loop_move";     to: "stems.2.volume_stepped" }
        Wire { from: "%surface%.loop_size";     to: "stems.2.filter_stepped" }
        Wire { from: "%surface%.browse.add_to_list"; to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".stems.2.fx_send"; step: 1/10; mode: RelativeMode.Decrement; output: false } }
        Wire { from: "%surface%.browse.view"; to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".stems.2.fx_send"; step: 1/10; mode: RelativeMode.Increment; output: false } }
		Wire { from: "%surface%.browse.preview";  to: TogglePropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".stems.2.filter_on"; output: true} }
        Wire { from: "%surface%.browse.favorite";  to: TogglePropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".stems.2.fx_send_on"; output: true} }
      }
      WiresGroup
      {
        enabled: propActiveStem.value == 3
        
        Wire { from: "%surface%.loop_move";     to: "stems.3.volume_stepped" }
        Wire { from: "%surface%.loop_size";     to: "stems.3.filter_stepped" }
        Wire { from: "%surface%.browse.add_to_list"; to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".stems.3.fx_send"; step: 1/10; mode: RelativeMode.Decrement; output: false } }
        Wire { from: "%surface%.browse.view"; to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".stems.3.fx_send"; step: 1/10; mode: RelativeMode.Increment; output: false } }
		Wire { from: "%surface%.browse.preview";  to: TogglePropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".stems.3.filter_on"; output: true} }
        Wire { from: "%surface%.browse.favorite";  to: TogglePropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".stems.3.fx_send_on"; output: true} }
      }
      WiresGroup
      {
        enabled: propActiveStem.value == 4
        
        Wire { from: "%surface%.loop_move";     to: "stems.4.volume_stepped" }
        Wire { from: "%surface%.loop_size";     to: "stems.4.filter_stepped" }
        Wire { from: "%surface%.browse.add_to_list"; to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".stems.4.fx_send"; step: 1/10; mode: RelativeMode.Decrement; output: false } }
        Wire { from: "%surface%.browse.view"; to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".stems.4.fx_send"; step: 1/10; mode: RelativeMode.Increment; output: false } }
		Wire { from: "%surface%.browse.preview";  to: TogglePropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".stems.4.filter_on"; output: true} }
        Wire { from: "%surface%.browse.favorite";  to: TogglePropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".stems.4.fx_send_on"; output: true} }
      }
    }
    
    WiresGroup
      {
      	enabled: propActiveStem.value != 0;
      
      	Wire
        {
        	from: "%surface%.browse.add_to_list";  
        	to: ButtonScriptAdapter
        	{
        		onPress: 
        		{
        			brightness = 1.0
        		}
        		onRelease:
        		{
        			brightness = 0.0
        		}
        		brightness: 0.0
				color: S4MK3Functions.colorForDeckSingle(0)
        	} 
			
        }
       
        Wire
        {
        	from: "%surface%.browse.view";  
        	to: ButtonScriptAdapter
        	{
        		onPress: 
        		{
        			brightness = 1.0
        		}
        		onRelease:
        		{
        			brightness = 0.0
        		}
        		brightness: 0.0
				color: S4MK3Functions.colorForDeckSingle(6)
        	} 
			
        }     
      }

    //------------------------- Lower pads to stem focus ---------------------------

    Wire { from: "%surface%.pads.5"; to: HoldPropertyAdapter { path: deckPropertiesPath + ".stems.active_stem"; value: 1; defaultValue: 0 } }
    Wire { from: "%surface%.pads.6"; to: HoldPropertyAdapter { path: deckPropertiesPath + ".stems.active_stem"; value: 2; defaultValue: 0 } }
    Wire { from: "%surface%.pads.7"; to: HoldPropertyAdapter { path: deckPropertiesPath + ".stems.active_stem"; value: 3; defaultValue: 0 } }
    Wire { from: "%surface%.pads.8"; to: HoldPropertyAdapter { path: deckPropertiesPath + ".stems.active_stem"; value: 4; defaultValue: 0 } }
  }

}