import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

typedef DevGestureCallback = void Function();

enum DevTriggerZone {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

class DevGesture extends StatefulWidget {
  final Widget child;
  final int tapCount;
  final Duration timeout;
  final List<DevTriggerZone> triggerZones;
  final Size tapAreaSize;
  final DevGestureCallback onTriggered;
  final bool showDebugBadge;

  const DevGesture({
    super.key,
    required this.child,
    required this.onTriggered,
    this.tapCount = 5,
    this.timeout = const Duration(seconds: 3),
    this.triggerZones = const [DevTriggerZone.bottomRight],
    this.tapAreaSize = const Size(60, 60),
    this.showDebugBadge = true,
  });

  @override
  State<DevGesture> createState() => _DevGestureState();
}

class _DevGestureState extends State<DevGesture> {
  int _tapCounter = 0;
  DateTime? _firstTapTime;

  void _handleTap() {
    final now = DateTime.now();

    if (_firstTapTime == null ||
        now.difference(_firstTapTime!) > widget.timeout) {
      _firstTapTime = now;
      _tapCounter = 1;
    } else {
      _tapCounter += 1;
    }

    if (_tapCounter >= widget.tapCount) {
      HapticFeedback.lightImpact(); // ✅ Trigger haptic feedback
      widget.onTriggered();

      // Reset
      _tapCounter = 0;
      _firstTapTime = null;
    }
  }

  Alignment _getAlignment(DevTriggerZone zone) {
    switch (zone) {
      case DevTriggerZone.topLeft:
        return Alignment.topLeft;
      case DevTriggerZone.topRight:
        return Alignment.topRight;
      case DevTriggerZone.bottomLeft:
        return Alignment.bottomLeft;
      case DevTriggerZone.bottomRight:
      default:
        return Alignment.bottomRight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,

        // Tap Zones
        for (final zone in widget.triggerZones)
          Align(
            alignment: _getAlignment(zone),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _handleTap,
              child: SizedBox(
                width: widget.tapAreaSize.width,
                height: widget.tapAreaSize.height,
              ),
            ),
          ),



        // Optional Dev Badge
        if (kDebugMode && widget.showDebugBadge)
          Positioned(
            right: 4,
            bottom: 4,
            child: Tooltip(
              message: "Dev tools available",
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.85),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(6),
                child: const Icon(
                  Icons.bug_report,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
      ],
    );
  }
}


// ℹ️ How to use in your app:
//
// import 'package:peekaboo/peekaboo.dart';
//
// In your app’s root widget:
//
// DevGesture(
//   tapCount: 5,
//   timeout: Duration(seconds: 4),
//   triggerZones: [DevTriggerZone.bottomRight, DevTriggerZone.topLeft],
//   onTriggered: () {
//     debugPrint("🔧 Dev Trigger Activated!");
//     AppOverlayLoading.stop(); // Or show dev panel, etc.
//   },
//   child: MyApp(),
// )

