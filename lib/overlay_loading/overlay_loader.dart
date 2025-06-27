import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


typedef LoadingOverrideBuilder = Widget Function(BuildContext context);

class AppOverlayLoader {
  AppOverlayLoader._();

  static OverlayEntry? _overlayEntry;
  static Timer? _timeoutTimer;

  static bool get isVisible => _overlayEntry != null;

  /// Call this to show the loading overlay
  static Future<bool> show(
      BuildContext context, {
        Duration timeout = const Duration(seconds: 60),
        bool dismissible = false,
        Color barrierColor = Colors.black54,
        LoadingOverrideBuilder? customLoader,
      }) async {
    if (_overlayEntry != null) return false;

    _overlayEntry = OverlayEntry(
      builder: (_) => _LoaderWidget(
        dismissible: dismissible,
        barrierColor: barrierColor,
        customLoader: customLoader,
      ),
    );

    if (!context.mounted) return false;

    Overlay.of(context).insert(_overlayEntry!);

    // Auto-hide after timeout
    _timeoutTimer = Timer(timeout, hide);

    return true;
  }

  /// Removes the overlay
  static void hide() {
    _timeoutTimer?.cancel();
    _timeoutTimer = null;
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class _LoaderWidget extends StatelessWidget {
  final bool dismissible;
  final Color barrierColor;
  final LoadingOverrideBuilder? customLoader;

  const _LoaderWidget({
    required this.dismissible,
    required this.barrierColor,
    this.customLoader,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: dismissible ? AppOverlayLoader.hide : null,
      child: Stack(
        children: [
          ModalBarrier(
            color: barrierColor,
            dismissible: dismissible,
          ),

          /// Invisible dev tap escape (top left 30x30)
          Positioned(
            top: 10,
            left: 10,
            child: GestureDetector(
              onTap: AppOverlayLoader.hide,
              child: const SizedBox(
                width: 30,
                height: 30,
                child: ColoredBox(color: Colors.transparent),
              ),
            ),
          ),

          /// Center loading
          Center(
            child: Container(
              height: 120,
              width: 120,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: customLoader != null
                  ? customLoader!(context)
                  : _DefaultLoadingIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}

class _DefaultLoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? const CupertinoActivityIndicator(radius: 16)
        : const CircularProgressIndicator(strokeWidth: 3);
  }
}



// ℹ️ How to use in your app:
//
// import 'package:peekaboo/peekaboo.dart';
//
// final shown = await PeekabooOverlayLoader.start(context);
// if (!shown) return;
//
// // Stop loader
// PeekabooOverlayLoader.stop();

//️ 🌟 Bonus: Optional safety in dispose of any screen
//dart
//Copy
//Edit
//@override
//void dispose() {
//  PeekabooOverlayLoader.stop();
//  super.dispose();
//}