import QtQuick 2.1
import qb.components 1.0
import qb.base 1.0;

App {
	id: root
	// These are the URL's for the QML resources from which our widgets will be instantiated.
	// By making them a URL type property they will automatically be converted to full paths,
	// preventing problems when passing them around to code that comes from a different path.
	property url trayUrl : "DomoticzTray.qml";
	property url thumbnailIcon: "qrc:/tsc/DomoticzSystrayIcon.png"
	property url menuScreenUrl : "DomoticzSettings.qml"
	property url domoticzScreenUrl : "DomoticzScreen.qml"
	property DomoticzSettings domoticzSettings
	property SystrayIcon domoticzTray
	property bool showDBIcon : true
	
	property string timeStr
	property string dateStr
	property string connectionPath
	property string ipadres
	property string poortnummer
	
	property string connectionPathSwitch: "";
	property string bulb_offvar: "qrc:/tsc/Light48_Off.png";
	property string bulb_onvar: "qrc:/tsc/Light48_On.png";
	property string group_offvar: "qrc:/tsc/GroupOff.png";
	property string group_onvar: "qrc:/tsc/GroupOn.png";
	
	property string switch1idx
	property string switch1StatusIcon
	property string switch1Name
	
	property string switch2idx
	property string switch2StatusIcon
	property string switch2Name

	property string switch3idx
	property string switch3StatusIcon
	property string switch3Name

	property string switch4idx
	property string switch4StatusIcon
	property string switch4Name
	
	property string switch5idx
	property string switch5StatusIcon
	property string switch5Name
	
//scenes 1-2-3 are automatically queried. make sure that you use Domoticz scenes 1-2-3 for Toon.
//scene3 is not visible by default. remove lines 276 and 318 in DomoticzScreen.qml to make it visible.

	property string scene1idx
	property string scene1StatusName
	property string scene1StatusIcon
	property string scene1Name

	property string scene2idx
	property string scene2StatusName
	property string scene2StatusIcon
	property string scene2Name

	property string scene3idx
	property string scene3StatusName
	property string scene3StatusIcon
	property string scene3Name

	function init() {
		registry.registerWidget("systrayIcon", trayUrl, this, "domoticzTray");
		registry.registerWidget("screen", domoticzScreenUrl, this);
		registry.registerWidget("screen", menuScreenUrl, this, "domoticzSettings");
		registry.registerWidget("menuItem", null, this, null, {objectName: "DBMenuItem", label: qsTr("DB-settings"), image: thumbnailIcon, screenUrl: menuScreenUrl, weight: 120});
	}
	//this function needs to be started after the app is booted.
	Component.onCompleted: {
		readDBState();
		readConnection();
		readSwitch();
	}
	
//this is the save of the toggle which could be found in the menuscreen.
	function saveshowDBIcon(text) {
		showDBIcon = (text == "Yes");
  		var doc2 = new XMLHttpRequest();
   		doc2.open("PUT", "file:///HCBv2/qml/apps/domoticzBoard/ShowDBIcon.txt");
   		doc2.send(showDBIcon);
		if (showDBIcon) {
			domoticzTray.show();
		} else {
			domoticzTray.hide();
		}
	}
	
	//In this read function you'll find the execution of the visibility of the systray icon.
	function readDBState() {
		var doc3 = new XMLHttpRequest();
		doc3.onreadystatechange = function() {
			if (doc3.readyState == XMLHttpRequest.DONE) {
				if (doc3.responseText.length > 2) {
					showDBIcon = (doc3.responseText == "true");
					if (showDBIcon) {
						domoticzTray.show();
					} else {
						domoticzTray.hide();
					}
				}
			}
 		}
		doc3.open("GET", "file:///HCBv2/qml/apps/domoticzBoard/ShowDBIcon.txt", true);
		doc3.send();
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
						ipadres = splitVar[0];
						poortnummer = splitVar[1];
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
						switch1idx = splitVar[0];
						switch2idx = splitVar[1];
						switch3idx = splitVar[2];
						switch4idx = splitVar[3];
						switch5idx = splitVar[4];

					}
				}
 			}
		}  		
		doc1.open("GET", "file:///HCBv2/qml/apps/domoticzBoard/switch.txt", true);
		doc1.send();
	}
	
	function readDeviceStatus1(idx) {
		var xmlhttp = new XMLHttpRequest();
		var i;
		var j;
		var tmpDeviceStatus1;
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4) {
				if (xmlhttp.status == 200) {
					var res = xmlhttp.responseText;
										
					i = res.indexOf('"Name"');
					j = res.indexOf('"', i+10);
						   if (idx == switch1idx) {
						switch1Name = res.substring(i+10 , j);
					} else if (idx == switch2idx) {
						switch2Name = res.substring(i+10 , j);
					} else if (idx == switch3idx) {
						switch3Name = res.substring(i+10 , j);
					} else if (idx == switch4idx) {
						switch4Name = res.substring(i+10 , j);
					} else 	  {
						switch5Name = res.substring(i+10 , j);
					}
					
					i = res.indexOf('"Status"', j);
					j = res.indexOf('"', i+12);
					tmpDeviceStatus1 = res.substring(i+12, j);
					if (idx == switch1idx) {
						if (tmpDeviceStatus1 == "On") {
							switch1StatusIcon = bulb_onvar;
						} else {
							switch1StatusIcon = bulb_offvar;
							}
					} else if (idx == switch2idx) {
						if (tmpDeviceStatus1 == "On") {
							switch2StatusIcon = bulb_onvar;
						} else {
							switch2StatusIcon = bulb_offvar;
							}
					} else if (idx == switch3idx) {
						if (tmpDeviceStatus1 == "On") {
							switch3StatusIcon = bulb_onvar;
						} else {
							switch3StatusIcon = bulb_offvar;
							}
					} else if (idx == switch4idx) {
						if (tmpDeviceStatus1 == "On") {
							switch4StatusIcon = bulb_onvar;
						} else {
							switch4StatusIcon = bulb_offvar;
							}
					} else {
						if (tmpDeviceStatus1 == "On") {
							switch5StatusIcon = bulb_onvar;
						} else {
							switch5StatusIcon = bulb_offvar;
							}
					}
				}
			}
		}
		xmlhttp.open("GET", "http://"+connectionPath+"/json.htm?type=devices&rid="+idx, true);
		xmlhttp.send();
	}
	
function readSceneStatus() {
	var xmlhttp = new XMLHttpRequest();
	var i;
	var j;
	var k;
	//var tmpSceneStatus1;
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				var res = xmlhttp.responseText;
			   
			   //scene1 json
				i = res.indexOf('"idx"');
				j = res.indexOf('"', i+9);
				k = res.indexOf('"', i+9);
				scene1idx =  res.substring(i+9, j);
				
				i = res.indexOf('"Name"');
				j = res.indexOf('"', i+10);
				scene1Name = res.substring(i+10 , j);
				
				i = res.indexOf('"Status"', j);
				j = res.indexOf('"', i+12);
				scene1StatusName = res.substring(i+12, j);
				if (scene1idx == "1") {
						if (scene1StatusName == "On") {
							scene1StatusIcon = group_offvar;
						} else if (scene1StatusName == "Off") {
							scene1StatusIcon = group_onvar;
						} else {
							scene1StatusIcon = group_offvar;
						}
					}
				//scene2 json
				res = res.slice(k)
				i = res.indexOf('"idx"');
				j = res.indexOf('"', i+9);
				k = res.indexOf('"', i+9);
				scene2idx =  res.substring(i+9, j);
				
				i = res.indexOf('"Name"');
				j = res.indexOf('"', i+10);
				scene2Name = res.substring(i+10 , j);
				
				i = res.indexOf('"Status"', j);
				j = res.indexOf('"', i+12);
				scene2StatusName = res.substring(i+12, j);	

				if (scene2idx == "2") {

						if (scene2StatusName == "On") {
							scene2StatusIcon = group_offvar;
						}  else if (scene2StatusName == "Off") {
							scene2StatusIcon = group_onvar;
						} else {
							scene2StatusIcon = group_offvar;
							}
					}
				//scene3 json
				res = res.slice(k)
				i = res.indexOf('"idx"');
				j = res.indexOf('"', i+9);
				scene3idx =  res.substring(i+9, j);
				
				i = res.indexOf('"Name"');
				j = res.indexOf('"', i+10);
				scene3Name = res.substring(i+10 , j);
				
				i = res.indexOf('"Status"', j);
				j = res.indexOf('"', i+12);
				scene3StatusName = res.substring(i+12, j);	
				
				if (scene3idx == "3") {
						if (scene3StatusName == "On") {
							scene3StatusIcon = group_offvar;
						}  else if (scene3StatusName == "Off") {
							scene3StatusIcon = group_onvar;
						} else {
							scene3StatusIcon = group_offvar;
							}
					}
				//ending tags
			}
		}
	}
	xmlhttp.open("GET", "http://"+connectionPath+"/json.htm?type=scenes", true);
	xmlhttp.send();
}
	
	function updateDomoticzLight1() {
		readDeviceStatus1(switch1idx);
	}
	function updateDomoticzLight2() {
		readDeviceStatus1(switch2idx);
	}
	function updateDomoticzLight3() {
		readDeviceStatus1(switch3idx);
	}
	function updateDomoticzLight4() {
		readDeviceStatus1(switch4idx);
	}
	function updateDomoticzLight5() {
		readDeviceStatus1(switch5idx);
	}
	function updateSceneStatus() {
		readSceneStatus();
	}

	Timer {
		id: datetimeTimer
		interval: 10000
		triggeredOnStart: true
		running: true
		repeat: true
		onTriggered: {
			updateDomoticzLight1();
			updateDomoticzLight2();
			updateDomoticzLight3();
			updateDomoticzLight4();
			updateDomoticzLight5();
			updateSceneStatus();
		}
	}

}
