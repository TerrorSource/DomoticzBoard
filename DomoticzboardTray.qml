import QtQuick 1.1

import qb.components 1.0
import qb.base 1.0

SystrayIcon {
	id: domoticzSystrayIcon
	visible: true
	posIndex: 8000

	property string objectName: "domoticzSystrayIcon"
	
	onClicked: {
		stage.openFullscreen(app.domoticzScreenUrl);
	}

	Image {
		id: imgDomoticz
		anchors.centerIn: parent
		source: "./drawables/DomoticzSystrayIcon.png"
	}
}
