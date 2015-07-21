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
<%@ page import="org.wso2.carbon.statistics.transport.stub.types.carbon.ThreadViewStatistics" %>

<%
    //String transportParamType = request.getParameter("transportType");

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

    //TransportStatistics transportStatistics;
    ThreadViewStatistics threadViewStatistics;
    try {
        threadViewStatistics = trpStatClient.getThreadViewStatistics();

        //transportStatistics = trpStatClient.getTransportStatistics(transportParamType);
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
                <%--<%= transportParamType.toUpperCase() %>--%>
                <fmt:message key="client.worker"/> -
            </th>
        </tr>
        </thead>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="avg.blocked.worker.percentage"/></td>
            <td><%= threadViewStatistics.getClientWorkerAvgBlockedWorkerPercentage() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="avg.unblocked.worker.percentage"/></td>
            <td><%= threadViewStatistics.getClientWorkerAvgUnblockedWorkerPercentage() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="dead.locked.workers"/></td>
            <td><%= threadViewStatistics.getClientWorkerDeadLockedWorkers() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="last15.minute.blocked.worker.percentage"/></td>
            <td><%= threadViewStatistics.getClientWorkerLast15MinuteBlockedWorkerPercentage() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="last24.hour.blocked.worker.percentage"/></td>
            <td><%= threadViewStatistics.getClientWorkerLast24HourBlockedWorkerPercentage() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="last5.minute.blocked.worker.percentage"/></td>
            <td><%= threadViewStatistics.getClientWorkerLast5MinuteBlockedWorkerPercentage() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="last8.hour.blocked.worker.percentage"/></td>
            <td><%= threadViewStatistics.getClientWorkerLast8HourBlockedWorkerPercentage() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="last.hour.blocked.worker.percentage"/></td>
            <td><%= threadViewStatistics.getClientWorkerLastHourBlockedWorkerPercentage() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="last.minute.blocked.worker.percentage"/></td>
            <td><%= threadViewStatistics.getClientWorkerLastMinuteBlockedWorkerPercentage() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="last.reset.time"/></td>
            <td><%= threadViewStatistics.getClientWorkerLastResetTime() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="total.worker.count"/></td>
            <td><%= threadViewStatistics.getClientWorkerTotalWorkerCount() %>
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
                <%--<%= transportParamType.toUpperCase() %>--%>
                <fmt:message key="server.worker"/> -
                <%--<%= transportStatistics.getTransportSenderClassName() %>--%>
            </th>
        </tr>
        </thead>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="avg.blocked.worker.percentage"/></td>
            <td><%= threadViewStatistics.getServerWorkerAvgBlockedWorkerPercentage() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="avg.unblocked.worker.percentage"/></td>
            <td><%= threadViewStatistics.getServerWorkerAvgUnblockedWorkerPercentage() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="dead.locked.workers"/></td>
            <td><%= threadViewStatistics.getServerWorkerDeadLockedWorkers() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="last15.minute.blocked.worker.percentage"/></td>
            <td><%= threadViewStatistics.getServerWorkerLast15MinuteBlockedWorkerPercentage() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="last24.hour.blocked.worker.percentage"/></td>
            <td><%= threadViewStatistics.getServerWorkerLast24HourBlockedWorkerPercentage() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="last5.minute.blocked.worker.percentage"/></td>
            <td><%= threadViewStatistics.getServerWorkerLast5MinuteBlockedWorkerPercentage() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="last8.hour.blocked.worker.percentage"/></td>
            <td><%= threadViewStatistics.getServerWorkerLast8HourBlockedWorkerPercentage() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="last.hour.blocked.worker.percentage"/></td>
            <td><%= threadViewStatistics.getServerWorkerLastHourBlockedWorkerPercentage() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="last.minute.blocked.worker.percentage"/></td>
            <td><%= threadViewStatistics.getServerWorkerLastMinuteBlockedWorkerPercentage() %>
            </td>
        </tr>
        <tr class="tableEvenRow">
            <td><fmt:message key="last.reset.time"/></td>
            <td><%= threadViewStatistics.getServerWorkerLastResetTime() %>
            </td>
        </tr>
        <tr class="tableOddRow">
            <td width="30%"><fmt:message key="total.worker.count"/></td>
            <td><%= threadViewStatistics.getServerWorkerTotalWorkerCount() %>
            </td>
        </tr>
    </table>

</td>
</tr>

</table>
</fmt:bundle>