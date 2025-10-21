import CSI 1.0
import QtQuick 2.0
import Qt5Compat.GraphicalEffects

import '../Widgets' as Widgets
import '../../Defines' as Defines

//--------------------------------------------------------------------------------------------------------------------
//  FX CONTROLS
//--------------------------------------------------------------------------------------------------------------------

// The FxControls are located on the top of the screen and blend in if one of the top knobs is touched/changed

Item {
  id: bottomLabels

  property string showHideState: "hide"
  property int bottomMargin: 0
  property int  yPositionWhenHidden: 240
  property int  yPositionWhenShown: (240 - height)
  property int deckId: 1
  property int hotcue: 0
  property int type: 0
  property string name: ""
  readonly property color barBgColor: "black"
  property int bank: 1
  
  AppProperty { id: type; path: "app.traktor.fx." + bank + ".type"}
  
  AppProperty { id: routing; path: "app.traktor.fx." + bank + ".routing"}
  property string routingText: routing.value == 0 ? "Send" : routing.value == 1 ? "Insert" : routing.value == 2 ? "Post" : "ERROR"

  AppProperty { id: fxSelect1; path: "app.traktor.fx." + bank + ".select.1"}
  AppProperty { id: fxSelect2; path: "app.traktor.fx." + bank + ".select.2"}
  AppProperty { id: fxSelect3; path: "app.traktor.fx." + bank + ".select.3"}

  property string name1: name1Prop.value == "" ? "No Effect" : name1Prop.value
  property string name2: name2Prop.value == "" ? "No Effect" : name2Prop.value
  property string name3: name3Prop.value == "" ? "No Effect" : name3Prop.value

  Defines.Colors    { id: colors    }
  Defines.Durations { id: durations }

  
  height: type.value == 2 ? 25 : 50
  anchors.left:  parent.left
  anchors.right: parent.right

  // dark grey background
  Rectangle {
    id: bottomInfoDetailsPanelDarkBg
    anchors {
      top: parent.top
      left:  parent.left
      right: parent.right
    }
    height: bottomLabels.height
    color: colors.colorFxHeaderBg
  }

  // dividers
  Rectangle {
    id: fxInfoDivider0
    width:1;
    height:63;
    color: colors.colorDivider
    anchors.top: parent.top
    anchors.topMargin: 25
    anchors.left: parent.left
    anchors.leftMargin: 320/3
  }

  // dividers
  Rectangle {
    id: fxInfoDivider1
    width:1;
    color: colors.colorDivider
    anchors.top: parent.top
    anchors.topMargin: 25
    anchors.left: parent.left
    anchors.leftMargin: (320/3) * 2
    height: 63
  }


  // Info Details
  Rectangle {
    id: bottomInfoDetailsPanel

    height: parent.height
    clip: true
    width: parent.width
    color: "transparent"

    anchors.left: parent.left
    anchors.leftMargin: 1


    Row {
      BankInfoDetails {
        id: bottomInfoDetails1
        finalLabel: (type.value == 2 ? "Pattern Player " : "FX Bank ") + bank + " - " + routingText
        hideValue: true
        hideTitle: false
        width: 240
      }
    }
    
    Row {
      BankInfoDetails {
        id: bottomInfoDetails2
        finalValue: fxSelect1.description
        hideValue: (type.value == 2 ? true : false)
        hideTitle: true
        width: 320/3
      }
      
      BankInfoDetails {
        id: bottomInfoDetails3
        finalValue: fxSelect2.description
        hideValue: (type.value != 0) ? true : false
        hideTitle: true
        width: 320/3
      }
      
      BankInfoDetails {
        id: bottomInfoDetails4
        finalValue: fxSelect3.description
        hideValue: (type.value != 0) ? true : false
        hideTitle: true
        width: 320/3
      }
    }
    
    
  }

  // black border & shadow
  Rectangle {
    id: headerBlackLine
    anchors.top: bottomLabels.bottom
    width:       parent.width
    color:       colors.colorBlack
    height:      2
  }
  Rectangle {
    id: headerShadow
    anchors.left:  parent.left
    anchors.right: parent.right
    anchors.top:   headerBlackLine.bottom
    height:        6
    gradient: Gradient {
      GradientStop { position: 1.0; color: colors.colorBlack0 }
      GradientStop { position: 0.0; color: colors.colorBlack63 }
    }
    visible: false
  }

  //------------------------------------------------------------------------------------------------------------------
  //  STATES
  //------------------------------------------------------------------------------------------------------------------

  Behavior on y { PropertyAnimation { duration: durations.overlayTransition;  easing.type: Easing.InOutQuad } }

  Item {
    id: showHide
    state: showHideState
    states: [
      State {
        name: "show";
        PropertyChanges { target: bottomLabels;   y: yPositionWhenShown}
      },
      State {
        name: "hide";
        PropertyChanges { target: bottomLabels;   y: yPositionWhenHidden}
      }
    ]
  }
}


