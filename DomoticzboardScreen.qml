import QtQuick 1.1

import qb.components 1.0

Screen {
	id: root
	
	screenTitleIconUrl: "./drawables/DomoticzSystrayIcon.png"
	screenTitle: qsTr("DomoticzBoard")
	
	//settings screen
	onShown: {
		addCustomTopRightButton("Instellingen");
	}

	onCustomButtonClicked: {
		if (app.domoticzSettings) {
			 app.domoticzSettings.show();
		}
	}

	hasBackButton : true
	
	//http open
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
		visible: app.switch1idx  > 0 ? true : false
		
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
		visible: app.switch1idx  > 0 ? true : false
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
		visible: app.switch2idx  > 0 ? true : false

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
		visible: app.switch2idx  > 0 ? true : false
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
		visible: app.switch3idx  > 0 ? true : false

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
		visible: app.switch3idx  > 0 ? true : false
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
		visible: app.switch4idx  > 0 ? true : false

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
		visible: app.switch14idx  > 0 ? true : false
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
		visible: app.switch5idx  > 0 ? true : false

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
		visible: app.switch5idx  > 0 ? true : false
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
		visible: app.scene1idx > 0 ? true : false

        iconSource: app.scene1StatusIcon

		onClicked: {
			if (app.scene1StatusName == "On") 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene1idx+"&switchcmd=Off");	} 
			else if (app.scene1StatusName == "Off") 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene1idx+"&switchcmd=On");}
			else 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene1idx+"&switchcmd=Off"); }
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
        text: app.scene1Name
		visible: app.scene1idx > 0 ? true : false
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
		visible: app.scene2idx  > 0 ? true : false

        iconSource: app.scene2StatusIcon
			
		onClicked: {
			if (app.scene2StatusName == "On") 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene2idx+"&switchcmd=Off");	} 
			else if (app.scene2StatusName == "Off") 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene2idx+"&switchcmd=On");}
			else 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene2idx+"&switchcmd=Off"); }
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
		text: app.scene2Name
		visible: app.scene2idx  > 0 ? true : false
    }

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
		visible: app.scene3idx  > 0 ? true : false

        iconSource: app.scene3StatusIcon
			
		onClicked: {
			if (app.scene3StatusName == "On") 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene3idx+"&switchcmd=Off");	} 
			else if (app.scene3StatusName == "Off") 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene3idx+"&switchcmd=On");}
			else 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene3idx+"&switchcmd=Off"); }
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
		text: app.scene3Name
		visible: app.scene3idx  > 0 ? true : false
    }
	
// Button 4
    IconButton {
       id: scene4Button
        anchors {
            top: scene3Button.bottom
            topMargin: isNxt ? 19 : 15
            left: parent.left
            leftMargin: isNxt ? 500 : 400
        }
        width: isNxt ? 75 : 60
        height: isNxt ? 75 : 60
		visible: app.scene4idx  > 0 ? true : false

        iconSource: app.scene4StatusIcon
			
		onClicked: {
			if (app.scene4StatusName == "On") 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene4idx+"&switchcmd=Off");	} 
			else if (app.scene4StatusName == "Off") 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene4idx+"&switchcmd=On");}
			else 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene4idx+"&switchcmd=Off"); }
			}
    }

    Text {
        id: scene4Title
        anchors {
            left: scene4Button.right
            verticalCenter: scene4Button.verticalCenter
            leftMargin: isNxt ? 12 : 10
        }
        font {
            family: qfont.semiBold.name
            pixelSize: isNxt ? 25 : 20
        }
        color: colors.clockTileColor
		text: app.scene4Name
		visible: app.scene4idx  > 0 ? true : false
    }
// Button 5
    IconButton {
       id: scene5Button
        anchors {
            top: scene4Button.bottom
            topMargin: isNxt ? 19 : 15
            left: parent.left
            leftMargin: isNxt ? 500 : 400
        }
        width: isNxt ? 75 : 60
        height: isNxt ? 75 : 60
		visible: app.scene5idx  > 0 ? true : false

        iconSource: app.scene5StatusIcon
			
		onClicked: {
			if (app.scene5StatusName == "On") 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene5idx+"&switchcmd=Off");	} 
			else if (app.scene5StatusName == "Off") 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene5idx+"&switchcmd=On");}
			else 
				{ simpleSynchronous("http://"+app.connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene5idx+"&switchcmd=Off"); }
			}
    }

    Text {
        id: scene5Title
        anchors {
            left: scene5Button.right
            verticalCenter: scene5Button.verticalCenter
            leftMargin: isNxt ? 12 : 10
        }
        font {
            family: qfont.semiBold.name
            pixelSize: isNxt ? 25 : 20
        }
        color: colors.clockTileColor
		text: app.scene5Name
		visible: app.scene5idx  > 0 ? true : false
    }
// closing tag
}