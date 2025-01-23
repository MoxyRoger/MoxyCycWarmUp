import Toybox.AntPlus;
import Toybox.System;

class MyFitnessEquipmentListener extends AntPlus.FitnessEquipmentListener {
    var fecSpeed;
    function initialize() {
        FitnessEquipmentListener.initialize();
    }

    function onFitnessEquipmentUpdate(data as AntPlus.FitnessEquipmentData) as Void {
        fecSpeed = data.feSpeed;
    }
}
