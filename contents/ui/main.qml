import QtQuick 2.0
import QtQuick.Layouts 1.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras


Item {
  id:root
  visible: source.hasMetadata
  width: units.gridUnit * 10
  height: units.gridUnit * 4
  //property var currentMetadata: mpris2Source.currentData ? mpris2Source.currentData.Metadata : undefined
  
  /*PlasmaComponents.Label{
    id: label
    anchors.fill: parent
    text: source.artist + " - " + source.title
  }*/
  Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
  Plasmoid.compactRepresentation: PlasmaComponents.Label {
    
    id: label
    anchors.fill: parent
    Layout.fillHeight: true
    Layout.fillWidth: false
    Layout.minimumWidth: contentItem.width
    Layout.maximumWidth: Layout.minimumWidth
    font {
        family: plasmoid.configuration.fontFamily || theme.defaultFont.family
        weight: plasmoid.configuration.boldText ? Font.Bold : theme.defaultFont.weight
        italic: plasmoid.configuration.italicText
        //pixelSize: 1024
    }
    minimumPixelSize: 1
    text: source.artist + " - " + source.title+ " " + source.getsources
    horizontalAlignment: Text.AlignRight
  }

  PlasmaCore.DataSource {
    id: source
    engine: "mpris2"
    connectedSources: sources
    interval: 0
    
    
    property bool hasMetadata: getHasMetadata()
    property string mysource: "spotify"
    property string title: getMetadata("xesam:title", '')
    property string artist: getMetadata("xesam:artist", []).join(", ")
    property string player: "spotifykek"
    property string getsources: ""
    
    onNewData:{
      source.player = sourceName
    }


    function getHasMetadata() {
        return data[mysource] != undefined
            && data[mysource]["Metadata"] != undefined
            && data[mysource]["Metadata"]["mpris:trackid"] != undefined;
    }

    function getMetadata(entry, def) {
        /*getsources = ""
        for (var prop in data) {
            getsources = getsources + prop + " "
        }
        getsources = getsources + "-:-"
        for (var prop in data["spotify"]["Metadata"]) {
            getsources = getsources + prop + " "
        }*/
        if (hasMetadata && data[mysource]["Metadata"][entry] != undefined)
            return data[mysource]["Metadata"][entry];
        else
            return def;
    }

  }


}

