import QtQuick 2.5

QtObject {

	property bool browseA: false
	property bool browseB: false
	property bool browseC: false
	property bool browseD: false
    
    function browserSet(deckIdx,state) {
    
        switch(deckIdx)
        {
            case 1: browseA = state;
            case 2: browseB = state;
            case 3: browseC = state;
            case 4: browseD = state;
            
            return true;
        }
    }
}