abstract class Connectable {
  bool connect();
}

mixin Schedulable {
  String scheduledTime = "";

  void setSchedule(String time) {
    scheduledTime = time;
  }
}

abstract class SmartDevice implements Connectable {
  static int totalDeviceCount = 0;

  String name;
  bool isOn;

  SmartDevice(this.name, {this.isOn = false}) {
    totalDeviceCount++;
  }

  SmartDevice.named({required this.name, this.isOn = false}) {
    totalDeviceCount++;
  }

  String getStatus();
  void performAction();

  @override
  bool connect() {
    return true;
  }
}

class SmartLight extends SmartDevice with Schedulable {
  int brightness;

  SmartLight(String name, {bool isOn = false, this.brightness = 100})
      : super(name, isOn: isOn);

  @override
  String getStatus() {
    return isOn ? "ON" : "OFF";
  }

  @override
  void performAction() {
    isOn = !isOn;
  }
}

class Thermostat extends SmartDevice {
  int temperature;

  Thermostat(String name, {this.temperature = 22}) : super(name, isOn: true);

  @override
  String getStatus() {
    if (!isOn) return "Off";
    return temperature < 20 ? "Cooling" : "Heating";
  }

  @override
  void performAction() {
    isOn = !isOn;
  }
}

class SmartSpeaker extends SmartDevice {
  int volume;

  SmartSpeaker.named({required String name, this.volume = 50, bool isOn = false})
      : super.named(name: name, isOn: isOn);

  @override
  String getStatus() {
    return isOn ? "Playing" : "Paused";
  }

  @override
  void performAction() {
    isOn = !isOn;
  }
}