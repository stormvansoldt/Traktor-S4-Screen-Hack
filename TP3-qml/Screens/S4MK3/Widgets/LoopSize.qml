import CSI 1.0
import QtQuick 2.0

Item {
  anchors.fill: parent

  AppProperty { id: loopEnabled; path: "app.traktor.decks." + (parent.deckId) + ".loop.active" }
  AppProperty { id: loopSizePos; path: "app.traktor.decks." + (parent.deckId) + ".loop.size";          }

  property int deckId: 0
  
  property var loopActiveColour: colors.cueColours[settings.cueLoopColour] 
  property var loopDimmedColour: colors.cueColoursDark[settings.cueLoopColour] 

  Rectangle {
    id:       loopSizeBackground
    width:    40
    height:   width
    radius:   width * 0.5
    opacity: loopActiveBlinkTimer.blink ? 0.25 : 1 
    color:    deckInfo.loopActiveLoop ? (loopActiveBlinkTimer.blink ? loopActiveColour : (settings.loopActiveRedFlash ? colors.colorRed : loopDimmedColour))
					: deckInfo.loopActive ? (deckInfo.shift ? loopDimmedColour : loopActiveColour) 
						: deckInfo.shift ? colors.colorDeckDarkGrey : colors.colorDeckGrey 
    Behavior on opacity { NumberAnimation { duration: blinkFreq; easing.type: Easing.Linear} }
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom:   parent.bottom
    Rectangle {
      id:       loopLengthBorder
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.verticalCenter:   parent.verticalCenter
      width:  loopSizeBackground.width -2
      height: width
      radius: width * 0.5
      color: "transparent"
      border.color: loopActiveColour
      border.width: 2
    }
  }

  Text {
      readonly property variant loopText: ["/32", "/16", "1/8", "1/4", "1/2", "1", "2", "4", "8", "16", "32"]
      text: loopText[loopSizePos.value]
      color: deckInfo.loopActive ? "black" : ( deckInfo.shift ? colors.colorDeckGrey : colors.defaultTextColor )
      font.pixelSize: fonts.extraLargeValueFontSize
      font.family: "Pragmatica"
      anchors.fill: loopSizeBackground
      anchors.rightMargin: 2
      anchors.topMargin: 1
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment:   Text.AlignVCenter
      onTextChanged: {
        if (loopSizePos.value < 5) {
          font.pixelSize = 18
        } else if ( loopSizePos.value > 8 ){
          font.pixelSize = 24
        } else {
          font.pixelSize = 25
        }
      }
    }
	
	Timer {
          id: loopActiveBlinkTimer
          property bool  blink: false
	
          interval: 333
          repeat:   true
          running:  deckInfo.loopActiveLoop

          onTriggered: {
            blink = !blink;
          }

          onRunningChanged: {
            blink = running;
          }
        }
}
