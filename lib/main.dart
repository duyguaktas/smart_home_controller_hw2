import 'package:flutter/material.dart';
import 'models/smart_device.dart';

void main() {
  runApp(const SmartHomeApp());
}

class SmartHomeApp extends StatelessWidget {
  const SmartHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Home Controller',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        scaffoldBackgroundColor: Colors.grey[50],
        cardTheme: CardThemeData(
          elevation: 2.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        ),
      ),
      home: const ControllerScreen(),
    );
  }
}

class ControllerScreen extends StatefulWidget {
  const ControllerScreen({super.key});

  @override
  State<ControllerScreen> createState() => _ControllerScreenState();
}

class _ControllerScreenState extends State<ControllerScreen> {

  final List<SmartDevice> myDevices = [
    SmartLight('Kitchen Light', isOn: false, brightness: 40),
    Thermostat('Living Room A/C ', temperature: 14),
    SmartSpeaker.named(name: 'Speaker', volume: 65, isOn: true),
    SmartLight('Garage Security', isOn: true, brightness: 100),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Smart Home Hub', style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: myDevices.length,
              itemBuilder: (context, index) {
                final device = myDevices[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        _buildDeviceIcon(device),
                        const SizedBox(width: 16),
                        Expanded(child: _buildDeviceDetails(device)),
                        _buildDeviceControls(device),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                )
              ],
            ),
            child: Text(
              'Total Connected Devices: ${SmartDevice.totalDeviceCount}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDeviceIcon(SmartDevice device) {
    IconData iconData = Icons.device_unknown;
    Color color = Colors.grey;

    if (device is SmartLight) {
      iconData = Icons.lightbulb_outline;
      color = device.isOn ? Colors.amber : Colors.grey;
    } else if (device is Thermostat) {
      iconData = Icons.thermostat_auto;
      color = Colors.deepOrange;
    } else if (device is SmartSpeaker) {
      iconData = Icons.speaker_group;
      color = Colors.teal;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(iconData, color: color, size: 30),
    );
  }

  Widget _buildDeviceDetails(SmartDevice device) {
    String subtitle = '';
    if (device is SmartLight) {
      subtitle = 'Intensity: ${device.brightness}%';
    } else if (device is Thermostat) {
      subtitle = 'Set to: ${device.temperature}°C';
    } else if (device is SmartSpeaker) {
      subtitle = 'Volume: ${device.volume}%';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          device.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(color: Colors.grey[700], fontSize: 14),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: device.isOn ? Colors.green : Colors.redAccent,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              'Status: ${device.getStatus()}',
              style: TextStyle(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildDeviceControls(SmartDevice device) {
    if (device is SmartLight) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Switch(
            value: device.isOn,
            activeColor: Colors.amber,
            onChanged: (val) {
              setState(() {
                device.performAction();
              });
            },
          ),
          SizedBox(
            width: 100,
            height: 20,
            child: Slider(
              value: device.brightness.toDouble(),
              min: 0,
              max: 100,
              activeColor: Colors.amber,
              onChanged: device.isOn ? (val) {
                setState(() {
                  device.brightness = val.toInt();
                });
              } : null,
            ),
          ),
        ],
      );
    } else if (device is Thermostat) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove_circle_outline, color: Colors.deepOrange),
            onPressed: () {
              setState(() {
                device.temperature--;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.deepOrange),
            onPressed: () {
              setState(() {
                device.temperature++;
              });
            },
          ),
        ],
      );
    } else if (device is SmartSpeaker) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              device.isOn ? Icons.pause_circle_filled : Icons.play_circle_fill,
              color: Colors.teal,
              size: 32,
            ),
            onPressed: () {
              setState(() {
                device.performAction();
              });
            },
          ),
          SizedBox(
            width: 100,
            height: 20,
            child: Slider(
              value: device.volume.toDouble(),
              min: 0,
              max: 100,
              activeColor: Colors.teal,
              onChanged: (val) {
                setState(() {
                  device.volume = val.toInt();
                });
              },
            ),
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
