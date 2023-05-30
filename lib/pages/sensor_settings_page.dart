import 'package:flutter/material.dart';
import 'package:smart_water_meter/components/custom_list_view.dart';
import 'package:smart_water_meter/components/custom_textfield.dart';
import 'package:smart_water_meter/enums/color_constants.dart';
import 'package:tuple/tuple.dart';

class SensorSettingsPage extends StatefulWidget {
  const SensorSettingsPage({super.key});

  @override
  State<SensorSettingsPage> createState() => _SensorSettingsPageState();
}

class _SensorSettingsPageState extends State<SensorSettingsPage> {
  @override
  Widget build(BuildContext context) {
    List<Tuple2<String, VoidCallback?>> sensorList = [
      Tuple2<String, VoidCallback?>("Sensor Kolam A-1", () {
        _sensorSettingModalBottomSheet(context);
      }),
      Tuple2<String, VoidCallback?>("Sensor Kolam A-2", () {}),
      Tuple2<String, VoidCallback?>("Sensor Kolam A-3", () {}),
      Tuple2<String, VoidCallback?>("Sensor Kolam B-1", () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SensorSettingsPage()));
      }),
    ];

    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Pengaturan Alat",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      )),
      backgroundColor: const Color(0xFFF4F4F4),
      body: SafeArea(child: CustomListView(listItems: sensorList)),
    );
  }
}

// void _settingModalBottomSheet(context) {
//   showModalBottomSheet(
//       context: context,
//       builder: (BuildContext bc) {
//         return Scaffold(
//           appBar: AppBar(),
//           body: Container(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Ubah Nama Alat",
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.w700)),
//                       Text("Icon")
//                     ],
//                   ),
//                   SizedBox(height: 32),
//                   Text(
//                     "Hapus Alat",
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                         color: ColorConstants.red),
//                   )
//                 ],
//               )),
//         );
//       });
// }

void _sensorSettingModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      builder: (BuildContext bc) {
        return IntrinsicHeight(
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(width: 1.0, color: Color(0x1A000000)))),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.chevron_left)),
                  Text("Sensor Kolam A-1",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Ubah Nama Sensor",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("Hapus Alat",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.red)),
                ],
              ),
            ),
            SizedBox(
              height: 32,
            )
          ]),
        );
      });
}

// void _settingModalBottomSheet(context) {
//   showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       builder: (BuildContext bc) {
//         return Wrap(
//           children: <Widget>[
//             ListTile(
//                 splashColor: Colors.transparent,
//                 leading: const Icon(Icons.chevron_left),
//                 title: const Text("Sensor Kolam A-1",
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
//                 onTap: () => {Navigator.of(context).pop()}),
//             ListTile(
//                 title: const Text("Ubah Nama Alat",
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
//                 trailing: const Icon(Icons.chevron_right),
//                 onTap: () => {_changeSensorNameModalBottomSheet(context)}),
//             ListTile(
//                 title: const Text("Hapus Alat",
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                         color: ColorConstants.red)),
//                 onTap: () => {}),
//             ListTile(
//                 title: const SizedBox(
//                   height: 16,
//                 ),
//                 onTap: () => {}),
//           ],
//         );
//       });
// }

void _changeSensorNameModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      builder: (BuildContext bc) {
        return IntrinsicHeight(child: Column(children: [Text("haha")]));
      });
}
