# 👀 Peekaboo

Peekaboo is a developer utility toolkit for Flutter apps — designed to **reveal** useful tools while staying invisible in production.

> Easily inject debugging panels, secret gesture triggers, overlay loaders, platform overrides, and more into any Flutter app.

---

## 🚀 Features

- 🔄 Global Overlay Loader (`AppOverlayLoader`)
- 🐛 Developer Logger (`PeekabooLogger`)
- 📱 Device Info + Emulator Detection
- 🛠️ Secret Dev Panel with:
    - Boot logs
    - Platform overrides
    - Feature toggles
    - Manual simulation tools
- 🎯 Platform override & feature flag registry
- 🕵️ Hidden gesture triggers (invisible corners)
- 🎨 Modular architecture — easy to plug & extend

---

## 🔧 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  peekaboo:
    git:
      url: https://github.com/YOUR_USERNAME/peekaboo.git
```

> Or publish on `pub.dev` and use:
> `peekaboo: ^0.0.1`

---

## 🛠️ Usage

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BootupService().initialize();
  runApp(MyApp());
}
```

```dart
AppOverlayLoader.show(context);
PeekabooLogger().d("This is a debug log");
```

Want a full dev panel?

```dart
DevGesture(
  onTriggered: () => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const DevPanel()),
  ),
  child: YourAppUI(),
);
```

---

## 🧱 Modules Overview

| Module                 | Description |
|------------------------|-------------|
| `AppOverlayLoader`     | Global loading overlay |
| `PeekabooLogger`       | Log with PrettyPrinter |
| `DeviceHelper`         | Device info and emulator detection |
| `BootupService`        | Collect and show boot logs |
| `DevPanel`             | Modular dev dashboard |
| `DevGesture`           | Secret corner tap to trigger dev tools |
| `OverrideRegistry`     | Feature flags and config injection |
| `PlatformHelper`       | Platform override utility |

---

## ❌ No Production Overhead

All debug tools are:
- Disabled in `kReleaseMode`
- Triggered only by developers via gestures or flags

---

## 📁 Folder Structure

```bash
lib/
├── overlay_loading/
├── logger/
├── device_info/
├── bootup/
├── dev_panel/
├── trigger/
├── override/
├── peekaboo.dart
```

---

## 🧪 Try It Out

For internal development, use the `simulator/` app (not published). It allows:
- Visual testing of all modules
- Interactive debug panel
- Hot reload + update tests

--- 

