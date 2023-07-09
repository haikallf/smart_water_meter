import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:smart_water_meter/components/list_item.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({super.key, required this.listItems});
  final List<Tuple2<String, VoidCallback?>> listItems;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ]),
        child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListItem(
                  text: listItems[index].item1, onTap: listItems[index].item2);
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 0,
                color: Color(0x1A000000),
              );
            },
            itemCount: listItems.length));
  }
}
