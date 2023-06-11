import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_water_meter/enums/color_constant.dart';

class WarningFadeIcon extends StatefulWidget {
  const WarningFadeIcon({super.key, required this.onTap});
  final VoidCallback? onTap;

  @override
  State<WarningFadeIcon> createState() => _WarningFadeIconState();
}

class _WarningFadeIconState extends State<WarningFadeIcon>
    with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
      duration: const Duration(milliseconds: 600), vsync: this)
    ..repeat(reverse: true);

  late final Animation<double> _animation =
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        height: 32,
        width: 32,
        child: FadeTransition(
          opacity: _animation,
          child: SvgPicture.asset(
            "assets/warning.svg",
            colorFilter: const ColorFilter.mode(
                ColorConstant.colorsdanger, BlendMode.srcIn),
            height: 16,
            width: 16,
          ),
        ),
      ),
    );
  }
}
