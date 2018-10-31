import QtQuick 1.1
import qb.components 1.0
import qb.base 1.0;

App {
	id: root
	// These are the URL's for the QML resources from which our widgets will be instantiated.
	// By making them a URL type property they will automatically be converted to full paths,
	// preventing problems when passing them around to code that comes from a different path.
	property url trayUrl : "DomoticzTray.qml";
	property url thumbnailIcon: "./drawables/DomoticzSystrayIcon.png"
	property url menuScreenUrl : "DomoticzMenu.qml"
	property url domoticzScreenUrl : "DomoticzScreen.qml"
	property DomoticzMenu domoticzMenu
	property SystrayIcon domoticzTray
	property bool showDBIcon : true
	
	property string timeStr
	property string dateStr
	property string connectionPath: domoticzMenu.connectionPath
	property string connectionPathSwitch: "";

	property string switch1idx: confswitch1Label.inputText
	property string switch1StatusIcon
	property string switch1Name
	
	property string switch2idx: confswitch2Label.inputText
	property string switch2StatusIcon
	property string switch2Name

	property string switch3idx: "7" //put IDX of switch/wall plug here
	property string switch3StatusIcon
	property string switch3Name

	property string switch4idx: "190" //put IDX of switch/wall plug here
	property string switch4StatusIcon
	property string switch4Name
	
	property string switch5idx: "119" //put IDX of switch/wall plug here
	property string switch5StatusIcon
	property string switch5Name
	
//scenes 1-2-3 are automatically queried. make sure that you use Domoticz scenes 1-2-3 for Toon.
//scene3 is not visible by default. remove lines 347 and 388 in DomoticzScreen.qml to make it visible.

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
		registry.registerWidget("screen", menuScreenUrl, this, "domoticzMenu");
		registry.registerWidget("menuItem", null, this, null, {objectName: "DBMenuItem", label: qsTr("DB-settings"), image: thumbnailIcon, screenUrl: menuScreenUrl, weight: 120});
	}
	//this function needs to be started after the app is booted.
	Component.onCompleted: {
		readDBState();
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
							switch1StatusIcon = "./drawables/Light48_On.png";
						} else {
							switch1StatusIcon = "./drawables/Light48_Off.png";
							}
					} else if (idx == switch2idx) {
						if (tmpDeviceStatus1 == "On") {
							switch2StatusIcon = "./drawables/Light48_On.png";
						} else {
							switch2StatusIcon = "./drawables/Light48_Off.png";
							}
					} else if (idx == switch3idx) {
						if (tmpDeviceStatus1 == "On") {
							switch3StatusIcon = "./drawables/Light48_On.png";
						} else {
							switch3StatusIcon = "./drawables/Light48_Off.png";
							}
					} else if (idx == switch4idx) {
						if (tmpDeviceStatus1 == "On") {
							switch4StatusIcon = "./drawables/Light48_On.png";
						} else {
							switch4StatusIcon = "./drawables/Light48_Off.png";
							}
					} else {
						if (tmpDeviceStatus1 == "On") {
							switch5StatusIcon = "./drawables/Light48_On.png";
						} else {
							switch5StatusIcon = "./drawables/Light48_Off.png";
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
	//var tmpSceneStatus1;
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				var res = xmlhttp.responseText;
			   
			   //scene1 json
				i = res.indexOf('"idx"', j);
				j = res.indexOf('"', i+9);
				scene1idx =  res.substring(i+9, j);
				
				i = res.indexOf('"Name"');
				j = res.indexOf('"', i+10);
				scene1Name = res.substring(i+10 , j);
			   
				i = res.indexOf('"Status"', j);
				j = res.indexOf('"', i+12);
				scene1StatusName = res.substring(i+12, j);
				if (scene1idx == "1") {
						if (scene1StatusName == "On") {
							scene1StatusIcon = "./drawables/GroupOff.png";
						} else if (scene1StatusName == "Off") {
							scene1StatusIcon = "./drawables/GroupOn.png";
						} else {
							scene1StatusIcon = "./drawables/GroupOff.png";
						}
					}
				//scene2 json
				res = res.slice(i)
				i = res.indexOf('"idx"', j);
				j = res.indexOf('"', i+9);
				scene2idx =  res.substring(i+9, j);
				
				i = res.indexOf('"Name"');
				j = res.indexOf('"', i+10);
				scene2Name = res.substring(i+10 , j);
			   
				i = res.indexOf('"Status"', j);
				j = res.indexOf('"', i+12);
				scene2StatusName = res.substring(i+12, j);	
				if (scene2idx == "2") {
						if (scene2StatusName == "On") {
							scene2StatusIcon = "./drawables/GroupOff.png";
						}  else if (scene2StatusName == "Off") {
							scene2StatusIcon = "./drawables/GroupOn.png";
						} else {
							scene2StatusIcon = "./drawables/GroupOff.png";
							}
					}
				//scene3 json
				res = res.slice(i)
				i = res.indexOf('"idx"', j);
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
							scene3StatusIcon = "./drawables/GroupOff.png";
						}  else if (scene3StatusName == "Off") {
							scene3StatusIcon = "./drawables/GroupOn.png";
						} else {
							scene3StatusIcon = "./drawables/GroupOff.png";
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
