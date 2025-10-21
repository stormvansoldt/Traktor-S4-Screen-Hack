import CSI 1.0
import QtQuick 2.5
import "../../Defines"
import '../../Screens/Defines' as Defines2
import "S4MK3Functions.js" as S4MK3Functions

Module
{
  id: module
  
  property string surface: ""
  property int deckIdx: 1
  property bool active: false
  
  property int deckA: settings.deckAColour
  property int deckB: settings.deckBColour
  property int deckC: settings.deckCColour
  property int deckD: settings.deckDColour
  
  property bool browseLED: false
  
  AppProperty { id: loadedProp;    path: "app.traktor.decks." + deckIdx + ".is_loaded_signal" }
  property bool loadedSignal: loadedProp.value
  onLoadedSignalChanged: (settings.disableKnobSingleBrowserCloser ? browseLED = browseLED : browseLED = false) 
  
  property bool favorites: false
  
  property string deckPropertiesPath: ""
  
  MappingPropertyDescriptor { id: viewProp; path: deckPropertiesPath + ".view"; type: MappingPropertyDescriptor.Boolean; value: (browseLED || (settings.showBrowserOnFullScreen ? browserMode : false) || (settings.showBrowserOnFavourites ? favorites : false))  }
  property bool viewVal: viewProp.value
  
  
  
  // Encoder Modes ----------------------
  readonly property int listMode:           0
  readonly property int favoritesMode:      1
  readonly property int previewPlayerMode:  2
  readonly property int treeMode:           3
  // ------------------------------------
  property int encoderMode: module.listMode
  // ------------------------------------

  // LED Brightness ----------------------
  readonly property real onBrightness:     1.0
  readonly property real dimmedBrightness: 0

  readonly property var deckColor: S4MK3Functions.colorForDeck(module.deckIdx,deckA,deckB,deckC,deckD)

  Browser {
    name: "browser"
    fullScreenColor: module.deckColor
    prepListColor: module.deckColor
  }
  ButtonGestures { name: "browser_load_gestures" }
  ButtonGestures { name: "loop_load_gestures" }

  AppProperty { id: isLoadedPreviewProp;    path: "app.traktor.browser.preview_player.is_loaded" }
  readonly property bool isPreviewLoaded: isLoadedPreviewProp.value
  AppProperty { id: loadPreviewProp;    path: "app.traktor.browser.preview_player.load" }
  AppProperty { id: unloadPreviewProp;  path: "app.traktor.browser.preview_player.unload" }
  AppProperty { id: propBrowser; 		path: "app.traktor.browser.full_screen" }
  AppProperty { id: propSort; 		path: "app.traktor.browser.sort_id" }
  property int sortId: propSort.value  
  
  AppProperty { id: propIsStemDeck;       path: "app.traktor.decks." + deckIdx + ".type"; }
  readonly property bool    isStemDeck:           (propIsStemDeck.value == 2) ? true : false	
  
  AppProperty { id: propStem1Vol;	path: "äpp.traktor.decks." + deckIdx + ".stems.1.volume" }
  AppProperty { id: propStem1Filt;	path: "äpp.traktor.decks." + deckIdx + ".stems.1.filter_on" }
  AppProperty { id: propStem1FiltVal;	path: "äpp.traktor.decks." + deckIdx + ".stems.1.filter_value" }
  AppProperty { id: propStem1Muted;	path: "äpp.traktor.decks." + deckIdx + ".stems.1.muted" }
  AppProperty { id: propStem1FX;	path: "äpp.traktor.decks." + deckIdx + ".stems.1.fx_send" }
  AppProperty { id: propStem1FXOn;	path: "äpp.traktor.decks." + deckIdx + ".stems.1.fx_send_on" }
  
  AppProperty { id: propStem2Vol;	path: "äpp.traktor.decks." + deckIdx + ".stems.2.volume" }
  AppProperty { id: propStem2Filt;	path: "äpp.traktor.decks." + deckIdx + ".stems.2.filter_on" }
  AppProperty { id: propStem2FiltVal;	path: "äpp.traktor.decks." + deckIdx + ".stems.2.filter_value" }
  AppProperty { id: propStem2Muted;	path: "äpp.traktor.decks." + deckIdx + ".stems.2.muted" }
  AppProperty { id: propStem2FX;	path: "äpp.traktor.decks." + deckIdx + ".stems.2.fx_send" }
  AppProperty { id: propStem2FXOn;	path: "äpp.traktor.decks." + deckIdx + ".stems.2.fx_send_on" }
  
  AppProperty { id: propStem3Vol;	path: "äpp.traktor.decks." + deckIdx + ".stems.3.volume" }
  AppProperty { id: propStem3Filt;	path: "äpp.traktor.decks." + deckIdx + ".stems.3.filter_on" }
  AppProperty { id: propStem3FiltVal;	path: "äpp.traktor.decks." + deckIdx + ".stems.3.filter_value" }
  AppProperty { id: propStem3Muted;	path: "äpp.traktor.decks." + deckIdx + ".stems.3.muted" }
  AppProperty { id: propStem3FX;	path: "äpp.traktor.decks." + deckIdx + ".stems.3.fx_send" }
  AppProperty { id: propStem3FXOn;	path: "äpp.traktor.decks." + deckIdx + ".stems.3.fx_send_on" }
  
  AppProperty { id: propStem4Vol;	path: "äpp.traktor.decks." + deckIdx + ".stems.4.volume" }
  AppProperty { id: propStem4Filt;	path: "äpp.traktor.decks." + deckIdx + ".stems.4.filter_on" }
  AppProperty { id: propStem4FiltVal;	path: "äpp.traktor.decks." + deckIdx + ".stems.4.filter_value" }
  AppProperty { id: propStem4Muted;	path: "äpp.traktor.decks." + deckIdx + ".stems.4.muted" }
  AppProperty { id: propStem4FX;	path: "äpp.traktor.decks." + deckIdx + ".stems.4.fx_send" }
  AppProperty { id: propStem4FXOn;	path: "äpp.traktor.decks." + deckIdx + ".stems.4.fx_send_on" }

  
  readonly property bool 	browserMode: 	  propBrowser.value
  onBrowserModeChanged: {
	settings.showBrowserOnFullScreen && (browserMode == false) ? browseLED = false : browseLED = browseLED;
  }
  property bool shift: false
  
  
  Timer {
          id: previewPlayerEnabledTimer
          property bool blink: false

          interval: 250
          repeat:   true
          running:  isPreviewLoaded

          onTriggered: {
            blink = !blink;
          }

          onRunningChanged: {
            blink = running;
          }
    }

  WiresGroup {

    enabled: module.active
	
	WiresGroup
	  {
		// only enable loop control when the deck is in focus and no stem or slot is selected for either deck.
		enabled: module.active && viewVal

		WiresGroup
		{
		  enabled: settings.enableBrowserMode
		  
		  Wire { enabled: !shift; from: "%surface%.loop_size"; to: "browser.list_navigation"; }
		  Wire { enabled: shift; from: "%surface%.loop_size.turn"; to: RelativePropertyAdapter { path: "app.traktor.browser.list.select_up_down"; step: settings.scrollPageSize; mode: RelativeMode.Stepped } }

		  Wire { from: "%surface%.loop_move"; to: "browser.tree_navigation"; }
		  Wire { from: "%surface%.loop_size.push"; to: "browser_load_gestures.input" }
		  Wire { enabled: settings.disableAllCueOnTrackLoad; from: "%surface%.loop_size.push"; to: SetPropertyAdapter { path: "app.traktor.mixer.channels.1.cue"; value: false; } }
		  Wire { enabled: settings.disableAllCueOnTrackLoad; from: "%surface%.loop_size.push"; to: SetPropertyAdapter { path: "app.traktor.mixer.channels.2.cue"; value: false; } }
		  Wire { enabled: settings.disableAllCueOnTrackLoad; from: "%surface%.loop_size.push"; to: SetPropertyAdapter { path: "app.traktor.mixer.channels.3.cue"; value: false; } }
		  Wire { enabled: settings.disableAllCueOnTrackLoad; from: "%surface%.loop_size.push"; to: SetPropertyAdapter { path: "app.traktor.mixer.channels.4.cue"; value: false; } }
		  Wire { enabled: settings.enableCueOnTrackLoad; from: "%surface%.loop_size.push"; to: SetPropertyAdapter { path: "app.traktor.mixer.channels." + deckIdx + ".cue"; value: true; } }
		  Wire { from: "%surface%.loop_size.push"; to: "browser.full_screen"; enabled: !settings.disableKnobFullBrowserCloser && browserMode }
		  
		  Wire
		  {
		    enabled: !shift
			from: "%surface%.hotcues";
			to: SetPropertyAdapter { path: "app.traktor.browser.sort_id"; value: settings.hotcueButtonSort; output: settings.disableSortButtonOutput ? false : true  }
		  }
		  Wire
		  {
			enabled: shift && (sortId == settings.hotcueButtonSort)
			from: "%surface%.hotcues";
			to: TriggerPropertyAdapter { path: "app.traktor.browser.flip_sort_up_down";  output: settings.disableSortButtonOutput ? false : true  }
		  }
		  Wire
		  {
		    enabled: shift && (sortId != settings.hotcueButtonSort)
			from: "%surface%.hotcues";
			to: SetPropertyAdapter { path: "app.traktor.browser.sort_id"; value: 1; output: false  }
		  }
		  Wire
		  {
		    enabled: !shift
			from: "%surface%.record";
			to: SetPropertyAdapter { path: "app.traktor.browser.sort_id"; value: settings.recordButtonSort; output: settings.disableSortButtonOutput ? false : true  }
		  }
		  Wire
		  {
			enabled: shift && (sortId == settings.recordButtonSort)
			from: "%surface%.record";
			to: TriggerPropertyAdapter { path: "app.traktor.browser.flip_sort_up_down";  output: true  }
		  }
		  Wire
		  {
		    enabled: shift && (sortId != settings.recordButtonSort)
			from: "%surface%.record";
			to: SetPropertyAdapter { path: "app.traktor.browser.sort_id"; value: 1; output: false  }
		  }
		  Wire
		  {
		    enabled: !shift
			from: "%surface%.samples";
			to: SetPropertyAdapter { path: "app.traktor.browser.sort_id"; value: settings.samplesButtonSort; output: settings.disableSortButtonOutput ? false : true; }
		  }
		  Wire
		  {
			enabled: shift && (sortId == settings.samplesButtonSort)
			from: "%surface%.samples";
			to: TriggerPropertyAdapter { path: "app.traktor.browser.flip_sort_up_down";  output: settings.disableSortButtonOutput ? false : true  }
		  }
		  Wire
		  {
		    enabled: shift && (sortId != settings.samplesButtonSort)
			from: "%surface%.samples";
			to: SetPropertyAdapter { path: "app.traktor.browser.sort_id"; value: 1; output: false  }
		  }
		  Wire
		  {
		    enabled: !shift
			from: "%surface%.mute";
			to: SetPropertyAdapter { path: "app.traktor.browser.sort_id"; value: settings.muteButtonSort; output: settings.disableSortButtonOutput ? false : true  }
		  }
		  Wire
		  {
			enabled: shift && (sortId == settings.muteButtonSort)
			from: "%surface%.mute";
			to: TriggerPropertyAdapter { path: "app.traktor.browser.flip_sort_up_down";  output: settings.disableSortButtonOutput ? false : true  }
		  }
		  Wire
		  {
		    enabled: shift && (sortId != settings.muteButtonSort)
			from: "%surface%.mute";
			to: SetPropertyAdapter { path: "app.traktor.browser.sort_id"; value: 1; output: false  }
		  }
		  Wire
		  {
		    enabled: !shift
			from: "%surface%.stems";
			to: SetPropertyAdapter { path: "app.traktor.browser.sort_id"; value: settings.stemsButtonSort; output: settings.disableSortButtonOutput ? false : true  }
		  }
		  Wire
		  {
			enabled: shift && (sortId == settings.stemsButtonSort)
			from: "%surface%.stems";
			to: TriggerPropertyAdapter { path: "app.traktor.browser.flip_sort_up_down";  output: settings.disableSortButtonOutput ? false : true  }
		  }
		  Wire
		  {
		    enabled: shift && (sortId != settings.stemsButtonSort)
			from: "%surface%.stems";
			to: SetPropertyAdapter { path: "app.traktor.browser.sort_id"; value: 1; output: false  }
		  }
		}
	  }
	WiresGroup
	{
	enabled: settings.showBrowserOnFullScreen
    Wire 
    { 
      from: "%surface%.browse.view";   
      to: ButtonScriptAdapter 
      { 
        onPress: 
        { 
          browseLED = !browseLED
        }
        brightness: browseLED ? onBrightness : dimmedBrightness
        color: module.deckColor
      }
      enabled: !browserMode && !settings.swapViewButtons
    }
	
	Wire 
    { 
      from: "%surface%.browse.add_to_list";   
      to: ButtonScriptAdapter 
      { 
        onPress: 
        { 
          browseLED = !browseLED
        }
		brightness: browseLED ? onBrightness : dimmedBrightness
        color: module.deckColor
      }
      enabled: !browserMode && settings.swapViewButtons
    }
    
    Wire 
    { 
      from: "%surface%.browse.view";   
      to: "browser.full_screen";
      enabled: settings.swapViewButtons
    }
	
	Wire 
    { 
      from: "%surface%.browse.view";   
      to: "browser.full_screen";
      enabled: browserMode && !settings.swapViewButtons
    }
    
    Wire { from: "%surface%.browse.add_to_list";  to: "browser.add_remove_from_prep_list"; enabled: !viewVal && !browserMode && shift }
    Wire { from: "%surface%.browse.add_to_list";  to: "browser.add_remove_from_prep_list"; enabled: viewVal && !browserMode && !shift }
    Wire { from: "%surface%.browse.add_to_list";  to: "browser.add_remove_from_prep_list"; enabled: browserMode }
    Wire { from: "%surface%.browse.add_to_list";  to: "browser.full_screen"; enabled: !viewVal && !settings.swapViewButtons && !shift }
    Wire { from: "%surface%.browse.add_to_list";  to: "browser.full_screen"; enabled: viewVal && !browserMode && !settings.swapViewButtons && shift }
	}
	
	WiresGroup
	{
	enabled: !settings.showBrowserOnFullScreen
    Wire 
    { 
      from: "%surface%.browse.view";   
      to: ButtonScriptAdapter 
      { 
        onPress: 
        { 
          browseLED = !browseLED
        }
        brightness: browseLED ? onBrightness : dimmedBrightness
        color: module.deckColor
      }
    }
	
    Wire { from: "%surface%.browse.add_to_list";  to: "browser.add_remove_from_prep_list"; }
	}
    // enable favortie browsing
    Wire 
    { 
      from: "%surface%.browse.favorite";   
      to: ButtonScriptAdapter 
      { 
        onPress: 
        { 
          module.encoderMode = module.favoritesMode; 
          module.favorites = true;
          brightness = onBrightness;
        }
        onRelease: 
        { 
          module.encoderMode = module.listMode;
          module.favorites = false;
		  brightness = dimmedBrightness;

        } 
        brightness: dimmedBrightness
        color: module.deckColor
      }
    }

    // Load/unload current track to preview play and enable encoder seek
    Wire 
    { 
	  enabled: (isLoadedPreviewProp.value == false) && !settings.disablePreviewPlayerToggle
      from: "%surface%.browse.preview"; 
      to: ButtonScriptAdapter 
      { 
        onPress: 
        { 
			loadPreviewProp.value = true; 
        }
        brightness: dimmedBrightness
        color: module.deckColor
      }
    }
	
	// Load/unload current track to preview play and enable encoder seek
    Wire 
    { 
	  enabled: (isLoadedPreviewProp.value == true) && !settings.disablePreviewPlayerToggle
      from: "%surface%.browse.preview"; 
      to: ButtonScriptAdapter 
      { 
        onPress: 
        { 
			 unloadPreviewProp.value = true; 
        }
        brightness: previewPlayerEnabledTimer.blink ? onBrightness : dimmedBrightness
        color: module.deckColor
      }
    }
	
	// Load/unload current track to preview play and enable encoder seek
    Wire 
    { 
	  enabled: (isLoadedPreviewProp.value == true)
      from: "%surface%.browse.encoder.push"; 
      to: ButtonScriptAdapter 
      { 
        onPress: 
        { 
			 unloadPreviewProp.value = true; 
        }
      }
    }
	
	// Load/unload current track to preview play and enable encoder seek
    Wire 
    { 
	  enabled: settings.disablePreviewPlayerToggle
      from: "%surface%.browse.preview"; 
      to: ButtonScriptAdapter 
      { 
        onPress: 
        { 
			 loadPreviewProp.value = true; 
			 module.encoderMode = module.previewPlayerMode; 
			 brightness = onBrightness
        }
		onRelease: 
        { 
			 unloadPreviewProp.value = true; 
			 module.encoderMode = module.listMode; 
			 brightness = dimmedBrightness
        }
        brightness: dimmedBrightness
        color: module.deckColor
      }
    }

    // Shift
    Wire
    {
      from: "%surface%.shift";
      to: ButtonScriptAdapter
      {
        onPress:
        {
          module.encoderMode = settings.browserEncoderShiftScroll ? module.listMode : module.treeMode;
        }
        onRelease:
        {
          module.encoderMode = module.listMode;
        }
      }
    }

    // list mode
    WiresGroup {
      enabled: module.encoderMode == module.listMode && !isLoadedPreviewProp.value;
      
      Wire { enabled: !settings.browserEncoderShiftScroll; from: "%surface%.browse.encoder"; to: "browser.list_navigation" } 	
	  Wire { enabled: settings.browserEncoderShiftScroll && !shift; from: "%surface%.browse.encoder.turn"; to: RelativePropertyAdapter { path: "app.traktor.browser.list.select_up_down"; step: 1; mode: RelativeMode.Stepped } }
	  Wire { enabled: settings.browserEncoderShiftScroll && shift; from: "%surface%.browse.encoder.turn"; to: RelativePropertyAdapter { path: "app.traktor.browser.list.select_up_down"; step: settings.scrollPageSize; mode: RelativeMode.Stepped } }

	  Wire { from: "%surface%.browse.encoder.push"; to: "browser_load_gestures.input" }
	  Wire { from: "browser_load_gestures.single_click"; to: TriggerPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".load.selected"; output: false } }
      Wire { from: "browser_load_gestures.double_click"; to: TriggerPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".load_secondary.selected"; output: false } }
	  Wire { enabled: settings.disableAllCueOnTrackLoad; from: "%surface%.browse.encoder.push"; to: SetPropertyAdapter { path: "app.traktor.mixer.channels.1.cue"; value: false; } }
	  Wire { enabled: settings.disableAllCueOnTrackLoad; from: "%surface%.browse.encoder.push"; to: SetPropertyAdapter { path: "app.traktor.mixer.channels.2.cue"; value: false; } }
	  Wire { enabled: settings.disableAllCueOnTrackLoad; from: "%surface%.browse.encoder.push"; to: SetPropertyAdapter { path: "app.traktor.mixer.channels.3.cue"; value: false; } }
	  Wire { enabled: settings.disableAllCueOnTrackLoad; from: "%surface%.browse.encoder.push"; to: SetPropertyAdapter { path: "app.traktor.mixer.channels.4.cue"; value: false; } }
	  Wire { enabled: settings.enableCueOnTrackLoad; from: "%surface%.browse.encoder.push"; to: SetPropertyAdapter { path: "app.traktor.mixer.channels." + deckIdx + ".cue"; value: true; } }
      Wire { from: "%surface%.browse.encoder.push"; to: "browser.full_screen"; enabled: !settings.disableKnobFullBrowserCloser && browserMode }
    
	
	
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem1Vol.value != 1.0; from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.1.volume"; value: 1.0 } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem1FiltVal.value != 0.5;  from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.1.filter_value"; value: 0.5 } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem1Filt.value; from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.1.filter_on"; value: false } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem1Muted.value; from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.1.muted"; value: false } }
	  Wire { enabled: settings.resetStemFXOnLoad && propStem1FX.value != 1.0; from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.1.fx_send"; value: 1.0 } }
	  Wire { enabled: settings.resetStemFXOnLoad && !propStem1FXOn.value; from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.1.fx_send_on"; value: true } }

    
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem2Vol.value != 1.0; from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.2.volume"; value: 1.0 } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem2FiltVal.value != 0.5;  from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.2.filter_value"; value: 0.5 } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem2Filt.value; from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.2.filter_on"; value: false } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem2Muted.value; from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.2.muted"; value: false } }
	  Wire { enabled: settings.resetStemFXOnLoad && propStem2FX.value != 1.0; from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.2.fx_send"; value: 1.0 } }
	  Wire { enabled: settings.resetStemFXOnLoad && !propStem2FXOn.value; from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.2.fx_send_on"; value: true } }

    
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem3Vol.value != 1.0; from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.3.volume"; value: 1.0 } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem3FiltVal.value != 0.5;  from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.3.filter_value"; value: 0.5 } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem3Filt.value; from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.3.filter_on"; value: false } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem3Muted.value; from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.3.muted"; value: false } }
	  Wire { enabled: settings.resetStemFXOnLoad && propStem3FX.value != 1.0; from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.3.fx_send"; value: 1.0 } }
	  Wire { enabled: settings.resetStemFXOnLoad && !propStem3FXOn.value; from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.3.fx_send_on"; value: true } }

    
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem4Vol.value != 1.0; from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.4.volume"; value: 1.0 } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem4FiltVal.value != 0.5;  from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.4.filter_value"; value: 0.5 } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem4Filt.value; from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.4.filter_on"; value: false } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem4Muted.value; from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.4.muted"; value: false } }
	  Wire { enabled: settings.resetStemFXOnLoad && propStem4FX.value != 1.0; from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.4.fx_send"; value: 1.0 } }
	  Wire { enabled: settings.resetStemFXOnLoad && !propStem4FXOn.value; from: "browser_load_gestures.single_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.4.fx_send_on"; value: true } }
	  
	  
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem1Vol.value != 1.0; from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.1.volume"; value: 1.0 } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem1FiltVal.value != 0.5;  from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.1.filter_value"; value: 0.5 } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem1Filt.value; from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.1.filter_on"; value: false } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem1Muted.value; from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.1.muted"; value: false } }
	  Wire { enabled: settings.resetStemFXOnLoad && propStem1FX.value != 1.0; from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.1.fx_send"; value: 1.0 } }
	  Wire { enabled: settings.resetStemFXOnLoad && !propStem1FXOn.value; from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.1.fx_send_on"; value: true } }

    
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem2Vol.value != 1.0; from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.2.volume"; value: 1.0 } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem2FiltVal.value != 0.5;  from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.2.filter_value"; value: 0.5 } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem2Filt.value; from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.2.filter_on"; value: false } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem2Muted.value; from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.2.muted"; value: false } }
	  Wire { enabled: settings.resetStemFXOnLoad && propStem2FX.value != 1.0; from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.2.fx_send"; value: 1.0 } }
	  Wire { enabled: settings.resetStemFXOnLoad && !propStem2FXOn.value; from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.2.fx_send_on"; value: true } }

    
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem3Vol.value.value != 1.0; from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.3.volume"; value: 1.0 } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem3FiltVal.value != 0.5;  from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.3.filter_value"; value: 0.5 } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem3Filt.value; from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.3.filter_on"; value: false } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem3Muted.value; from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.3.muted"; value: false } }
	  Wire { enabled: settings.resetStemFXOnLoad && propStem3FX.value != 1.0; from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.3.fx_send"; value: 1.0 } }
	  Wire { enabled: settings.resetStemFXOnLoad && !propStem3FXOn.value; from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.3.fx_send_on"; value: true } }

    
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem4Vol.value != 1.0; from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.4.volume"; value: 1.0 } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem4FiltVal.value != 0.5;  from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.4.filter_value"; value: 0.5 } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem4Filt.value; from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.4.filter_on"; value: false } }
	  Wire { enabled: settings.resetStemControlsOnLoad && propStem4Muted.value; from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.4.muted"; value: false } }
	  Wire { enabled: settings.resetStemFXOnLoad && propStem4FX.value != 1.0; from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.4.fx_send"; value: 1.0 } }
	  Wire { enabled: settings.resetStemFXOnLoad && !propStem4FXOn.value; from: "browser_load_gestures.double_click"; to: SetPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".stems.4.fx_send_on"; value: true } }

	
	}
	
   
    // favorites mode
    Wire 
    { 
      enabled: module.encoderMode == module.favoritesMode && !isLoadedPreviewProp.value;
      from: "%surface%.browse.encoder"; 
      to: "browser.favorites_navigation" 
    }

    // tree mode
    Wire 
    { 
      enabled: module.encoderMode == module.treeMode && !isLoadedPreviewProp.value;
      from: "%surface%.browse.encoder"; 
      to: "browser.tree_navigation" 
    }

    // preview mode
	WiresGroup {
		enabled: settings.disablePreviewPlayerToggle ? module.encoderMode == module.previewPlayerMode : isLoadedPreviewProp.value;
		
		Wire { from: "%surface%.browse.encoder"; to: RelativePropertyAdapter { path: "app.traktor.browser.preview_player.seek"; step: 0.01; mode: RelativeMode.Stepped } }
		Wire { from: "%surface%.browse.encoder.push"; to: TriggerPropertyAdapter { path: "app.traktor.decks." + deckIdx + ".load.from_preview_player" } }
		
	}
  }
}