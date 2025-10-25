import CSI 1.0
import QtQuick 2.5
import "../../Defines"
import '../../Screens/Defines' as Defines2
import "../../Screens/S4MK3/ViewModels" as ViewModels
import "../S4MK3/S4MK3Functions.js" as S4MK3Functions


Module
{
  id: module
  property bool shift: false 
  property string surface: ""
  property int deckIdx: 0
  property bool active: false
  property string deckPropertiesPath: ""
  property bool isSlotSelected: (module.active && propActiveSlot.value != 0)
  
  property int deckA: settings.deckAColour
  property int deckB: settings.deckBColour
  property int deckC: settings.deckCColour
  property int deckD: settings.deckDColour
  
  AppProperty { id: type1; path: "app.traktor.decks.1.type" }
  AppProperty { id: type2; path: "app.traktor.decks.2.type" }
  AppProperty { id: type3; path: "app.traktor.decks.3.type" }
  AppProperty { id: type4; path: "app.traktor.decks.4.type" }

  AppProperty { id: cell1; path: "app.traktor.decks." + deckIdx + ".remix.players.1.sequencer.selected_cell" }
  AppProperty { id: cell2; path: "app.traktor.decks." + deckIdx + ".remix.players.2.sequencer.selected_cell" }
  AppProperty { id: cell3; path: "app.traktor.decks." + deckIdx + ".remix.players.3.sequencer.selected_cell" }
  AppProperty { id: cell4; path: "app.traktor.decks." + deckIdx + ".remix.players.4.sequencer.selected_cell" }
  
  AppProperty { id: state1; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.1.rows." + cell1.value+1 + ".state" }
  AppProperty { id: state2; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.2.rows." + cell1.value+1 + ".state" }
  AppProperty { id: state3; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.3.rows." + cell1.value+1 + ".state" }
  AppProperty { id: state4; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.4.rows." + cell1.value+1 + ".state" }
  
  AppProperty { id: col1cell1State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.1.rows.1.state" }
  AppProperty { id: col1cell2State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.1.rows.2.state" }
  AppProperty { id: col1cell3State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.1.rows.3.state" }
  AppProperty { id: col1cell4State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.1.rows.4.state" }
  AppProperty { id: col1cell5State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.1.rows.5.state" }
  AppProperty { id: col1cell6State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.1.rows.6.state" }
  AppProperty { id: col1cell7State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.1.rows.7.state" }
  AppProperty { id: col1cell8State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.1.rows.8.state" }
  AppProperty { id: col1cell9State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.1.rows.9.state" }
  AppProperty { id: col1cell10State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.1.rows.10.state" }
  AppProperty { id: col1cell11State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.1.rows.11.state" }
  AppProperty { id: col1cell12State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.1.rows.12.state" }
  AppProperty { id: col1cell13State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.1.rows.13.state" }
  AppProperty { id: col1cell14State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.1.rows.14.state" }
  AppProperty { id: col1cell15State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.1.rows.15.state" }
  AppProperty { id: col1cell16State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.1.rows.16.state" }
  
  AppProperty { id: col2cell1State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.2.rows.1.state" }
  AppProperty { id: col2cell2State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.2.rows.2.state" }
  AppProperty { id: col2cell3State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.2.rows.3.state" }
  AppProperty { id: col2cell4State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.2.rows.4.state" }
  AppProperty { id: col2cell5State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.2.rows.5.state" }
  AppProperty { id: col2cell6State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.2.rows.6.state" }
  AppProperty { id: col2cell7State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.2.rows.7.state" }
  AppProperty { id: col2cell8State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.2.rows.8.state" }
  AppProperty { id: col2cell9State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.2.rows.9.state" }
  AppProperty { id: col2cell10State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.2.rows.10.state" }
  AppProperty { id: col2cell11State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.2.rows.11.state" }
  AppProperty { id: col2cell12State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.2.rows.12.state" }
  AppProperty { id: col2cell13State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.2.rows.13.state" }
  AppProperty { id: col2cell14State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.2.rows.14.state" }
  AppProperty { id: col2cell15State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.2.rows.15.state" }
  AppProperty { id: col2cell16State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.2.rows.16.state" }

  AppProperty { id: col3cell1State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.3.rows.1.state" }
  AppProperty { id: col3cell2State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.3.rows.2.state" }
  AppProperty { id: col3cell3State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.3.rows.3.state" }
  AppProperty { id: col3cell4State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.3.rows.4.state" }
  AppProperty { id: col3cell5State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.3.rows.5.state" }
  AppProperty { id: col3cell6State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.3.rows.6.state" }
  AppProperty { id: col3cell7State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.3.rows.7.state" }
  AppProperty { id: col3cell8State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.3.rows.8.state" }
  AppProperty { id: col3cell9State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.3.rows.9.state" }
  AppProperty { id: col3cell10State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.3.rows.10.state" }
  AppProperty { id: col3cell11State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.3.rows.11.state" }
  AppProperty { id: col3cell12State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.3.rows.12.state" }
  AppProperty { id: col3cell13State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.3.rows.13.state" }
  AppProperty { id: col3cell14State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.3.rows.14.state" }
  AppProperty { id: col3cell15State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.3.rows.15.state" }
  AppProperty { id: col3cell16State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.3.rows.16.state" }

  AppProperty { id: col4cell1State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.4.rows.1.state" }
  AppProperty { id: col4cell2State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.4.rows.2.state" }
  AppProperty { id: col4cell3State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.4.rows.3.state" }
  AppProperty { id: col4cell4State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.4.rows.4.state" }
  AppProperty { id: col4cell5State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.4.rows.5.state" }
  AppProperty { id: col4cell6State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.4.rows.6.state" }
  AppProperty { id: col4cell7State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.4.rows.7.state" }
  AppProperty { id: col4cell8State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.4.rows.8.state" }
  AppProperty { id: col4cell9State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.4.rows.9.state" }
  AppProperty { id: col4cell10State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.4.rows.10.state" }
  AppProperty { id: col4cell11State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.4.rows.11.state" }
  AppProperty { id: col4cell12State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.4.rows.12.state" }
  AppProperty { id: col4cell13State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.4.rows.13.state" }
  AppProperty { id: col4cell14State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.4.rows.14.state" }
  AppProperty { id: col4cell15State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.4.rows.15.state" }
  AppProperty { id: col4cell16State; path: "app.traktor.decks." + deckIdx + ".remix.cell.columns.4.rows.16.state" }

  AppProperty { id: recOn; path: "app.traktor.decks." + deckIdx + ".remix.sequencer.rec.on" }
  
  AppProperty { id: source; path: "app.traktor.decks." + deckIdx + ".capture_source" }



  RemixTrigger { name: "triggering"; channel: deckIdx; target: RemixTrigger.StepSequencer }
  RemixMixing { name: "mixing"; channel: deckIdx }

  MappingPropertyDescriptor { id: mute ; path: deckPropertiesPath + ".mute"; type: MappingPropertyDescriptor.Boolean; value: false}
  MappingPropertyDescriptor { id: propActiveSlot; path: deckPropertiesPath + ".active_slot"; 
                              type: MappingPropertyDescriptor.Integer; value: 0; min: 0; max: 4 }
  MappingPropertyDescriptor { id: propSampleBrowsing; path: deckPropertiesPath + ".sample_browsing";
                              type: MappingPropertyDescriptor.Boolean; value: false }
                              
  property int activeSlot: propActiveSlot.value

  Timer 
  {
    id: sample_browsing_countdown;
    interval: 500;
    onTriggered: { propSampleBrowsing.value = false; }
  }

  function playerPath(playerId)
  {
    return "app.traktor.decks." + module.deckIdx + ".remix.players." + playerId;
  }

  Wire { enabled: module.active && !module.shift; from: "%surface%.mute"; to: HoldPropertyAdapter { path: deckPropertiesPath + ".mute"; value: true; }}

  WiresGroup
  {
    enabled: module.active
    
    Wire
    {
    	enabled: module.shift
    	from: "%surface%.grid_adjust";
    	to: ButtonScriptAdapter
    	{
    		onPress:
    		{
    			source.value == 4 ? (type1.value == 0 ? source.value = 0 : type2.value == 0 ? source.value = 1 : type3.value == 0 ? source.value = 2 : type4.value == 0 ? source.value = 3 : source.value = 4) : 
    				source.value == 0 ? (type2.value == 0 ? source.value = 1 : type3.value == 0 ? source.value = 2 : type4.value == 0 ? source.value = 3 : source.value = 4) : 
    					source.value == 1 ? (type3.value == 0 ? source.value = 2 : type4.value == 0 ? source.value = 3 : source.value = 4) : 
    						source.value == 2 ? (type4.value == 0 ? source.value = 3 : source.value = 4) : 
    							source.value = 3 ? source.value = 4 : source.value = source.value;
    			brightness = 1.0;
    		}
    		onRelease:
    		{
    			brightness = 0.0;
    		}
    		brightness: 0.0;
    	}
    }

    // Mute + pad to mute column
    WiresGroup
    {
      enabled: mute.value

      Wire { from: "%surface%.pads.1"; to: "mixing.1.mute" } 
      Wire { from: "%surface%.pads.2"; to: "mixing.2.mute" }
      Wire { from: "%surface%.pads.3"; to: "mixing.3.mute" }
      Wire { from: "%surface%.pads.4"; to: "mixing.4.mute" }
    }

    WiresGroup
    {
      enabled: !mute.value


      WiresGroup
      {
        enabled: !module.shift
        
        Wire { enabled: propActiveSlot.value != 1; from: "%surface%.pads.1"; to: "triggering.1.trigger" } 
        Wire { enabled: propActiveSlot.value != 2; from: "%surface%.pads.2"; to: "triggering.2.trigger" }
        Wire { enabled: propActiveSlot.value != 3; from: "%surface%.pads.3"; to: "triggering.3.trigger" }
        Wire { enabled: propActiveSlot.value != 4; from: "%surface%.pads.4"; to: "triggering.4.trigger" }
      }

      WiresGroup
      {
        enabled: module.shift && (propActiveSlot.value == 0)
        
        Wire { from: "%surface%.pads.1"; to: "triggering.1.stop" } 
        Wire { from: "%surface%.pads.2"; to: "triggering.2.stop" }
        Wire { from: "%surface%.pads.3"; to: "triggering.3.stop" }
        Wire { from: "%surface%.pads.4"; to: "triggering.4.stop" }

        Wire { from: "%surface%.pads.1"; to: InvokeActionAdapter { path: playerPath(1) + ".sequencer.delete_pattern"; } } 
        Wire { from: "%surface%.pads.2"; to: InvokeActionAdapter { path: playerPath(2) + ".sequencer.delete_pattern"; } } 
        Wire { from: "%surface%.pads.3"; to: InvokeActionAdapter { path: playerPath(3) + ".sequencer.delete_pattern"; } } 
        Wire { from: "%surface%.pads.4"; to: InvokeActionAdapter { path: playerPath(4) + ".sequencer.delete_pattern"; } } 
      }
    }

    WiresGroup
    {
      enabled: module.shift && propActiveSlot.value == 0

      Wire { from: "%surface%.loop_size.push";  to: TogglePropertyAdapter  { path: "app.traktor.decks." + deckIdx + ".remix.quant" } }
      Wire { from: "%surface%.loop_size.turn";  to: RelativePropertyAdapter { path:"app.traktor.decks." + deckIdx + ".remix.quant_index"; mode: RelativeMode.Stepped } }
    }

    WiresGroup
    {
      

      Wire { enabled: !module.shift; from: "%surface%.record"; to: TogglePropertyAdapter  { path: "app.traktor.decks." + deckIdx + ".remix.sequencer.rec.on" } }
      Wire { enabled: !module.shift; from: "%surface%.record"; to: SetPropertyAdapter     { path: "app.traktor.decks." + deckIdx + ".remix.sequencer.on"; value: true; output: false }}

	  
     
      WiresGroup
      {
        enabled: propActiveSlot.value == 1
        
        Wire { from: "%surface%.loop_move";       to: "mixing.1.volume" }
        Wire { from: "%surface%.loop_size";       to: "mixing.1.filter" }
        Wire { from: "%surface%.browse.encoder";  to: "triggering.1.selected_cell"; enabled: propSampleBrowsing.value }
        
        Wire { enabled: cell1.value + 1 == 1; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.1.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell1.value + 1 == 2; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.2.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell1.value + 1 == 3; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.3.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell1.value + 1 == 4; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.4.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell1.value + 1 == 5; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.5.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell1.value + 1 == 6; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.6.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell1.value + 1 == 7; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.7.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell1.value + 1 == 8; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.8.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell1.value + 1 == 9; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.9.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell1.value + 1 == 10; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.10.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell1.value + 1 == 11; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.11.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell1.value + 1 == 12; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.12.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell1.value + 1 == 13; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.13.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell1.value + 1 == 14; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.14.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell1.value + 1 == 15; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.15.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell1.value + 1 == 16; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.16.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }

        Wire { enabled: cell1.value + 1 == 1; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.1.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell1.value + 1 == 2; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.2.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell1.value + 1 == 3; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.3.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell1.value + 1 == 4; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.4.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell1.value + 1 == 5; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.5.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell1.value + 1 == 6; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.6.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell1.value + 1 == 7; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.7.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell1.value + 1 == 8; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.8.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell1.value + 1 == 9; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.9.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell1.value + 1 == 10; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.10.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell1.value + 1 == 11; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.11.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell1.value + 1 == 12; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.12.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell1.value + 1 == 13; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.13.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell1.value + 1 == 14; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.14.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell1.value + 1 == 15; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.15.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell1.value + 1 == 16; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.16.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
		
		Wire { enabled: cell1.value + 1 == 1; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.1.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell1.value + 1 == 2; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.2.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell1.value + 1 == 3; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.3.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell1.value + 1 == 4; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.4.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell1.value + 1 == 5; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.5.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell1.value + 1 == 6; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.6.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell1.value + 1 == 7; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.7.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell1.value + 1 == 8; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.8.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell1.value + 1 == 9; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.9.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell1.value + 1 == 10; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.10.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell1.value + 1 == 11; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.11.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell1.value + 1 == 12; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.12.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell1.value + 1 == 13; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.13.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell1.value + 1 == 14; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.14.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell1.value + 1 == 15; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.15.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell1.value + 1 == 16; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.16.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }

		Wire { enabled: cell1.value + 1 == 1; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.1.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell1.value + 1 == 2; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.2.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell1.value + 1 == 3; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.3.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell1.value + 1 == 4; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.4.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell1.value + 1 == 5; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.5.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell1.value + 1 == 6; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.6.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell1.value + 1 == 7; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.7.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell1.value + 1 == 8; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.8.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell1.value + 1 == 9; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.9.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell1.value + 1 == 10; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.10.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell1.value + 1 == 11; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.11.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell1.value + 1 == 12; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.12.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell1.value + 1 == 13; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.13.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell1.value + 1 == 14; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.14.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell1.value + 1 == 15; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.15.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell1.value + 1 == 16; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.16.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }

		WiresGroup
		{
			enabled: !module.shift
		
			Wire { enabled: ((cell1.value + 1 == 1) && (col1cell1State.value == 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.1.capture"; } }
			Wire { enabled: ((cell1.value + 1 == 2) && (col1cell2State.value == 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.2.capture"; } }
			Wire { enabled: ((cell1.value + 1 == 3) && (col1cell3State.value == 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.3.capture"; } }
			Wire { enabled: ((cell1.value + 1 == 4) && (col1cell4State.value == 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.4.capture"; } }
			Wire { enabled: ((cell1.value + 1 == 5) && (col1cell5State.value == 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.5.capture"; } }
			Wire { enabled: ((cell1.value + 1 == 6) && (col1cell6State.value == 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.6.capture"; } }
			Wire { enabled: ((cell1.value + 1 == 7) && (col1cell7State.value == 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.7.capture"; } }
			Wire { enabled: ((cell1.value + 1 == 8) && (col1cell8State.value == 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.8.capture"; } }
			Wire { enabled: ((cell1.value + 1 == 9) && (col1cell9State.value == 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.9.capture"; } }
			Wire { enabled: ((cell1.value + 1 == 10) && (col1cell10State.value == 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.10.capture"; } }
			Wire { enabled: ((cell1.value + 1 == 11) && (col1cell11State.value == 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.11.capture"; } }
			Wire { enabled: ((cell1.value + 1 == 12) && (col1cell12State.value == 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.12.capture"; } }
			Wire { enabled: ((cell1.value + 1 == 13) && (col1cell13State.value == 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.13.capture"; } }
			Wire { enabled: ((cell1.value + 1 == 14) && (col1cell14State.value == 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.14.capture"; } }
			Wire { enabled: ((cell1.value + 1 == 15) && (col1cell15State.value == 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.15.capture"; } }
			Wire { enabled: ((cell1.value + 1 == 16) && (col1cell16State.value == 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.16.capture"; } }
		
			Wire { enabled: ((cell1.value + 1 == 1) && (col1cell1State.value != 0)); from: "%surface%.pads.1"; to: "triggering.1.trigger" } 
			Wire { enabled: ((cell1.value + 1 == 2) && (col1cell2State.value != 0)); from: "%surface%.pads.1"; to: "triggering.1.trigger" } 
			Wire { enabled: ((cell1.value + 1 == 3) && (col1cell3State.value != 0)); from: "%surface%.pads.1"; to: "triggering.1.trigger" } 
			Wire { enabled: ((cell1.value + 1 == 4) && (col1cell4State.value != 0)); from: "%surface%.pads.1"; to: "triggering.1.trigger" } 
			Wire { enabled: ((cell1.value + 1 == 5) && (col1cell5State.value != 0)); from: "%surface%.pads.1"; to: "triggering.1.trigger" } 
			Wire { enabled: ((cell1.value + 1 == 6) && (col1cell6State.value != 0)); from: "%surface%.pads.1"; to: "triggering.1.trigger" } 
			Wire { enabled: ((cell1.value + 1 == 7) && (col1cell7State.value != 0)); from: "%surface%.pads.1"; to: "triggering.1.trigger" } 
			Wire { enabled: ((cell1.value + 1 == 8) && (col1cell8State.value != 0)); from: "%surface%.pads.1"; to: "triggering.1.trigger" } 
			Wire { enabled: ((cell1.value + 1 == 9) && (col1cell9State.value != 0)); from: "%surface%.pads.1"; to: "triggering.1.trigger" } 
			Wire { enabled: ((cell1.value + 1 == 10) && (col1cell10State.value != 0)); from: "%surface%.pads.1"; to: "triggering.1.trigger" } 
			Wire { enabled: ((cell1.value + 1 == 11) && (col1cell11State.value != 0)); from: "%surface%.pads.1"; to: "triggering.1.trigger" } 
			Wire { enabled: ((cell1.value + 1 == 12) && (col1cell12State.value != 0)); from: "%surface%.pads.1"; to: "triggering.1.trigger" } 
			Wire { enabled: ((cell1.value + 1 == 13) && (col1cell13State.value != 0)); from: "%surface%.pads.1"; to: "triggering.1.trigger" } 
			Wire { enabled: ((cell1.value + 1 == 14) && (col1cell14State.value != 0)); from: "%surface%.pads.1"; to: "triggering.1.trigger" } 
			Wire { enabled: ((cell1.value + 1 == 15) && (col1cell15State.value != 0)); from: "%surface%.pads.1"; to: "triggering.1.trigger" } 
			Wire { enabled: ((cell1.value + 1 == 16) && (col1cell16State.value != 0)); from: "%surface%.pads.1"; to: "triggering.1.trigger" } 

		}
		
		WiresGroup
		{
			enabled: module.shift
		
			Wire { enabled: ((cell1.value + 1 == 1) && (col1cell1State.value != 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.1.delete"; } }
			Wire { enabled: ((cell1.value + 1 == 2) && (col1cell2State.value != 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.2.delete"; } }
			Wire { enabled: ((cell1.value + 1 == 3) && (col1cell3State.value != 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.3.delete"; } }
			Wire { enabled: ((cell1.value + 1 == 4) && (col1cell4State.value != 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.4.delete"; } }
			Wire { enabled: ((cell1.value + 1 == 5) && (col1cell5State.value != 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.5.delete"; } }
			Wire { enabled: ((cell1.value + 1 == 6) && (col1cell6State.value != 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.6.delete"; } }
			Wire { enabled: ((cell1.value + 1 == 7) && (col1cell7State.value != 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.7.delete"; } }
			Wire { enabled: ((cell1.value + 1 == 8) && (col1cell8State.value != 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.8.delete"; } }
			Wire { enabled: ((cell1.value + 1 == 9) && (col1cell9State.value != 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.9.delete"; } }
			Wire { enabled: ((cell1.value + 1 == 10) && (col1cell10State.value != 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.10.delete"; } }
			Wire { enabled: ((cell1.value + 1 == 11) && (col1cell11State.value != 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.11.delete"; } }
			Wire { enabled: ((cell1.value + 1 == 12) && (col1cell12State.value != 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.12.delete"; } }
			Wire { enabled: ((cell1.value + 1 == 13) && (col1cell13State.value != 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.13.delete"; } }
			Wire { enabled: ((cell1.value + 1 == 14) && (col1cell14State.value != 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.14.delete"; } }
			Wire { enabled: ((cell1.value + 1 == 15) && (col1cell15State.value != 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.15.delete"; } }
			Wire { enabled: ((cell1.value + 1 == 16) && (col1cell16State.value != 0)); from: "%surface%.pads.1";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.1.rows.16.delete"; } }
			
		}
        
        Wire { from: "%surface%.browse.preview";  to: TogglePropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".remix.players.1.key_lock"; output: true} }
        Wire { from: "%surface%.browse.favorite";  to: TogglePropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".remix.players.1.fx_send_on"; output: true} }
        
        
      }

      WiresGroup
      {
        enabled: propActiveSlot.value == 2
        
        Wire { from: "%surface%.loop_move";       to: "mixing.2.volume" }
        Wire { from: "%surface%.loop_size";       to: "mixing.2.filter" }
        Wire { from: "%surface%.browse.encoder";  to: "triggering.2.selected_cell"; enabled: propSampleBrowsing.value }
        
        Wire { enabled: cell2.value + 1 == 1; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.1.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell2.value + 1 == 2; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.2.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell2.value + 1 == 3; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.3.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell2.value + 1 == 4; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.4.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell2.value + 1 == 5; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.5.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell2.value + 1 == 6; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.6.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell2.value + 1 == 7; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.7.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell2.value + 1 == 8; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.8.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell2.value + 1 == 9; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.9.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell2.value + 1 == 10; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.10.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell2.value + 1 == 11; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.11.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell2.value + 1 == 12; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.12.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell2.value + 1 == 13; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.13.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell2.value + 1 == 14; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.14.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell2.value + 1 == 15; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.15.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell2.value + 1 == 16; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.16.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }

        Wire { enabled: cell2.value + 1 == 1; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.1.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell2.value + 1 == 2; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.2.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell2.value + 1 == 3; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.3.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell2.value + 1 == 4; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.4.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell2.value + 1 == 5; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.5.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell2.value + 1 == 6; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.6.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell2.value + 1 == 7; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.7.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell2.value + 1 == 8; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.8.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell2.value + 1 == 9; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.9.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell2.value + 1 == 10; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.10.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell2.value + 1 == 11; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.11.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell2.value + 1 == 12; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.12.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell2.value + 1 == 13; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.13.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell2.value + 1 == 14; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.14.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell2.value + 1 == 15; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.15.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell2.value + 1 == 16; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.16.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }

		Wire { enabled: cell2.value + 1 == 1; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.1.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell2.value + 1 == 2; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.2.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell2.value + 1 == 3; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.3.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell2.value + 1 == 4; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.4.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell2.value + 1 == 5; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.5.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell2.value + 1 == 6; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.6.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell2.value + 1 == 7; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.7.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell2.value + 1 == 8; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.8.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell2.value + 1 == 9; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.9.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell2.value + 1 == 10; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.10.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell2.value + 1 == 11; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.11.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell2.value + 1 == 12; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.12.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell2.value + 1 == 13; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.13.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell2.value + 1 == 14; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.14.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell2.value + 1 == 15; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.15.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell2.value + 1 == 16; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.16.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }

		Wire { enabled: cell2.value + 1 == 1; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.1.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell2.value + 1 == 2; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.2.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell2.value + 1 == 3; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.3.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell2.value + 1 == 4; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.4.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell2.value + 1 == 5; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.5.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell2.value + 1 == 6; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.6.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell2.value + 1 == 7; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.7.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell2.value + 1 == 8; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.8.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell2.value + 1 == 9; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.9.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell2.value + 1 == 10; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.10.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell2.value + 1 == 11; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.11.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell2.value + 1 == 12; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.12.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell2.value + 1 == 13; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.13.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell2.value + 1 == 14; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.14.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell2.value + 1 == 15; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.15.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell2.value + 1 == 16; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.16.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }

		
		WiresGroup
		{
			enabled: !module.shift
		
			Wire { enabled: ((cell2.value + 1 == 1) && (col2cell1State.value == 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.1.capture"; } }
			Wire { enabled: ((cell2.value + 1 == 2) && (col2cell2State.value == 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.2.capture"; } }
			Wire { enabled: ((cell2.value + 1 == 3) && (col2cell3State.value == 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.3.capture"; } }
			Wire { enabled: ((cell2.value + 1 == 4) && (col2cell4State.value == 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.4.capture"; } }
			Wire { enabled: ((cell2.value + 1 == 5) && (col2cell5State.value == 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.5.capture"; } }
			Wire { enabled: ((cell2.value + 1 == 6) && (col2cell6State.value == 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.6.capture"; } }
			Wire { enabled: ((cell2.value + 1 == 7) && (col2cell7State.value == 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.7.capture"; } }
			Wire { enabled: ((cell2.value + 1 == 8) && (col2cell8State.value == 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.8.capture"; } }
			Wire { enabled: ((cell2.value + 1 == 9) && (col2cell9State.value == 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.9.capture"; } }
			Wire { enabled: ((cell2.value + 1 == 10) && (col2cell10State.value == 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.10.capture"; } }
			Wire { enabled: ((cell2.value + 1 == 11) && (col2cell11State.value == 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.11.capture"; } }
			Wire { enabled: ((cell2.value + 1 == 12) && (col2cell12State.value == 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.12.capture"; } }
			Wire { enabled: ((cell2.value + 1 == 13) && (col2cell13State.value == 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.13.capture"; } }
			Wire { enabled: ((cell2.value + 1 == 14) && (col2cell14State.value == 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.14.capture"; } }
			Wire { enabled: ((cell2.value + 1 == 15) && (col2cell15State.value == 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.15.capture"; } }
			Wire { enabled: ((cell2.value + 1 == 16) && (col2cell16State.value == 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.16.capture"; } }
		
			Wire { enabled: ((cell2.value + 1 == 1) && (col2cell1State.value != 0)); from: "%surface%.pads.2"; to: "triggering.2.trigger" } 
			Wire { enabled: ((cell2.value + 1 == 2) && (col2cell2State.value != 0)); from: "%surface%.pads.2"; to: "triggering.2.trigger" } 
			Wire { enabled: ((cell2.value + 1 == 3) && (col2cell3State.value != 0)); from: "%surface%.pads.2"; to: "triggering.2.trigger" } 
			Wire { enabled: ((cell2.value + 1 == 4) && (col2cell4State.value != 0)); from: "%surface%.pads.2"; to: "triggering.2.trigger" } 
			Wire { enabled: ((cell2.value + 1 == 5) && (col2cell5State.value != 0)); from: "%surface%.pads.2"; to: "triggering.2.trigger" } 
			Wire { enabled: ((cell2.value + 1 == 6) && (col2cell6State.value != 0)); from: "%surface%.pads.2"; to: "triggering.2.trigger" } 
			Wire { enabled: ((cell2.value + 1 == 7) && (col2cell7State.value != 0)); from: "%surface%.pads.2"; to: "triggering.2.trigger" } 
			Wire { enabled: ((cell2.value + 1 == 8) && (col2cell8State.value != 0)); from: "%surface%.pads.2"; to: "triggering.2.trigger" } 
			Wire { enabled: ((cell2.value + 1 == 9) && (col2cell9State.value != 0)); from: "%surface%.pads.2"; to: "triggering.2.trigger" } 
			Wire { enabled: ((cell2.value + 1 == 10) && (col2cell10State.value != 0)); from: "%surface%.pads.2"; to: "triggering.2.trigger" } 
			Wire { enabled: ((cell2.value + 1 == 11) && (col2cell11State.value != 0)); from: "%surface%.pads.2"; to: "triggering.2.trigger" } 
			Wire { enabled: ((cell2.value + 1 == 12) && (col2cell12State.value != 0)); from: "%surface%.pads.2"; to: "triggering.2.trigger" } 
			Wire { enabled: ((cell2.value + 1 == 13) && (col2cell13State.value != 0)); from: "%surface%.pads.2"; to: "triggering.2.trigger" } 
			Wire { enabled: ((cell2.value + 1 == 14) && (col2cell14State.value != 0)); from: "%surface%.pads.2"; to: "triggering.2.trigger" } 
			Wire { enabled: ((cell2.value + 1 == 15) && (col2cell15State.value != 0)); from: "%surface%.pads.2"; to: "triggering.2.trigger" } 
			Wire { enabled: ((cell2.value + 1 == 16) && (col2cell16State.value != 0)); from: "%surface%.pads.2"; to: "triggering.2.trigger" } 

		}
		
		WiresGroup
		{
			enabled: module.shift
		
			Wire { enabled: ((cell2.value + 1 == 1) && (col2cell1State.value != 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.1.delete"; } }
			Wire { enabled: ((cell2.value + 1 == 2) && (col2cell2State.value != 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.2.delete"; } }
			Wire { enabled: ((cell2.value + 1 == 3) && (col2cell3State.value != 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.3.delete"; } }
			Wire { enabled: ((cell2.value + 1 == 4) && (col2cell4State.value != 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.4.delete"; } }
			Wire { enabled: ((cell2.value + 1 == 5) && (col2cell5State.value != 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.5.delete"; } }
			Wire { enabled: ((cell2.value + 1 == 6) && (col2cell6State.value != 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.6.delete"; } }
			Wire { enabled: ((cell2.value + 1 == 7) && (col2cell7State.value != 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.7.delete"; } }
			Wire { enabled: ((cell2.value + 1 == 8) && (col2cell8State.value != 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.8.delete"; } }
			Wire { enabled: ((cell2.value + 1 == 9) && (col2cell9State.value != 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.9.delete"; } }
			Wire { enabled: ((cell2.value + 1 == 10) && (col2cell10State.value != 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.10.delete"; } }
			Wire { enabled: ((cell2.value + 1 == 11) && (col2cell11State.value != 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.11.delete"; } }
			Wire { enabled: ((cell2.value + 1 == 12) && (col2cell12State.value != 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.12.delete"; } }
			Wire { enabled: ((cell2.value + 1 == 13) && (col2cell13State.value != 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.13.delete"; } }
			Wire { enabled: ((cell2.value + 1 == 14) && (col2cell14State.value != 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.14.delete"; } }
			Wire { enabled: ((cell2.value + 1 == 15) && (col2cell15State.value != 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.15.delete"; } }
			Wire { enabled: ((cell2.value + 1 == 16) && (col2cell16State.value != 0)); from: "%surface%.pads.2";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.2.rows.16.delete"; } }
			
		}

        Wire { from: "%surface%.browse.preview";  to: TogglePropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".remix.players.2.key_lock"; output: true} }
        Wire { from: "%surface%.browse.favorite";  to: TogglePropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".remix.players.2.fx_send_on"; output: true} }
        
      }

      WiresGroup
      {
        enabled: propActiveSlot.value == 3
        
        Wire { from: "%surface%.loop_move";       to: "mixing.3.volume" }
        Wire { from: "%surface%.loop_size";       to: "mixing.3.filter" }
        Wire { from: "%surface%.browse.encoder";  to: "triggering.3.selected_cell"; enabled: propSampleBrowsing.value }
        
        Wire { enabled: cell3.value + 1 == 1; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.1.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell3.value + 1 == 2; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.2.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell3.value + 1 == 3; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.3.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell3.value + 1 == 4; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.4.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell3.value + 1 == 5; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.5.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell3.value + 1 == 6; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.6.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell3.value + 1 == 7; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.7.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell3.value + 1 == 8; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.8.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell3.value + 1 == 9; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.9.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell3.value + 1 == 10; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.10.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell3.value + 1 == 11; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.11.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell3.value + 1 == 12; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.12.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell3.value + 1 == 13; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.13.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell3.value + 1 == 14; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.14.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell3.value + 1 == 15; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.15.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell3.value + 1 == 16; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.16.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }

        Wire { enabled: cell3.value + 1 == 1; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.1.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell3.value + 1 == 2; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.2.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell3.value + 1 == 3; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.3.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell3.value + 1 == 4; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.4.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell3.value + 1 == 5; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.5.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell3.value + 1 == 6; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.6.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell3.value + 1 == 7; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.7.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell3.value + 1 == 8; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.8.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell3.value + 1 == 9; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.9.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell3.value + 1 == 10; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.10.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell3.value + 1 == 11; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.11.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell3.value + 1 == 12; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.12.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell3.value + 1 == 13; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.13.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell3.value + 1 == 14; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.14.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell3.value + 1 == 15; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.15.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell3.value + 1 == 16; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.16.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }

		Wire { enabled: cell3.value + 1 == 1; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.1.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell3.value + 1 == 2; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.2.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell3.value + 1 == 3; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.3.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell3.value + 1 == 4; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.4.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell3.value + 1 == 5; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.5.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell3.value + 1 == 6; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.6.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell3.value + 1 == 7; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.7.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell3.value + 1 == 8; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.8.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell3.value + 1 == 9; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.9.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell3.value + 1 == 10; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.10.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell3.value + 1 == 11; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.11.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell3.value + 1 == 12; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.12.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell3.value + 1 == 13; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.13.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell3.value + 1 == 14; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.14.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell3.value + 1 == 15; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.15.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell3.value + 1 == 16; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.16.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }

		Wire { enabled: cell3.value + 1 == 1; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.1.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell3.value + 1 == 2; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.2.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell3.value + 1 == 3; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.3.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell3.value + 1 == 4; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.4.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell3.value + 1 == 5; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.5.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell3.value + 1 == 6; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.6.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell3.value + 1 == 7; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.7.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell3.value + 1 == 8; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.8.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell3.value + 1 == 9; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.9.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell3.value + 1 == 10; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.10.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell3.value + 1 == 11; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.11.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell3.value + 1 == 12; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.12.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell3.value + 1 == 13; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.13.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell3.value + 1 == 14; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.14.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell3.value + 1 == 15; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.15.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell3.value + 1 == 16; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.16.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }


		WiresGroup
		{
			enabled: !module.shift
		
			Wire { enabled: ((cell3.value + 1 == 1) && (col3cell1State.value == 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.1.capture"; } }
			Wire { enabled: ((cell3.value + 1 == 2) && (col3cell2State.value == 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.2.capture"; } }
			Wire { enabled: ((cell3.value + 1 == 3) && (col3cell3State.value == 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.3.capture"; } }
			Wire { enabled: ((cell3.value + 1 == 4) && (col3cell4State.value == 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.4.capture"; } }
			Wire { enabled: ((cell3.value + 1 == 5) && (col3cell5State.value == 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.5.capture"; } }
			Wire { enabled: ((cell3.value + 1 == 6) && (col3cell6State.value == 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.6.capture"; } }
			Wire { enabled: ((cell3.value + 1 == 7) && (col3cell7State.value == 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.7.capture"; } }
			Wire { enabled: ((cell3.value + 1 == 8) && (col3cell8State.value == 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.8.capture"; } }
			Wire { enabled: ((cell3.value + 1 == 9) && (col3cell9State.value == 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.9.capture"; } }
			Wire { enabled: ((cell3.value + 1 == 10) && (col3cell10State.value == 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.10.capture"; } }
			Wire { enabled: ((cell3.value + 1 == 11) && (col3cell11State.value == 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.11.capture"; } }
			Wire { enabled: ((cell3.value + 1 == 12) && (col3cell12State.value == 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.12.capture"; } }
			Wire { enabled: ((cell3.value + 1 == 13) && (col3cell13State.value == 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.13.capture"; } }
			Wire { enabled: ((cell3.value + 1 == 14) && (col3cell14State.value == 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.14.capture"; } }
			Wire { enabled: ((cell3.value + 1 == 15) && (col3cell15State.value == 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.15.capture"; } }
			Wire { enabled: ((cell3.value + 1 == 16) && (col3cell16State.value == 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.16.capture"; } }

			Wire { enabled: ((cell3.value + 1 == 1) && (col3cell1State.value != 0)); from: "%surface%.pads.3"; to: "triggering.3.trigger" } 
			Wire { enabled: ((cell3.value + 1 == 2) && (col3cell2State.value != 0)); from: "%surface%.pads.3"; to: "triggering.3.trigger" } 
			Wire { enabled: ((cell3.value + 1 == 3) && (col3cell3State.value != 0)); from: "%surface%.pads.3"; to: "triggering.3.trigger" } 
			Wire { enabled: ((cell3.value + 1 == 4) && (col3cell4State.value != 0)); from: "%surface%.pads.3"; to: "triggering.3.trigger" } 
			Wire { enabled: ((cell3.value + 1 == 5) && (col3cell5State.value != 0)); from: "%surface%.pads.3"; to: "triggering.3.trigger" } 
			Wire { enabled: ((cell3.value + 1 == 6) && (col3cell6State.value != 0)); from: "%surface%.pads.3"; to: "triggering.3.trigger" } 
			Wire { enabled: ((cell3.value + 1 == 7) && (col3cell7State.value != 0)); from: "%surface%.pads.3"; to: "triggering.3.trigger" } 
			Wire { enabled: ((cell3.value + 1 == 8) && (col3cell8State.value != 0)); from: "%surface%.pads.3"; to: "triggering.3.trigger" } 
			Wire { enabled: ((cell3.value + 1 == 9) && (col3cell9State.value != 0)); from: "%surface%.pads.3"; to: "triggering.3.trigger" } 
			Wire { enabled: ((cell3.value + 1 == 10) && (col3cell10State.value != 0)); from: "%surface%.pads.3"; to: "triggering.3.trigger" } 
			Wire { enabled: ((cell3.value + 1 == 11) && (col3cell11State.value != 0)); from: "%surface%.pads.3"; to: "triggering.3.trigger" } 
			Wire { enabled: ((cell3.value + 1 == 12) && (col3cell12State.value != 0)); from: "%surface%.pads.3"; to: "triggering.3.trigger" } 
			Wire { enabled: ((cell3.value + 1 == 13) && (col3cell13State.value != 0)); from: "%surface%.pads.3"; to: "triggering.3.trigger" } 
			Wire { enabled: ((cell3.value + 1 == 14) && (col3cell14State.value != 0)); from: "%surface%.pads.3"; to: "triggering.3.trigger" } 
			Wire { enabled: ((cell3.value + 1 == 15) && (col3cell15State.value != 0)); from: "%surface%.pads.3"; to: "triggering.3.trigger" } 
			Wire { enabled: ((cell3.value + 1 == 16) && (col3cell16State.value != 0)); from: "%surface%.pads.3"; to: "triggering.3.trigger" } 

		}
		
		WiresGroup
		{
			enabled: module.shift
		
			Wire { enabled: ((cell3.value + 1 == 1) && (col3cell1State.value != 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.1.delete"; } }
			Wire { enabled: ((cell3.value + 1 == 2) && (col3cell2State.value != 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.2.delete"; } }
			Wire { enabled: ((cell3.value + 1 == 3) && (col3cell3State.value != 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.3.delete"; } }
			Wire { enabled: ((cell3.value + 1 == 4) && (col3cell4State.value != 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.4.delete"; } }
			Wire { enabled: ((cell3.value + 1 == 5) && (col3cell5State.value != 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.5.delete"; } }
			Wire { enabled: ((cell3.value + 1 == 6) && (col3cell6State.value != 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.6.delete"; } }
			Wire { enabled: ((cell3.value + 1 == 7) && (col3cell7State.value != 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.7.delete"; } }
			Wire { enabled: ((cell3.value + 1 == 8) && (col3cell8State.value != 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.8.delete"; } }
			Wire { enabled: ((cell3.value + 1 == 9) && (col3cell9State.value != 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.9.delete"; } }
			Wire { enabled: ((cell3.value + 1 == 10) && (col3cell10State.value != 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.10.delete"; } }
			Wire { enabled: ((cell3.value + 1 == 11) && (col3cell11State.value != 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.11.delete"; } }
			Wire { enabled: ((cell3.value + 1 == 12) && (col3cell12State.value != 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.12.delete"; } }
			Wire { enabled: ((cell3.value + 1 == 13) && (col3cell13State.value != 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.13.delete"; } }
			Wire { enabled: ((cell3.value + 1 == 14) && (col3cell14State.value != 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.14.delete"; } }
			Wire { enabled: ((cell3.value + 1 == 15) && (col3cell15State.value != 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.15.delete"; } }
			Wire { enabled: ((cell3.value + 1 == 16) && (col3cell16State.value != 0)); from: "%surface%.pads.3";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.3.rows.16.delete"; } }
		
		}
        
        Wire { from: "%surface%.browse.preview";  to: TogglePropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".remix.players.3.key_lock"; output: true} }
        Wire { from: "%surface%.browse.favorite";  to: TogglePropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".remix.players.3.fx_send_on"; output: true} }
        
      }

      WiresGroup
      {
        enabled: propActiveSlot.value == 4
        
        Wire { from: "%surface%.loop_move";       to: "mixing.4.volume" }
        Wire { from: "%surface%.loop_size";       to: "mixing.4.filter" }
        Wire { from: "%surface%.browse.encoder";  to: "triggering.4.selected_cell"; enabled: propSampleBrowsing.value }
        
        Wire { enabled: cell4.value + 1 == 1; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.1.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell4.value + 1 == 2; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.2.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell4.value + 1 == 3; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.3.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell4.value + 1 == 4; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.4.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell4.value + 1 == 5; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.5.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell4.value + 1 == 6; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.6.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell4.value + 1 == 7; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.7.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell4.value + 1 == 8; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.8.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell4.value + 1 == 9; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.9.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell4.value + 1 == 10; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.10.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell4.value + 1 == 11; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.11.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell4.value + 1 == 12; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.12.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell4.value + 1 == 13; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.13.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell4.value + 1 == 14; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.14.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell4.value + 1 == 15; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.15.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }
        Wire { enabled: cell4.value + 1 == 16; from: "%surface%.browse.add_to_list";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.16.pitch"; step: 1/12; mode: RelativeMode.Decrement; output: false } }

        Wire { enabled: cell4.value + 1 == 1; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.1.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell4.value + 1 == 2; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.2.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell4.value + 1 == 3; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.3.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell4.value + 1 == 4; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.4.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell4.value + 1 == 5; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.5.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell4.value + 1 == 6; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.6.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell4.value + 1 == 7; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.7.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell4.value + 1 == 8; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.8.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell4.value + 1 == 9; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.9.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell4.value + 1 == 10; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.10.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell4.value + 1 == 11; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.11.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell4.value + 1 == 12; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.12.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell4.value + 1 == 13; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.13.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell4.value + 1 == 14; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.14.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell4.value + 1 == 15; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.15.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }
        Wire { enabled: cell4.value + 1 == 16; from: "%surface%.browse.view";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.16.pitch"; step: 1/12; mode: RelativeMode.Increment; output: false } }

		Wire { enabled: cell4.value + 1 == 1; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.1.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell4.value + 1 == 2; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.2.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell4.value + 1 == 3; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.3.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell4.value + 1 == 4; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.4.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell4.value + 1 == 5; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.5.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell4.value + 1 == 6; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.6.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell4.value + 1 == 7; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.7.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell4.value + 1 == 8; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.8.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell4.value + 1 == 9; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.9.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell4.value + 1 == 10; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.10.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell4.value + 1 == 11; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.11.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell4.value + 1 == 12; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.12.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell4.value + 1 == 13; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.13.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell4.value + 1 == 14; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.14.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell4.value + 1 == 15; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.15.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }
		Wire { enabled: cell4.value + 1 == 16; from: "%surface%.top_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.16.gain"; step: 1/24; mode: RelativeMode.Decrement; output: false } }

		Wire { enabled: cell4.value + 1 == 1; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.1.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell4.value + 1 == 2; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.2.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell4.value + 1 == 3; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.3.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell4.value + 1 == 4; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.4.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell4.value + 1 == 5; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.5.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell4.value + 1 == 6; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.6.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell4.value + 1 == 7; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.7.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell4.value + 1 == 8; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.8.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell4.value + 1 == 9; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.9.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell4.value + 1 == 10; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.10.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell4.value + 1 == 11; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.11.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell4.value + 1 == 12; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.12.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell4.value + 1 == 13; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.13.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell4.value + 1 == 14; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.14.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell4.value + 1 == 15; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.15.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }
		Wire { enabled: cell4.value + 1 == 16; from: "%surface%.bottom_deck";  to: RelativePropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.16.gain"; step: 1/24; mode: RelativeMode.Increment; output: false } }


		WiresGroup
		{
			enabled: !module.shift
		
			Wire { enabled: ((cell4.value + 1 == 1) && (col4cell1State.value == 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.1.capture"; } }
			Wire { enabled: ((cell4.value + 1 == 2) && (col4cell2State.value == 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.2.capture"; } }
			Wire { enabled: ((cell4.value + 1 == 3) && (col4cell3State.value == 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.3.capture"; } }
			Wire { enabled: ((cell4.value + 1 == 4) && (col4cell4State.value == 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.4.capture"; } }
			Wire { enabled: ((cell4.value + 1 == 5) && (col4cell5State.value == 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.5.capture"; } }
			Wire { enabled: ((cell4.value + 1 == 6) && (col4cell6State.value == 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.6.capture"; } }
			Wire { enabled: ((cell4.value + 1 == 7) && (col4cell7State.value == 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.7.capture"; } }
			Wire { enabled: ((cell4.value + 1 == 8) && (col4cell8State.value == 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.8.capture"; } }
			Wire { enabled: ((cell4.value + 1 == 9) && (col4cell9State.value == 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.9.capture"; } }
			Wire { enabled: ((cell4.value + 1 == 10) && (col4cell10State.value == 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.10.capture"; } }
			Wire { enabled: ((cell4.value + 1 == 11) && (col4cell11State.value == 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.11.capture"; } }
			Wire { enabled: ((cell4.value + 1 == 12) && (col4cell12State.value == 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.12.capture"; } }
			Wire { enabled: ((cell4.value + 1 == 13) && (col4cell13State.value == 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.13.capture"; } }
			Wire { enabled: ((cell4.value + 1 == 14) && (col4cell14State.value == 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.14.capture"; } }
			Wire { enabled: ((cell4.value + 1 == 15) && (col4cell15State.value == 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.15.capture"; } }
			Wire { enabled: ((cell4.value + 1 == 16) && (col4cell16State.value == 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.16.capture"; } }
		
			Wire { enabled: ((cell4.value + 1 == 1) && (col4cell1State.value != 0)); from: "%surface%.pads.4"; to: "triggering.4.trigger" } 
			Wire { enabled: ((cell4.value + 1 == 2) && (col4cell2State.value != 0)); from: "%surface%.pads.4"; to: "triggering.4.trigger" } 
			Wire { enabled: ((cell4.value + 1 == 3) && (col4cell3State.value != 0)); from: "%surface%.pads.4"; to: "triggering.4.trigger" } 
			Wire { enabled: ((cell4.value + 1 == 4) && (col4cell4State.value != 0)); from: "%surface%.pads.4"; to: "triggering.4.trigger" } 
			Wire { enabled: ((cell4.value + 1 == 5) && (col4cell5State.value != 0)); from: "%surface%.pads.4"; to: "triggering.4.trigger" } 
			Wire { enabled: ((cell4.value + 1 == 6) && (col4cell6State.value != 0)); from: "%surface%.pads.4"; to: "triggering.4.trigger" } 
			Wire { enabled: ((cell4.value + 1 == 7) && (col4cell7State.value != 0)); from: "%surface%.pads.4"; to: "triggering.4.trigger" } 
			Wire { enabled: ((cell4.value + 1 == 8) && (col4cell8State.value != 0)); from: "%surface%.pads.4"; to: "triggering.4.trigger" } 
			Wire { enabled: ((cell4.value + 1 == 9) && (col4cell9State.value != 0)); from: "%surface%.pads.4"; to: "triggering.4.trigger" } 
			Wire { enabled: ((cell4.value + 1 == 10) && (col4cell10State.value != 0)); from: "%surface%.pads.4"; to: "triggering.4.trigger" } 
			Wire { enabled: ((cell4.value + 1 == 11) && (col4cell11State.value != 0)); from: "%surface%.pads.4"; to: "triggering.4.trigger" } 
			Wire { enabled: ((cell4.value + 1 == 12) && (col4cell12State.value != 0)); from: "%surface%.pads.4"; to: "triggering.4.trigger" } 
			Wire { enabled: ((cell4.value + 1 == 13) && (col4cell13State.value != 0)); from: "%surface%.pads.4"; to: "triggering.4.trigger" } 
			Wire { enabled: ((cell4.value + 1 == 14) && (col4cell14State.value != 0)); from: "%surface%.pads.4"; to: "triggering.4.trigger" } 
			Wire { enabled: ((cell4.value + 1 == 15) && (col4cell15State.value != 0)); from: "%surface%.pads.4"; to: "triggering.4.trigger" } 
			Wire { enabled: ((cell4.value + 1 == 16) && (col4cell16State.value != 0)); from: "%surface%.pads.4"; to: "triggering.4.trigger" } 

		}
		
		WiresGroup
		{
			enabled: module.shift
		
			Wire { enabled: ((cell4.value + 1 == 1) && (col4cell1State.value != 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.1.delete"; } }
			Wire { enabled: ((cell4.value + 1 == 2) && (col4cell2State.value != 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.2.delete"; } }
			Wire { enabled: ((cell4.value + 1 == 3) && (col4cell3State.value != 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.3.delete"; } }
			Wire { enabled: ((cell4.value + 1 == 4) && (col4cell4State.value != 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.4.delete"; } }
			Wire { enabled: ((cell4.value + 1 == 5) && (col4cell5State.value != 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.5.delete"; } }
			Wire { enabled: ((cell4.value + 1 == 6) && (col4cell6State.value != 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.6.delete"; } }
			Wire { enabled: ((cell4.value + 1 == 7) && (col4cell7State.value != 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.7.delete"; } }
			Wire { enabled: ((cell4.value + 1 == 8) && (col4cell8State.value != 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.8.delete"; } }
			Wire { enabled: ((cell4.value + 1 == 9) && (col4cell9State.value != 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.9.delete"; } }
			Wire { enabled: ((cell4.value + 1 == 10) && (col4cell10State.value != 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.10.delete"; } }
			Wire { enabled: ((cell4.value + 1 == 11) && (col4cell11State.value != 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.11.delete"; } }
			Wire { enabled: ((cell4.value + 1 == 12) && (col4cell12State.value != 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.12.delete"; } }
			Wire { enabled: ((cell4.value + 1 == 13) && (col4cell13State.value != 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.13.delete"; } }
			Wire { enabled: ((cell4.value + 1 == 14) && (col4cell14State.value != 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.14.delete"; } }
			Wire { enabled: ((cell4.value + 1 == 15) && (col4cell15State.value != 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.15.delete"; } }
			Wire { enabled: ((cell4.value + 1 == 16) && (col4cell16State.value != 0)); from: "%surface%.pads.4";  to: TriggerPropertyAdapter {path: "app.traktor.decks." + module.deckIdx + ".remix.cell.columns.4.rows.16.delete"; } }
		
		}
        
        Wire { from: "%surface%.browse.preview";  to: TogglePropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".remix.players.4.key_lock"; output: true} }
        Wire { from: "%surface%.browse.favorite";  to: TogglePropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".remix.players.4.fx_send_on"; output: true} }
        
      }
      
      WiresGroup
      {
      	enabled: propActiveSlot.value != 0;
      	
      	Wire
        {
        	from: "%surface%.top_deck";  
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
        	from: "%surface%.bottom_deck";  
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

      Wire
      {
        enabled: propActiveSlot.value != 0
        from: Or
        {
          inputs:
          [
            "%surface%.browse.encoder.push",
            "%surface%.browse.encoder.is_turned",
          ]
        }
        to: ButtonScriptAdapter{
            onPress:
            {
              sample_browsing_countdown.stop();
              propSampleBrowsing.value = true;
            }
            onRelease:
            {
              sample_browsing_countdown.restart();
            }
        }
      }
    }

    //------------------------- Lower pads to slot focus ---------------------------

    Wire { from: "%surface%.pads.5"; to: HoldPropertyAdapter { path: deckPropertiesPath + ".active_slot"; value: 1; defaultValue: 0 } }
    Wire { from: "%surface%.pads.6"; to: HoldPropertyAdapter { path: deckPropertiesPath + ".active_slot"; value: 2; defaultValue: 0 } }
    Wire { from: "%surface%.pads.7"; to: HoldPropertyAdapter { path: deckPropertiesPath + ".active_slot"; value: 3; defaultValue: 0 } }
    Wire { from: "%surface%.pads.8"; to: HoldPropertyAdapter { path: deckPropertiesPath + ".active_slot"; value: 4; defaultValue: 0 } }
  }

}
