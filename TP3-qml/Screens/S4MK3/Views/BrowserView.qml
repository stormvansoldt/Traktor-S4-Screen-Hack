import CSI 1.0
import QtQuick 2.0
import Traktor.Gui 1.0 as Traktor

import '../Browser' as BrowserView
import '../Widgets' as Widgets

//----------------------------------------------------------------------------------------------------------------------
//                                            BROWSER VIEW
//
//  The Browser View is connected to traktors QBrowser from which it receives its data model. The navigation through the
//  data is done by calling funcrtions invoked from QBrowser.
//----------------------------------------------------------------------------------------------------------------------

Item {
  id: qmlBrowser
  property var deckInfo: ({})
  property string propertiesPath: ""
  property bool  isActive:      false
  property bool  enterNode:     false
  property bool  exitNode:      false
  property int   increment:     0
  property color focusColor:    colors.colorDeckBlueBright
  property int   speed:         150
  property real  sortingKnobValue:  0
  property int   pageSize:          10
  property int   fastScrollCenter:  3
  property bool leftScreen: deckInfo.isLeftScreen(deckInfo.deckId)

  readonly property int  maxItemsOnScreen: 8

  // This is used by the footer to change/display the sorting!
  property alias sortingId:         browser.sorting
  property alias sortingDirection:  browser.sortingDirection
  property alias isContentList:     browser.isContentList

  anchors.fill: parent

    //MappingProperty { id: browserViewMode; path: "mapping.state.browser_view_mode" }

  //--------------------------------------------------------------------------------------------------------------------

  onIncrementChanged: {
    if (qmlBrowser.increment != 0) {
      var newValue = clamp(browser.currentIndex + qmlBrowser.increment, 0, contentList.count - 1);
  
      // center selection if user is _fast scrolling_ but we're at the _beginning_ or _end_ of the list
      if(qmlBrowser.increment >= pageSize) {
        var centerTop = fastScrollCenter;

        if(browser.currentIndex < centerTop) {          
          newValue = centerTop;
        }
      }
      if(qmlBrowser.increment <= (-pageSize)) {
        var centerBottom = contentList.count - 1 - fastScrollCenter;

        if(browser.currentIndex > centerBottom) {          
          newValue = centerBottom;
        }
      }
      
      browser.changeCurrentIndex(newValue);
      qmlBrowser.increment = 0;
    }      
  }
  
  onExitNodeChanged: {
    if (qmlBrowser.exitNode) {
      browser.exitNode()
    }
    
    qmlBrowser.exitNode = false;
  }

  //--------------------------------------------------------------------------------------------------------------------

  onEnterNodeChanged: {
    if (qmlBrowser.enterNode) {
      var movedDown = browser.enterNode(screen.focusDeckId, contentList.currentIndex);
      if (movedDown) { 
        browser.relocateCurrentIndex()
      }
    }
    
    qmlBrowser.enterNode = false;
  }

  function clamp(val, min, max){
    return Math.max(min, Math.min(val, max));
  }

  Traktor.Browser
  {
    id: browser;
    isActive: qmlBrowser.isActive
  }
  
  Rectangle {
  	id: background
  	anchors.fill: parent
  	color: "black"
  
  }
  
   //--------------------------------------------------------------------------------------------------------------------
  //  LIST VIEW -- NEEDS A MODEL CONTAINING THE LIST OF ITEMS TO SHOW AND A DELEGATE TO DEFINE HOW ONE ITEM LOOKS LIKE
  //-------------------------------------------------------------------------------------------------------------------

  // zebra filling up the rest of the list if smaller than maxItemsOnScreen (= 8 entries)
  Grid {
    anchors.top:            contentList.top
    anchors.topMargin:      contentList.topMargin +  contentList.contentHeight + 1 // +1 = for spacing
    anchors.right:          parent.right
    anchors.left:           parent.left
    anchors.leftMargin:     3
    columns:                1
    spacing:                1  

    Repeater {
      model: (contentList.count < qmlBrowser.maxItemsOnScreen) ? (qmlBrowser.maxItemsOnScreen - contentList.count) : 0
      Rectangle { 
        color: ( (contentList.count + index)%2 == 0) ? colors.colorGrey32 : "Black"
        width: qmlBrowser.width; 
        height: settings.browserFontSize*2 }
    }
  }

  //--------------------------------------------------------------------------------------------------------------------

  ListView {
    id: contentList
    anchors.fill: parent
    verticalLayoutDirection: ListView.TopToBottom
    // the top/bottom margins are applied only at the beginning/end of the list in order to show half entries while scrolling 
    // and keep the list delegates in the same position always.

    // the commented out margins caused browser anchor problems leading to a disappearing browser! check later !?
    anchors.topMargin:       17 // ( (contentList.count <  qmlBrowser.maxItemsOnScreen ) || (currentIndex < 4                     )) ? 17 : 0
    anchors.bottomMargin:    18 // ( (contentList.count >= qmlBrowser.maxItemsOnScreen) && (currentIndex >= contentList.count - 4)) ? 18 : 0 
    clip:                    false
    spacing:                 1
    preferredHighlightBegin: 119 - 17 // -17 because of the reduced height due to the topMargin
    preferredHighlightEnd  : 152 - 17 // -17 because of the reduced height due to the topMargin
    highlightRangeMode :     ListView.ApplyRange
    highlightMoveDuration:   0
    delegate:                BrowserView.ListDelegate {id: listDelegate; masterBPM: deckInfo.masterBPM; masterKey: deckInfo.masterKey; keyIndex: deckInfo.keyIndex; isPlaying: deckInfo.isPlaying; adjacentKeys: settings.adjacentKeys;}
    model:                   browser.dataSet
    currentIndex:            browser.currentIndex 
    focus:                   true 
    cacheBuffer:             10
	visible: settings.showBrowserOnFullScreen ? ((deckInfo.isInBrowserMode && leftScreen) || (deckInfo.viewButton && !deckInfo.isInBrowserMode) || deckInfo.favorites) : true
  }
  
  ListView {
    id: contentListRight
    anchors.fill: parent
    verticalLayoutDirection: ListView.TopToBottom
    // the top/bottom margins are applied only at the beginning/end of the list in order to show half entries while scrolling 
    // and keep the list delegates in the same position always.

    // the commented out margins caused browser anchor problems leading to a disappearing browser! check later !?
    anchors.topMargin:       0 // ( (contentList.count <  qmlBrowser.maxItemsOnScreen ) || (currentIndex < 4                     )) ? 17 : 0
    anchors.bottomMargin:    0 // ( (contentList.count >= qmlBrowser.maxItemsOnScreen) && (currentIndex >= contentList.count - 4)) ? 18 : 0 
    clip:                    false
    spacing:                 0
    preferredHighlightBegin: 0 // -17 because of the reduced height due to the topMargin
    preferredHighlightEnd  : 240 // -17 because of the reduced height due to the topMargin
    highlightRangeMode :     ListView.ApplyRange
    highlightMoveDuration:   0
    delegate:                BrowserView.TrackView  {id: trackView; masterBPM: deckInfo.masterBPM;}
    model:                   browser.dataSet
    currentIndex:            browser.currentIndex 
    focus:                   true 
    cacheBuffer:             10
    visible: settings.showBrowserOnFullScreen ? (deckInfo.isInBrowserMode && !leftScreen) : false
  }
  
  BrowserView.BrowserHeader {
    id: browserHeader
    nodeIconId:     browser.iconId
    currentDeck:    deckInfo.deckId
	headerEnabled:	deckInfo.headerEnabled
	headerShort:	deckInfo.headerText
	headerLong:		deckInfo.headerTextLong
    state:          "show"
    pathStrings:    browser.currentPath 


    Behavior on height { NumberAnimation { duration: speed; } }
    
    visible: settings.showBrowserOnFullScreen ? !(deckInfo.isInBrowserMode && !leftScreen) : true
   
  }

  //--------------------------------------------------------------------------------------------------------------------

  BrowserView.BrowserFooter {
    id: browserFooter
    state:        "show"
    propertiesPath: qmlBrowser.propertiesPath
    sortingKnobValue: qmlBrowser.sortingKnobValue
	headerEnabled:	deckInfo.headerEnabled
	headerShort:	deckInfo.headerText
	headerLong:		deckInfo.headerTextLong
	maxCount:		contentList.count
	count:			browser.currentIndex + 1

    Behavior on height { NumberAnimation { duration: speed; } }
    
    visible: settings.showBrowserOnFullScreen ? !(deckInfo.isInBrowserMode && !leftScreen) : true
    
  }
  
  BrowserView.TrackFooter {
    id: trackFooter
    state:        "show"
    propertiesPath: qmlBrowser.propertiesPath
    sortingKnobValue: qmlBrowser.sortingKnobValue
	maxCount:		contentList.count
	count:			browser.currentIndex + 1

    Behavior on height { NumberAnimation { duration: speed; } }
    
    visible: settings.showBrowserOnFullScreen ? (deckInfo.isInBrowserMode && !leftScreen) : false
    
  }

}

