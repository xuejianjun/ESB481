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
<%@ page import="org.wso2.carbon.ui.CarbonUIMessage" %>
<%@ page import="org.wso2.carbon.statistics.transport.ui.TransportStatisticsAdminClient" %>
<%@ page import="org.wso2.carbon.statistics.transport.stub.types.carbon.SystemTransportStatistics" %>
<%
    response.setHeader("Cache-Control", "no-cache");

    String backendServerURL = CarbonUIUtil.getServerURL(config.getServletContext(), session);
    ConfigurationContext configContext =
            (ConfigurationContext) config.getServletContext().getAttribute(CarbonConstants.
                    CONFIGURATION_CONTEXT);

    String cookie = (String) session.getAttribute(ServerConstants.ADMIN_SERVICE_COOKIE);
    TransportStatisticsAdminClient trpStatClient = new TransportStatisticsAdminClient(cookie,
            backendServerURL, configContext, request.getLocale());

    int trpListenerGraphWidth = 500;
    int trpSenderGraphWidth = 500;

    SystemTransportStatistics sysTransportStatistics;
    try {
        sysTransportStatistics = trpStatClient.getSystemTransportStatistics();
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
    <table class="noBorders" width="100%" style="border: medium none">
        <tr>
            <td width="49%">
                <table class="noBorders" width="100%">
                    <thead>
                    <tr>
                        <th><fmt:message key="bytes.vs.time.units"/></th>
                    </tr>
                    </thead>
                    <tr>
                        <td <%--style="border:none !important"--%>>
                            <div id="trpListenerAllGraph"
                                 style="width:<%= trpListenerGraphWidth %>px;height:300px;"/>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="2%">&nbsp;</td>
            <td width="49%">
                <table class="noBorders" width="100%">
                    <thead>
                    <tr>
                        <th><fmt:message key="bytes.vs.time.units"/></th>
                    </tr>
                    </thead>
                    <tr>
                        <td>
                            <div id="trpSenderAllGraph" 
                                 style="width:<%= trpSenderGraphWidth %>px;height:300px;"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

        <script type="text/javascript">
            allGraphTrpListenerBytesReceived.
                    add(<%= sysTransportStatistics.getTransportListenerBytesReceived() %>);
            allGraphTrpListenerBytesSent.
                    add(<%= sysTransportStatistics.getTransportListenerBytesSent() %>);
            allGraphTrpSenderBytesReceived.
                    add(<%= sysTransportStatistics.getTransportSenderBytesReceived() %>);
            allGraphTrpSenderBytesSent.
                    add(<%= sysTransportStatistics.getTransportSenderBytesSent() %>);
            drawAll();
        </script>

    </table>
</fmt:bundle>