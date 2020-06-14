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
    text: source.artist + " - " + source.title
    horizontalAlignment: Text.AlignRight
  }

  PlasmaCore.DataSource {
    id: source
    engine: "mpris2"
    connectedSources: Array("@multiplex")
    interval: 0
    
    
    property bool hasMetadata: getHasMetadata()
    property string title: getMetadata("xesam:title", '')
    property string artist: getMetadata("xesam:artist", []).join(", ")


    function getHasData() {
        return data["@multiplex"] != undefined
            && data["@multiplex"]["PlaybackStatus"] != undefined;
    }

    function getHasMetadata() {
        return data["@multiplex"] != undefined
            && data["@multiplex"]["Metadata"] != undefined
            && data["@multiplex"]["Metadata"]["mpris:trackid"] != undefined;
    }

    function getMetadata(entry, def) {
        if (hasMetadata && data["@multiplex"]["Metadata"][entry] != undefined)
            return data["@multiplex"]["Metadata"][entry];
        else
            return def;
    }

  }


}

