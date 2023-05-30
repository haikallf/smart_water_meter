import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:smart_water_meter/components/list_item.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({super.key, required this.listItems});
  final List<Tuple2<String, VoidCallback?>> listItems;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListItem(
              text: listItems[index].item1, onTap: listItems[index].item2);
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: Color(0x1A000000),
          );
        },
        itemCount: listItems.length);
  }
}
