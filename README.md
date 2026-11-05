# Smart Home Controller App
**BIM493 - Mobile Programming | Assignment #2**

https://github.com/duyguaktas/smart_home_controller_hw2.git
---

## 👥 Team Information

- Duygu Aktaş - 10785084980
- Yaren Yel - 19129073888

### Member Contributions
- **Duygu Aktaş**
  - Designed the core OOP architecture including the abstract `SmartDevice` class and subclasses (`SmartLight`, `Thermostat`, `SmartSpeaker`).
  - Implemented required Dart features: Interface (`Connectable`), Mixin (`Schedulable`), and keywords (`static`, `super`, `this`).
- **Yaren Yel**
  - Developed the interactive UI components (Switches, Sliders, and state-dependent Play/Pause buttons) and customized the device themes.
  - Configured the Flutter project structure and `ListView.builder` for dynamic device rendering.
  - Managed state updates (`setState`) for device interactions, capacity counters, and dynamic status text logic (e.g., "Heating" vs "Cooling").

---

## 🛠️ Flutter Environment & Setup

### Environment Information
Output of `flutter --version`:
```text
Flutter 3.47.9 • channel stable • [https://github.com/flutter/flutter.git](https://github.com/flutter/flutter.git)
Framework • revision (3.47.9)
Engine • revision ...
Tools • Dart 3.7.x • DevTools ...

```

### How to Run the Project

1. **Clone or Extract the Repository:**
Ensure all project files including `lib/`, `models/`, and `pubspec.yaml` are present.
2. **Install Dependencies:**
Open a terminal in the project directory and run:
```bash
flutter pub get

```


3. **Launch Application:**
Run the app on a connected device, emulator, or Windows desktop:
```bash
flutter run

```



---

## ✅ Feature Verification Checklist

| Requirement | Status | Description |
| --- | --- | --- |
| **Class & Objects** | PASS | Created `SmartDevice` base class and subclasses. Displayed 4 different instances on the screen. |
| **Constructor** | PASS | Utilized both default and named constructors (e.g., `SmartSpeaker.named`). |
| **Inheritance & Abstraction** | PASS | Subclasses extend abstract `SmartDevice`. Implemented `getStatus()` and `performAction()` methods. |
| **Interface & Mixin** | PASS | Implemented `Connectable` interface across devices and applied `Schedulable` mixin to `SmartLight`. |
| **Keywords (`static`, `super`, `this`)** | PASS | Tracked total devices with `static`, passed variables with `super`, and assigned parameters via `this`. |
| **Device Information UI** | PASS | Each card dynamically shows name, relevant properties (brightness, temperature, volume), and status. |
| **Interaction Controls** | PASS | Provided switches for lights, +/- adjusters for the thermostat, and a functional play/pause toggle for the speaker. |
| **Dynamic Temperature Logic** | PASS | Thermostat status automatically switches between "Heating" and "Cooling" based on a 20°C threshold. |

---

## ⚠️ Known Limitations

* Total device count and device statuses are managed in-memory and will revert to their default hardcoded initial states upon application restart.

```

```
