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
<%@ page import="org.wso2.carbon.statistics.transport.ui.Utils" %>

<fmt:bundle basename="org.wso2.carbon.statistics.transport.ui.i18n.Resources">
<carbon:breadcrumb
		label="system.statistics"
		resourceBundle="org.wso2.carbon.statistics.transport.ui.i18n.Resources"
		topPage="true"
		request="<%=request%>" />

    <script type="text/javascript" src="js/statistics.js"></script>
    <script type="text/javascript" src="js/graphs.js"></script>

    <script type="text/javascript" src="../admin/js/jquery.flot.js"></script>
    <script type="text/javascript" src="../admin/js/excanvas.js"></script>
    <script type="text/javascript" src="../admin/js/main.js"></script>
    <%--<script type="text/javascript" src="../ajax/js/prototype.js"></script>--%>

    <%
        String transportParamType = request.getParameter("transportType");

        int statRefreshInterval = 6000;
        statRefreshInterval = Utils.getPositiveIntegerValue(session, request,
                statRefreshInterval, "statRefreshInterval");

        int trpListenerGraphWidth = 500;
        trpListenerGraphWidth = Utils.getPositiveIntegerValue(session, request,
                trpListenerGraphWidth, "trpListenerGraphWidth");

        int trpListenerGraphXScale = 25;
        trpListenerGraphXScale = Utils.getPositiveIntegerValue(session, request,
                trpListenerGraphXScale, "trpListenerGraphXScale");

        int trpSenderGraphWidth = 500;
        trpSenderGraphWidth = Utils.getPositiveIntegerValue(session, request,
                trpSenderGraphWidth, "trpSenderGraphWidth");

        int trpSenderGraphXScale = 25;
        trpSenderGraphXScale = Utils.getPositiveIntegerValue(session, request,
                trpSenderGraphXScale, "trpSenderGraphXScale");
    %>

    <script id="source" type="text/javascript">
        jQuery.noConflict();
        var trpListenerGraphWidth = <%= trpListenerGraphWidth %>;
        var trpListenerGraphXScale = <%= trpListenerGraphXScale %>;

        initStats(trpListenerGraphXScale, trpListenerGraphXScale);

        function drawTransportListenerGraph() {
            jQuery.plot(jQuery("#trpListenerGraph"), [
                {
                    label: "<fmt:message key="transport.listener.bytes.received"/>",
                    data: graphTrpListenerBytesReceived.get(),
                    lines: { show: true, fill: true }
                },
                {
                    label: "<fmt:message key="transport.listener.bytes.sent"/>",
                    data: graphTrpListenerBytesSent.get(),
                    lines: { show: true, fill: true }
                }
            ],  {
                    xaxis: {
                        ticks: graphTrpListenerBytesReceived.tick(),
                        min: 0
                    },
                    yaxis: {
                        ticks: 10,
                        min: 0
                    }
            });
        }

        function drawTransportSenderGraph() {
            jQuery.plot(jQuery("#trpSenderGraph"), [
                {
                    label: "<fmt:message key="transport.sender.bytes.received"/>",
                    data: graphTrpSenderBytesReceived.get(),
                    lines: { show: true, fill: true }
                },
                {
                    label: "<fmt:message key="transport.sender.bytes.sent"/>",
                    data: graphTrpSenderBytesSent.get(),
                    lines: { show: true, fill: true }
                }
            ],  {
                    xaxis: {
                        ticks: graphTrpSenderBytesReceived.tick(),
                        min: 0
                    },
                    yaxis: {
                        ticks: 10,
                        min: 0
                    }
            });
        }

        function draw(){
            drawTransportListenerGraph();
            drawTransportSenderGraph();
        }
    </script>

    <div id="middle">
        <h2> <%= transportParamType.toUpperCase() %> <fmt:message key="transport.statistics"/></h2>

        <div id="workArea">
            <div id="result"></div>
            <script type="text/javascript">
                jQuery.noConflict()
                var refresh;
                function refreshStats() {
                    sessionAwareFunction(function (){
                        var url = "transport_stats_ajaxprocessor.jsp?transportType=<%= transportParamType %>";
                        jQuery("#result").load(url, null , function (responseText, status, XMLHttpRequest) {
                                    if ( status != "success"){
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

            <form action="transport_view.jsp?transportType=<%= transportParamType %>" method="post">
                <table width="100%" class="styledLeft" style="margin-left: 0px;">
                    <thead>
                    <tr>
                        <th colspan="4"><fmt:message key="transport.statistics.configuration"/></th>
                    </tr>
                    </thead>
                    <tr>
                        <td width="20%"><fmt:message key="statistics.refresh.interval"/></td>
                        <td colspan="3">
                            <input type="text" value="<%= statRefreshInterval %>"
                                   name="statRefreshInterval"
                                   size="5" maxlength="5"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">&nbsp;</td>
                    </tr>

                    <tr>
                        <td colspan="2" width="50%">
                            <strong><fmt:message key="transport.listener.graph"/></strong>
                        </td>
                        <td colspan="2" width="50%">
                            <strong><fmt:message key="transport.sender.graph"/></strong>
                        </td>
                    </tr>
                    <tr>
                        <td width="20%">
                            <fmt:message key="x.scale"/>
                        </td>
                        <td width="30%">
                            <input type="text" size="5" value="<%= trpListenerGraphXScale %>"
                                   name="trpListenerGraphXScale"
                                   maxlength="4"/>
                        </td>
                         <td width="20%">
                            <fmt:message key="x.scale"/>
                        </td>
                        <td width="30%">
                            <input type="text" size="5" value="<%= trpSenderGraphXScale %>"
                                   name="trpSenderGraphXScale"
                                   maxlength="4"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="20%">
                            <fmt:message key="x.width"/>
                        </td>
                        <td width="30%">
                            <input type="text" size="5" value="<%= trpListenerGraphWidth %>"
                                   name="trpListenerGraphWidth"
                                   maxlength="4"/>
                        </td>
                         <td width="20%">
                            <fmt:message key="x.width"/>
                        </td>
                        <td width="30%">
                            <input type="text" size="5" value="<%= trpSenderGraphWidth%>"
                                   name="trpSenderGraphWidth"
                                   maxlength="4"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" class="buttonRow">
                            <input type="submit" class="button" value="<fmt:message key="update"/>" id="updateStats"/>&nbsp;&nbsp;
                            <%--<input type="reset" class="button" value="<fmt:message key="reset"/>"/>--%>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</fmt:bundle>
