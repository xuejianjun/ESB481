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

    <%
        String backendServerURL = CarbonUIUtil.getServerURL(config.getServletContext(), session);
        ConfigurationContext configContext = (ConfigurationContext) config.getServletContext().
                getAttribute(CarbonConstants.CONFIGURATION_CONTEXT);

        String cookie = (String) session.getAttribute(ServerConstants.ADMIN_SERVICE_COOKIE);

        TransportStatisticsAdminClient trpStatClient = new TransportStatisticsAdminClient(cookie,
                backendServerURL, configContext, request.getLocale());

        String[] transportArray = trpStatClient.getExposedTransports();
    %>

    <div id="middle">
        <h2><fmt:message key="transport.statistics"/></h2>

        <div id="workArea">
            <div id="result"></div>
            <p>&nbsp;</p>

            <table class="styledLeft" width="100%" id="serviceSummaryTable"
                   style="margin-left: 0px;">
                <thead>
                <tr>
                    <th colspan="2"><fmt:message key="service.summary"/></th>
                </tr>
                </thead>
                <%
                    for (String aTransportArray : transportArray) {
                %>
                <tr>
                    <td>
                        <%--<a href="transport_info.jsp?transportType=<%=aTransportArray %>">--%>
                        <a href="transport_view.jsp?transportType=<%= aTransportArray %>">
                            <%= aTransportArray.toUpperCase() %> Transport
                        </a>
                    </td>
                </tr>
                <%
                    }
                %>
                <tr>
                    <td>
                         <%--<a href="transport_view.jsp?transportType=http"> Transport View - Graph enabled--%>
                        <a href="index_ver1.jsp"> Index_ver1.jsp
                        </a>
                    </td>
                </tr>                
            </table>
        </div>

    </div>
</fmt:bundle>
