// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:imove_challenge/core/theme/theme_constants.dart';

enum CupertinoToastPosition { top, bottom }

class EightToastOverlayProvider extends InheritedWidget {
  final EightToastOverlay overlay;

  const EightToastOverlayProvider({super.key, required this.overlay, required super.child});

  @override
  bool updateShouldNotify(covariant EightToastOverlayProvider oldWidget) {
    return overlay != oldWidget.overlay;
  }
}

class EightToastOverlay {
  final OverlayEntry _overlayEntry;

  static EightToastOverlay of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<EightToastOverlayProvider>()!.overlay;
  }

  EightToastOverlay._(this._overlayEntry);

  void dismiss() {
    _overlayEntry.remove();
  }
}

class EightToast {
  static Duration defaultDisplayDuration = Duration(milliseconds: ToastConstants.milliseconds3000);
  static Duration defaultFadeInDuration = Duration(milliseconds: ToastConstants.milliseconds500);
  static Duration defaultFadeOutDuration = Duration(milliseconds: ToastConstants.milliseconds300);

  static EightToastOverlay show(
    BuildContext context, {
    required WidgetBuilder builder,
    Duration? displayDuration,
    Duration? fadeInDuration,
    Duration? fadeOutDuration,
    CupertinoToastPosition position = CupertinoToastPosition.top,
  }) {
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => EightToastOverlayProvider(
        overlay: EightToastOverlay._(overlayEntry),
        child: _EightToastWidget(
          builder: builder,
          displayDuration: displayDuration ?? defaultDisplayDuration,
          fadeInDuration: fadeInDuration ?? defaultFadeInDuration,
          fadeOutDuration: fadeOutDuration ?? defaultFadeOutDuration,
          onDismissed: () => overlayEntry.remove(),
          position: position,
        ),
      ),
    );

    Overlay.of(context, rootOverlay: true).insert(overlayEntry);
    return EightToastOverlay._(overlayEntry);
  }
}

class _EightToastWidget extends StatefulWidget {
  final WidgetBuilder builder;
  final Duration displayDuration;
  final Duration fadeInDuration;
  final Duration fadeOutDuration;
  final VoidCallback onDismissed;
  final CupertinoToastPosition position;

  const _EightToastWidget({
    required this.builder,
    required this.displayDuration,
    required this.fadeInDuration,
    required this.fadeOutDuration,
    required this.onDismissed,
    required this.position,
  });

  @override
  State<_EightToastWidget> createState() => _EightToastWidgetState();
}

class _EightToastWidgetState extends State<_EightToastWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;
  Timer? _dismissTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.fadeInDuration,
      reverseDuration: widget.fadeOutDuration,
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: widget.position == CupertinoToastPosition.top
          ? const Offset(0.0, -1.5)
          : const Offset(0.0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
    _scheduleDismissal();
  }

  void _scheduleDismissal() {
    _dismissTimer?.cancel(); // just in case
    _dismissTimer = Timer(widget.displayDuration, () {
      if (mounted) {
        _controller.reverse().then((_) => widget.onDismissed());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.position == CupertinoToastPosition.top ? ToastConstants.heightLarge : null,
      bottom: widget.position == CupertinoToastPosition.bottom ? ToastConstants.heightLarge : null,
      left: ToastConstants.toastMargin,
      right: ToastConstants.toastMargin,
      child: SlideTransition(
        position: _offsetAnimation,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              if (widget.position == CupertinoToastPosition.top &&
                  details.primaryDelta! < -ToastConstants.toastMargin) {
                // Swipe up to dismiss when toast is at top
                _controller.reverse().then((_) => widget.onDismissed());
              } else if (widget.position == CupertinoToastPosition.bottom &&
                  details.primaryDelta! > ToastConstants.toastMargin) {
                // Swipe down to dismiss when toast is at bottom
                _controller.reverse().then((_) => widget.onDismissed());
              }
            },
            onLongPressStart: (_) {
              // Pause dismiss while holding
              _cancelScheduledDismissal();
            },
            onLongPressEnd: (_) {
              // Resume dismiss when user releases
              _scheduleDismissal();
            },
            child: widget.builder(context),
          ),
        ),
      ),
    );
  }

  void _cancelScheduledDismissal() {
    _dismissTimer?.cancel();
  }

  @override
  void dispose() {
    _controller.dispose();
    _dismissTimer?.cancel();
    super.dispose();
  }
}
