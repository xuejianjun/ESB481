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
<%@ page import="org.wso2.carbon.ui.CarbonUIUtil" %>
<%@ page import="org.apache.axis2.context.ConfigurationContext" %>
<%@ page import="org.wso2.carbon.CarbonConstants" %>
<%@ page import="org.wso2.carbon.utils.ServerConstants" %>
<%@ page import="org.wso2.carbon.statistics.transport.ui.*" %>

<fmt:bundle basename="org.wso2.carbon.statistics.transport.ui.i18n.Resources">
    <carbon:breadcrumb
            label="transport.statistics"
            resourceBundle="org.wso2.carbon.statistics.transport.ui.i18n.Resources"
            topPage="true"
            request="<%=request%>"/>

    <script type="text/javascript" src="js/transpost_tatistics.js"></script>
    <script type="text/javascript" src="js/graphs.js"></script>

    <script type="text/javascript" src="../admin/js/jquery.flot.js"></script>
    <script type="text/javascript" src="../admin/js/excanvas.js"></script>
    <script type="text/javascript" src="../admin/js/main.js"></script>
    <%--<script type="text/javascript" src="../ajax/js/prototype.js"></script>--%>

    <%
        String backendServerURL = CarbonUIUtil.getServerURL(config.getServletContext(), session);
        ConfigurationContext configContext = (ConfigurationContext) config.getServletContext().
                getAttribute(CarbonConstants.CONFIGURATION_CONTEXT);
        String cookie = (String) session.getAttribute(ServerConstants.ADMIN_SERVICE_COOKIE);
        TransportStatisticsAdminClient trpStatClient = new TransportStatisticsAdminClient(cookie,
                backendServerURL, configContext, request.getLocale());
        int statRefreshInterval = 6000;
        int trpListenerGraphWidth = 500;
        int trpListenerGraphXScale = 25;
        String[] transportArray = trpStatClient.getExposedTransports();
    %>

    <script id="source" type="text/javascript">
        jQuery.noConflict();
        var trpListenerGraphWidth = <%= trpListenerGraphWidth %>;
        var trpListenerGraphXScale = <%= trpListenerGraphXScale %>;

        initAllStats(trpListenerGraphXScale, trpListenerGraphXScale);

        function drawAllTransportListenerGraph() {
            jQuery.plot(jQuery("#trpListenerAllGraph"), [
                {
                    label: "<fmt:message key="transport.listener.bytes.received"/>",
                    data: allGraphTrpListenerBytesReceived.get(),
                    lines: { show: true, fill: true }
                },
                {
                    label: "<fmt:message key="transport.listener.bytes.sent"/>",
                    data: allGraphTrpListenerBytesSent.get(),
                    lines: { show: true, fill: true }
                }
            ], {
                xaxis: {
                    ticks: allGraphTrpListenerBytesReceived.tick(),
                    min: 0
                },
                yaxis: {
                    ticks: 10,
                    min: 0
                }
            });
        }

        function drawAllTransportSenderGraph() {
            jQuery.plot(jQuery("#trpSenderAllGraph"), [
                {
                    label: "<fmt:message key="transport.sender.bytes.received"/>",
                    data: allGraphTrpSenderBytesReceived.get(),
                    lines: { show: true, fill: true }
                },
                {
                    label: "<fmt:message key="transport.sender.bytes.sent"/>",
                    data: allGraphTrpSenderBytesSent.get(),
                    lines: { show: true, fill: true }
                }
            ], {
                xaxis: {
                    ticks: allGraphTrpSenderBytesReceived.tick(),
                    min: 0
                },
                yaxis: {
                    ticks: 10,
                    min: 0
                }
            });
        }

        function drawAll() {
            drawAllTransportListenerGraph();
            drawAllTransportSenderGraph();
        }
    </script>

    <div id="middle">
        <h2><fmt:message key="transport.statistics"/></h2>

        <div id="workArea">

            <p>&nbsp;</p>

            <table class="styledLeft" width="100%" id="serviceSummaryTable"
                   style="margin-left: 0px;">
                <thead>
                <tr>
                    <th colspan="1"><fmt:message key="service.summary"/></th>
                </tr>
                </thead>

                <tr>
                    <td>
                        <%--<div>--%>

                            <div id="result"></div>
                            <script type="text/javascript">
                                //debugger;
                                jQuery.noConflict()
                                var refresh;
                                function refreshStats() {
                                    sessionAwareFunction(function () {
                                        var url = "transport_main_ajaxprocessor.jsp";
                                        jQuery("#result").load(url, null, function (responseText, status, XMLHttpRequest) {
                                            if (status != "success") {
                                                stopRefreshStats();
                                                document.getElementById('result').innerHTML = responseText;
                                            }
                                        });
                                    }/*, org_wso2_carbon_statistics_transport_ui_jsi18n["session.timed.out"]*/);
                                }
                                function stopRefreshStats() {
                                    if (refresh) {
                                        clearInterval(refresh);
                                    }
                                }
                                jQuery(document).ready(function() {
                                    refreshStats();
                                    refresh = setInterval("refreshStats()", <%= statRefreshInterval %>);
                                });

                            </script>

                            <p>&nbsp;</p>

                        <%--</div>--%>
                    </td>
                </tr>
                <%
                    for (String aTransportArray : transportArray) {
                %>
                <tr>
                    <td>
                        <a href="transport_view.jsp?transportType=<%= aTransportArray %>">
                            <%= aTransportArray.toUpperCase() %> Transport
                        </a>
                    </td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>

    </div>
</fmt:bundle>
