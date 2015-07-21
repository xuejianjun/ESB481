/*
 *  Copyright (c) 2008, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

/*
 * transpost_tatistics.js contains scripts pertaining to handle @server_short_name@ statistics data
 */

// variables for Transport Listener
var allGraphTrpListenerBytesSent;
var allGraphTrpListenerBytesReceived;

// variables for Transport Sender
var allGraphTrpSenderBytesSent;
var allGraphTrpSenderBytesReceived;

function initAllStats(transportListenerXScale, transportSenderXScale) {
    if (transportListenerXScale != null) {
        initAllTransportListenerGraphs(transportListenerXScale);

    } else {
    }
    if (transportSenderXScale != null) {
        initAllTransportSenderGraphs(transportSenderXScale);
    }
}

function isNumeric(sText){
    var validChars = "0123456789.";
    var isNumber = true;
    var character;
    for (var i = 0; i < sText.length && isNumber == true; i++) {
        character = sText.charAt(i);
        if (validChars.indexOf(character) == -1) {
            isNumber = false;
        }
    }
    return isNumber;
}

function initAllTransportListenerGraphs(transportListenerXScale){
    if (transportListenerXScale < 1 || !isNumeric(transportListenerXScale)) {
        return;
    }
    allGraphTrpListenerBytesReceived = new carbonGraph(transportListenerXScale);
    allGraphTrpListenerBytesSent =  new carbonGraph(transportListenerXScale);
}

function initAllTransportSenderGraphs(transportSenderXScale){
    if (transportSenderXScale < 1 || !isNumeric(transportSenderXScale)) {
        return;
    }
    allGraphTrpSenderBytesReceived = new carbonGraph(transportSenderXScale);
    allGraphTrpSenderBytesSent =  new carbonGraph(transportSenderXScale);
}




