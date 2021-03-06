import QtQuick 1.1
import BasicUIControls 1.0
import qb.components 1.0
import BxtClient 1.0

Screen {
	id: root
	screenTitle: qsTr("DomoticzBoard Instellingen")
	screenTitleIconUrl: "./drawables/DomoticzSystrayIcon.png"

	onHidden: {
		screenStateController.screenColorDimmedIsReachable = true;
	}
	
	onShown: {
		showDBIconToggle.isSwitchedOn = app.showDBIcon;
		ipadresLabel.inputText = app.ipadres;
		poortnummerLabel.inputText = app.poortnummer;
		console.log("********** Domoticz Menu ipadres,poortnummer:"  + app.ipadres + ":" + app.poortnummer);
		confswitch1Label.inputText = app.switch1idx;
		confswitch2Label.inputText = app.switch2idx;
		confswitch3Label.inputText = app.switch3idx;
		confswitch4Label.inputText = app.switch4idx;
		confswitch5Label.inputText = app.switch5idx;
	}
	
	function saveIpadres(text) {
		if (text) {
			ipadresLabel.inputText = text;
			app.ipadres = text;
			savepath();
		}
	}

	function savePoortnummer(text) {
		if (text) {
			poortnummerLabel.inputText = text;
			app.poortnummer = text;
			savepath();
		}
	}

	function savepath(){
		var str = ipadresLabel.inputText + ":" + poortnummerLabel.inputText;
		var doc2 = new XMLHttpRequest();
			doc2.onreadystatechange = function() {
				if (doc2.readyState == XMLHttpRequest.DONE) {
				}
			}
		doc2.open("PUT", "file:///HCBv2/qml/apps/domoticzboard/serverip.txt");
		doc2.send(str);
		app.refreshScreen();
	}
	
	// switch save to file
	
	function saveconfswitch1(text) {
		if (text.length == 0) text = "0";
		confswitch1Label.inputText = text;
		app.switch1idx = text;
		saveswitchconfig();
	}
	function saveconfswitch2(text) {
		if (text.length == 0) text = "0";
		confswitch2Label.inputText = text;
		app.switch2idx = text;
		saveswitchconfig();
	}
	function saveconfswitch3(text) {
		if (text.length == 0) text = "0";
		confswitch3Label.inputText = text;
		app.switch3idx = text;
		saveswitchconfig();
	}
	function saveconfswitch4(text) {
		if (text.length == 0) text = "0";
		confswitch4Label.inputText = text;
		app.switch4idx = text;
		saveswitchconfig();
	}
	function saveconfswitch5(text) {
		if (text.length == 0) text = "0";
		confswitch5Label.inputText = text;
		app.switch5idx = text;
		saveswitchconfig();
	}
	function saveswitchconfig(){
		var str = confswitch1Label.inputText + "," + confswitch2Label.inputText + "," + confswitch3Label.inputText + "," + confswitch4Label.inputText + "," + confswitch5Label.inputText;
		var doc1 = new XMLHttpRequest();
			doc1.onreadystatechange = function() {
				if (doc1.readyState == XMLHttpRequest.DONE) {
				}
			}
		doc1.open("PUT", "file:///HCBv2/qml/apps/domoticzboard/switch.txt");
		doc1.send(str);
		app.refreshScreen();
	}
	
	Text {
		id: titleText
		anchors {
			left: parent.left
			leftMargin: isNxt ? 62 : 50
            top: parent.top
            topMargin: isNxt ? 19 : 15
		}
		font {
			pixelSize: qfont.bodyText
			family: qfont.regular.name
		}
		wrapMode: Text.WordWrap
		text: "Configureer hier de instellingen voor domoticzboard"
	}
	
//Next part is to give someone the option for having a systray icon (in the right upper corner)
	Text {
		id: systrayText
		anchors {
			left: parent.left
			leftMargin: isNxt ? 62 : 50
			top: titleText.bottom
			topMargin: isNxt ? 25 : 20
		}
		font {
			pixelSize: qfont.bodyText
			family: qfont.regular.name
		}
		wrapMode: Text.WordWrap
		text: "domoticzboard icoon zichtbaar op systray?"
	}
	
	OnOffToggle {
		id: showDBIconToggle
		height: 36
		anchors {
			left: systrayText.left
			leftMargin: isNxt ? 488 : 390
			top: titleText.bottom
			topMargin: isNxt ? 25 : 20
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
	StandardButton {
		id: infoButton
		anchors {
			left: showDBIconToggle.right
			leftMargin: isNxt ? 31 : 25
			top: titleText.bottom
			topMargin: isNxt ? 25 : 20
		}
		text: "?"
		onClicked: {
			qdialog.showDialog(qdialog.SizeLarge, qsTr("Informatie"), qsTr("De vraag betreft het icoon wat helemaal boven in op het hoofdscherm wordt getoond, indien u dit icoon wenst te zien zorg dat hij aan staat, zo niet uiteraard uit. <br><br> Bij het aan of uit zetten van deze knop, bevestigd u de keuze voor het laten zien van het icoon.") , qsTr("Sluiten"));
		}
	}

// server ip and port colums
	Column {
		id: labelContainer
		anchors {
			top: systrayText.top
			topMargin: isNxt ? 25 : 20
			left: parent.left
			leftMargin: isNxt ? 55 : 44
			right: parent.right
			rightMargin: isNxt ? 34 : 27
		}
		spacing: 6


		Item {
			id: spacer
			width: parent.width
			height: isNxt ? 22 : 18
		}

	// start ipadres
		Item {
			width: parent.width
			height: childrenRect.height
			
			EditTextLabel4421 {
				id: ipadresLabel
				height: editipAdresButton.height
				leftText: qsTr("Hostname")
				leftTextAvailableWidth: isNxt ? 625 : 500

				anchors {
					left: parent.left
					leftMargin: 1
					right: editipAdresButton.left
					rightMargin: isNxt ? 7 : 6
					topMargin: isNxt ? 7 : 6
				}
			}
			
			IconButton {
				id: editipAdresButton
				width: isNxt ? 50 : 40
				anchors {
					bottom: ipadresLabel.bottom
					right: parent.right
				}
				iconSource: "./drawables/edit.png"

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

			EditTextLabel4421 {
				id: poortnummerLabel
				height: editportNumberButton.height
				leftText: qsTr("Port (default is 8080)")
				leftTextAvailableWidth: isNxt ? 625 : 500

				anchors {
					left: parent.left
					leftMargin: 1
					right: editportNumberButton.left
					rightMargin: isNxt ? 7 : 6
					topMargin: isNxt ? 7 : 6
				}
			}
			
			IconButton {
				id: editportNumberButton
				width: isNxt ? 50 : 40
				anchors {
					bottom: poortnummerLabel.bottom
					right: parent.right
				}
				iconSource: "./drawables/edit.png"

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

			EditTextLabel4421 {
				id: confswitch1Label
				height: editconfswitch1Button.height
				leftText: qsTr("Domoticz switch 1")
				leftTextAvailableWidth: isNxt ? 625 : 500

				anchors {
					left: parent.left
					leftMargin: 1
					right: editconfswitch1Button.left
					rightMargin: isNxt ? 7 : 6
					topMargin: isNxt ? 7 : 6
				}

			}
			
			IconButton {
				id: editconfswitch1Button
				width: isNxt ? 50 : 40
				anchors {
					bottom: confswitch1Label.bottom
					right: parent.right
				}
				iconSource: "./drawables/edit.png"

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

			EditTextLabel4421 {
				id: confswitch2Label
				height: editconfswitch2Button.height
				leftText: qsTr("Domoticz switch 2")
				leftTextAvailableWidth: isNxt ? 625 : 500

				anchors {
					left: parent.left
					leftMargin: 1
					right: editconfswitch2Button.left
					rightMargin: isNxt ? 7 : 6
					topMargin: isNxt ? 7 : 6
				}
			}
			
			IconButton {
				id: editconfswitch2Button
				width: isNxt ? 50 : 40
				anchors {
					bottom: confswitch2Label.bottom
					right: parent.right
				}
				iconSource: "./drawables/edit.png"

				onClicked: {
					qkeyboard.open("Voer hier het IDX nummer in", confswitch2Label.inputText, saveconfswitch2)
				}
			}
		}
	// end switch 2 config
	// start switch 3 config
		Item {
			width: parent.width
			height: childrenRect.height

			EditTextLabel4421 {
				id: confswitch3Label
				height: editconfswitch3Button.height
				leftText: qsTr("Domoticz switch 3")
				leftTextAvailableWidth: isNxt ? 625 : 500

				anchors {
					left: parent.left
					leftMargin: 1
					right: editconfswitch3Button.left
					rightMargin: isNxt ? 7 : 6
					topMargin: isNxt ? 7 : 6
				}
			}
			
			IconButton {
				id: editconfswitch3Button
				width: isNxt ? 50 : 40
				anchors {
					bottom: confswitch3Label.bottom
					right: parent.right
				}
				iconSource: "./drawables/edit.png"

				onClicked: {
					qkeyboard.open("Voer hier het IDX nummer in", confswitch3Label.inputText, saveconfswitch3)
				}
			}
		}
	// end switch 3 config
	// start switch 4 config
		Item {
			width: parent.width
			height: childrenRect.height

			EditTextLabel4421 {
				id: confswitch4Label
				height: editconfswitch4Button.height
				leftText: qsTr("Domoticz switch 4")
				leftTextAvailableWidth: isNxt ? 625 : 500

				anchors {
					left: parent.left
					leftMargin: 1
					right: editconfswitch4Button.left
					rightMargin: isNxt ? 7 : 6
					topMargin: isNxt ? 7 : 6
				}
			}
			
			IconButton {
				id: editconfswitch4Button
				width: isNxt ? 50 : 40
				anchors {
					bottom: confswitch4Label.bottom
					right: parent.right
				}
				iconSource: "./drawables/edit.png"

				onClicked: {
					qkeyboard.open("Voer hier het IDX nummer in", confswitch4Label.inputText, saveconfswitch4)
				}
			}
		}
	// end switch 4 config
	// start switch 5 config
		Item {
			width: parent.width
			height: childrenRect.height

			EditTextLabel4421 {
				id: confswitch5Label
				height: editconfswitch4Button.height
				leftText: qsTr("Domoticz switch 5")
				leftTextAvailableWidth: isNxt ? 625 : 500

				anchors {
					left: parent.left
					leftMargin: 1
					right: editconfswitch5Button.left
					rightMargin: isNxt ? 7 : 6
					topMargin: isNxt ? 7 : 6
				}
			}
			
			IconButton {
				id: editconfswitch5Button
				width: isNxt ? 50 : 40
				anchors {
					bottom: confswitch5Label.bottom
					right: parent.right
				}
				iconSource: "./drawables/edit.png"

				onClicked: {
					qkeyboard.open("Voer hier het IDX nummer in", confswitch5Label.inputText, saveconfswitch5)
				}
			}
		}
	// end switch 5 config
	}	
}
