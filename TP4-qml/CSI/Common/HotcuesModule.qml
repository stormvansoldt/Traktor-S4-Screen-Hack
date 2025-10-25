import CSI 1.0
import QtQuick 2.0
import '../../Screens/Defines' as Defines
import "../S4MK3/S4MK3Functions.js" as S4MK3Functions

Module
{
  id: module
  property bool shift: false
  property string surface: ""
  property string propertiesPath: ""
  property int deckIdx: 0
  property bool active: false
  property string side: (deckIdx == 2 || deckIdx == 4) ? "right" : "left"
  property bool browser: false
  
  Defines.Settings  {id: settings}
  
  AppProperty { id: hc1Exists; path: "app.traktor.decks." + deckIdx + ".track.cue.hotcues.1.exists"}
  AppProperty { id: hc2Exists; path: "app.traktor.decks." + deckIdx + ".track.cue.hotcues.2.exists"}
  AppProperty { id: hc3Exists; path: "app.traktor.decks." + deckIdx + ".track.cue.hotcues.3.exists"}
  AppProperty { id: hc4Exists; path: "app.traktor.decks." + deckIdx + ".track.cue.hotcues.4.exists"}
  AppProperty { id: hc5Exists; path: "app.traktor.decks." + deckIdx + ".track.cue.hotcues.5.exists"}
  AppProperty { id: hc6Exists; path: "app.traktor.decks." + deckIdx + ".track.cue.hotcues.6.exists"}
  AppProperty { id: hc7Exists; path: "app.traktor.decks." + deckIdx + ".track.cue.hotcues.7.exists"}
  AppProperty { id: hc8Exists; path: "app.traktor.decks." + deckIdx + ".track.cue.hotcues.8.exists"}
  
  property bool hc1: hc1Exists.value
  property bool hc2: hc2Exists.value
  property bool hc3: hc3Exists.value
  property bool hc4: hc4Exists.value
  property bool hc5: hc5Exists.value
  property bool hc6: hc6Exists.value
  property bool hc7: hc7Exists.value
  property bool hc8: hc8Exists.value
  
  AppProperty { id: cue1TypeProp;			path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.1.type"; }
  AppProperty { id: cue2TypeProp;			path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.2.type"; }
  AppProperty { id: cue3TypeProp;			path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.3.type"; }
  AppProperty { id: cue4TypeProp;			path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.4.type"; }
  AppProperty { id: cue5TypeProp;			path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.5.type"; }
  AppProperty { id: cue6TypeProp;			path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.6.type"; }
  AppProperty { id: cue7TypeProp;			path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.7.type"; }
  AppProperty { id: cue8TypeProp;			path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.8.type"; }
  
  property int cue1Type: cue1TypeProp.value
  property int cue2Type: cue2TypeProp.value
  property int cue3Type: cue3TypeProp.value
  property int cue4Type: cue4TypeProp.value
  property int cue5Type: cue5TypeProp.value
  property int cue6Type: cue6TypeProp.value
  property int cue7Type: cue7TypeProp.value
  property int cue8Type: cue8TypeProp.value
  
  AppProperty { id: cue1NameProp;			path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.1.name"; }
  AppProperty { id: cue2NameProp;			path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.2.name"; }
  AppProperty { id: cue3NameProp;			path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.3.name"; }
  AppProperty { id: cue4NameProp;			path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.4.name"; }
  AppProperty { id: cue5NameProp;			path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.5.name"; }
  AppProperty { id: cue6NameProp;			path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.6.name"; }
  AppProperty { id: cue7NameProp;			path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.7.name"; }
  AppProperty { id: cue8NameProp;			path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.8.name"; }
  
  property string name1: settings.hotcueName1
  property string name2: settings.hotcueName2
  property string name3: settings.hotcueName3
  property string name4: settings.hotcueName4
  property string name5: settings.hotcueName5
  property string name6: settings.hotcueName6
  property string name7: settings.hotcueName7
  property string name8: settings.hotcueName8
  
  property int cueName1Check: cue1NameProp.value == name1 ? 1 : cue1NameProp.value == name2 ? 2 : cue1NameProp.value == name3 ? 3 : cue1NameProp.value == name4 ? 4 : cue1NameProp.value == name5 ? 5 : cue1NameProp.value == name6 ? 6 : cue1NameProp.value == name7 ? 7 : cue1NameProp.value == name8 ? 8 : 0
  property int cueName2Check: cue2NameProp.value == name1 ? 1 : cue2NameProp.value == name2 ? 2 : cue2NameProp.value == name3 ? 3 : cue2NameProp.value == name4 ? 4 : cue2NameProp.value == name5 ? 5 : cue2NameProp.value == name6 ? 6 : cue2NameProp.value == name7 ? 7 : cue2NameProp.value == name8 ? 8 : 0
  property int cueName3Check: cue3NameProp.value == name1 ? 1 : cue3NameProp.value == name2 ? 2 : cue3NameProp.value == name3 ? 3 : cue3NameProp.value == name4 ? 4 : cue3NameProp.value == name5 ? 5 : cue3NameProp.value == name6 ? 6 : cue3NameProp.value == name7 ? 7 : cue3NameProp.value == name8 ? 8 : 0
  property int cueName4Check: cue4NameProp.value == name1 ? 1 : cue4NameProp.value == name2 ? 2 : cue4NameProp.value == name3 ? 3 : cue4NameProp.value == name4 ? 4 : cue4NameProp.value == name5 ? 5 : cue4NameProp.value == name6 ? 6 : cue4NameProp.value == name7 ? 7 : cue4NameProp.value == name8 ? 8 : 0
  property int cueName5Check: cue5NameProp.value == name1 ? 1 : cue5NameProp.value == name2 ? 2 : cue5NameProp.value == name3 ? 3 : cue5NameProp.value == name4 ? 4 : cue5NameProp.value == name5 ? 5 : cue5NameProp.value == name6 ? 6 : cue5NameProp.value == name7 ? 7 : cue5NameProp.value == name8 ? 8 : 0
  property int cueName6Check: cue6NameProp.value == name1 ? 1 : cue6NameProp.value == name2 ? 2 : cue6NameProp.value == name3 ? 3 : cue6NameProp.value == name4 ? 4 : cue6NameProp.value == name5 ? 5 : cue6NameProp.value == name6 ? 6 : cue6NameProp.value == name7 ? 7 : cue6NameProp.value == name8 ? 8 : 0
  property int cueName7Check: cue7NameProp.value == name1 ? 1 : cue7NameProp.value == name2 ? 2 : cue7NameProp.value == name3 ? 3 : cue7NameProp.value == name4 ? 4 : cue7NameProp.value == name5 ? 5 : cue7NameProp.value == name6 ? 6 : cue7NameProp.value == name7 ? 7 : cue7NameProp.value == name8 ? 8 : 0
  property int cueName8Check: cue8NameProp.value == name1 ? 1 : cue8NameProp.value == name2 ? 2 : cue8NameProp.value == name3 ? 3 : cue8NameProp.value == name4 ? 4 : cue8NameProp.value == name5 ? 5 : cue8NameProp.value == name6 ? 6 : cue8NameProp.value == name7 ? 7 : cue8NameProp.value == name8 ? 8 : 0
  
  property bool cueName1Match: !settings.hotcueNameColours || cueName1Check == 0 ? false : true
  property bool cueName2Match: !settings.hotcueNameColours || cueName2Check == 0 ? false : true
  property bool cueName3Match: !settings.hotcueNameColours || cueName3Check == 0 ? false : true
  property bool cueName4Match: !settings.hotcueNameColours || cueName4Check == 0 ? false : true
  property bool cueName5Match: !settings.hotcueNameColours || cueName5Check == 0 ? false : true
  property bool cueName6Match: !settings.hotcueNameColours || cueName6Check == 0 ? false : true
  property bool cueName7Match: !settings.hotcueNameColours || cueName7Check == 0 ? false : true
  property bool cueName8Match: !settings.hotcueNameColours || cueName8Check == 0 ? false : true
  
  AppProperty { id: loopActive; path: "app.traktor.decks." + module.deckIdx + ".loop.active"}
  AppProperty { id: inLoopActive; path: "app.traktor.decks." + module.deckIdx + ".loop.is_in_active_loop"}
  
  function nameColour(inputName) {
  	switch(inputName) {
  		case 0: return S4MK3Functions.colorForDeckSingle(16);
  		case 1: return S4MK3Functions.colorForDeckSingle2(settings.hotcueName1Colour);
  		case 2: return S4MK3Functions.colorForDeckSingle2(settings.hotcueName2Colour);
  		case 3: return S4MK3Functions.colorForDeckSingle2(settings.hotcueName3Colour);
  		case 4: return S4MK3Functions.colorForDeckSingle2(settings.hotcueName4Colour);
  		case 5: return S4MK3Functions.colorForDeckSingle2(settings.hotcueName5Colour);
  		case 6: return S4MK3Functions.colorForDeckSingle2(settings.hotcueName6Colour);
  		case 7: return S4MK3Functions.colorForDeckSingle2(settings.hotcueName7Colour);
  		case 8: return S4MK3Functions.colorForDeckSingle2(settings.hotcueName8Colour);
  	}
  
  }

  function cueColour(inputType) {
  	switch(inputType) {
  		case -1: return S4MK3Functions.colorForDeckSingle2(settings.cueCueColour);
  		case 0: return S4MK3Functions.colorForDeckSingle2(settings.cueCueColour);
  		case 1: return S4MK3Functions.colorForDeckSingle2(settings.cueFadeInColour);
  		case 2: return S4MK3Functions.colorForDeckSingle2(settings.cueFadeOutColour);
  		case 3: return S4MK3Functions.colorForDeckSingle2(settings.cueLoadColour);
  		case 4: return S4MK3Functions.colorForDeckSingle2(settings.cueGridColour);
  		case 5: return S4MK3Functions.colorForDeckSingle2(settings.cueLoopColour);
  	}
  
  }
  
  property var colorBlack: S4MK3Functions.colorForDeckSingle(16)

  AppProperty { id: cueTypeProp;			path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues." + module.hotcueIdValue + ".type"; }
  readonly property int type: cueTypeProp.value

  Hotcues   { name: "hotcues";      channel: deckIdx }
  
  MappingPropertyDescriptor 
  { 
    id: hotcueInfo; 
    path: "mapping.state." + module.deckIdx + ".hotcueInfo"; 
    type: MappingPropertyDescriptor.Boolean; 
    value: false;
  }
  
  MappingPropertyDescriptor 
  { 
    id: hotcueButton; 
    path: "mapping.state." + module.deckIdx + ".hotcueButton"; 
    type: MappingPropertyDescriptor.Boolean; 
    value: false;
  }
  
  MappingPropertyDescriptor 
  { 
    id: hotcueId; 
    path: "mapping.state." + module.deckIdx + ".hotcueId"; 
    type: MappingPropertyDescriptor.Integer; 
    value: 1;
  }
  
  property int hotcueIdValue: hotcueId.value
  property bool enabled: hotcueInfo.value

  AppProperty { id: typeProp;			path: "app.traktor.decks." + module.deckIdx + ".track.cue.type"; }
  property int typeUp: type < 5 ? type+1 : 5
  property int typeDown: cueTypeProp.value > -1 ? cueTypeProp.value-1 : -1

  WiresGroup
  {
    enabled: active 
    
    
    Wire { from: "%surface%.pads.1"; to: SetPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueId"; value: 1; output: false} }
    Wire { from: "%surface%.pads.2"; to: SetPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueId"; value: 2; output: false} }
    Wire { from: "%surface%.pads.3"; to: SetPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueId"; value: 3; output: false} }
    Wire { from: "%surface%.pads.4"; to: SetPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueId"; value: 4; output: false} }
    Wire { from: "%surface%.pads.5"; to: SetPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueId"; value: 5; output: false} }
    Wire { from: "%surface%.pads.6"; to: SetPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueId"; value: 6; output: false} }
    Wire { from: "%surface%.pads.7"; to: SetPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueId"; value: 7; output: false} }
    Wire { from: "%surface%.pads.8"; to: SetPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueId"; value: 8; output: false} }
    
    Wire { from: "%surface%.hotcues"; to: DirectPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueInfo"; output: false} }
    Wire { from: "%surface%.hotcues"; to: DirectPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueButton"; output: false} }


    WiresGroup
    {
      enabled: !module.shift && !hotcueButton.value
      
      Wire { from: "%surface%.pads.1"; to: DirectPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueInfo"; output: false} }
      Wire { from: "%surface%.pads.2"; to: DirectPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueInfo"; output: false} }
      Wire { from: "%surface%.pads.3"; to: DirectPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueInfo"; output: false} }
      Wire { from: "%surface%.pads.4"; to: DirectPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueInfo"; output: false} }
      Wire { from: "%surface%.pads.5"; to: DirectPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueInfo"; output: false} }
      Wire { from: "%surface%.pads.6"; to: DirectPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueInfo"; output: false} }
      Wire { from: "%surface%.pads.7"; to: DirectPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueInfo"; output: false} }
      Wire { from: "%surface%.pads.8"; to: DirectPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueInfo"; output: false} }
    

	  Wire { enabled: loopActive.value && hc1 && (cue1Type != 5); from: "%surface%.pads.1";   to: SetPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".loop.set.in"; output: false; value: true } }
      Wire { enabled: loopActive.value && hc2 && (cue2Type != 5); from: "%surface%.pads.2";   to: SetPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".loop.set.in"; output: false; value: true } }
      Wire { enabled: loopActive.value && hc3 && (cue3Type != 5); from: "%surface%.pads.3";   to: SetPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".loop.set.in"; output: false; value: true } }
      Wire { enabled: loopActive.value && hc4 && (cue4Type != 5); from: "%surface%.pads.4";   to: SetPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".loop.set.in"; output: false; value: true } }
      Wire { enabled: loopActive.value && hc5 && (cue5Type != 5); from: "%surface%.pads.5";   to: SetPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".loop.set.in"; output: false; value: true } }
      Wire { enabled: loopActive.value && hc6 && (cue6Type != 5); from: "%surface%.pads.6";   to: SetPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".loop.set.in"; output: false; value: true } }
      Wire { enabled: loopActive.value && hc7 && (cue7Type != 5); from: "%surface%.pads.7";   to: SetPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".loop.set.in"; output: false; value: true } }
      Wire { enabled: loopActive.value && hc8 && (cue8Type != 5); from: "%surface%.pads.8";   to: SetPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".loop.set.in"; output: false; value: true } }
      

      Wire { enabled: settings.hotcue1SetsGridmarker ? !hc1Exists.value : false; from: "%surface%.pads.1";   to: TriggerPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".track.gridmarker.set"; output: false; } }
      
      Wire { enabled: settings.hotcue1SetsGridmarker ? hc1Exists.value : true; from: "%surface%.pads.1";   to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.1.active"; output: true; color: hc1 ? (module.cueName1Match ? nameColour(module.cueName1Check) : cueColour(module.cue1Type)) : colorBlack } }
      Wire { from: "%surface%.pads.2";   to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.2.active"; output: true; color: hc2 ? (module.cueName2Match ? nameColour(module.cueName2Check) : cueColour(module.cue2Type)) : colorBlack} }
      Wire { from: "%surface%.pads.3";   to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.3.active"; output: true; color: hc3 ? (module.cueName3Match ? nameColour(module.cueName3Check) : cueColour(module.cue3Type)) : colorBlack} }
      Wire { from: "%surface%.pads.4";   to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.4.active"; output: true; color: hc4 ? (module.cueName4Match ? nameColour(module.cueName4Check) : cueColour(module.cue4Type)) : colorBlack} }
      Wire { from: "%surface%.pads.5";   to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.5.active"; output: true; color: hc5 ? (module.cueName5Match ? nameColour(module.cueName5Check) : cueColour(module.cue5Type)) : colorBlack} }
      Wire { from: "%surface%.pads.6";   to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.6.active"; output: true; color: hc6 ? (module.cueName6Match ? nameColour(module.cueName6Check) : cueColour(module.cue6Type)) : colorBlack} }
      Wire { from: "%surface%.pads.7";   to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.7.active"; output: true; color: hc7 ? (module.cueName7Match ? nameColour(module.cueName7Check) : cueColour(module.cue7Type)) : colorBlack} }
      Wire { from: "%surface%.pads.8";   to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.8.active"; output: true; color: hc8 ? (module.cueName8Match ? nameColour(module.cueName8Check) : cueColour(module.cue8Type)) : colorBlack} }

    }
    
    
    WiresGroup
    {
      enabled: module.shift && !hotcueButton.value
      
      Wire { from: "%surface%.pads.1";   to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.1.delete"; output: true; color: hc1 ? (module.cueName1Match ? nameColour(module.cueName1Check) : cueColour(module.cue1Type)) : colorBlack} }
      Wire { from: "%surface%.pads.2";   to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.2.delete"; output: true; color: hc2 ? (module.cueName2Match ? nameColour(module.cueName2Check) : cueColour(module.cue2Type)) : colorBlack} }
      Wire { from: "%surface%.pads.3";   to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.3.delete"; output: true; color: hc3 ? (module.cueName3Match ? nameColour(module.cueName3Check) : cueColour(module.cue3Type)) : colorBlack} }
      Wire { from: "%surface%.pads.4";   to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.4.delete"; output: true; color: hc4 ? (module.cueName4Match ? nameColour(module.cueName4Check) : cueColour(module.cue4Type)) : colorBlack} }
      Wire { from: "%surface%.pads.5";   to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.5.delete"; output: true; color: hc5 ? (module.cueName5Match ? nameColour(module.cueName5Check) : cueColour(module.cue5Type)) : colorBlack} }
      Wire { from: "%surface%.pads.6";   to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.6.delete"; output: true; color: hc6 ? (module.cueName6Match ? nameColour(module.cueName6Check) : cueColour(module.cue6Type)) : colorBlack} }
      Wire { from: "%surface%.pads.7";   to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.7.delete"; output: true; color: hc7 ? (module.cueName7Match ? nameColour(module.cueName7Check) : cueColour(module.cue7Type)) : colorBlack} }
      Wire { from: "%surface%.pads.8";   to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.8.delete"; output: true; color: hc8 ? (module.cueName8Match ? nameColour(module.cueName8Check) : cueColour(module.cue8Type)) : colorBlack} }

    }
    
    WiresGroup 
    {
    	enabled: module.enabled && !hotcueButton.value
    	
		Wire
   		{
   			enabled: (cueTypeProp.value>0) && !browser
    		from: "s4mk3." + side + ".top_deck";
    		to: ButtonScriptAdapter
    		{
    			onPress: 
    			{
    				typeProp.value = (cueTypeProp.value > 0 ? cueTypeProp.value-1 : 0);
    				brightness = 1.0;
    			}
    			onRelease:
    			{
    				brightness = 0.0;
    			}
    			brightness: 0.0
    			color: S4MK3Functions.colorForDeckSingle(0)
    		}
  		}
  		
  		Wire
   		{
   			enabled: (cueTypeProp.value<5) && !browser
    		from: "s4mk3." + side + ".bottom_deck";
    		to: ButtonScriptAdapter
    		{
    			onPress: 
    			{
    				typeProp.value = (cueTypeProp.value < 5 ? cueTypeProp.value+1 : 5);
    				brightness = 1.0;
    			}
    			onRelease:
    			{
    				brightness = 0.0;
    			}
    			brightness: 0.0
    			color: S4MK3Functions.colorForDeckSingle(6)
    		}
  		}   
  	}
  	
  	WiresGroup
    {
      enabled: hotcueButton.value
      
      Wire { from: "%surface%.pads.1"; to: DirectPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueInfo"; output: true; color: hc1 ? (module.cueName1Match ? nameColour(module.cueName1Check) : cueColour(module.cue1Type)) : colorBlack } }
      Wire { from: "%surface%.pads.2"; to: DirectPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueInfo"; output: true; color: hc2 ? (module.cueName2Match ? nameColour(module.cueName2Check) : cueColour(module.cue2Type)) : colorBlack } }
      Wire { from: "%surface%.pads.3"; to: DirectPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueInfo"; output: true; color: hc3 ? (module.cueName3Match ? nameColour(module.cueName3Check) : cueColour(module.cue3Type)) : colorBlack } }
      Wire { from: "%surface%.pads.4"; to: DirectPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueInfo"; output: true; color: hc4 ? (module.cueName4Match ? nameColour(module.cueName4Check) : cueColour(module.cue4Type)) : colorBlack } }
      Wire { from: "%surface%.pads.5"; to: DirectPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueInfo"; output: true; color: hc5 ? (module.cueName5Match ? nameColour(module.cueName5Check) : cueColour(module.cue5Type)) : colorBlack } }
      Wire { from: "%surface%.pads.6"; to: DirectPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueInfo"; output: true; color: hc6 ? (module.cueName6Match ? nameColour(module.cueName6Check) : cueColour(module.cue6Type)) : colorBlack } }
      Wire { from: "%surface%.pads.7"; to: DirectPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueInfo"; output: true; color: hc7 ? (module.cueName7Match ? nameColour(module.cueName7Check) : cueColour(module.cue7Type)) : colorBlack } }
      Wire { from: "%surface%.pads.8"; to: DirectPropertyAdapter { path: "mapping.state." + module.deckIdx + ".hotcueInfo"; output: true; color: hc8 ? (module.cueName8Match ? nameColour(module.cueName8Check) : cueColour(module.cue8Type)) : colorBlack } } 
    }
  }
}
