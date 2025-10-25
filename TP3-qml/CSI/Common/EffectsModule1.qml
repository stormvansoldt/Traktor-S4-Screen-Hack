import CSI 1.0
import QtQuick 2.5
import "../S4MK3/S4MK3Functions.js" as S4MK3Functions
import '../../Screens/Defines' as Defines


Module
{
  id: module

  Defines.Settings  {id: settings}
  
  property int deckIdx: 1
  
  AppProperty {id: fxAssign; path: "app.traktor.mixer.channels." + module.deckIdx + ".fx.assign." + module.fxUnit}
  
  property bool shift: false
  property string surface: ""
  property bool active: false
  onActiveChanged: {
  	active ? slot1.value = 0 : slot1.value = slot1.value;
  	active ? slot2.value = 0 : slot2.value = slot2.value;
  	active ? slot3.value = 0 : slot3.value = slot3.value;
  	active && settings.autoEnableFX1 ? fxAssign.value = true : fxAssign.value = false;
  }
  property string deckPropertiesPath: ""
  property int fxUnit: 0
  
  property int effect1: settings.fx1pad1
  property int effect2: settings.fx1pad2
  property int effect3: settings.fx1pad3
  property int effect4: settings.fx1pad4
  property int effect5: settings.fx1pad5
  property int effect6: settings.fx1pad6
  property int effect7: settings.fx1pad7
  property int effect8: settings.fx1pad8
  
  property real knob1PrevVal: 0
  property real knob2PrevVal: 0
  property real knob3PrevVal: 0

  AppProperty {id: button1; path: "app.traktor.fx." + module.fxUnit + ".buttons.1"}
  AppProperty {id: button2; path: "app.traktor.fx." + module.fxUnit + ".buttons.2"}
  AppProperty {id: button3; path: "app.traktor.fx." + module.fxUnit + ".buttons.3"}
  
  AppProperty {id: knob1; path: "app.traktor.fx." + module.fxUnit + ".knobs.1"}
  AppProperty {id: knob2; path: "app.traktor.fx." + module.fxUnit + ".knobs.2"}
  AppProperty {id: knob3; path: "app.traktor.fx." + module.fxUnit + ".knobs.3"}
  
  property bool button1val: button1.value
  property bool button2val: button2.value
  property bool button3val: button3.value
  
  AppProperty {id: slot1; path: "app.traktor.fx." + module.fxUnit + ".select.1"}
  AppProperty {id: slot2; path: "app.traktor.fx." + module.fxUnit + ".select.2"}
  AppProperty {id: slot3; path: "app.traktor.fx." + module.fxUnit + ".select.3"}

  property int slot1val: slot1.value
  property int slot2val: slot2.value
  property int slot3val: slot3.value

  Timer {
  	id: timer1
    interval: 10
    running: active
    repeat: true
    onTriggered: slot1.value != 0 ? button1.value = 1 : module.effect1 = module.effect1;
  }
  
  Timer {
  	id: timer2
    interval: 10
    running: active
    repeat: true
    onTriggered: slot2.value != 0 ? button2.value = 1 : module.effect1 = module.effect1;
  }
  
  Timer {
  	id: timer3
    interval: 10
    running: active
    repeat: true
    onTriggered: slot3.value != 0 ? button3.value = 1 : module.effect1 = module.effect1;
  }

  WiresGroup
  {
    enabled: active 

    WiresGroup
    {
	  enabled: !module.shift && !settings.toggleOnly1
 	  Wire {
		from: "%surface%.pads.1";
		to: ButtonScriptAdapter 
		{ 
			onPress: 
			{

				(slot1.value == module.effect1) || (slot2.value == module.effect1) || (slot3.value == module.effect1) ? module.effect1 = module.effect1 : 
				!module.button1val ? module.knob1PrevVal = knob1.value : 
				!module.button2val ? module.knob2PrevVal = knob2.value : 
				!module.button3val ? module.knob3PrevVal = knob3.value : 
					module.effect1 = module.effect1;	
			
				(slot1.value == module.effect1) || (slot2.value == module.effect1) || (slot3.value == module.effect1) ? module.effect1 = module.effect1 : 
				!module.button1val ? slot1.value = module.effect1 : 
					!module.button2val ? slot2.value = module.effect1 : 
						!module.button3val ? slot3.value = module.effect1 : 
							module.effect1 = module.effect1; 
							
				(settings.fx1pad1set == true) && slot1.value == module.effect1 ? knob1.value = settings.fx1pad1value/100 : module.effect1 = module.effect1 	
					(settings.fx1pad1set == true) && slot2.value == module.effect1 ? knob2.value = settings.fx1pad1value/100 : module.effect1 = module.effect1 	
						(settings.fx1pad1set == true) && slot3.value == module.effect1 ? knob3.value = settings.fx1pad1value/100 : module.effect1 = module.effect1 	
			}
			onRelease:
			{ 
				slot1.value == module.effect1 ? slot1.value = 0 : module.effect1 = module.effect1 	
					slot2.value == module.effect1 ? slot2.value = 0 : module.effect1 = module.effect1 	
						slot3.value == module.effect1 ? slot3.value = 0 : module.effect1 = module.effect1 
						
				knob1.value = module.knob1PrevVal;
				knob2.value = module.knob2PrevVal;
				knob3.value = module.knob3PrevVal;


			}
			brightness: ((slot1.value == module.effect1) && module.button1val) || ((slot2.value == module.effect1) && module.button2val) || ((slot3.value == module.effect1) && module.button3val) ? 1.0 : 0.0
			color: (slot1.value == module.effect1) || (slot2.value == module.effect1) || (slot3.value == module.effect1) ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(3)

		}
	  }
	  
 	  
 	  Wire {
		from: "%surface%.pads.2";
		to: ButtonScriptAdapter 
		{ 
			onPress: 
			{
				(slot1.value == module.effect2) || (slot2.value == module.effect2) || (slot3.value == module.effect2) ? module.effect2 = module.effect2 : 
				!module.button1val ? module.knob1PrevVal = knob1.value : 
				!module.button2val ? module.knob2PrevVal = knob2.value : 
				!module.button3val ? module.knob3PrevVal = knob3.value : 
					module.effect2 = module.effect2;	
			
				(slot1.value == module.effect2) || (slot2.value == module.effect2) || (slot3.value == module.effect2) ? module.effect2 = module.effect2 : 
				!module.button1val ? slot1.value = module.effect2 : 
					!module.button2val ? slot2.value = module.effect2 : 
						!module.button3val ? slot3.value = module.effect2 : 
							module.effect2 = module.effect2; 
				(settings.fx1pad2set == true) && slot1.value == module.effect2 ? knob1.value = settings.fx1pad2value/100 : module.effect2 = module.effect2 	
					(settings.fx1pad2set == true) && slot2.value == module.effect2 ? knob2.value = settings.fx1pad2value/100 : module.effect2 = module.effect2 	
						(settings.fx1pad2set == true) && slot3.value == module.effect2 ? knob3.value = settings.fx1pad2value/100 : module.effect2 = module.effect2 	

			}
			onRelease:
			{ 
				slot1.value == module.effect2 ? slot1.value = 0 : module.effect2 = module.effect2 	
					slot2.value == module.effect2 ? slot2.value = 0 : module.effect2 = module.effect2 	
						slot3.value == module.effect2 ? slot3.value = 0 : module.effect2 = module.effect2 	
				knob1.value = module.knob1PrevVal;
				knob2.value = module.knob2PrevVal;
				knob3.value = module.knob3PrevVal;

			}
			brightness: ((slot1.value == module.effect2) && module.button1val) || ((slot2.value == module.effect2) && module.button2val) || ((slot3.value == module.effect2) && module.button3val) ? 1.0 : 0.0
			color: (slot1.value == module.effect2) || (slot2.value == module.effect2) || (slot3.value == module.effect2) ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(3)
		}
	  }
	
 	  Wire {
		from: "%surface%.pads.3";
		to: ButtonScriptAdapter 
		{ 
			onPress: 
			{
				(slot1.value == module.effect3) || (slot2.value == module.effect3) || (slot3.value == module.effect3) ? module.effect3 = module.effect3 : 
				!module.button1val ? module.knob1PrevVal = knob1.value : 
				!module.button2val ? module.knob2PrevVal = knob2.value : 
				!module.button3val ? module.knob3PrevVal = knob3.value : 
					module.effect3 = module.effect3;	
			
				(slot1.value == module.effect3) || (slot2.value == module.effect3) || (slot3.value == module.effect3) ? module.effect3 = module.effect3 : 
				!module.button1val ? slot1.value = module.effect3 : 
					!module.button2val ? slot2.value = module.effect3 : 
						!module.button3val ? slot3.value = module.effect3 : 
							module.effect3 = module.effect3; 
				(settings.fx1pad3set == true) && slot1.value == module.effect3 ? knob1.value = settings.fx1pad3value/100 : module.effect3 = module.effect3 	
					(settings.fx1pad3set == true) && slot2.value == module.effect3 ? knob2.value = settings.fx1pad3value/100 : module.effect3 = module.effect3 	
						(settings.fx1pad3set == true) && slot3.value == module.effect3 ? knob3.value = settings.fx1pad3value/100 : module.effect3 = module.effect3 								
			}
			onRelease:
			{ 
				slot1.value == module.effect3 ? slot1.value = 0 : module.effect3 = module.effect3 	
					slot2.value == module.effect3 ? slot2.value = 0 : module.effect3 = module.effect3 	
						slot3.value == module.effect3 ? slot3.value = 0 : module.effect3 = module.effect3 	
				knob1.value = module.knob1PrevVal;
				knob2.value = module.knob2PrevVal;
				knob3.value = module.knob3PrevVal;

			}
			brightness: ((slot1.value == module.effect3) && module.button1val) || ((slot2.value == module.effect3) && module.button2val) || ((slot3.value == module.effect3) && module.button3val) ? 1.0 : 0.0
			color: (slot1.value == module.effect3) || (slot2.value == module.effect3) || (slot3.value == module.effect3) ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(3)
		}
	  }
	
 	  Wire {
		from: "%surface%.pads.4";
		to: ButtonScriptAdapter 
		{ 
			onPress: 
			{
				(slot1.value == module.effect4) || (slot2.value == module.effect4) || (slot3.value == module.effect4) ? module.effect4 = module.effect4 : 
				!module.button1val ? module.knob1PrevVal = knob1.value : 
				!module.button2val ? module.knob2PrevVal = knob2.value : 
				!module.button3val ? module.knob3PrevVal = knob3.value : 
					module.effect4 = module.effect4;	
			
				(slot1.value == module.effect4) || (slot2.value == module.effect4) || (slot3.value == module.effect4) ? module.effect4 = module.effect4 : 
				!module.button1val ? slot1.value = module.effect4 : 
					!module.button2val ? slot2.value = module.effect4 : 
						!module.button3val ? slot3.value = module.effect4 : 
							module.effect4 = module.effect4; 
				(settings.fx1pad4set == true) && slot1.value == module.effect4 ? knob1.value = settings.fx1pad4value/100 : module.effect4 = module.effect4 	
					(settings.fx1pad4set == true) && slot2.value == module.effect4 ? knob2.value = settings.fx1pad4value/100 : module.effect4 = module.effect4 	
						(settings.fx1pad4set == true) && slot3.value == module.effect4 ? knob3.value = settings.fx1pad4value/100 : module.effect4 = module.effect4 	
			}
			onRelease:
			{ 
				slot1.value == module.effect4 ? slot1.value = 0 :module.effect4 = module.effect4 	
					slot2.value == module.effect4 ? slot2.value = 0 :module.effect4 = module.effect4 	
						slot3.value == module.effect4 ? slot3.value = 0 :module.effect4 = module.effect4 	
				knob1.value = module.knob1PrevVal;
				knob2.value = module.knob2PrevVal;
				knob3.value = module.knob3PrevVal;

			}
			brightness: ((slot1.value == module.effect4) && module.button1val) || ((slot2.value == module.effect4) && module.button2val) || ((slot3.value == module.effect4) && module.button3val) ? 1.0 : 0.0
			color: (slot1.value == module.effect4) || (slot2.value == module.effect4) || (slot3.value == module.effect4) ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(3)
		}
	  }
	
 	  Wire {
		from: "%surface%.pads.5";
		to: ButtonScriptAdapter 
		{ 
			onPress: 
			{
				(slot1.value == module.effect5) || (slot2.value == module.effect5) || (slot3.value == module.effect5) ? module.effect5 = module.effect5 : 
				!module.button1val ? module.knob1PrevVal = knob1.value : 
				!module.button2val ? module.knob2PrevVal = knob2.value : 
				!module.button3val ? module.knob3PrevVal = knob3.value : 
					module.effect5 = module.effect5;	
			
				(slot1.value == module.effect5) || (slot2.value == module.effect5) || (slot3.value == module.effect5) ? module.effect5 = module.effect5 : 
				!module.button1val ? slot1.value = module.effect5 : 
					!module.button2val ? slot2.value = module.effect5 : 
						!module.button3val ? slot3.value = module.effect5 : 
							module.effect5 = module.effect5; 
				(settings.fx1pad5set == true) && slot1.value == module.effect5 ? knob1.value = settings.fx1pad5value/100 : module.effect5 = module.effect5 	
					(settings.fx1pad5set == true) && slot2.value == module.effect5 ? knob2.value = settings.fx1pad5value/100 : module.effect5 = module.effect5 	
						(settings.fx1pad5set == true) && slot3.value == module.effect5 ? knob3.value = settings.fx1pad5value/100 : module.effect5 = module.effect5 	
			}
			onRelease:
			{ 
				slot1.value == module.effect5 ? slot1.value = 0 : module.effect5 = module.effect5 	
					slot2.value == module.effect5 ? slot2.value = 0 : module.effect5 = module.effect5 	
						slot3.value == module.effect5 ? slot3.value = 0 : module.effect5 = module.effect5 	
				knob1.value = module.knob1PrevVal;
				knob2.value = module.knob2PrevVal;
				knob3.value = module.knob3PrevVal;

			}
			brightness: ((slot1.value == module.effect5) && module.button1val) || ((slot2.value == module.effect5) && module.button2val) || ((slot3.value == module.effect5) && module.button3val) ? 1.0 : 0.0
			color: (slot1.value == module.effect5) || (slot2.value == module.effect5) || (slot3.value == module.effect5) ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(3)
		}
	  }
	
 	  Wire {
		from: "%surface%.pads.6";
		to: ButtonScriptAdapter 
		{ 
			onPress: 
			{
				(slot1.value == module.effect6) || (slot2.value == module.effect6) || (slot3.value == module.effect6) ? module.effect6 = module.effect6 : 
				!module.button1val ? module.knob1PrevVal = knob1.value : 
				!module.button2val ? module.knob2PrevVal = knob2.value : 
				!module.button3val ? module.knob3PrevVal = knob3.value : 
					module.effect6 = module.effect6;	
			
				(slot1.value == module.effect6) || (slot2.value == module.effect6) || (slot3.value == module.effect6) ? module.effect6 = module.effect6 : 
				!module.button1val ? slot1.value = module.effect6 : 
					!module.button2val ? slot2.value = module.effect6 : 
						!module.button3val ? slot3.value = module.effect6 : 
							module.effect6 = module.effect6; 
				(settings.fx1pad6set == true) && slot1.value == module.effect6 ? knob1.value = settings.fx1pad6value/100 : module.effect6 = module.effect6 	
					(settings.fx1pad6set == true) && slot2.value == module.effect6 ? knob2.value = settings.fx1pad6value/100 : module.effect6 = module.effect6 	
						(settings.fx1pad6set == true) && slot3.value == module.effect6 ? knob3.value = settings.fx1pad6value/100 : module.effect6 = module.effect6 	
			}
			onRelease:
			{ 
				slot1.value == module.effect6 ? slot1.value = 0 : module.effect6 = module.effect6 	
					slot2.value == module.effect6 ? slot2.value = 0 : module.effect6 = module.effect6 	
						slot3.value == module.effect6 ? slot3.value = 0 : module.effect6 = module.effect6 	
				knob1.value = module.knob1PrevVal;
				knob2.value = module.knob2PrevVal;
				knob3.value = module.knob3PrevVal;

			}
			brightness: ((slot1.value == module.effect6) && module.button1val) || ((slot2.value == module.effect6) && module.button2val) || ((slot3.value == module.effect6) && module.button3val) ? 1.0 : 0.0
			color: (slot1.value == module.effect6) || (slot2.value == module.effect6) || (slot3.value == module.effect6) ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(3)
		}
	  }
	
 	  Wire {
		from: "%surface%.pads.7";
		to: ButtonScriptAdapter 
		{ 
			onPress: 
			{
				(slot1.value == module.effect7) || (slot2.value == module.effect7) || (slot3.value == module.effect7) ? module.effect7 = module.effect7 : 
				!module.button1val ? module.knob1PrevVal = knob1.value : 
				!module.button2val ? module.knob2PrevVal = knob2.value : 
				!module.button3val ? module.knob3PrevVal = knob3.value : 
					module.effect7 = module.effect7;	
			
				(slot1.value == module.effect7) || (slot2.value == module.effect7) || (slot3.value == module.effect7) ? module.effect7 = module.effect7 : 
				!module.button1val ? slot1.value = module.effect7 : 
					!module.button2val ? slot2.value = module.effect7 : 
						!module.button3val ? slot3.value = module.effect7 : 
							module.effect7 = module.effect7; 
				(settings.fx1pad7set == true) && slot1.value == module.effect7 ? knob1.value = settings.fx1pad7value/100 : module.effect7 = module.effect7 	
					(settings.fx1pad7set == true) && slot2.value == module.effect7 ? knob2.value = settings.fx1pad7value/100 : module.effect7 = module.effect7 	
						(settings.fx1pad7set == true) && slot3.value == module.effect7 ? knob3.value = settings.fx1pad7value/100 : module.effect7 = module.effect7 	
			}
			onRelease:
			{ 
				slot1.value == module.effect7 ? slot1.value = 0 : module.effect7 = module.effect7 	
					slot2.value == module.effect7 ? slot2.value = 0 : module.effect7 = module.effect7 	
						slot3.value == module.effect7 ? slot3.value = 0 : module.effect7 = module.effect7 	
				knob1.value = module.knob1PrevVal;
				knob2.value = module.knob2PrevVal;
				knob3.value = module.knob3PrevVal;

			}
			brightness: ((slot1.value == module.effect7) && module.button1val) || ((slot2.value == module.effect7) && module.button2val) || ((slot3.value == module.effect7) && module.button3val) ? 1.0 : 0.0
			color: (slot1.value == module.effect7) || (slot2.value == module.effect7) || (slot3.value == module.effect7) ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(3)
		}
	  }
	
 	  Wire {
		from: "%surface%.pads.8";
		to: ButtonScriptAdapter 
		{ 
			onPress: 
			{
				(slot1.value == module.effect8) || (slot2.value == module.effect8) || (slot3.value == module.effect8) ? module.effect8 = module.effect8 : 
				!module.button1val ? module.knob1PrevVal = knob1.value : 
				!module.button2val ? module.knob2PrevVal = knob2.value : 
				!module.button3val ? module.knob3PrevVal = knob3.value : 
					module.effect8 = module.effect8;	
			
				(slot1.value == module.effect8) || (slot2.value == module.effect8) || (slot3.value == module.effect8) ? module.effect8 = module.effect8 : 
				!module.button1val ? slot1.value = module.effect8 : 
					!module.button2val ? slot2.value = module.effect8 : 
						!module.button3val ? slot3.value = module.effect8 : 
							module.effect8 = module.effect8; 
				(settings.fx1pad8set == true) && slot1.value == module.effect8 ? knob1.value = settings.fx1pad8value/100 : module.effect8 = module.effect8 	
					(settings.fx1pad8set == true) && slot2.value == module.effect8 ? knob2.value = settings.fx1pad8value/100 : module.effect8 = module.effect8 	
						(settings.fx1pad8set == true) && slot3.value == module.effect8 ? knob3.value = settings.fx1pad8value/100 : module.effect8 = module.effect8 	
			}
			onRelease:
			{ 
				slot1.value == module.effect8 ? slot1.value = 0 : module.effect8 = module.effect8 	
					slot2.value == module.effect8 ? slot2.value = 0 : module.effect8 = module.effect8 	
						slot3.value == module.effect8 ? slot3.value = 0 : module.effect8 = module.effect8 
				knob1.value = module.knob1PrevVal;
				knob2.value = module.knob2PrevVal;
				knob3.value = module.knob3PrevVal;

			}
			brightness: ((slot1.value == module.effect8) && module.button1val) || ((slot2.value == module.effect8) && module.button2val) || ((slot3.value == module.effect8) && module.button3val) ? 1.0 : 0.0
			color: (slot1.value == module.effect8) || (slot2.value == module.effect8) || (slot3.value == module.effect8) ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(3)
		}
	  }
	}
	
	WiresGroup
    {
	  enabled: module.shift || settings.toggleOnly1
 	  Wire {
		from: "%surface%.pads.1";
		to: ButtonScriptAdapter 
		{ 
			onPress: 
			{
				(slot1.value == module.effect1) || (slot2.value == module.effect1) || (slot3.value == module.effect1) ? module.effect1 = module.effect1 : 
				!module.button1val ? module.knob1PrevVal = knob1.value : 
				!module.button2val ? module.knob2PrevVal = knob2.value : 
				!module.button3val ? module.knob3PrevVal = knob3.value : 
					module.effect1 = module.effect1;	
			
			(slot1.value == module.effect1) || (slot2.value == module.effect1) || (slot3.value == module.effect1) ? (slot1.value == module.effect1 ? slot1.value = 0 : slot2.value == module.effect1 ? slot2.value = 0 : slot3.value == module.effect1 ? slot3.value = 0 : module.effect1 = module.effect1) :	
				!module.button1val ? slot1.value = module.effect1 : 
					!module.button2val ? slot2.value = module.effect1 : 
						!module.button3val ? slot3.value = module.effect1 : 
							module.effect1 = module.effect1; 
				(settings.fx1pad1set == true) && slot1.value == module.effect1 ? knob1.value = settings.fx1pad1value/100 : module.effect1 = module.effect1 	
					(settings.fx1pad1set == true) && slot2.value == module.effect1 ? knob2.value = settings.fx1pad1value/100 : module.effect1 = module.effect1 	
						(settings.fx1pad1set == true) && slot3.value == module.effect1 ? knob3.value = settings.fx1pad1value/100 : module.effect1 = module.effect1 	
			}
			
			brightness: ((slot1.value == module.effect1) && module.button1val) || ((slot2.value == module.effect1) && module.button2val) || ((slot3.value == module.effect1) && module.button3val) ? 1.0 : 0.0
			color: (slot1.value == module.effect1) || (slot2.value == module.effect1) || (slot3.value == module.effect1) ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(3)

		}
	  }
	  
	  Wire {
		from: "%surface%.pads.2";
		to: ButtonScriptAdapter 
		{ 
			onPress: 
			{
				(slot1.value == module.effect2) || (slot2.value == module.effect2) || (slot3.value == module.effect2) ? module.effect2 = module.effect2 : 
				!module.button1val ? module.knob1PrevVal = knob1.value : 
				!module.button2val ? module.knob2PrevVal = knob2.value : 
				!module.button3val ? module.knob3PrevVal = knob3.value : 
					module.effect2 = module.effect2;	
			
			(slot1.value == module.effect2) || (slot2.value == module.effect2) || (slot3.value == module.effect2) ? (slot1.value == module.effect2 ? slot1.value = 0 : slot2.value == module.effect2 ? slot2.value = 0 : slot3.value == module.effect2 ? slot3.value = 0 : module.effect1 = module.effect1) :	
				!module.button1val ? slot1.value = module.effect2 : 
					!module.button2val ? slot2.value = module.effect2 : 
						!module.button3val ? slot3.value = module.effect2 : 
							module.effect1 = module.effect1; 
				(settings.fx1pad2set == true) && slot1.value == module.effect1 ? knob1.value = settings.fx1pad2value/100 : module.effect1 = module.effect1 	
					(settings.fx1pad2set == true) && slot2.value == module.effect1 ? knob2.value = settings.fx1pad2value/100 : module.effect1 = module.effect1 	
						(settings.fx1pad2set == true) && slot3.value == module.effect1 ? knob3.value = settings.fx1pad2value/100 : module.effect1 = module.effect1 	
			}
			
			brightness: ((slot1.value == module.effect2) && module.button1val) || ((slot2.value == module.effect2) && module.button2val) || ((slot3.value == module.effect2) && module.button3val) ? 1.0 : 0.0
			color: (slot1.value == module.effect2) || (slot2.value == module.effect2) || (slot3.value == module.effect2) ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(3)

		}
	  }
	  
	  Wire {
		from: "%surface%.pads.3";
		to: ButtonScriptAdapter 
		{ 
			onPress: 
			{
				(slot1.value == module.effect3) || (slot2.value == module.effect3) || (slot3.value == module.effect3) ? module.effect3 = module.effect3 : 
				!module.button1val ? module.knob1PrevVal = knob1.value : 
				!module.button2val ? module.knob2PrevVal = knob2.value : 
				!module.button3val ? module.knob3PrevVal = knob3.value : 
					module.effect3 = module.effect3;	
			
			(slot1.value == module.effect3) || (slot2.value == module.effect3) || (slot3.value == module.effect3) ? (slot1.value == module.effect3 ? slot1.value = 0 : slot2.value == module.effect3 ? slot2.value = 0 : slot3.value == module.effect3 ? slot3.value = 0 : module.effect3 = module.effect3) :	
				!module.button1val ? slot1.value = module.effect3 : 
					!module.button2val ? slot2.value = module.effect3 : 
						!module.button3val ? slot3.value = module.effect3 : 
							module.effect3 = module.effect3; 
				(settings.fx1pad3set == true) && slot1.value == module.effect1 ? knob1.value = settings.fx1pad3value/100 : module.effect1 = module.effect1 	
					(settings.fx1pad3set == true) && slot2.value == module.effect1 ? knob2.value = settings.fx1pad3value/100 : module.effect1 = module.effect1 	
						(settings.fx1pad3set == true) && slot3.value == module.effect1 ? knob3.value = settings.fx1pad3value/100 : module.effect1 = module.effect1 	
			}
			
			brightness: ((slot1.value == module.effect3) && module.button1val) || ((slot2.value == module.effect3) && module.button2val) || ((slot3.value == module.effect3) && module.button3val) ? 1.0 : 0.0
			color: (slot1.value == module.effect3) || (slot2.value == module.effect3) || (slot3.value == module.effect3) ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(3)

		}
	  }
	   	  
	  Wire {
		from: "%surface%.pads.4";
		to: ButtonScriptAdapter 
		{ 
			onPress: 
			{
				(slot1.value == module.effect4) || (slot2.value == module.effect4) || (slot3.value == module.effect4) ? module.effect4 = module.effect4 : 
				!module.button1val ? module.knob1PrevVal = knob1.value : 
				!module.button2val ? module.knob2PrevVal = knob2.value : 
				!module.button3val ? module.knob3PrevVal = knob3.value : 
					module.effect4 = module.effect4;	
			
			(slot1.value == module.effect4) || (slot2.value == module.effect4) || (slot3.value == module.effect4) ? (slot1.value == module.effect4 ? slot1.value = 0 : slot2.value == module.effect4 ? slot2.value = 0 : slot3.value == module.effect4 ? slot3.value = 0 : module.effect4 = module.effect4) :	
				!module.button1val ? slot1.value = module.effect4 : 
					!module.button2val ? slot2.value = module.effect4 : 
						!module.button3val ? slot3.value = module.effect4 : 
							module.effect4 = module.effect4; 
				(settings.fx1pad4set == true) && slot1.value == module.effect1 ? knob1.value = settings.fx1pad4value/100 : module.effect1 = module.effect1 	
					(settings.fx1pad4set == true) && slot2.value == module.effect1 ? knob2.value = settings.fx1pad4value/100 : module.effect1 = module.effect1 	
						(settings.fx1pad4set == true) && slot3.value == module.effect1 ? knob3.value = settings.fx1pad4value/100 : module.effect1 = module.effect1 	
			}
			
			brightness: ((slot1.value == module.effect4) && module.button1val) || ((slot2.value == module.effect4) && module.button2val) || ((slot3.value == module.effect4) && module.button3val) ? 1.0 : 0.0
			color: (slot1.value == module.effect4) || (slot2.value == module.effect4) || (slot3.value == module.effect4) ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(3)

		}
	  }
	   	  
	  Wire {
		from: "%surface%.pads.5";
		to: ButtonScriptAdapter 
		{ 
			onPress: 
			{
				(slot1.value == module.effect5) || (slot2.value == module.effect5) || (slot3.value == module.effect5) ? module.effect5 = module.effect5 : 
				!module.button1val ? module.knob1PrevVal = knob1.value : 
				!module.button2val ? module.knob2PrevVal = knob2.value : 
				!module.button3val ? module.knob3PrevVal = knob3.value : 
					module.effect5 = module.effect5;	
			
			(slot1.value == module.effect5) || (slot2.value == module.effect5) || (slot3.value == module.effect5) ? (slot1.value == module.effect5 ? slot1.value = 0 : slot2.value == module.effect5 ? slot2.value = 0 : slot3.value == module.effect5 ? slot3.value = 0 : module.effect5 = module.effect5) :	
				!module.button1val ? slot1.value = module.effect5 : 
					!module.button2val ? slot2.value = module.effect5 : 
						!module.button3val ? slot3.value = module.effect5 : 
							module.effect5 = module.effect5; 
				(settings.fx1pad5set == true) && slot1.value == module.effect1 ? knob1.value = settings.fx1pad5value/100 : module.effect1 = module.effect1 	
					(settings.fx1pad5set == true) && slot2.value == module.effect1 ? knob2.value = settings.fx1pad5value/100 : module.effect1 = module.effect1 	
						(settings.fx1pad5set == true) && slot3.value == module.effect1 ? knob3.value = settings.fx1pad5value/100 : module.effect1 = module.effect1 	
			}
			
			brightness: ((slot1.value == module.effect5) && module.button1val) || ((slot2.value == module.effect5) && module.button2val) || ((slot3.value == module.effect5) && module.button3val) ? 1.0 : 0.0
			color: (slot1.value == module.effect5) || (slot2.value == module.effect5) || (slot3.value == module.effect5) ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(3)

		}
	  }
	   	  
	  Wire {
		from: "%surface%.pads.6";
		to: ButtonScriptAdapter 
		{ 
			onPress: 
			{
				(slot1.value == module.effect6) || (slot2.value == module.effect6) || (slot3.value == module.effect6) ? module.effect6 = module.effect6 : 
				!module.button1val ? module.knob1PrevVal = knob1.value : 
				!module.button2val ? module.knob2PrevVal = knob2.value : 
				!module.button3val ? module.knob3PrevVal = knob3.value : 
					module.effect6 = module.effect6;	
				
			(slot1.value == module.effect6) || (slot2.value == module.effect6) || (slot3.value == module.effect6) ? (slot1.value == module.effect6 ? slot1.value = 0 : slot2.value == module.effect6 ? slot2.value = 0 : slot3.value == module.effect6 ? slot3.value = 0 : module.effect6 = module.effect6) :	
				!module.button1val ? slot1.value = module.effect6 : 
					!module.button2val ? slot2.value = module.effect6 : 
						!module.button3val ? slot3.value = module.effect6 : 
							module.effect6 = module.effect6; 
				(settings.fx1pad6set == true) && slot1.value == module.effect1 ? knob1.value = settings.fx1pad6value/100 : module.effect1 = module.effect1 	
					(settings.fx1pad6set == true) && slot2.value == module.effect1 ? knob2.value = settings.fx1pad6value/100 : module.effect1 = module.effect1 	
						(settings.fx1pad6set == true) && slot3.value == module.effect1 ? knob3.value = settings.fx1pad6value/100 : module.effect1 = module.effect1 	
			}
			
			brightness: ((slot1.value == module.effect6) && module.button1val) || ((slot2.value == module.effect6) && module.button2val) || ((slot3.value == module.effect6) && module.button3val) ? 1.0 : 0.0
			color: (slot1.value == module.effect6) || (slot2.value == module.effect6) || (slot3.value == module.effect6) ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(3)

		}
	  }
	   	  
	  Wire {
		from: "%surface%.pads.7";
		to: ButtonScriptAdapter 
		{ 
			onPress: 
			{
				(slot1.value == module.effect7) || (slot2.value == module.effect7) || (slot3.value == module.effect7) ? module.effect7 = module.effect7 : 
				!module.button1val ? module.knob1PrevVal = knob1.value : 
				!module.button2val ? module.knob2PrevVal = knob2.value : 
				!module.button3val ? module.knob3PrevVal = knob3.value : 
					module.effect7 = module.effect7;	
			
			(slot1.value == module.effect7) || (slot2.value == module.effect7) || (slot3.value == module.effect7) ? (slot1.value == module.effect7 ? slot1.value = 0 : slot2.value == module.effect7 ? slot2.value = 0 : slot3.value == module.effect7 ? slot3.value = 0 : module.effect7 = module.effect7) :	
				!module.button1val ? slot1.value = module.effect7 : 
					!module.button2val ? slot2.value = module.effect7 : 
						!module.button3val ? slot3.value = module.effect7 : 
							module.effect7 = module.effect7; 
				(settings.fx1pad7set == true) && slot1.value == module.effect1 ? knob1.value = settings.fx1pad7value/100 : module.effect1 = module.effect1 	
					(settings.fx1pad7set == true) && slot2.value == module.effect1 ? knob2.value = settings.fx1pad7value/100 : module.effect1 = module.effect1 	
						(settings.fx1pad7set == true) && slot3.value == module.effect1 ? knob3.value = settings.fx1pad7value/100 : module.effect1 = module.effect1 	
			}
			
			brightness: ((slot1.value == module.effect7) && module.button1val) || ((slot2.value == module.effect7) && module.button2val) || ((slot3.value == module.effect7) && module.button3val) ? 1.0 : 0.0
			color: (slot1.value == module.effect7) || (slot2.value == module.effect7) || (slot3.value == module.effect7) ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(3)

		}
	  }
	  
	  Wire {
		from: "%surface%.pads.8";
		to: ButtonScriptAdapter 
		{ 
			onPress: 
			{
				(slot1.value == module.effect8) || (slot2.value == module.effect8) || (slot3.value == module.effect8) ? module.effect8 = module.effect8 : 
				!module.button1val ? module.knob1PrevVal = knob1.value : 
				!module.button2val ? module.knob2PrevVal = knob2.value : 
				!module.button3val ? module.knob3PrevVal = knob3.value : 
					module.effect8 = module.effect8;	
				
			(slot1.value == module.effect8) || (slot2.value == module.effect8) || (slot3.value == module.effect8) ? (slot1.value == module.effect8 ? slot1.value = 0 : slot2.value == module.effect8 ? slot2.value = 0 : slot3.value == module.effect8 ? slot3.value = 0 : module.effect8 = module.effect8) :	
				!module.button1val ? slot1.value = module.effect8 : 
					!module.button2val ? slot2.value = module.effect8 : 
						!module.button3val ? slot3.value = module.effect8 : 
							module.effect8 = module.effect8; 
				(settings.fx1pad8set == true) && slot1.value == module.effect1 ? knob1.value = settings.fx1pad8value/100 : module.effect1 = module.effect1 	
					(settings.fx1pad8set == true) && slot2.value == module.effect1 ? knob2.value = settings.fx1pad8value/100 : module.effect1 = module.effect1 	
						(settings.fx1pad8set == true) && slot3.value == module.effect1 ? knob3.value = settings.fx1pad8value/100 : module.effect1 = module.effect1 	
			}
			
			brightness: ((slot1.value == module.effect8) && module.button1val) || ((slot2.value == module.effect8) && module.button2val) || ((slot3.value == module.effect8) && module.button3val) ? 1.0 : 0.0
			color: (slot1.value == module.effect8) || (slot2.value == module.effect8) || (slot3.value == module.effect8) ? S4MK3Functions.colorForDeckSingle(6) : S4MK3Functions.colorForDeckSingle(3)

		}
	  }
	  
	}
  }
}
