import CSI 1.0
import QtQuick 2.0
import Qt5Compat.GraphicalEffects
import Traktor.Gui 1.0 as T

import '../Widgets' as Widgets



Item {
  id: view
  
  property int    deckId:         0
  property int    sampleWidth:    0
  property var    waveformPosition 
  
  readonly property var colorIds: [stemColorId_1.value, stemColorId_2.value, stemColorId_3.value, stemColorId_4.value]

  //--------------------------------------------------------------------------------------------------------------------
 
  AppProperty { id: stemColorId_1; path: "app.traktor.decks." + deckId + ".stems.1.color_id" }
  AppProperty { id: stemColorId_2; path: "app.traktor.decks." + deckId + ".stems.2.color_id" }
  AppProperty { id: stemColorId_3; path: "app.traktor.decks." + deckId + ".stems.3.color_id" }
  AppProperty { id: stemColorId_4; path: "app.traktor.decks." + deckId + ".stems.4.color_id" }
  
  AppProperty { id: stem1Muted; path: "app.traktor.decks." + deckId + ".stems.1.muted" }
  AppProperty { id: stem2Muted; path: "app.traktor.decks." + deckId + ".stems.2.muted" }
  AppProperty { id: stem3Muted; path: "app.traktor.decks." + deckId + ".stems.3.muted" }
  AppProperty { id: stem4Muted; path: "app.traktor.decks." + deckId + ".stems.4.muted" }
  
  readonly property bool muted1:	stem1Muted.value
  readonly property bool muted2:	stem2Muted.value
  readonly property bool muted3:	stem3Muted.value
  readonly property bool muted4:	stem4Muted.value
  
  Repeater {
    id: waveformRepeater
    model: 4
	
	
	
    SingleWaveform { 
      y:      index * view.height/4 + (index > 1 ? 2 : 1)
      width:  view.width
      height: 31
      clip:   true

	  muted:			((index == 0) ? muted1 : (index == 1) ? muted2 : (index == 2) ? muted3 : (index == 3) ? muted4 : false)
      deckId:           view.deckId
      streamId:         index + 1
      sampleWidth:      view.sampleWidth
      waveformPosition: view.waveformPosition
      waveformColors:   waveformRepeater.muted ? colors.getWaveformColorsDim(colorIds[index]) : colors.getWaveformColors(colorIds[index])
    }
  }
}
