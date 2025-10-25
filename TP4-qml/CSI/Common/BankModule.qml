import CSI 1.0
import "../S4MK3/S4MK3Functions.js" as S4MK3Functions
import '../../Screens/Defines' as Defines

Module
{
  id: module
  property bool shift: false
  property string surface: ""
  property int deckIdx: 0
  property bool active: false
  
  property int fxBank: 1
    
  Defines.Settings  {id: settings}
  
  property string propertiesPath: ""
  
  AppProperty { id: type; path: "app.traktor.fx." + fxBank + ".type"}
  
  AppProperty { id: routing; path: "app.traktor.fx." + fxBank + ".routing"}




  WiresGroup
  {
    enabled: active
	  
	  Wire { 
	  	enabled: true;
	  	from: "%surface%.pads.1"; 
	  	to: ButtonScriptAdapter {
	  		onPress: {
	  			type.value == 0 ? type.value = 1 : type.value == 1 ? type.value = 2 : type.value == 2 ? type.value = 0 : type.value = type.value;
	  		}
	  		brightness: type.value == 1 ? 0.0 : 1.0;
	  		color: type.value == 0 ? S4MK3Functions.colorForDeckSingle(3) : type.value == 1 ? S4MK3Functions.colorForDeckSingle(3) : type.value == 2 ? S4MK3Functions.colorForDeckSingle(7) : S4MK3Functions.colorForDeckSingle(3)
	  	}
	  }
	  
	  Wire { 
	  	from: "%surface%.pads.5"; 
	  	to: ButtonScriptAdapter {
	  		onPress: {
	  			routing.value == 0 ? routing.value = 1 : routing.value == 1 ? routing.value = 2 : routing.value == 2 ? routing.value = 0 : routing.value = routing.value;
	  			brightness == 1.0;
	  		}
	  		onRelease: {
	  			brightness = 0.0;
	  		}
	  		brightness: 0.0;
	  		color: routing.value == 0 ? S4MK3Functions.colorForDeckSingle(4) : routing.value == 1 ? S4MK3Functions.colorForDeckSingle(2) : routing.value == 2 ? S4MK3Functions.colorForDeckSingle(1) : S4MK3Functions.colorForDeckSingle(0)
	  	}
	  }
	  	  
	  Wire { enabled: type.value != 2; from: "%surface%.pads.2"; to: RelativePropertyAdapter { path: "app.traktor.fx." + fxBank + ".select.1"; step: 1; mode: RelativeMode.Decrement; output: false } }
      Wire { enabled: type.value != 2; from: "%surface%.pads.6"; to: RelativePropertyAdapter { path: "app.traktor.fx." + fxBank + ".select.1"; step: 1; mode: RelativeMode.Increment; output: false } }
	  
	  Wire { enabled: type.value == 2; from: "%surface%.pads.2"; to: RelativePropertyAdapter { path: "app.traktor.fx." + fxBank + ".kitSelect"; step: 1; mode: RelativeMode.Decrement; output: false } }
      Wire { enabled: type.value == 2; from: "%surface%.pads.6"; to: RelativePropertyAdapter { path: "app.traktor.fx." + fxBank + ".kitSelect"; step: 1; mode: RelativeMode.Increment; output: false } }
	  
	  Wire { enabled: type.value == 0; from: "%surface%.pads.3"; to: RelativePropertyAdapter { path: "app.traktor.fx." + fxBank + ".select.2"; step: 1; mode: RelativeMode.Decrement; output: false } }
      Wire { enabled: type.value == 0; from: "%surface%.pads.7"; to: RelativePropertyAdapter { path: "app.traktor.fx." + fxBank + ".select.2"; step: 1; mode: RelativeMode.Increment; output: false } }
	  
      Wire { enabled: type.value == 0; from: "%surface%.pads.4"; to: RelativePropertyAdapter { path: "app.traktor.fx." + fxBank + ".select.3"; step: 1; mode: RelativeMode.Decrement; output: false } }
      Wire { enabled: type.value == 0; from: "%surface%.pads.8"; to: RelativePropertyAdapter { path: "app.traktor.fx." + fxBank + ".select.3"; step: 1; mode: RelativeMode.Increment; output: false } }
	  
	  Wire { 
      	from: "%surface%.pads.2"; 
      	to: ButtonScriptAdapter 
      	{ 
      		onPress: {brightness = 1.0} onRelease: {brightness = 0.0}
      		brightness: 0.0;
      		color: S4MK3Functions.colorForDeckSingle(6); 
      	}
	   }
	   Wire { 
      	from: "%surface%.pads.6"; 
      	to: ButtonScriptAdapter 
      	{ 
      		onPress: {brightness = 1.0} onRelease: {brightness = 0.0}
      		brightness: 0.0;
      		color: S4MK3Functions.colorForDeckSingle(0); 
      	}
	  }
	  
	  Wire { 
	  	enabled: type.value == 0; 
      	from: "%surface%.pads.3"; 
      	to: ButtonScriptAdapter 
      	{ 
      		onPress: {brightness = 1.0} onRelease: {brightness = 0.0}
      		brightness: 0.0;
      		color: S4MK3Functions.colorForDeckSingle(6); 
      	}
	   }
	   Wire { 
	   	enabled: type.value == 0; 
      	from: "%surface%.pads.7"; 
      	to: ButtonScriptAdapter 
      	{ 
      		onPress: {brightness = 1.0} onRelease: {brightness = 0.0}
      		brightness: 0.0;
      		color: S4MK3Functions.colorForDeckSingle(0); 
      	}
	  }
	  
	  Wire { 
	  	enabled: type.value == 0; 
      	from: "%surface%.pads.4"; 
      	to: ButtonScriptAdapter 
      	{ 
      		onPress: {brightness = 1.0} onRelease: {brightness = 0.0}
      		brightness: 0.0;
      		color: S4MK3Functions.colorForDeckSingle(6); 
      	}
	   }
	   Wire { 
      	enabled: type.value == 0; 
      	from: "%surface%.pads.8"; 
      	to: ButtonScriptAdapter 
      	{ 
      		onPress: {brightness = 1.0} onRelease: {brightness = 0.0}
      		brightness: 0.0;
      		color: S4MK3Functions.colorForDeckSingle(0); 
      	}
	  }
      
      
  }
}
