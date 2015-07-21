<!--
 ~ Copyright (c) 2005-2010, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 ~
 ~ WSO2 Inc. licenses this file to you under the Apache License,
 ~ Version 2.0 (the "License"); you may not use this file except
 ~ in compliance with the License.
 ~ You may obtain a copy of the License at
 ~
 ~    http://www.apache.org/licenses/LICENSE-2.0
 ~
 ~ Unless required by applicable law or agreed to in writing,
 ~ software distributed under the License is distributed on an
 ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 ~ KIND, either express or implied.  See the License for the
 ~ specific language governing permissions and limitations
 ~ under the License.
 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://wso2.org/projects/carbon/taglibs/carbontags.jar" prefix="carbon" %>
<%@ page import="org.wso2.carbon.statistics.transport.ui.TransportStatisticsAdminClient" %>
<%@ page import="org.wso2.carbon.ui.CarbonUIUtil" %>
<%@ page import="org.apache.axis2.context.ConfigurationContext" %>
<%@ page import="org.wso2.carbon.CarbonConstants" %>
<%@ page import="org.wso2.carbon.utils.ServerConstants" %>

<%!
    private String transportParamType;
    private String transportListener = "listener";
    private String transportSender = "sender";
%>

<%
    transportParamType = request.getParameter("transportType");

    String backendServerURL = CarbonUIUtil.getServerURL(config.getServletContext(), session);
    ConfigurationContext configContext = (ConfigurationContext) config.getServletContext().
            getAttribute(CarbonConstants.CONFIGURATION_CONTEXT);

    String cookie = (String) session.getAttribute(ServerConstants.ADMIN_SERVICE_COOKIE);

    TransportStatisticsAdminClient trpStatClient = new TransportStatisticsAdminClient(cookie,
            backendServerURL, configContext, request.getLocale());
%>


<div id="middle">
    <fmt:bundle basename="org.wso2.carbon.statistics.transport.ui.i18n.Resources">
        <h2><%= transportParamType.toUpperCase() %> <fmt:message key="transport.statistics"/>

        </h2>

        <div id="workArea">
            <div id="result"></div>
            <p>&nbsp;</p>

            <table class="styledLeft" width="100%" id="serviceSummaryTable"
                   style="margin-left: 0px;">
                <thead>
                <tr>
                    <th colspan="2"><fmt:message
                            key="transport.statistics.for"/> <%= transportParamType.toUpperCase() %>
                        <fmt:message key="transport"/> -
                         <%= trpStatClient.getTransportClassName(transportListener, transportParamType)%>
                    </th>
                </tr>
                </thead>
                <tr class="tableOddRow">
                    <td width="30%"><fmt:message key="active.thread.count"/></td>
                    <td><%= trpStatClient.getActiveThreadCount(transportListener, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableEvenRow">
                    <td><fmt:message key="avg.size.received"/></td>
                    <td><%= trpStatClient.getAvgSizeReceived(transportListener, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableOddRow">
                    <td width="30%"><fmt:message key="avg.size.sent"/></td>
                    <td><%= trpStatClient.getAvgSizeSent(transportListener, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableEvenRow">
                    <td><fmt:message key="bytes.received"/></td>
                    <td><%= trpStatClient.getBytesReceived(transportListener, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableOddRow">
                    <td width="30%"><fmt:message key="bytes.sent"/></td>
                    <td><%= trpStatClient.getBytesSent(transportListener, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableEvenRow">
                    <td><fmt:message key="faults.receiving"/></td>
                    <td><%= trpStatClient.getFaultsReceiving(transportListener, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableOddRow">
                    <td width="30%"><fmt:message key="fault.sending"/></td>
                    <td><%= trpStatClient.getFaultsSending(transportListener, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableEvenRow">
                    <td><fmt:message key="last.reset.time"/></td>
                    <td><%= trpStatClient.getLastResetTime(transportListener, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableOddRow">
                    <td width="30%"><fmt:message key="max.size.received"/></td>
                    <td><%= trpStatClient.getMaxSizeReceived(transportListener, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableEvenRow">
                    <td><fmt:message key="max.size.sent"/></td>
                    <td><%= trpStatClient.getMaxSizeSent(transportListener, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableOddRow">
                    <td width="30%"><fmt:message key="messages.received"/></td>
                    <td><%= trpStatClient.getMessagesReceived(transportListener, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableEvenRow">
                    <td><fmt:message key="messages.sent"/></td>
                    <td><%= trpStatClient.getMessagesSent(transportListener, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableOddRow">
                    <td width="30%"><fmt:message key="metrics.window"/></td>
                    <td><%= trpStatClient.getMetricsWindow(transportListener, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableEvenRow">
                    <td><fmt:message key="min.size.received"/></td>
                    <td><%= trpStatClient.getMinSizeReceived(transportListener, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableOddRow">
                    <td width="30%"><fmt:message key="min.size.sent"/></td>
                    <td><%= trpStatClient.getMinSizeSent(transportListener, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableEvenRow">
                    <td><fmt:message key="queue.size"/></td>
                    <td><%= trpStatClient.getQueueSize(transportListener, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableOddRow">
                    <td width="30%"><fmt:message key="timeouts.receiving"/></td>
                    <td><%= trpStatClient.getTimeoutsReceiving(transportListener, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableEvenRow">
                    <td><fmt:message key="timeouts.sending"/></td>
                    <td><%= trpStatClient.getTimeoutsSending(transportListener, transportParamType) %>
                    </td>
                </tr>
            </table>
        </div>
    </fmt:bundle>
</div>

<div id="middle">
    <fmt:bundle basename="org.wso2.carbon.statistics.transport.ui.i18n.Resources">
        <div id="workArea">
            <div id="result2"></div>
            <p>&nbsp;</p>

            <table class="styledLeft" width="100%" id="serviceSummaryTable2"
                   style="margin-left: 0px;">
                <thead>
                <tr>
                    <th colspan="2"><fmt:message
                            key="transport.statistics.for"/> <%= transportParamType.toUpperCase() %>
                        <fmt:message key="transport"/> -
                        <%= trpStatClient.getTransportClassName(transportSender, transportParamType)%>
                    </th>
                </tr>
                </thead>
                <tr class="tableOddRow">
                    <td width="30%"><fmt:message key="active.thread.count"/></td>
                    <td><%= trpStatClient.getActiveThreadCount(transportSender, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableEvenRow">
                    <td><fmt:message key="avg.size.received"/></td>
                    <td><%= trpStatClient.getAvgSizeReceived(transportSender, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableOddRow">
                    <td width="30%"><fmt:message key="avg.size.sent"/></td>
                    <td><%= trpStatClient.getAvgSizeSent(transportSender, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableEvenRow">
                    <td><fmt:message key="bytes.received"/></td>
                    <td><%= trpStatClient.getBytesReceived(transportSender, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableOddRow">
                    <td width="30%"><fmt:message key="bytes.sent"/></td>
                    <td><%= trpStatClient.getBytesSent(transportSender, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableEvenRow">
                    <td><fmt:message key="faults.receiving"/></td>
                    <td><%= trpStatClient.getFaultsReceiving(transportSender, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableOddRow">
                    <td width="30%"><fmt:message key="fault.sending"/></td>
                    <td><%= trpStatClient.getFaultsSending(transportSender, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableEvenRow">
                    <td><fmt:message key="last.reset.time"/></td>
                    <td><%= trpStatClient.getLastResetTime(transportSender, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableOddRow">
                    <td width="30%"><fmt:message key="max.size.received"/></td>
                    <td><%= trpStatClient.getMaxSizeReceived(transportSender, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableEvenRow">
                    <td><fmt:message key="max.size.sent"/></td>
                    <td><%= trpStatClient.getMaxSizeSent(transportSender, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableOddRow">
                    <td width="30%"><fmt:message key="messages.received"/></td>
                    <td><%= trpStatClient.getMessagesReceived(transportSender, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableEvenRow">
                    <td><fmt:message key="messages.sent"/></td>
                    <td><%= trpStatClient.getMessagesSent(transportSender, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableOddRow">
                    <td width="30%"><fmt:message key="metrics.window"/></td>
                    <td><%= trpStatClient.getMetricsWindow(transportSender, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableEvenRow">
                    <td><fmt:message key="min.size.received"/></td>
                    <td><%= trpStatClient.getMinSizeReceived(transportSender, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableOddRow">
                    <td width="30%"><fmt:message key="min.size.sent"/></td>
                    <td><%= trpStatClient.getMinSizeSent(transportSender, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableEvenRow">
                    <td><fmt:message key="queue.size"/></td>
                    <td><%= trpStatClient.getQueueSize(transportSender, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableOddRow">
                    <td width="30%"><fmt:message key="timeouts.receiving"/></td>
                    <td><%= trpStatClient.getTimeoutsReceiving(transportSender, transportParamType) %>
                    </td>
                </tr>
                <tr class="tableEvenRow">
                    <td><fmt:message key="timeouts.sending"/></td>
                    <td><%= trpStatClient.getTimeoutsSending(transportSender, transportParamType) %>
                    </td>
                </tr>
            </table>
        </div>
    </fmt:bundle>
</div>

