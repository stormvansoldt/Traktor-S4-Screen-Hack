import CSI 1.0
import QtQuick 2.5
import "../../Defines"
import "S4MK3Functions.js" as S4MK3Functions
import '../../Screens/Defines' as Defines2

/*
  This file represents a hardware module on the S4MK3
*/
Module
{
  id: module
  
  property int deckA: settings.deckAColour
  property int deckB: settings.deckBColour
  property int deckC: settings.deckCColour
  property int deckD: settings.deckDColour
  
  // LED Brightness ----------------------
  readonly property real onBrightness:     1.0
  readonly property real dimmedBrightness: 0
    
  property string surface: ""
  property string propertiesPath: ""
  property int topDeckIdx: 0 
  property int bottomDeckIdx: 0 
  property alias shift: shiftProp.value
  property bool eitherShift: leftShiftProp.value || rightShiftProp.value
  property bool view: viewProp.value
  property int focusedDeckIdx: topDeckFocus.value ? topDeckIdx : bottomDeckIdx
  property bool hapticHotcuesEnabled: true
  
  property bool fx1Active: false
  property bool fx2Active: false
  
  property var deckColor: focusedDeckIdx == 1 ? S4MK3Functions.colorForDeckSingle(deckA) : focusedDeckIdx == 2 ? S4MK3Functions.colorForDeckSingle(deckB) : focusedDeckIdx == 3 ? S4MK3Functions.colorForDeckSingle(deckC) : focusedDeckIdx == 4 ? S4MK3Functions.colorForDeckSingle(deckD) : S4MK3Functions.colorForDeckSingle(3)

  AppProperty {id: nextCue; path: "app.traktor.decks." + focusedDeckIdx + ".track.cue.jump_to_next_prev"}
  
  AppProperty { id: propLoaded; 	  			path: "app.traktor.decks." + focusedDeckIdx + ".is_loaded_signal" }
  property bool isLoaded: propLoaded.value
  onIsLoadedChanged: {
  	if (settings.resetPadModeOnLoad == true) {
  		focusedDeck().padsMode = PadsMode.defaultPadsModeForDeck(focusedDeck().deckType, settings.loadHotcuesOnLoad);	
  		nonFocusedDeck().enablePads = false; 
  		updatePads();
  	}
	settings.jumpToFirstCueOnLoad ? nextCue.value = -1 : nextCue.value = 0;
  }
  
  
  AppProperty { id: propEnabled; 	  			path: "app.traktor.decks." + focusedDeckIdx + ".freeze.enabled" }
  readonly property bool 	slicerEnabled: 	      propEnabled.value
  onSlicerEnabled: updatePads()

  //--------------------------HelperFunctions-----------------------------

  function updatePads() 
  {
	if(PadsMode.isPadsModeSupported(focusedDeck().padsMode, focusedDeck().deckType))
    {
      focusedDeck().enablePads = true;
      nonFocusedDeck().enablePads = false;
    } 
    else if(focusedDeck().padsMode == PadsMode.remix && nonFocusedDeck().deckType === DeckType.Remix)
    {
      focusedDeck().enablePads = false;
      nonFocusedDeck().enablePads = true
      nonFocusedDeck().padsMode = PadsMode.remix;
    }
    else
    {
      focusedDeck().padsMode = PadsMode.defaultPadsModeForDeck(focusedDeck().deckType, settings.loadHotcuesOnLoad);
	  nonFocusedDeck().enablePads = false;
    }

    // Keep pads state in sync with focused deck, will only trigger callbacks if value has changed
    globalPadsMode.value = focusedDeck().padsMode;
  }

  function nonFocusedDeck()
  {
    return topDeckFocus.value ? bottomDeck : topDeck;
  }

  function focusedDeck()
  {
    return topDeckFocus.value ? topDeck : bottomDeck;
  }

  //--------------------------MAPPING-----------------------------

  // Deck focus //

  MappingPropertyDescriptor
  {
    id: topDeckFocus;
    path: propertiesPath + ".top_deck_focus";
    type: MappingPropertyDescriptor.Boolean;
    value: true;
    onValueChanged:
    {
      updatePads();
      topDeck.gridAdjustEnableProp.value = false;
      bottomDeck.gridAdjustEnableProp.value = false;

    }  
  }

  Wire
  {
    enabled: ((settings.enableDuplicate ? !eitherShift : true) && !focusedDeck().hotcuesEnabled) && (focusedDeck().activeSlot == 0)
    from: "%surface%.top_deck";
    to: SetPropertyAdapter  { path: propertiesPath + ".top_deck_focus"; value: true; color: S4MK3Functions.colorForDeck(module.topDeckIdx,deckA,deckB,deckC,deckD) }
  } 

  Wire
  {
    enabled: (settings.enableDuplicate ? !eitherShift : true) && !focusedDeck().hotcuesEnabled && (focusedDeck().activeSlot == 0)
    from: "%surface%.bottom_deck";
    to: SetPropertyAdapter  { path: propertiesPath + ".top_deck_focus"; value: false; color: S4MK3Functions.colorForDeck(module.bottomDeckIdx,deckA,deckB,deckC,deckD) }
  } 

  // Performace pads mode  //

  MappingPropertyDescriptor
  {
    id: globalPadsMode;
    path: propertiesPath + ".pads_mode";
    type: MappingPropertyDescriptor.Integer;
    value: PadsMode.disabled;
    onValueChanged:
    {
      focusedDeck().padsMode = globalPadsMode.value;
    }  
  }

  // Shift //
  MappingPropertyDescriptor { id: shiftProp; path: propertiesPath + ".shift"; type: MappingPropertyDescriptor.Boolean; value: false }
  Wire { from: "%surface%.shift";  to: DirectPropertyAdapter { path: propertiesPath + ".shift" } }
  
  // Left Shift //
  MappingPropertyDescriptor { id: leftShiftProp; path: propertiesPath + ".leftShift"; type: MappingPropertyDescriptor.Boolean; value: false }
  Wire { from: "s4mk3.left.shift";  to: DirectPropertyAdapter { path: propertiesPath + ".leftShift" } }
  
  // Right Shift //
  MappingPropertyDescriptor { id: rightShiftProp; path: propertiesPath + ".rightShift"; type: MappingPropertyDescriptor.Boolean; value: false }
  Wire { from: "s4mk3.right.shift";  to: DirectPropertyAdapter { path: propertiesPath + ".rightShift" } }

    
  //------------------------------------SUBMODULES---------------------------------------------//

  KontrolScreen { name: "screen"; side: topDeckIdx==1 ? ScreenSide.Left : ScreenSide.Right; propertiesPath: module.propertiesPath; flavor: ScreenFlavor.S4MK3 }
  Wire { from: "screen.output";   to: "%surface%.display" }

  S4MK3Deck
  {
    id: topDeck
    name: "topDeck"
    surface: module.surface
    deckPropertiesPath: propertiesPath + "." + topDeckIdx
    isLinkedDeckEncoderInUse: bottomDeck.isEncoderInUse
    shift: shiftProp.value
    deckIdx: topDeckIdx
    active: topDeckFocus.value
    hapticHotcuesEnabled: module.hapticHotcuesEnabled
    bottomRemix: PadsMode.isPadsModeSupported(PadsMode.remix, bottomDeck.deckType);
    fx1Active: module.fx1Active
    fx2Active: module.fx2Active
    onDeckTypeChanged:
    {
      updatePads();
    }
    onPadsModeChanged:
    {
      updatePads();
    }
  }

  S4MK3Deck
  {
    id: bottomDeck
    name: "bottomDeck"
    surface: module.surface
    isLinkedDeckEncoderInUse: topDeck.isEncoderInUse
    deckPropertiesPath: propertiesPath + "." + bottomDeckIdx
    shift: shiftProp.value
    deckIdx: bottomDeckIdx
    active: !topDeckFocus.value
    hapticHotcuesEnabled: module.hapticHotcuesEnabled
    fx1Active: module.fx1Active
    fx2Active: module.fx2Active
    onDeckTypeChanged:
    { 
      updatePads();
    }
    onPadsModeChanged:
    {
      updatePads();
    }
  }
}
            
 
