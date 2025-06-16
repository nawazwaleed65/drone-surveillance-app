import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DroneControlPage(),
  ));
}

class DroneControlPage extends StatefulWidget {
  @override
  _DroneControlPageState createState() => _DroneControlPageState();
}

class _DroneControlPageState extends State<DroneControlPage> {
  bool isDroneRunning = false;
  String droneWifiSSID = "FLOW_WIFI-2a89c0";
  String droneFeedUrl = "rtsp://192.168.1.101:8554/live";
  late VlcPlayerController _vlcController;
  bool isConnectedToDrone = false;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    _vlcController = VlcPlayerController.network(
      droneFeedUrl,
      hwAcc: HwAcc.full,
      autoPlay: false,
      options: VlcPlayerOptions(),
    );
    checkWifiConnection();
  }

  void checkWifiConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      isConnectedToDrone = connectivityResult == ConnectivityResult.wifi;
    });
  }

  void startDrone() {
    if (isConnectedToDrone) {
      setState(() {
        isDroneRunning = true;
        _vlcController.play();
      });
    } else {
      showErrorDialog("Connect to the drone's Wi-Fi first.");
    }
  }

  void stopDrone() {
    setState(() {
      isDroneRunning = false;
      _vlcController.stop();
    });
  }

  Future<void> capturePhoto() async {
    if (!isDroneRunning) {
      showErrorDialog("Start the drone to capture a photo.");
      return;
    }
    await _vlcController.takeSnapshot();
    File snapshotFile = File('${(await getApplicationDocumentsDirectory()).path}/snapshot_${DateTime.now().millisecondsSinceEpoch}.jpg');
    showSuccessDialog("Photo saved at: ${snapshotFile.path}");
  }

  void startRecording() async {
    if (!isDroneRunning) {
      showErrorDialog("Start the drone to record.");
      return;
    }
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/record_${DateTime.now().millisecondsSinceEpoch}.mp4';
    await _vlcController.startRecording(filePath);
    setState(() {
      isRecording = true;
    });
    showSuccessDialog("Recording started!");
  }

  void stopRecording() async {
    if (!isRecording) {
      showErrorDialog("No recording in progress.");
      return;
    }
    await _vlcController.stopRecording();
    setState(() {
      isRecording = false;
    });
    showSuccessDialog("Recording saved.");
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))],
      ),
    );
  }

  void showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Success"),
        content: Text(message),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))],
      ),
    );
  }

  @override
  void dispose() {
    _vlcController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [Icon(Icons.flight_takeoff), SizedBox(width: 8), Text('Drone Surveillance App')]),
        backgroundColor: Colors.grey[700],
      ),
      body: Container(
        color: Colors.grey[300],
        child: Column(
          children: [
            Expanded(
              child: isDroneRunning
                  ? VlcPlayer(
                controller: _vlcController,
                aspectRatio: 16 / 9,
                placeholder: Center(child: CircularProgressIndicator()),
              )
                  : Center(child: Text('Start the drone to view the live feed', style: TextStyle(fontSize: 18, color: Colors.black54))),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: isDroneRunning ? null : startDrone,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    icon: Icon(Icons.flight),
                    label: Text('Start Drone'),
                  ),
                  ElevatedButton.icon(
                    onPressed: isDroneRunning ? stopDrone : null,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    icon: Icon(Icons.stop_circle),
                    label: Text('Stop Drone'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
