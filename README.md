# Replacement screens for Traktor S4 mk3

I'll update this README over time, but please read the instructions in the included PDF as it contains important information for importing everything correctly.

I've kept both versions of the hack for compatibility reasons, but I won't be working on the Traktor 3 ones at all. Only TP4 will be updated.

# Installation

**Installing the screen mod**
1. Navigate to your Traktor installation folder. Replace {number} below with either 3 or 4, depending on which version you have installed
    - Windows: `C:\Program Files\Native Instruments\Traktor Pro {number}\Resources64\`
    - Mac: `/Applications/Native Instruments`, right-click on Traktor Pro {number}->Show Package Contents->`Contents/Resources/`
2. Make a new folder named `qml-old` and copy everything from inside the `qml` folder into it so you have a backup
3. Download this repo and unzip it
4. Open `TP{number}-qml` and copy all three folders into the `qml` directory, overwriting the folders currently there
5. Plug in your S4 and fire up Traktor

**NOTE**: If you have issues with Traktor crashing after installing this mod, please remove any other QML mods you have installed (ie. DJMirror, traktor-api-client, etc.). There are file changes in other mods that conflict with this one, and I haven't had a chance to isolate which one is causing the issue yet. 

**Installing the FX TSI**
1. Open Traktor's settings by clicking the gear icon in the top right of the screen
2. Click "Import" at the bottom of the window, and select the `Screen Hack Effect Settings.tsi` file from this repo

# Configuration

There's a collection of settings that have been consolidated to a single file to make it easy to access. There's comments in the file itself that should be pretty self-explanatory.

`C:\Program Files\Native Instruments\Traktor Pro 4\qml\Screens\Defines\Settings.qml`

## Changing the empty deck background image (S4Mk3)

Thanks to a quick easy change, this mod not only lets you use custom images for the empty decks, but animated ones too!

1. Grab a small `.gif` or `.png` of your choosing (ideally in a 4:3 aspect ratio)
2. Navigate to your `Resources64\qml` folder at Traktor's install location
3. Drop the image into `Screens\Images`
4. Go back to the `Screens` folder, and open the file `S4MK3\Views\TrackDeck.qml`
5. Find the `AnimatedImage` object and rename the `source` value to point at the image file you just uploaded:
```
  //Image {
  AnimatedImage {
    id: emptyTrackDeckImage
    anchors.fill:         parent
    anchors.bottomMargin: settings.bottom
    anchors.topMargin:    settings.top
    visible:              deckInfo.showLogo && settings.enableLogo

    source:               "../../Images/goldengoomba.gif"
    fillMode:             Image.PreserveAspectFit
  } 
```
6. Save & exit, then restart Traktor
