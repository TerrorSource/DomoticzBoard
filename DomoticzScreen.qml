import QtQuick 1.1

import qb.components 1.0

Screen {
	id: root
	
	screenTitleIconUrl: "drawables/SysTrayIcon.png"
	screenTitle: qsTr("DomoticzBoard")
	
	property string connectionPath: app.domoticzMenu.connectionPath
	
	function simpleSynchronous(request) {
		var xmlhttp = new XMLHttpRequest();
		xmlhttp.open("GET", request, true);
		xmlhttp.send();
	}
// Function lights
	function switchLight1() {
		var tmp = app.switch1StatusIcon;
		if (tmp == "./drawables/Light48_On.png") {
			app.switch1StatusIcon = "./drawables/Light48_Off.png";
		} else {
			app.switch1StatusIcon = "./drawables/Light48_On.png";
		}
	}

	function switchLight2() {
		var tmp = app.switch2StatusIcon;
		if (tmp == "./drawables/Light48_Off.png") {
			app.switch2StatusIcon = "./drawables/Light48_On.png";
		} else {
			app.switch2StatusIcon = "./drawables/Light48_Off.png";
		}
	}

	function switchLight3() {
		var tmp = app.switch3StatusIcon;
		if (tmp == "./drawables/Light48_Off.png") {
			app.switch3StatusIcon = "./drawables/Light48_On.png";
		} else {
			app.switch3StatusIcon = "./drawables/Light48_Off.png";
		}
	}

	function switchLight4() {
		var tmp = app.switch4StatusIcon;
		if (tmp == "./drawables/Light48_Off.png") {
			app.switch4StatusIcon = "./drawables/Light48_On.png";
		} else {
			app.switch4StatusIcon = "./drawables/Light48_Off.png";
		}
	}
	
	function switchLight5() {
		var tmp = app.switch5StatusIcon;
		if (tmp == "./drawables/Light48_Off.png") {
			app.switch5StatusIcon = "./drawables/Light48_On.png";
		} else {
			app.switch5StatusIcon = "./drawables/Light48_Off.png";
		}
	}
	
// Function scenes
	function switchScene1() {
		var tmp = app.scene1StatusIcon;
		if (tmp = "./drawables/GroupOff.png") {
			app.scene1StatusIcon = "./drawables/GroupOff.png";
		} else {
			app.scene1StatusIcon = "./drawables/GroupOn.png";
		}
	}
	
	function switchScene2() {
		var tmp = app.scene2StatusIcon;
		if (tmp = "./drawables/GroupOff.png") {
			app.scene2StatusIcon = "./drawables/GroupOff.png";
		} else {
			app.scene2StatusIcon = "./drawables/GroupOn.png";
		}
	}
	function switchScene3() {
		var tmp = app.scene3StatusIcon;
		if (tmp = "./drawables/GroupOff.png") {
			app.scene3StatusIcon = "./drawables/GroupOff.png";
		} else {
			app.scene3StatusIcon = "./drawables/GroupOn.png";
		}
	}

// ----- LEFT COLUMN -----
// iconButton1
    IconButton {
        id: switch1Button
        anchors {
            top: parent.top
            topMargin: 15
            left: parent.left
            leftMargin: 25
        }
        width: 60
        height: 60

        iconSource: app.switch1StatusIcon

		onClicked: {
			simpleSynchronous("http://"+connectionPath+"/json.htm?type=command&param=switchlight&idx="+app.switch1idx+"&switchcmd=Toggle");
			switchLight1();
    		}
	}

    Text {
        id: switch1Title
        anchors {
            left: switch1Button.right
            verticalCenter: switch1Button.verticalCenter
            leftMargin: 10
        }
        font {
            family: qfont.semiBold.name
            pixelSize: 20
        }
        color: colors.clockTileColor
        text: app.switch1Name
    }

// iconButton2
    IconButton {
        id: switch2Button
        anchors {
            top: switch1Button.bottom
            topMargin: 15
            left: parent.left
            leftMargin: 25
        }
        width: 60
        height: 60

        iconSource: app.switch2StatusIcon

	onClicked: {
		simpleSynchronous("http://"+connectionPath+"/json.htm?type=command&param=switchlight&idx="+app.switch2idx+"&switchcmd=Toggle");
		switchLight2();
	}
    }

    Text {
        id: switch2Title
        anchors {
            left: switch2Button.right
            verticalCenter: switch2Button.verticalCenter
            leftMargin: 10
        }
        font {
            family: qfont.semiBold.name
            pixelSize: 20
        }
        color: colors.clockTileColor
        text: app.switch2Name
    }

// iconButton3
    IconButton {
        id: switch3Button
        anchors {
            top: switch2Button.bottom
            topMargin: 15
            left: parent.left
            leftMargin: 25
        }
        width: 60
        height: 60

        iconSource: app.switch3StatusIcon

	onClicked: {
		simpleSynchronous("http://"+connectionPath+"/json.htm?type=command&param=switchlight&idx="+app.switch3idx+"&switchcmd=Toggle");
		switchLight3();
	}
    }

    Text {
        id: switch3Title
        anchors {
            left: switch3Button.right
            verticalCenter: switch3Button.verticalCenter
            leftMargin: 10
        }
        font {
            family: qfont.semiBold.name
            pixelSize: 20
        }
        color: colors.clockTileColor
        text: app.switch3Name
    }

// iconButton4
    IconButton {
        id: switch4Button
        anchors {
            top: switch3Button.bottom
            topMargin: 15
            left: parent.left
            leftMargin: 25
        }
        width: 60
        height: 60

        iconSource: app.switch4StatusIcon

	onClicked: {
		simpleSynchronous("http://"+connectionPath+"/json.htm?type=command&param=switchlight&idx="+app.switch4idx+"&switchcmd=Toggle");
		switchLight4();
	}
    }

    Text {
        id: switch4Title
        anchors {
            left: switch4Button.right
            verticalCenter: switch4Button.verticalCenter
            leftMargin: 10
        }
        font {
            family: qfont.semiBold.name
            pixelSize: 20
        }
        color: colors.clockTileColor
        text: app.switch4Name
    }
// iconButton5
    IconButton {
        id: switch5Button
        anchors {
            top: switch4Button.bottom
            topMargin: 15
            left: parent.left
            leftMargin: 25
        }
        width: 60
        height: 60

        iconSource: app.switch5StatusIcon

	onClicked: {
		simpleSynchronous("http://"+connectionPath+"/json.htm?type=command&param=switchlight&idx="+app.switch5idx+"&switchcmd=Toggle");
		switchLight5();
	}
    }

    Text {
        id: switch5Title
        anchors {
            left: switch5Button.right
            verticalCenter: switch5Button.verticalCenter
            leftMargin: 10
        }
        font {
            family: qfont.semiBold.name
            pixelSize: 20
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
            topMargin: 15
            left: parent.left
            leftMargin: 400
        }
        width: 60
        height: 60

        iconSource: app.scene1StatusIcon

		onClicked: {
			if (app.scene1StatusName == "On") 
				{ simpleSynchronous("http://"+connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene1idx+"&switchcmd=Off");	} 
			else if (app.scene1StatusName == "Off") 
				{ simpleSynchronous("http://"+connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene1idx+"&switchcmd=On");}
			else 
				{ simpleSynchronous("http://"+connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene1idx+"&switchcmd=Off"); }
				switchScene1();
				}
	}

    Text {
        id: scene1Title
        anchors {
            left: scene1Button.right
            verticalCenter: scene1Button.verticalCenter
            leftMargin: 10
        }
        font {
            family: qfont.semiBold.name
            pixelSize: 20
        }
        color: colors.clockTileColor
        text: app.scene1Name
    }

// Button 2
    IconButton {
        id: scene2Button
        anchors {
            top: scene1Button.bottom
            topMargin: 15
            left: parent.left
            leftMargin: 400
        }
        width: 60
        height: 60

        iconSource: app.scene2StatusIcon
			
		onClicked: {
			if (app.scene2StatusName == "On") 
				{ simpleSynchronous("http://"+connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene2idx+"&switchcmd=Off");	} 
			else if (app.scene2StatusName == "Off") 
				{ simpleSynchronous("http://"+connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene2idx+"&switchcmd=On");}
			else 
				{ simpleSynchronous("http://"+connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene2idx+"&switchcmd=Off"); }
				switchScene2();
				}
    }

    Text {
        id: scene2Title
        anchors {
            left: scene2Button.right
            verticalCenter: scene2Button.verticalCenter
            leftMargin: 10
        }
        font {
            family: qfont.semiBold.name
            pixelSize: 20
        }
        color: colors.clockTileColor
        text: app.scene2Name
    }

/* // REMOVE THIS LINE FOR SCENE 3 1/2

// Button 3
    IconButton {
       id: scene3Button
        anchors {
            top: scene2Button.bottom
            topMargin: 15
            left: parent.left
            leftMargin: 400
        }
        width: 60
        height: 60

        iconSource: app.scene3StatusIcon
			
		onClicked: {
			if (app.scene3StatusName == "On") 
				{ simpleSynchronous("http://"+connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene3idx+"&switchcmd=Off");	} 
			else if (app.scene3StatusName == "Off") 
				{ simpleSynchronous("http://"+connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene3idx+"&switchcmd=On");}
			else 
				{ simpleSynchronous("http://"+connectionPath+"/json.htm?type=command&param=switchscene&idx="+app.scene3idx+"&switchcmd=Off"); }
				switchscene3();
				}
    }

    Text {
        id: scene3Title
        anchors {
            left: scene3Button.right
            verticalCenter: scene3Button.verticalCenter
            leftMargin: 10
        }
        font {
            family: qfont.semiBold.name
            pixelSize: 20
        }
        color: colors.clockTileColor
        text: app.scene3Name
    }
*/ // REMOVE THIS LINE FOR SCENE 3 2/2

// closing tag
}