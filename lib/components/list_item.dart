import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:smart_water_meter/enums/text_style_constant.dart';

class ListItem extends StatefulWidget {
  const ListItem({super.key, required this.text, required this.onTap});
  final String text;
  final VoidCallback? onTap;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            widget.text,
            style: const TextStyleConstant().label02,
          ),
          const iconoir.NavArrowRight()
        ]),
      ),
    );
  }
}
