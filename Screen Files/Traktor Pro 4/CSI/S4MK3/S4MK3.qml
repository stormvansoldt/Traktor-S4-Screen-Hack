import CSI 1.0
import QtQuick 2.0

import "../../Defines"
import "../../Screens/Defines" as Defines2

import "../Common/Settings"


Mapping
{
  S4MK3 { name: "s4mk3" }

  Defines2.Settings {id: settings}
  
  // ----------------- Global Properties ------------------- //

  MappingPropertyDescriptor
  {
    id: ttmodeRpm
    path: "mapping.settings.haptic.platter_speed"
    type: MappingPropertyDescriptor.Integer
    value: 0
  }

  MappingPropertyDescriptor { path: "mapping.settings.tempo_fader_relative"; type: MappingPropertyDescriptor.Boolean; value: true; }
  
  MappingPropertyDescriptor { path: "mapping.settings.haptic.ticks_density"; type: MappingPropertyDescriptor.Integer; value: 0; min: 0; max: 2 }

  MappingPropertyDescriptor { path: "mapping.settings.haptic.tension"; type: MappingPropertyDescriptor.Integer; value: 50; min: 0; max: 255 }
  Wire { from: "s4mk3.jogwheel.tension"; to: ValuePropertyAdapter { path: "mapping.settings.haptic.tension"; ignoreEvents: PinEvent.WireEnabled } }

  MappingPropertyDescriptor { id: hapticHotcuesEnabledProp; path: "mapping.settings.haptic.hotcues_enabled"; type: MappingPropertyDescriptor.Boolean; value: true }

  // ----------------- Mapping Modules ------------------- //

  S4MK3Mixer
  {
    name: "mixer"
    shift: left.eitherShift || right.eitherShift
  }

  S4MK3Side
  {
    id: left
    name: "left"
    surface: "s4mk3.left"
    propertiesPath: "mapping.state.left"
    topDeckIdx: 1
    bottomDeckIdx: 3
    hapticHotcuesEnabled: hapticHotcuesEnabledProp.value
    fx1Active: fx1.active
    fx2Active: fx2.active
  }

  S4MK3Side
  {
    id: right
    name: "right"
    surface: "s4mk3.right"
    propertiesPath: "mapping.state.right"
    topDeckIdx: 2
    bottomDeckIdx: 4
    hapticHotcuesEnabled: hapticHotcuesEnabledProp.value
    fx1Active: fx1.active
    fx2Active: fx2.active
  }
  
  WiresGroup {
    enabled: left.eitherShift && !settings.resetFXFunctions
  	Wire{ from: "s4mk3.left.fx.buttons.2"; to: ButtonScriptAdapter { onPress: { fx1.active = true; fx3.active = false; } brightness: fx1.active ? 1.0 : 0.0 } }
 	Wire{ from: "s4mk3.left.fx.buttons.3"; to: ButtonScriptAdapter { onPress: { fx3.active = true; fx1.active = false; } brightness: fx3.active ? 1.0 : 0.0 } }
 	Wire{ from: "s4mk3.right.fx.buttons.2"; to: ButtonScriptAdapter { onPress: { fx2.active = true; fx4.active = false; } brightness: fx2.active ? 1.0 : 0.0 } }
 	Wire{ from: "s4mk3.right.fx.buttons.3"; to: ButtonScriptAdapter { onPress: { fx4.active = true; fx2.active = false; } brightness: fx4.active ? 1.0 : 0.0 } }
  }

  S4MK3DeckFX
  {
      id: fx1
      name: "fx1"
      active: true
      shift: left.eitherShift
      surface_prefix: "s4mk3.left"
	  propertiesPath: "mapping.state.left.fx1"
      fxUnit: 1
  }

  S4MK3DeckFX
  {
  	  id: fx2
      name: "fx2"
      active: true
      shift: right.eitherShift
      surface_prefix: "s4mk3.right"
	  propertiesPath: "mapping.state.right.fx2"
      fxUnit: 2
  }
  
  S4MK3DeckFX
  {
      id: fx3
      name: "fx3"
      active: false
      shift: left.eitherShift
      surface_prefix: "s4mk3.left"
	  propertiesPath: "mapping.state.left.fx3"
      fxUnit: 3
  }

  S4MK3DeckFX
  {
  	  id: fx4
      name: "fx4"
      active: false
      shift: right.eitherShift
      surface_prefix: "s4mk3.right"
	  propertiesPath: "mapping.state.right.fx4"
      fxUnit: 4
  }

} // mapping

