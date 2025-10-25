import CSI 1.0
import QtQuick 2.5
import "../Common"
import "S4MK3Functions.js" as S4MK3Functions

Module
{
  id: module
  
  property bool active: false
  
  property string surface_prefix: "s4mk3.left"
  property string propertiesPath: ""
  property int fxUnit: 1
  property bool shift: false
    
  AppProperty { id: fxMode; path: "app.traktor.fx.4fx_units" }
  
  AppProperty { id: routing; path: "app.traktor.fx." + fxUnit + ".routing" }
  
  FxUnit { name: "adapter"; channel: fxUnit}
  
  WiresGroup {
    enabled: module.active && !settings.resetFXFunctions
    
    WiresGroup {

    	// knobs
 	   Wire { from: "%surface_prefix%.fx.knobs.1"; to: "adapter.dry_wet" }
 	   Wire { from: "%surface_prefix%.fx.knobs.2"; to: "adapter.knob1" }
 	   Wire { from: "%surface_prefix%.fx.knobs.3"; to: "adapter.knob2" }
 	   Wire { from: "%surface_prefix%.fx.knobs.4"; to: "adapter.knob3" }
 	}
  
    WiresGroup {
		enabled: !shift

        // buttons
        Wire { from: "%surface_prefix%.fx.buttons.1"; to: "adapter.enabled" }
  		Wire { from: "%surface_prefix%.fx.buttons.2"; to: "adapter.button1" }
  		Wire { from: "%surface_prefix%.fx.buttons.3"; to: "adapter.button2" }
  		Wire { from: "%surface_prefix%.fx.buttons.4"; to: "adapter.button3" }
 	}
 	
  }
  
  WiresGroup {
    enabled: module.active && settings.resetFXFunctions
    
    // knobs
  Wire { from: "%surface_prefix%.fx.knobs.1"; to: "adapter.dry_wet" }
  Wire { from: "%surface_prefix%.fx.knobs.2"; to: "adapter.knob1" }
  Wire { from: "%surface_prefix%.fx.knobs.3"; to: "adapter.knob2" }
  Wire { from: "%surface_prefix%.fx.knobs.4"; to: "adapter.knob3" }

  // buttons
  Wire { from: "%surface_prefix%.fx.buttons.1"; to: "adapter.enabled" }
  Wire { from: "%surface_prefix%.fx.buttons.2"; to: "adapter.button1" }
  Wire { from: "%surface_prefix%.fx.buttons.3"; to: "adapter.button2" }
  Wire { from: "%surface_prefix%.fx.buttons.4"; to: "adapter.button3" }
  
 	
 	
  }
  
}
