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
<%@ page import="org.apache.axis2.context.ConfigurationContext" %>
<%@ page import="org.wso2.carbon.CarbonConstants" %>
<%@ page import="org.wso2.carbon.ui.CarbonUIUtil" %>
<%@ page import="org.wso2.carbon.utils.ServerConstants" %>
<%@ page import="org.wso2.carbon.statistics.transport.ui.Utils" %>
<%@ page import="org.wso2.carbon.ui.CarbonUIMessage" %>
<%@ page import="org.wso2.carbon.statistics.transport.ui.TransportStatisticsAdminClient" %>
<%@ page import="org.wso2.carbon.statistics.transport.stub.types.carbon.TransportStatistics" %>

<%
    String transportParamType = request.getParameter("transportType");

    response.setHeader("Cache-Control", "no-cache");

    String backendServerURL = CarbonUIUtil.getServerURL(config.getServletContext(), session);
    ConfigurationContext configContext =
            (ConfigurationContext) config.getServletContext().getAttribute(CarbonConstants.
                    CONFIGURATION_CONTEXT);

    String cookie = (String) session.getAttribute(ServerConstants.ADMIN_SERVICE_COOKIE);
    TransportStatisticsAdminClient trpStatClient = new TransportStatisticsAdminClient(cookie,
            backendServerURL, configContext, request.getLocale());

    int trpListenerGraphWidth = 500;
    trpListenerGraphWidth = Utils.getPositiveIntegerValue(session, request, trpListenerGraphWidth,
            "trpListenerGraphWidth");

    int trpSenderGraphWidth = 500;
    trpSenderGraphWidth = Utils.getPositiveIntegerValue(session, request, trpSenderGraphWidth,
            "trpSenderGraphWidth");

    TransportStatistics transportStatistics;
    try {
        transportStatistics = trpStatClient.getTransportStatistics(transportParamType);
    } catch (Exception e) {
        response.setStatus(500);
        CarbonUIMessage uiMsg = new CarbonUIMessage(CarbonUIMessage.ERROR, e.getMessage(), e);
        session.setAttribute(CarbonUIMessage.ID, uiMsg);
%>

<jsp:include page="../admin/error.jsp"/>

<%
        return;
    }
%>

<fmt:bundle basename="org.wso2.carbon.statistics.transport.ui.i18n.Resources">
<table width="100%">
<tr>
    <td width="49%">
        <table class="styledLeft" width="100%">
            <thead>
            <tr>
                <th><fmt:message key="bytes.vs.time.units"/></th>
            </tr>
            </thead>
            <tr>
                <td>
                    <div id="trpListenerGraph"
                         style="width:<%= trpListenerGraphWidth %>px;height:300px;"/>
                </td>
            </tr>
        </table>
    </td>
    <td width="2%">&nbsp;</td>
    <td width="49%">
        <table class="styledLeft" width="100%">
            <thead>
            <tr>
                <th><fmt:message key="bytes.vs.time.units"/></th>
            </tr>
            </thead>
            <tr>
                <td>
                    <div id="trpSenderGraph"
                         style="width:<%= trpSenderGraphWidth %>px;height:300px;"/>
                </td>
            </tr>
        </table>
    </td>
</tr>
<tr>
    <td colspan="3">&nbsp;</td>
</tr>
<tr>
<td width="49%">
    <!-- Transport Listener Summary -->
    <table class="styledLeft" width="100%" id="serviceSummaryTable"
           style="margin-left: 0px;">
        <thead>
        <tr>
            <th colspan="2">
                <%= transportParamType.toUpperCase() %>
                <fmt:message key="transport.listener"/> -
                <%= transportStatistics.getTransportListenerClassName()%>
            </th>
        </tr>
        </thead>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="active.thread.count"/></td>
            <td><%= transportStatistics.getTransportListenerActiveThreadCount() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="avg.size.received"/></td>
            <td><%= transportStatistics.getTransportListenerAvgSizeReceived() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="avg.size.sent"/></td>
            <td><%= transportStatistics.getTransportListenerAvgSizeSent() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="bytes.received"/></td>
            <td><%= transportStatistics.getTransportListenerBytesReceived() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="bytes.sent"/></td>
            <td><%= transportStatistics.getTransportListenerBytesSent() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="faults.receiving"/></td>
            <td><%= transportStatistics.getTransportListenerFaultsReceiving() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="fault.sending"/></td>
            <td><%= transportStatistics.getTransportListenerFaultsSending() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="last.reset.time"/></td>
            <td><%= transportStatistics.getTransportListenerLastResetTime() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="max.size.received"/></td>
            <td><%= transportStatistics.getTransportListenerMaxSizeReceived() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="max.size.sent"/></td>
            <td><%= transportStatistics.getTransportListenerMaxSizeSent() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="messages.received"/></td>
            <td><%= transportStatistics.getTransportListenerMessagesReceived() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="messages.sent"/></td>
            <td><%= transportStatistics.getTransportListenerMessagesSent() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="metrics.window"/></td>
            <td><%= transportStatistics.getTransportListenerMetricsWindow() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="min.size.received"/></td>
            <td><%= transportStatistics.getTransportListenerMinSizeReceived() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="min.size.sent"/></td>
            <td><%= transportStatistics.getTransportListenerMinSizeSent() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="queue.size"/></td>
            <td><%= transportStatistics.getTransportListenerQueueSize() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="timeouts.receiving"/></td>
            <td><%= transportStatistics.getTransportListenerTimeoutsReceiving()%>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="timeouts.sending"/></td>
            <td><%= transportStatistics.getTransportListenerTimeoutsSending() %>
            </td>
        </tr>
    </table>
</td>
<td width="2%">&nbsp;</td>
<td width="49%">
    <!-- Transport Sender Summary -->
    <table class="styledLeft" width="100%" id="serviceSummaryTable2"
           style="margin-left: 0px;">
        <thead>
        <tr>
            <th colspan="2">
                <%= transportParamType.toUpperCase() %>
                <fmt:message key="transport.sender"/> -
                <%= transportStatistics.getTransportSenderClassName() %>
            </th>
        </tr>
        </thead>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="active.thread.count"/></td>
            <td><%= transportStatistics.getTransportSenderActiveThreadCount() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="avg.size.received"/></td>
            <td><%= transportStatistics.getTransportSenderAvgSizeReceived() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="avg.size.sent"/></td>
            <td><%= transportStatistics.getTransportSenderAvgSizeSent() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="bytes.received"/></td>
            <td><%= transportStatistics.getTransportSenderBytesReceived() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="bytes.sent"/></td>
            <td><%= transportStatistics.getTransportSenderBytesSent() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="faults.receiving"/></td>
            <td><%= transportStatistics.getTransportSenderFaultsReceiving() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="fault.sending"/></td>
            <td><%= transportStatistics.getTransportSenderFaultsSending() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="last.reset.time"/></td>
            <td><%= transportStatistics.getTransportSenderLastResetTime() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="max.size.received"/></td>
            <td><%= transportStatistics.getTransportSenderMaxSizeReceived() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="max.size.sent"/></td>
            <td><%= transportStatistics.getTransportSenderMaxSizeSent() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="messages.received"/></td>
            <td><%= transportStatistics.getTransportSenderMessagesReceived() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="messages.sent"/></td>
            <td><%= transportStatistics.getTransportSenderMessagesSent() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="metrics.window"/></td>
            <td><%= transportStatistics.getTransportSenderMetricsWindow() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="min.size.received"/></td>
            <td><%= transportStatistics.getTransportSenderMinSizeReceived() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="min.size.sent"/></td>
            <td><%= transportStatistics.getTransportSenderMinSizeSent() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="queue.size"/></td>
            <td><%= transportStatistics.getTransportSenderQueueSize() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="timeouts.receiving"/></td>
            <td><%= transportStatistics.getTransportSenderTimeoutsReceiving() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="timeouts.sending"/></td>
            <td><%= transportStatistics.getTransportSenderTimeoutsSending() %>
            </td>
        </tr>
    </table>

</td>
</tr>

<script type="text/javascript">
    graphTrpListenerBytesReceived.
            add(<%= transportStatistics.getTransportListenerBytesReceived() %>);
    graphTrpListenerBytesSent.
            add(<%= transportStatistics.getTransportListenerBytesSent() %>);
    graphTrpSenderBytesReceived.
            add(<%= transportStatistics.getTransportSenderBytesReceived() %>);
    graphTrpSenderBytesSent.
            add(<%= transportStatistics.getTransportSenderBytesSent() %>);
    draw();
</script>

</table>
</fmt:bundle>