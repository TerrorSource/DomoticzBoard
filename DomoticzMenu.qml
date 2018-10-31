import QtQuick 1.1
import BasicUIControls 1.0
import qb.components 1.0
import BxtClient 1.0

Screen {
	id: root
	screenTitle: qsTr("DomoticzBoard Instellingen")
	screenTitleIconUrl: "./drawables/DomoticzSystrayIcon.png"

	property string connectionPath: "";
	property string connectionPathSwitch: "";
		
	onHidden: {
		screenStateController.screenColorDimmedIsReachable = true;
	}
	
	onShown: {
		readConnection();
		readSwitch();
		showDBIconToggle.isSwitchedOn = app.showDBIcon;
	}
	
	function saveIpadres(text) {
		if (text) {
			ipadresLabel.inputText = text;
			savepath();
		}
	}

	function savePoortnummer(text) {
		if (text) {
			poortnummerLabel.inputText = text;
			savepath();
		}
	}

	function savepath(){
		var str = ipadresLabel.inputText + ":" + poortnummerLabel.inputText;
		connectionPath = str;
		var doc2 = new XMLHttpRequest();
			doc2.onreadystatechange = function() {
				if (doc2.readyState == XMLHttpRequest.DONE) {
				}
			}
		doc2.open("PUT", "file:///HCBv2/qml/apps/domoticzBoard/serverip.txt");
		doc2.send(str);
	}
	
	// switch save to file
	
	function saveconfswitch1(text) {
		if (text) {
			confswitch1Label.inputText = text;
			saveswitchconfig();
		}
	}
	function saveconfswitch2(text) {
		if (text) {
			confswitch2Label.inputText = text;
			saveswitchconfig();
		}
	}
	
	function saveswitchconfig(){
		var str = confswitch1Label.inputText + "," + confswitch2Label.inputText;
		connectionPathSwitch = str;
		var doc1 = new XMLHttpRequest();
			doc1.onreadystatechange = function() {
				if (doc1.readyState == XMLHttpRequest.DONE) {
				}
			}
		doc1.open("PUT", "file:///HCBv2/qml/apps/domoticzBoard/switch.txt");
		doc1.send(str);
	}
	
	Text {
		id: titleText
		anchors {
			left: parent.left
			leftMargin: 50
            top: parent.top
            topMargin: 15
		}
		font {
			pixelSize: qfont.bodyText
			family: qfont.regular.name
		}
		wrapMode: Text.WordWrap
		text: "Configureer hier de instellingen voor DomoticzBoard"
	}
	
//Next part is to give someone the option for having a systray icon (in the right upper corner)
	Text {
		id: systrayText
		anchors {
			left: parent.left
			leftMargin: 50
			top: titleText.bottom
			topMargin: 20
		}
		font {
			pixelSize: qfont.bodyText
			family: qfont.regular.name
		}
		wrapMode: Text.WordWrap
		text: "DomoticzBoard icoon zichtbaar op systray?"
	}
	
	OnOffToggle {
		id: showDBIconToggle
		height: 36
		anchors {
			left: systrayText.left
			leftMargin: 325
			top: titleText.bottom
			topMargin: 20
		}
		leftIsSwitchedOn: false
		onSelectedChangedByUser: {
			if (isSwitchedOn) {
				app.saveshowDBIcon("Yes")
			} else {
				app.saveshowDBIcon("No")
			}
		}
	}
	
	//this will show a popup which is telling what the consequense is of change the toggle above.
	IconButton {
		id: infoButton
		anchors {
			left: showDBIconToggle.right
			leftMargin: 25
			top: titleText.bottom
			topMargin: 20
		}
		iconSource: "./drawables/info.png"
		onClicked: {
			qdialog.showDialog(qdialog.SizeLarge, qsTr("Informatie"), qsTr("De vraag betreft het icoon wat helemaal boven in op het hoofdscherm wordt getoond, indien u dit icoon wenst te zien zorg dat hij aan staat, zo niet uiteraard uit. <br><br> Bij het aan of uit zetten van deze knop, bevestigd u de keuze voor het laten zien van het icoon.") , qsTr("Sluiten"));
		}
	}

// server ip and port colums
	Column {
		id: labelContainer
		anchors {
			top: systrayText.top
			topMargin: 20
			left: parent.left
			leftMargin: 44
			right: parent.right
			rightMargin: 27
		}
		spacing: 6


		Item {
			id: spacer
			width: parent.width
			height: 18
		}

	// start ipadres
		Item {
			width: parent.width
			height: childrenRect.height
			
			EditTextLabel {
				id: ipadresLabel
				height: editipAdresButton.height
				leftText: qsTr("Hostname of ip-adres")
				leftTextAvailableWidth:500

				anchors {
					left: parent.left
					leftMargin: 1
					right: editipAdresButton.left
					rightMargin: 6
					top: titleText.bottom
					topMargin: 6
				}

				onClicked: {
					qkeyboard.open("Voer hier uw hostname of ip-adres in", ipadresLabel.inputText, saveIpadres)
				}
			}
			
			IconButton {
				id: editipAdresButton
				width: 40
				anchors {
					bottom: ipadresLabel.bottom
					right: parent.right
				}
				iconSource: "./drawables/edit.svg"

				onClicked: {
					qkeyboard.open("Voer hier uw hostname of ip-adres in", ipadresLabel.inputText, saveIpadres)
				}
			}
		}
	// end ipadres
	// start portnumber
	
		Item {
			width: parent.width
			height: childrenRect.height

			EditTextLabel {
				id: poortnummerLabel
				height: editportNumberButton.height
				leftText: qsTr("Poortnummer (default is 8080)")
				leftTextAvailableWidth:500

				anchors {
					left: parent.left
					leftMargin: 1
					right: editportNumberButton.left
					rightMargin: 6
					top: ipadresLabel.bottom
					topMargin: 6
				}
				onClicked: {
					qkeyboard.open("voer hier de poort in", poortnummerLabel.inputText, savePoortnummer);
				}
			}
			
			IconButton {
				id: editportNumberButton
				width: 40
				anchors {
					bottom: poortnummerLabel.bottom
					right: parent.right
				}
				iconSource: "./drawables/edit.svg"

				onClicked: {
					qkeyboard.open("voer hier de poort in", poortnummerLabel.inputText, savePoortnummer);
				}
			}
		}
	// end port number	
	// start switch 1 config	
		Item {
			width: parent.width
			height: childrenRect.height

			EditTextLabel {
				id: confswitch1Label
				height: editconfswitch1Button.height
				leftText: qsTr("Domoticz switch 1 ")
				leftTextAvailableWidth:500

				anchors {
					left: parent.left
					leftMargin: 1
					right: editconfswitch1Button.left
					rightMargin: 6
					top: poortnummerLabel.bottom
					topMargin: 6
				}
				
				onClicked: {
					qkeyboard.open("Voer hier het IDX nummer in", confswitch1Label.inputText, saveconfswitch1)
				}
			}
			
			IconButton {
				id: editconfswitch1Button
				width: 40
				anchors {
					bottom: confswitch1Label.bottom
					right: parent.right
				}
				iconSource: "./drawables/edit.svg"

				onClicked: {
					qkeyboard.open("Voer hier het IDX nummer in", confswitch1Label.inputText, saveconfswitch1)
				}
			}
		}
		
	// end switch 1 config
	// start switch 2 config	
		Item {
			width: parent.width
			height: childrenRect.height

			EditTextLabel {
				id: confswitch2Label
				height: editconfswitch2Button.height
				leftText: qsTr("Domoticz switch 2 ")
				leftTextAvailableWidth:500

				anchors {
					left: parent.left
					leftMargin: 1
					right: editconfswitch2Button.left
					rightMargin: 6
					top: confswitch1Label.bottom
					topMargin: 6
				}
				
				onClicked: {
					qkeyboard.open("Voer hier het IDX nummer in", confswitch2Label.inputText, saveconfswitch2)
				}
			}
			
			IconButton {
				id: editconfswitch2Button
				width: 40
				anchors {
					bottom: confswitch2Label.bottom
					right: parent.right
				}
				iconSource: "./drawables/edit.svg"

				onClicked: {
					qkeyboard.open("Voer hier het IDX nummer in", confswitch2Label.inputText, saveconfswitch2)
				}
			}
		}
		
	// end switch 2 config
	
	}

	
	//this will start the read function after the boot.
	Component.onCompleted: {
		readConnection();
		readSwitch();
	}
	
	//this read function will show you the correct information after a reboot of your toon device, it will receive the information of the serverip.txt file.
	function readConnection() {
		var doc2 = new XMLHttpRequest();
		doc2.onreadystatechange = function() {
			if (doc2.readyState == XMLHttpRequest.DONE) {
				if (doc2.responseText.length > 2) {
					connectionPath = doc2.responseText;
					if (connectionPath.length > 0) {
						var pathVar = connectionPath;
						var splitVar = pathVar.split(":")
						ipadresLabel.inputText = splitVar[0];
						poortnummerLabel.inputText = splitVar[1];
					}
				}
 			}
		}  		
		doc2.open("GET", "file:///HCBv2/qml/apps/domoticzBoard/serverip.txt", true);
		doc2.send();
	}
	function readSwitch() {
		var doc1 = new XMLHttpRequest();
		doc1.onreadystatechange = function() {
			if (doc1.readyState == XMLHttpRequest.DONE) {
				if (doc1.responseText.length > 2) {
					connectionPathSwitch = doc1.responseText;
					if (connectionPathSwitch.length > 0) {
						var pathVar = connectionPathSwitch;
						var splitVar = pathVar.split(",")
						confswitch1Label.inputText = splitVar[0];
						confswitch2Label.inputText = splitVar[1];
					}
				}
 			}
		}  		
		doc1.open("GET", "file:///HCBv2/qml/apps/domoticzBoard/switch.txt", true);
		doc1.send();
	}
}
