Sure! Here's a complete and well-formatted `README.md` file for your **Drone Surveillance App** built with Flutter:

---

````markdown
# 🚁 Drone Surveillance App

A Flutter-based mobile application that provides a live drone video feed via RTSP using VLC Player, with capabilities to capture photos, record video, and monitor drone connectivity via Wi-Fi.

---

## 📱 Features

- 📶 **Wi-Fi Check:** Ensures connection with drone's Wi-Fi before starting the stream.
- 🎥 **Live RTSP Streaming:** Uses `flutter_vlc_player` to stream real-time video.
- 📸 **Snapshot Capture:** Takes photos from the video stream and saves them locally.
- 🎞️ **Video Recording:** Records the live stream and saves the video locally.
- 🛑 **Drone Control:** Start/stop drone feed and video recording with intuitive UI buttons.

---

## 🔧 Technologies Used

- **Flutter** (Dart)
- [`flutter_vlc_player`](https://pub.dev/packages/flutter_vlc_player)
- [`connectivity_plus`](https://pub.dev/packages/connectivity_plus)
- [`path_provider`](https://pub.dev/packages/path_provider)

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Android Studio or VS Code
- A device/emulator (with VLC-compatible RTSP stream for testing)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/drone-surveillance-app.git
   cd drone-surveillance-app
````

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Run the app:**

   ```bash
   flutter run
   ```

> Make sure your testing device is connected to the drone Wi-Fi (`FLOW_WIFI-2a89c0`) and the drone is streaming RTSP on `rtsp://192.168.1.101:8554/live`.

---

## 📁 Project Structure

```
lib/
├── main.dart         # App entry point and main UI logic
```

---

## 📸 Screenshots

| Start Screen                    | Live Feed                          | Controls                              |
| ------------------------------- | ---------------------------------- | ------------------------------------- |
| ![Start](screenshots/start.png) | ![Live Feed](screenshots/feed.png) | ![Controls](screenshots/controls.png) |

---

## ❗ Known Limitations

* Works only when connected to a specific Wi-Fi network.
* Snapshot files are not accessible from gallery unless moved manually.
* Video recording paths and permission handling might require extra setup for iOS.

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).

---

## ✨ Author

**Muhammad Waleed**
🌐 \[YourPortfolio.com](https://nawazwaleed65.github.io/Portfolio/)
🐙 [GitHub](https://github.com/nawazwaleed65)

---

> 🚧 *Contributions, feedback, and suggestions are always welcome!*

```

---

Let me know if you want this converted into a file, include actual screenshots, or customize for Android/iOS build setup!
```
