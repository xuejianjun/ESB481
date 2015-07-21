/*
 * Copyright 2004,2005 The Apache Software Foundation.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.wso2.carbon.statistics.transport.ui;

import org.apache.axis2.AxisFault;
import org.apache.axis2.client.Options;
import org.apache.axis2.client.ServiceClient;
import org.apache.axis2.context.ConfigurationContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.wso2.carbon.statistics.transport.stub.TransportStatisticsAdminStub;
import org.wso2.carbon.statistics.transport.stub.types.carbon.ThreadViewStatistics;
import org.wso2.carbon.statistics.transport.stub.types.carbon.TransportStatistics;
import org.wso2.carbon.statistics.transport.stub.types.carbon.SystemTransportStatistics;

import java.rmi.RemoteException;
import java.util.Locale;
import java.util.ResourceBundle;

/**
 * Admin Client for the transport-statistics component.
 */
public class TransportStatisticsAdminClient {
    private static final Log log = LogFactory.getLog(TransportStatisticsAdminClient.class);
    private static final String BUNDLE = "org.wso2.carbon.statistics.transport.ui.i18n.Resources";
    private TransportStatisticsAdminStub stub;
    private ResourceBundle bundle;

    public TransportStatisticsAdminClient(String cookie,
                                 String backendServerURL,
                                 ConfigurationContext configCtx,
                                 Locale locale) throws AxisFault {
        String serviceURL = backendServerURL + "TransportStatisticsAdmin";
        bundle = ResourceBundle.getBundle(BUNDLE, locale);

        stub = new TransportStatisticsAdminStub(configCtx, serviceURL);
        ServiceClient client = stub._getServiceClient();
        Options option = client.getOptions();
        option.setManageSession(true);
        option.setProperty(org.apache.axis2.transport.http.HTTPConstants.COOKIE_STRING, cookie);
    }

    public String[] getExposedTransports() throws RemoteException {
        try {
            return stub.getExposedTransports();
        } catch (RemoteException e) {
            handleException(bundle.getString("cannot.get.transport.stats-getExposedTransports"), e);
        }
        return null;
    }

    public SystemTransportStatistics getSystemTransportStatistics() throws RemoteException {
        try {
            return stub.getAllTransportStatistics();
        } catch (RemoteException e) {
           handleException(bundle.
                   getString("cannot.get.transport.stats-getSystemTransportStatistics"), e);
        }
        return null;
    }

    public TransportStatistics getTransportStatistics(String transportName) throws RemoteException {
        try {
            return stub.getTransportStatistic(transportName);
        } catch (RemoteException e) {
            handleException(bundle.
                    getString("cannot.get.transport.stats-getTransportStatistics"), e);
        }
        return null;
    }

    public ThreadViewStatistics getThreadViewStatistics() throws RemoteException {
        try {
            return stub.getThreadViewStatistics();
        } catch (RemoteException e) {
            handleException(bundle.
                    getString("Can not get Thread View Statistics"), e);
        }
        return null;
    }

    public String getTransportClassName(String transportType, String transportName)
            throws RemoteException {
        try {
            return stub.getTransportClassName(transportType, transportName);
        } catch (RemoteException e) {
            handleException(bundle.getString("cannot.get.transport.stats-getTransportClassName"), e);
        }
        return null;
    }

   public int getActiveThreadCount(String transportType, String transportName)
           throws RemoteException {
        try {
            return stub.getActiveThreadCount(transportType, transportName);
        } catch (RemoteException e) {
            handleException(bundle.getString("cannot.get.transport.stats-getActiveThreadCount"), e);
        }
        return 0;
    }

     public double getAvgSizeReceived(String transportType, String transportName)
             throws RemoteException {
        try {
            return stub.getAvgSizeReceived(transportType, transportName);
        } catch (RemoteException e) {
            handleException(bundle.getString("cannot.get.transport.stats-getAvgSizeReceived"), e);
        }
        return 0;
    }

     public double getAvgSizeSent(String transportType, String transportName)
             throws RemoteException {
        try {
            return stub.getAvgSizeSent(transportType, transportName);
        } catch (RemoteException e) {
            handleException(bundle.getString("cannot.get.transport.stats-getAvgSizeSent"), e);
        }
        return 0;
    }

     public long getBytesReceived(String transportType, String transportName)
             throws RemoteException {
        try {
            return stub.getBytesReceived(transportType, transportName);
        } catch (RemoteException e) {
            handleException(bundle.getString("cannot.get.transport.stats-getBytesReceived"), e);
        }
        return 0;
    }

     public long getBytesSent(String transportType, String transportName)
             throws RemoteException {
        try {
            return stub.getBytesSent(transportType, transportName);
        } catch (RemoteException e) {
            handleException(bundle.getString("cannot.get.transport.stats-getBytesSent"), e);
        }
        return 0;
    }

     public long getFaultsReceiving(String transportType, String transportName)
             throws RemoteException {
        try {
            return stub.getFaultsReceiving(transportType, transportName);
        } catch (RemoteException e) {
            handleException(bundle.getString("cannot.get.transport.stats-getFaultsReceiving"), e);
        }
        return 0;
    }

     public long getFaultsSending(String transportType, String transportName)
             throws RemoteException {
        try {
            return stub.getFaultsSending(transportType, transportName);
        } catch (RemoteException e) {
            handleException(bundle.getString("cannot.get.transport.stats-getFaultsSending"), e);
        }
        return 0;
    }

     public long getLastResetTime(String transportType, String transportName)
             throws RemoteException {
        try {
            return stub.getLastResetTime(transportType, transportName);
        } catch (RemoteException e) {
            handleException(bundle.getString("cannot.get.transport.stats-getLastResetTime"), e);
        }
        return 0;
    }

    public long getMaxSizeReceived(String transportType, String transportName)
            throws RemoteException {
        try {
            return stub.getMaxSizeReceived(transportType, transportName);
        } catch (RemoteException e) {
            handleException(bundle.getString("cannot.get.transport.stats-getMaxSizeReceived"), e);
        }
        return 0;
    }

    public long getMaxSizeSent(String transportType, String transportName)
            throws RemoteException {
        try {
            return stub.getMaxSizeSent(transportType, transportName);
        } catch (RemoteException e) {
            handleException(bundle.getString("cannot.get.transport.stats-getMaxSizeSent"), e);
        }
        return 0;
    }

    public long getMessagesReceived(String transportType, String transportName)
            throws RemoteException {
        try {
            return stub.getMessagesReceived(transportType, transportName);
        } catch (RemoteException e) {
            handleException(bundle.getString("cannot.get.transport.stats-getMessagesReceived"), e);
        }
        return 0;
    }

    public long getMessagesSent(String transportType, String transportName)
            throws RemoteException {
        try {
            return stub.getMessagesSent(transportType, transportName);
        } catch (RemoteException e) {
            handleException(bundle.getString("cannot.get.transport.stats-getMessagesSent"), e);
        }
        return 0;
    }

    public long getMetricsWindow(String transportType, String transportName)
            throws RemoteException {
        try {
            return stub.getMetricsWindow(transportType, transportName);
        } catch (RemoteException e) {
            handleException(bundle.getString("cannot.get.transport.stats-getMetricsWindow"), e);
        }
        return 0;
    }

    public long getMinSizeReceived(String transportType, String transportName)
            throws RemoteException {
        try {
            return stub.getMinSizeReceived(transportType, transportName);
        } catch (RemoteException e) {
            handleException(bundle.getString("cannot.get.transport.stats-getMinSizeReceived"), e);
        }
        return 0;
    }

    public long getMinSizeSent(String transportType, String transportName)
            throws RemoteException {
        try {
            return stub.getMinSizeSent(transportType, transportName);
        } catch (RemoteException e) {
            handleException(bundle.getString("cannot.get.transport.stats-getMinSizeSent"), e);
        }
        return 0;
    }

    public int getQueueSize(String transportType, String transportName)
            throws RemoteException {
        try {
            return stub.getQueueSize(transportType, transportName);
        } catch (RemoteException e) {
            handleException(bundle.getString("cannot.get.transport.stats-getQueueSize"), e);
        }
        return 0;
    }

    public long getTimeoutsReceiving(String transportType, String transportName)
            throws RemoteException {
        try {
            return stub.getTimeoutsReceiving(transportType, transportName);
        } catch (RemoteException e) {
            handleException(bundle.getString("cannot.get.transport.stats-getTimeoutsReceiving"), e);
        }
        return 0;
    }

    public long getTimeoutsSending(String transportType, String transportName)
            throws RemoteException {
        try {
            return stub.getTimeoutsSending(transportType, transportName);
        } catch (RemoteException e) {
            handleException(bundle.getString("cannot.get.transport.stats-getTimeoutsSending"), e);
        }
        return 0;
    }

     private void handleException(String msg, Exception e) throws RemoteException {
        log.error(msg, e);
        throw new RemoteException(msg, e);
    }

}
