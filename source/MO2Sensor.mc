import Toybox.Ant;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;

class MO2Sensor extends Ant.GenericChannel
{
    var _eventCount = null;
    var is_first_msg = true;
    var deviceNumber = 0;
    var deviceMfg = 0;

    var totalHemoConcentration;
    var currentHemoPercent;
    
    function initialize() {
        deviceNumber = Application.Storage.getValue("SensorId");
        if(deviceNumber == null) {
            deviceNumber = 0;
        }
        var channelAssignment = new Ant.ChannelAssignment(
            Ant.CHANNEL_TYPE_RX_NOT_TX,
            Ant.NETWORK_PLUS);

        GenericChannel.initialize(method(:onMessage), channelAssignment);

        var deviceConfig = new Ant.DeviceConfig({
            :deviceNumber              => deviceNumber,
            :deviceType                => 31,
            :transmissionType          => 0,
            :messagePeriod             => 8192,
            :radioFrequency            => 57,
            :searchTimeoutLowPriority  => 10,  // 2.5 seconds per unit
            :searchTimeoutHighPriority => 0,
            :searchThreshold           => 0
        });

        GenericChannel.setDeviceConfig(deviceConfig);
        GenericChannel.open();
    }

    function reset() {
        _eventCount            = null;
        totalHemoConcentration = null;
        currentHemoPercent     = null;
    }

    function goToSearch() {
        GenericChannel.close();
        GenericChannel.release();
        var channelAssignment = new Ant.ChannelAssignment(
            Ant.CHANNEL_TYPE_RX_NOT_TX,
            Ant.NETWORK_PLUS);

        GenericChannel.initialize(method(:onMessage), channelAssignment);

        var deviceConfig = new Ant.DeviceConfig({
            :deviceNumber              => 0,
            :deviceType                => 31,
            :transmissionType          => 0,
            :messagePeriod             => 8192,
            :radioFrequency            => 57,
            :searchTimeoutLowPriority  => 10,  // 2.5 seconds per unit
            :searchTimeoutHighPriority => 0,
            :searchThreshold           => 0
        });

        GenericChannel.setDeviceConfig(deviceConfig);
        GenericChannel.open();
        is_first_msg = true;
        deviceNumber = 0;
    }

    function onMessage(msg as Message) as Void {
        var payload = msg.getPayload();
        if (Ant.MSG_ID_CHANNEL_RESPONSE_EVENT == msg.messageId) {

            if (Ant.MSG_ID_RF_EVENT == payload[0]) {
                var event = payload[1] & 0xFF;
                
				if (Ant.MSG_CODE_EVENT_CHANNEL_CLOSED == event) {
                    GenericChannel.open();
                    reset();
                }
                else if (Ant.MSG_CODE_EVENT_RX_FAIL_GO_TO_SEARCH == event) {
                    reset();
                }
            }
            else if (Ant.MSG_ID_CLOSE_CHANNEL == payload[0]) {
                GenericChannel.close();
                GenericChannel.release();
                GenericChannel.open();
            }
        }
        else if (Ant.MSG_ID_BROADCAST_DATA == msg.messageId) {
            var dataType = payload[0] & 0xFF;
            if (is_first_msg)
            {
                deviceNumber = GenericChannel.getDeviceConfig().deviceNumber;
                is_first_msg = false;
                Application.Storage.setValue("SensorId", deviceNumber);
            }

            // MUSCLE_OXYGEN_DATA_PAGE
            if (0x01 == dataType) {
                var eventCount = payload[1];
                if(deviceNumber == 0)
                {
                    deviceNumber = GenericChannel.getDeviceConfig().deviceNumber;
                }	
                if (_eventCount == null || _eventCount != eventCount) {
                    _eventCount = eventCount;

                    totalHemoConcentration = ((payload[5] & 0x0F) << 8 | payload[4]);
                    if (totalHemoConcentration == 0xFFE || totalHemoConcentration == 0xFFF) {
                        totalHemoConcentration = null; // invalid
                    }
                    else {
                        totalHemoConcentration /= 100f;
                    }

                    currentHemoPercent = (payload[7] << 2 | payload[6] >> 6);
                    if (currentHemoPercent == 0x3FE || currentHemoPercent == 0x3FF) {
                        currentHemoPercent = null; // invalid
                    }
                    else {
                        currentHemoPercent /= 10f;
                    }

                    var utcTimeRequired = payload[2] & 0x1;
                    if (utcTimeRequired) {
                        // create and populate the data payload
                        //var payload = new [8];
                        payload[0] = 0x10;  // Command data page
                        payload[1] = 0x00;  // Set time command
                        payload[2] = 0xFF;  // Reserved
                        payload[3] = 0;     // Signed 2's complement value indicating local time offset in 15m intervals

                        // set the current time
                        var epoch = Time.now().value() - 631065600;
                        payload[4] = (epoch      ) & 0xFF;
                        payload[5] = (epoch >>  8) & 0xFF;
                        payload[6] = (epoch >> 16) & 0xFF;
                        payload[7] = (epoch >> 24) & 0xFF;

                        // form and send the message
                        var message = new Ant.Message();
                        message.setPayload(payload);

                        GenericChannel.sendAcknowledge(message);
                    }
                }
            }
            else if (0x50 == dataType) {
				if (deviceMfg != payload[4]) {
        			deviceMfg = payload[4];
        		}
            }
        }
    }
}
