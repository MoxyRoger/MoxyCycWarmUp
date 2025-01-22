import Toybox.Ant;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;

class FECTrainer extends Ant.GenericChannel
{
    var is_first_msg = true;
    var deviceNumber = 0;
    var deviceMfg = 0;
    
    var instPower = 0;
    var instSpeed = 0.0;
    var ackSequence = SEND_INIT;        // controlled by MainApp and Internally

    function initialize() {
        deviceNumber = Application.Storage.getValue("FECId");
        if(deviceNumber == null) {
            deviceNumber = 0;
        }
        var channelAssignment = new Ant.ChannelAssignment(
            Ant.CHANNEL_TYPE_RX_NOT_TX,
            Ant.NETWORK_PLUS);

        GenericChannel.initialize(method(:onMessage), channelAssignment);

        var deviceConfig = new Ant.DeviceConfig({
            :deviceNumber              => deviceNumber,
            :deviceType                => 17,
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
        is_first_msg = true;
        instPower = 0;
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
            :deviceType                => 17,
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
                    deviceNumber = GenericChannel.getDeviceConfig().deviceNumber;
                    reset();
                }
                else if (Ant.MSG_CODE_EVENT_RX_FAIL_GO_TO_SEARCH == event) {
                    reset();
                }
                else if (Ant.MSG_CODE_EVENT_TRANSFER_TX_COMPLETED == event){  // Confirms that the Acknowledge was received
                  switch(ackSequence) {
                    case SEND_USER:
                        ackSequence = CONF_USER;
                        break;
                    case SEND_TARGPWR:
                        ackSequence = CONF_TARGPWR;
                        break;
                    case SEND_WINDRESIST:
                        ackSequence = CONF_WINDRESIST;
                        break;
                    case SEND_TRACKRESIST:
                        ackSequence = CONF_TRACKRESIST;
                        break;
                  }
              }
            }
            else if (Ant.MSG_ID_CLOSE_CHANNEL == payload[0]) {
                GenericChannel.close();
                GenericChannel.open();
            }
        }
        else if (Ant.MSG_ID_BROADCAST_DATA == msg.messageId) {
            var dataType = payload[0] & 0xFF;
            var ackload = new [8];
            var message = new Ant.Message();
            if (is_first_msg)
            {
                deviceNumber = GenericChannel.getDeviceConfig().deviceNumber;
                is_first_msg = false;
                Application.Storage.setValue("FECId", deviceNumber);
                ackSequence = SEND_TARGPWR;
            }

            if(deviceNumber == 0)
            {
                deviceNumber = GenericChannel.getDeviceConfig().deviceNumber;
            }

            switch(dataType) {
                case 0x10:                                                      // General FE Data Page
                    instSpeed = (payload[4] + payload[5]*256) * 3.6 / 1000;     // kph
                    break;
                case 0x19:                                                      // Specific Trainer Data Page
                    instPower = payload[5] + (payload[6] & 0x0F) * 256;         // watts
                    break;
                case 0x50:                                                      // Mfg ID Common Data Page
				    if (deviceMfg != payload[4]) {
        			    deviceMfg = payload[4];
                    }
                    break;
            }
            
            switch(ackSequence){
                case SEND_USER:
                    //var weight = Application.Storage.getValue("Weight-kg");
                    ackload[0] = 0x37;                           // User Configuration data page  [37][DC][05][FF][80][0C][46][00]
                    ackload[1] = 0x00; //((100 * weight) % 256) & 0xFF;  // Weight LSB
                    ackload[2] = 0x00; //((100 * weight) / 256) & 0xFF;  // Weight MSB
                    ackload[3] = 0xFF;                           // Reserved
                    ackload[4] = 0x80;                           // Wheel offset bits 0-3 , Bike Weight LSN bits 4-7
                    ackload[5] = 0x0C;                           // Bike Weight MSB - 10 Kg / .05 = 200 = 0xC8
                    ackload[6] = 0x46;                           // Wheel Diameter
                    ackload[7] = 0x00;                           // Gear Ratio
                    message.setPayload(ackload);
                    GenericChannel.sendAcknowledge(message);
                    break;
                case SEND_TARGPWR:
                    var targPower = Application.getApp().targetPower.toLong();
                    ackload[0] = 0x31;                   // Target Power data page
                    ackload[1] = 0xFF;                   // Reserved
                    ackload[2] = 0xFF;                   // Reserved
                    ackload[3] = 0xFF;                   // Reserved
                    ackload[4] = 0xFF;                   // Reserved
                    ackload[5] = 0xFF;                   // Reserved
                    ackload[6] = (targPower * 4) % 256;  // 0.25 Watts LSB
                    ackload[7] = (targPower * 4) / 256;  // 0.25 Watts MSB
                    message.setPayload(ackload);
                    GenericChannel.sendAcknowledge(message);
                    break;
                case SEND_WINDRESIST:
                    ackload[0] = 0x32;  // Wind Resistance  [32][FF][FF][FF][FF][33][7F][64]
                    ackload[1] = 0xFF;  // Reserved
                    ackload[2] = 0xFF;  // Reserved
                    ackload[3] = 0xFF;  // Reserved
                    ackload[4] = 0xFF;  // Reserved
                    ackload[5] = 0x33;  // Use Default Value
                    if(Application.getApp().targetPower == 1){
                        ackload[6] = 0x70;  // Tail Wind for gear selection
                    }
                    else{
                        ackload[6] = 0x7F;  // Use Default Value
                    }
                    ackload[7] = 0x64;  // Use Default Value
                    message.setPayload(ackload);
                    GenericChannel.sendAcknowledge(message);
                    break;
                case SEND_TRACKRESIST:
                    ackload[0] = 0x33;  // Track Resistance [33][FF][FF][FF][FF][1A][4F][50]
                    ackload[1] = 0xFF;  // Reserved
                    ackload[2] = 0xFF;  // Reserved
                    ackload[3] = 0xFF;  // Reserved
                    ackload[4] = 0xFF;  // Reserved
                    if(Application.getApp().targetPower == 1){
                        ackload[5] = 0x66;  // 0.70% Slope LSB for gear selection
                        ackload[6] = 0x4E;  // 0.70% Slope MSB for gear selection
                    }
                    else{
                        ackload[5] = 0x1A;  // 2.5% Slope LSB
                        ackload[6] = 0x4F;  // 2.5% Slope MSB
                    }
                    ackload[7] = 0x50;  // Use Default Value of .004 / 5e-5
                    message.setPayload(ackload);
                    GenericChannel.sendAcknowledge(message);
                    break;
            }
        }
    }
}
