import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.all(16),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            widget.text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const Icon(
            Icons.chevron_right,
            size: 24,
          )
        ]),
      ),
    );
  }
}
