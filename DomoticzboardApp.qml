import QtQuick 1.1
import qb.components 1.0
import qb.base 1.0;

App {
	id: root

	property url trayUrl : "DomoticzboardTray.qml";
	property url thumbnailIcon: "./drawables/DomoticzSystrayIcon.png"
	property url menuScreenUrl : "DomoticzboardSettings.qml"
	property url domoticzScreenUrl : "DomoticzboardScreen.qml"
	property DomoticzboardSettings domoticzSettings
	property SystrayIcon domoticzTray
	property bool showDBIcon : true
	
	property string timeStr
	property string dateStr
	property string connectionPath
	property string ipadres
	property string poortnummer
	
	property string connectionPathSwitch: "";
	property string bulb_offvar: "./drawables/Light48_Off.png";
	property string bulb_onvar: "./drawables/Light48_On.png";
	property string group_offvar: "./drawables/GroupOff.png";
	property string group_onvar: "./drawables/GroupOn.png";
	
	property string switch1idx : "0"
	property string switch1StatusIcon
	property string switch1Name
	
	property string switch2idx : "0"
	property string switch2StatusIcon
	property string switch2Name

	property string switch3idx : "0"
	property string switch3StatusIcon
	property string switch3Name

	property string switch4idx : "0"
	property string switch4StatusIcon
	property string switch4Name
	
	property string switch5idx : "0"
	property string switch5StatusIcon
	property string switch5Name

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
	
	property string scene4idx
	property string scene4StatusName
	property string scene4StatusIcon
	property string scene4Name
	
	property string scene5idx
	property string scene5StatusName
	property string scene5StatusIcon
	property string scene5Name

	function init() {
		registry.registerWidget("systrayIcon", trayUrl, this, "domoticzTray");
		registry.registerWidget("screen", domoticzScreenUrl, this);
		registry.registerWidget("screen", menuScreenUrl, this, "domoticzSettings");
		registry.registerWidget("menuItem", null, this, null, {objectName: "DBMenuItem", label: qsTr("DB-settings"), image: thumbnailIcon, screenUrl: menuScreenUrl, weight: 120});
	}
	//this function needs to be started after the app is booted.
	Component.onCompleted: {
		refreshScreen();
	}

	function refreshScreen() {
		readDBState();
		readConnection();
		readSwitch();
		datetimeTimer.start();
	}
	
//this is the save of the toggle which could be found in the menuscreen.
	function saveshowDBIcon(text) {
		showDBIcon = (text == "Yes");
  		var doc2 = new XMLHttpRequest();
   		doc2.open("PUT", "file:///HCBv2/qml/apps/domoticzboard/ShowDBIcon.txt");
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
		doc3.open("GET", "file:///HCBv2/qml/apps/domoticzboard/ShowDBIcon.txt", true);
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
		doc2.open("GET", "file:///HCBv2/qml/apps/domoticzboard/serverip.txt", true);
		doc2.send();
	}
	
	function readSwitch() {
		var doc1 = new XMLHttpRequest();
		doc1.onreadystatechange = function() {
			if (doc1.readyState == XMLHttpRequest.DONE) {
				if (doc1.responseText.length > 2) {
					connectionPathSwitch = doc1.responseText;
					if (connectionPathSwitch.length > 0) {
						var splitVar = connectionPathSwitch.split(",");
						if (splitVar[0].length > 0) switch1idx = splitVar[0];
						if (splitVar[1].length > 0) switch2idx = splitVar[1];
						if (splitVar[2].length > 0) switch3idx = splitVar[2];
						if (splitVar[3].length > 0) switch4idx = splitVar[3];
						if (splitVar[4].length > 0) switch5idx = splitVar[4];
					}
				}
 			}
		}  		
		doc1.open("GET", "file:///HCBv2/qml/apps/domoticzboard/switch.txt", true);
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
					} else if (idx == switch5idx) {
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
					} else if (idx == switch5idx){
						if (tmpDeviceStatus5 == "On") {
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
				//scene4 json
				res = res.slice(k)
				i = res.indexOf('"idx"');
				j = res.indexOf('"', i+9);
				scene4idx =  res.substring(i+9, j);
				
				i = res.indexOf('"Name"');
				j = res.indexOf('"', i+10);
				scene4Name = res.substring(i+10 , j);
				
				i = res.indexOf('"Status"', j);
				j = res.indexOf('"', i+12);
				scene4StatusName = res.substring(i+12, j);	
				
				if (scene4idx == "4") {
						if (scene4StatusName == "On") {
							scene4StatusIcon = group_offvar;
						}  else if (scene4StatusName == "Off") {
							scene4StatusIcon = group_onvar;
						} else {
							scene4StatusIcon = group_offvar;
							}
					}
				//scene5 json
				res = res.slice(k)
				i = res.indexOf('"idx"');
				j = res.indexOf('"', i+9);
				scene5idx =  res.substring(i+9, j);
				
				i = res.indexOf('"Name"');
				j = res.indexOf('"', i+10);
				scene5Name = res.substring(i+10 , j);
				
				i = res.indexOf('"Status"', j);
				j = res.indexOf('"', i+12);
				scene5StatusName = res.substring(i+12, j);	
				
				if (scene5idx == "5") {
						if (scene5StatusName == "On") {
							scene5StatusIcon = group_offvar;
						}  else if (scene5StatusName == "Off") {
							scene5StatusIcon = group_onvar;
						} else {
							scene5StatusIcon = group_offvar;
							}
					}
				//ending tags
			}
		}
	}
	xmlhttp.open("GET", "http://"+connectionPath+"/json.htm?type=scenes", true);
	xmlhttp.send();
}
	

	Timer {
		id: datetimeTimer
		interval: 10000
		running: false
		repeat: true
		onTriggered: {
			if (switch1idx !== "0") readDeviceStatus1(switch1idx);
			if (switch2idx !== "0") readDeviceStatus1(switch2idx);
			if (switch3idx !== "0") readDeviceStatus1(switch3idx);
			if (switch4idx !== "0") readDeviceStatus1(switch4idx);
			if (switch5idx !== "0") readDeviceStatus1(switch5idx);
			readSceneStatus();
		}
	}

}
