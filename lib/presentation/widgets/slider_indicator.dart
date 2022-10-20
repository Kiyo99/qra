import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SliderIndicator extends HookWidget {
  final int slideCount;
  final int currentSlide;
  final Color? activeColor;
  final Color? dotColor;

  const SliderIndicator({
    Key? key,
    required this.slideCount,
    required this.currentSlide,
    this.activeColor,
    this.dotColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return slideCount > 1
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                slideCount,
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(
                    vertical: 7.0,
                    horizontal: 2.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: currentSlide == index
                          ? dotColor ?? Colors.white24
                          : activeColor ?? Colors.white,
                    ),
                    color: currentSlide == index
                        ? activeColor ?? Colors.white
                        : dotColor ?? Colors.white24,
                  ),
                ),
              ).toList(),
            ),
          )
        : const SizedBox();
  }
}
