import QtQuick 2.1

import qb.components 1.0

Screen {
	id: root
	
	screenTitleIconUrl: "qrc:/tsc/DomoticzSystrayIcon.png"
	screenTitle: qsTr("DomoticzBoard")
	
	function simpleSynchronous(request) {
		var xmlhttp = new XMLHttpRequest();
		xmlhttp.open("GET", request, true);
		xmlhttp.send();
	}

// ----- LEFT COLUMN -----
// iconButton1
    IconButton {
        id: switch1Button
        anchors {
            top: parent.top
            topMargin: isNxt ? 19 : 15
            left: parent.left
            leftMargin: isNxt ? 31 : 25
        }
        width: isNxt ? 75 : 60
        height: isNxt ? 75 : 60

        iconSource: app.switch1StatusIcon

		onClicked: {
			simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchlight&idx="+app.switch1idx+"&switchcmd=Toggle");
			switchLight1();
    		}
	}

    Text {
        id: switch1Title
        anchors {
            left: switch1Button.right
            verticalCenter: switch1Button.verticalCenter
            leftMargin: isNxt ? 12 : 10
        }
        font {
            family: qfont.semiBold.name
            pixelSize: isNxt ? 25 : 20
        }
        color: colors.clockTileColor
        text: app.switch1Name
    }

// iconButton2
    IconButton {
        id: switch2Button
        anchors {
            top: switch1Button.bottom
            topMargin: isNxt ? 19 : 15
            left: parent.left
            leftMargin: isNxt ? 31 : 25
        }
        width: isNxt ? 75 : 60
        height: isNxt ? 75 : 60

        iconSource: app.switch2StatusIcon

	onClicked: {
		simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchlight&idx="+app.switch2idx+"&switchcmd=Toggle");
		switchLight2();
	}
    }

    Text {
        id: switch2Title
        anchors {
            left: switch2Button.right
            verticalCenter: switch2Button.verticalCenter
            leftMargin: isNxt ? 12 : 10
        }
        font {
            family: qfont.semiBold.name
            pixelSize: isNxt ? 25 : 20
        }
        color: colors.clockTileColor
        text: app.switch2Name
    }

// iconButton3
    IconButton {
        id: switch3Button
        anchors {
            top: switch2Button.bottom
            topMargin: isNxt ? 19 : 15
            left: parent.left
            leftMargin: isNxt ? 31 : 25
        }
        width: isNxt ? 75 : 60
        height: isNxt ? 75 : 60

        iconSource: app.switch3StatusIcon

	onClicked: {
		simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchlight&idx="+app.switch3idx+"&switchcmd=Toggle");
		switchLight3();
	}
    }

    Text {
        id: switch3Title
        anchors {
            left: switch3Button.right
            verticalCenter: switch3Button.verticalCenter
            leftMargin: isNxt ? 12 : 10
        }
        font {
            family: qfont.semiBold.name
            pixelSize: isNxt ? 25 : 20
        }
        color: colors.clockTileColor
        text: app.switch3Name
    }

// iconButton4
    IconButton {
        id: switch4Button
        anchors {
            top: switch3Button.bottom
            topMargin: isNxt ? 19 : 15
            left: parent.left
            leftMargin: isNxt ? 31 : 25
        }
        width: isNxt ? 75 : 60
        height: isNxt ? 75 : 60

        iconSource: app.switch4StatusIcon

	onClicked: {
		simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchlight&idx="+app.switch4idx+"&switchcmd=Toggle");
		switchLight4();
	}
    }

    Text {
        id: switch4Title
        anchors {
            left: switch4Button.right
            verticalCenter: switch4Button.verticalCenter
            leftMargin: isNxt ? 12 : 10
        }
        font {
            family: qfont.semiBold.name
            pixelSize: isNxt ? 25 : 20
        }
        color: colors.clockTileColor
        text: app.switch4Name
    }
// iconButton5
    IconButton {
        id: switch5Button
        anchors {
            top: switch4Button.bottom
            topMargin: isNxt ? 19 : 15
            left: parent.left
            leftMargin: isNxt ? 31 : 25
        }
        width: isNxt ? 75 : 60
        height: isNxt ? 75 : 60

        iconSource: app.switch5StatusIcon

	onClicked: {
		simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchlight&idx="+app.switch5idx+"&switchcmd=Toggle");
		switchLight5();
	}
    }

    Text {
        id: switch5Title
        anchors {
            left: switch5Button.right
            verticalCenter: switch5Button.verticalCenter
            leftMargin: isNxt ? 12 : 10
        }
        font {
            family: qfont.semiBold.name
            pixelSize: isNxt ? 25 : 20
        }
        color: colors.clockTileColor
        text: app.switch5Name
    }

// ----- RIGHT COLUMN -----
// Button 1
    IconButton 
	{
        id: scene1Button
        anchors {
            top: parent.top
            topMargin: isNxt ? 19 : 15
            left: parent.left
            leftMargin: isNxt ? 500 : 400
        }
        width: isNxt ? 75 : 60
        height: isNxt ? 75 : 60

        iconSource: app.scene1StatusIcon

		onClicked: {
			if (app.scene1StatusName == "On") 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene1idx+"&switchcmd=Off");	} 
			else if (app.scene1StatusName == "Off") 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene1idx+"&switchcmd=On");}
			else 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene1idx+"&switchcmd=Off"); }
				switchScene1();
				}
	}

    Text {
        id: scene1Title
        anchors {
            left: scene1Button.right
            verticalCenter: scene1Button.verticalCenter
            leftMargin: isNxt ? 12 : 10
        }
        font {
            family: qfont.semiBold.name
            pixelSize: isNxt ? 25 : 20
        }
        color: colors.clockTileColor
        //text: app.scene1Name
        text: app.scene1Name
    }

// Button 2
    IconButton {
        id: scene2Button
        anchors {
            top: scene1Button.bottom
            topMargin: isNxt ? 19 : 15
            left: parent.left
            leftMargin: isNxt ? 500 : 400
        }
        width: isNxt ? 75 : 60
        height: isNxt ? 75 : 60

        iconSource: app.scene2StatusIcon
			
		onClicked: {
			if (app.scene2StatusName == "On") 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene2idx+"&switchcmd=Off");	} 
			else if (app.scene2StatusName == "Off") 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene2idx+"&switchcmd=On");}
			else 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene2idx+"&switchcmd=Off"); }
				switchscene2();
				}
    }

    Text {
        id: scene2Title
        anchors {
            left: scene2Button.right
            verticalCenter: scene2Button.verticalCenter
            leftMargin: isNxt ? 12 : 10
        }
        font {
            family: qfont.semiBold.name
            pixelSize: isNxt ? 25 : 20
        }
        color: colors.clockTileColor
        //text: app.scene2Name
		text: app.scene2Name
    }

/* // REMOVE THIS LINE FOR SCENE 3 1/2

// Button 3
    IconButton {
       id: scene3Button
        anchors {
            top: scene2Button.bottom
            topMargin: isNxt ? 19 : 15
            left: parent.left
            leftMargin: isNxt ? 500 : 400
        }
        width: isNxt ? 75 : 60
        height: isNxt ? 75 : 60

        iconSource: app.scene3StatusIcon
			
		onClicked: {
			if (app.scene3StatusName == "On") 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene3idx+"&switchcmd=Off");	} 
			else if (app.scene3StatusName == "Off") 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene3idx+"&switchcmd=On");}
			else 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene3idx+"&switchcmd=Off"); }
				switchscene3();
				}
    }

    Text {
        id: scene3Title
        anchors {
            left: scene3Button.right
            verticalCenter: scene3Button.verticalCenter
            leftMargin: isNxt ? 12 : 10
        }
        font {
            family: qfont.semiBold.name
            pixelSize: isNxt ? 25 : 20
        }
        color: colors.clockTileColor
        //text: app.scene3Name
		text: app.scene3Name
    }
*/ // REMOVE THIS LINE FOR SCENE 3 2/2

// closing tag
}