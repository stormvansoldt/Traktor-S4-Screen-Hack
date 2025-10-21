import CSI 1.0
import "../S4MK3/S4MK3Functions.js" as S4MK3Functions
import '../../Screens/Defines' as Defines


Module
{
  id: module

  Defines.Settings  {id: settings}
  
  property bool shift: false
  property string surface: ""
  property bool active: false
  property string deckPropertiesPath: ""

  WiresGroup
  {
    enabled: active 

    WiresGroup
    {
      enabled: !module.shift

	  Wire { 
		from: "%surface%.pads.1";
		to: SetPropertyAdapter { path: "app.traktor.browser.favorites.select"; value: 0; color: S4MK3Functions.colorForDeckSingle(settings.favorites1PadColor)  }
      }
	  Wire { 
		from: "%surface%.pads.2";
		to: SetPropertyAdapter { path: "app.traktor.browser.favorites.select"; value: 1; color: S4MK3Functions.colorForDeckSingle(settings.favorites2PadColor)  }
      }
	  Wire { 
		from: "%surface%.pads.3";
		to: SetPropertyAdapter { path: "app.traktor.browser.favorites.select"; value: 2; color: S4MK3Functions.colorForDeckSingle(settings.favorites3PadColor)  }
      } 
	  Wire { 
		from: "%surface%.pads.4";
		to: SetPropertyAdapter { path: "app.traktor.browser.favorites.select"; value: 3; color: S4MK3Functions.colorForDeckSingle(settings.favorites4PadColor)  }
      } 
	  Wire { 
		from: "%surface%.pads.5";
		to: SetPropertyAdapter { path: "app.traktor.browser.favorites.select"; value: 4; color: S4MK3Functions.colorForDeckSingle(settings.favorites5PadColor)  }
      } 
	  Wire { 
		from: "%surface%.pads.6";
		to: SetPropertyAdapter { path: "app.traktor.browser.favorites.select"; value: 5; color: S4MK3Functions.colorForDeckSingle(settings.favorites6PadColor)  }
      } 
	  Wire { 
		from: "%surface%.pads.7";
		to: SetPropertyAdapter { path: "app.traktor.browser.favorites.select"; value: 6; color: S4MK3Functions.colorForDeckSingle(settings.favorites7PadColor)  }
      } 
	  Wire { 
		from: "%surface%.pads.8";
		to: SetPropertyAdapter { path: "app.traktor.browser.favorites.select"; value: 7; color: S4MK3Functions.colorForDeckSingle(settings.favorites8PadColor)  }
      } 
	  
    }

    WiresGroup
    {
      enabled: module.shift
	  Wire { 
		from: "%surface%.pads.1";
		to: SetPropertyAdapter { path: "app.traktor.browser.favorites.select"; value: 8; color: S4MK3Functions.colorForDeckSingle(settings.favorites9PadColor)  }
      } 
	  Wire { 
		from: "%surface%.pads.2";
		to: SetPropertyAdapter { path: "app.traktor.browser.favorites.select"; value: 9; color: S4MK3Functions.colorForDeckSingle(settings.favorites10PadColor)  }
      }
	  Wire { 
		from: "%surface%.pads.3";
		to: SetPropertyAdapter { path: "app.traktor.browser.favorites.select"; value: 10; color: S4MK3Functions.colorForDeckSingle(settings.favorites11PadColor)  }
      } 
	  Wire { 
		from: "%surface%.pads.4";
		to: SetPropertyAdapter { path: "app.traktor.browser.favorites.select"; value: 11; color: S4MK3Functions.colorForDeckSingle(settings.favorites12PadColor)  }
      } 
    }
  }
}
