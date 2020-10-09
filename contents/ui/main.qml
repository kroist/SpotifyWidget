import QtQuick 2.0
import QtQuick.Layouts 1.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras


Item {
  id:root
  //width: units.gridUnit * 10
  height: units.gridUnit

  Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
    Plasmoid.compactRepresentation: GridLayout {
        PlasmaComponents.Label {
            id: txt
            text: source.artist + " - " + source.title
            visible: source.hasMetadata
        }
        PlasmaCore.IconItem {
            id: icn
            source: "spotify"
            height: 20
            visible: txt.visible
        }
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
    


    function getHasMetadata() {
        return data[mysource] != undefined
            && data[mysource]["Metadata"] != undefined
            && data[mysource]["Metadata"]["mpris:trackid"] != undefined;
    }

    function getMetadata(entry, def) {
        if (hasMetadata && data[mysource]["Metadata"][entry] != undefined)
            return data[mysource]["Metadata"][entry];
        else
            return def;
    }

  }


}

