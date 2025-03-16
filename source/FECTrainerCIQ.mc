import Toybox.Ant;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;

class FECTrainer extends Ant.GenericChannel
{
    var deviceNumber = 0;
    var deviceMfg = 0;
    var instPower = 0;
    var fecSpeed;
    hidden var is_first_msg = true;
    hidden var targPower = 0;
    hidden var basicResist = 50;
    hidden var slope = 0;
    hidden var surface = .004;   // Default value
    hidden var windCoeff = 0.51; // Default value
    hidden var windSpeed = 0;    // Default value
    hidden var draftFact = 1.0;  // Default value
    hidden var userWt = 75;      // Default value
    hidden var bikeWt = 10;      // Default value
    hidden var sendTargPwr = false;
    hidden var sendBasRst  = false;
    hidden var sendTrack   = false;
    hidden var sendWind    = false;
    hidden var sendUser    = false;
    hidden var unConfirmed = 0;

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

    function controlEquipment(mode, value){
        switch(mode) {
            case AntPlus.TRAINER_TARGET_POWER:
                targPower = value.toNumber(); //Target power setting of the fitness equipment. 0 - 4000W input range, unit 0.25W.
                sendTargPwr = true;
                break;
            case AntPlus.TRAINER_RESISTANCE:
                basicResist = value.toNumber(); //Basic resistance value of the fitness equipment. Percent of max resistance 0 - 100 input range, unit 0.5%.
                sendBasRst = true;
                break;
            case AntPlus.TRAINER_USER_WEIGHT:
                userWt = value.toFloat();
                sendUser = true;
                break;
            case AntPlus.TRAINER_BIKE_WEIGHT:
                bikeWt = value.toFloat();
                sendUser = true;
                break;
            case AntPlus.TRAINER_WIND_COEFF:
                windCoeff = value.toFloat();
                sendWind = true;
                break;
            case AntPlus.TRAINER_WIND_SPEED:
                windSpeed = value.toFloat();
                sendWind = true;
                break;
            case AntPlus.TRAINER_WIND_DRAFT_FACTOR:
                draftFact = value.toFloat();
                sendWind = true;
                break;
            case AntPlus.TRAINER_SLOPE:
                slope = value.toFloat();
                sendTrack = true;
                break;
            case AntPlus.TRAINER_SURFACE:
                surface = value.toFloat();
                sendTrack = true;
                break;            
        }        
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
                  switch (unConfirmed){
                    case 0:
                        break;
                    case 1:
                        sendTargPwr = false;
                        unConfirmed = 0;
                        break;
                    case 2:
                        sendBasRst = false;
                        unConfirmed = 0;
                        break;
                    case 3:
                        sendUser = false;
                        unConfirmed = 0;
                        System.println("User confirmed " + payload[4] + ", " + payload[5] + ", " + payload[6] + ", " + payload[7]);
                        break;
                    case 4:
                        sendWind = false;
                        unConfirmed = 0;
                        System.println("Wind confirmed" + payload[4] + ", " + payload[5] + ", " + payload[6] + ", " + payload[7]);
                        break;
                    case 5:
                        sendTrack = false;
                        unConfirmed = 0;
                        System.println("Track confirmed" + payload[4] + ", " + payload[5] + ", " + payload[6] + ", " + payload[7]);
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
                sendTargPwr = true;
            }

            if(deviceNumber == 0)
            {
                deviceNumber = GenericChannel.getDeviceConfig().deviceNumber;
            }

            switch(dataType) {
                case 0x10:                                                      // General FE Data Page
                    fecSpeed = (payload[4] + payload[5]*256) * 3.6 / 1000;     // kph
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

            if (sendTargPwr && (unConfirmed == 0 || unConfirmed == 1)) {
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
                unConfirmed = 1;
            }
            else if (sendBasRst && (unConfirmed == 0 || unConfirmed == 2)) {
                ackload[0] = 0x30;                   // Basic Resistance data page
                ackload[1] = 0xFF;                   // Reserved
                ackload[2] = 0xFF;                   // Reserved
                ackload[3] = 0xFF;                   // Reserved
                ackload[4] = 0xFF;                   // Reserved
                ackload[5] = 0xFF;                   // Reserved
                ackload[6] = 0xFF;                   // Reserved
                ackload[7] = basicResist * 2;        // 0% to 100% in 0.5% units
                message.setPayload(ackload);
                GenericChannel.sendAcknowledge(message);
                unConfirmed = 2;
            }
            else if (sendUser && (unConfirmed == 0 || unConfirmed == 3)) {
                ackload[0] = 0x37;                                     // User Configuration data page  [37][DC][05][FF][80][0C][46][00]
                ackload[1] = (100 * userWt).toNumber() & 0xFF;         // User Weight LSB - .01 kg units
                ackload[2] = ((100 * userWt).toNumber() / 256) & 0xFF; // Weight MSB - .01 kg units
                ackload[3] = 0xFF;                                     // Reserved
                ackload[4] = ((bikeWt * 20).toNumber() & 0x0F) * 16;   // Wheel offset bits 0-3 , Bike Weight LSN bits 4-7 (not programmed)
                ackload[5] = ((bikeWt * 20).toNumber() / 16) & 0xFF;   // Bike Weight- .05 kg units (not programmed)
                ackload[6] = 0x46;//;                                  // Wheel Diameter (not programmed)
                ackload[7] = 0x00;                                     // Gear Ratio (not programmed)
                message.setPayload(ackload);
                GenericChannel.sendAcknowledge(message);
                unConfirmed = 3;
            }
            else if (sendWind && (unConfirmed == 0 || unConfirmed == 4)) {
                ackload[0] = 0x32;  // Wind Resistance  [32][FF][FF][FF][FF][33][7F][64]
                ackload[1] = 0xFF;  // Reserved
                ackload[2] = 0xFF;  // Reserved
                ackload[3] = 0xFF;  // Reserved
                ackload[4] = 0xFF;  // Reserved
                ackload[5] = (windCoeff * 100).toNumber() & 0xFF;   // Wind Resistance Coefficient
                ackload[6] = (windSpeed + 127).toNumber() & 0xFF;   // Wind Speed
                ackload[7] = (draftFact * 100).toNumber() & 0xFF;   // Drafting Factor
                message.setPayload(ackload);
                GenericChannel.sendAcknowledge(message);
                unConfirmed = 4;
            }
            else if (sendTrack && (unConfirmed == 0 || unConfirmed == 5)) {
                ackload[0] = 0x33;  // Track Resistance data page[33][FF][FF][FF][FF][1A][4F][50]
                ackload[1] = 0xFF;  // Reserved
                ackload[2] = 0xFF;  // Reserved
                ackload[3] = 0xFF;  // Reserved
                ackload[4] = 0xFF;  // Reserved
                ackload[5] = ((slope + 200) * 100).toNumber() & 0xFF;         // Slope LSB
                ackload[6] = (((slope + 200) * 100).toNumber() / 256) & 0xFF; // Slope MSB
                ackload[7] = (20000 * surface).toNumber();                    // Coefficient of Rolling Resistance
                message.setPayload(ackload);
                GenericChannel.sendAcknowledge(message);
                unConfirmed = 5;
            }
        }
    }
}