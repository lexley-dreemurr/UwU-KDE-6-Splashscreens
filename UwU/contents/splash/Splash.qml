import QtQuick 2.5

Item {
    id: root
    width: 8000
    height: 4500

    // Hintergrundbild, passt sich der Größe an
    Image {
        id: background
        source: "images/background.png"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    // Eigene Property für die Splashscreen-Stufen
    property int stage

    // Wenn die Stage sich ändert, Animationen starten
    onStageChanged: {
        if (stage === 1) {
            introAnimation.running = true;
        } else if (stage === 5) {
            // Animation für busyIndicator beim Stage 5
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    // Content-Container, der Logo und BusyIndicator enthält
    Item {
        id: content
        anchors.fill: parent
        opacity: 0

        // Hilfsobjekt um Maße zu bestimmen
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit / 4)
        }

        // Dein Logo in der Mitte
        Image {
            id: logo
            property real size: units.gridUnit * 8
            anchors.centerIn: parent
            source: "images/UwUlogo.png"
            sourceSize.width: size
            sourceSize.height: size
        }

        // Busy Indicator mit Rotation
        Image {
            id: busyIndicator
            y: parent.height - (parent.height - logo.y) / 2 - height / 2
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/busy01.svg"
            sourceSize.height: units.gridUnit * 3
            sourceSize.width: units.gridUnit * 3

            RotationAnimator on rotation {
                id: rotationAnimator
                from: 0
                to: 360
                duration: 800
                loops: Animation.Infinite
            }
        }
    }

    // Animation um den Content ein- und auszublenden
    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 1000
        easing.type: Easing.InOutQuad
    }
}
