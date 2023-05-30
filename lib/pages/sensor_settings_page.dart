import 'package:flutter/material.dart';
import 'package:smart_water_meter/components/custom_alert.dart';
import 'package:smart_water_meter/components/custom_button.dart';
import 'package:smart_water_meter/components/custom_list_view.dart';
import 'package:smart_water_meter/enums/color_constants.dart';
import 'package:tuple/tuple.dart';

class SensorSettingsPage extends StatefulWidget {
  const SensorSettingsPage({super.key});

  @override
  State<SensorSettingsPage> createState() => _SensorSettingsPageState();
}

class _SensorSettingsPageState extends State<SensorSettingsPage> {
  String newSensorName = "";
  bool isSensorNameFieldFocus = false;

  void handleSensorNameChange(String value) {
    setState(() {
      newSensorName = value;
    });
  }

  void handleSensorNameFieldFocusChange(bool isFocused) {
    setState(() {
      isSensorNameFieldFocus = isFocused;
    });
  }

  void forceRebuild() {
    setState(() {});
  }

  void closeAllModalBottomSheet() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

//
  void showCustomAlertDialog(
      BuildContext context,
      String content,
      String cancelButtonText,
      String confirmationButtonText,
      VoidCallback? onTap,
      [String? title,
      bool? isDanger]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlert(
            content: content,
            cancelButtonText: cancelButtonText,
            confirmationButtonText: confirmationButtonText,
            onTap: onTap);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    void changeSensorNameModalBottomSheet(BuildContext context) {
      showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          builder: (context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
              return IntrinsicHeight(
                child: Container(
                  color: Colors.white,
                  child: Column(children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1.0, color: Color(0x1A000000)))),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.chevron_left)),
                          Text("Ubah Nama Alat",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Nama Alat",
                                style: TextStyle(
                                    color: isSensorNameFieldFocus
                                        ? Colors.blue
                                        : Colors.black)),
                            Focus(
                              onFocusChange: (isFocus) {
                                setModalState(() {
                                  handleSensorNameFieldFocusChange(isFocus);
                                });
                              },
                              child: Column(children: [
                                TextField(
                                  onChanged: (value) {
                                    handleSensorNameChange(value.toString());
                                  },
                                  maxLength: 32,
                                  style: TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.all(12),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                    fillColor: Colors.grey[100],
                                    filled: true,
                                  ),
                                ),
                              ]),
                            )
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: CustomButton(
                          onTap: () {
                            closeAllModalBottomSheet();
                          },
                          text: "Simpan"),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ]),
                ),
              );
            });
          });
    }

    void sensorSettingModalBottomSheet(context) {
      showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          builder: (BuildContext context) {
            return IntrinsicHeight(
              child: Container(
                color: Colors.white,
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1.0, color: Color(0x1A000000)))),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.chevron_left)),
                        Text("Sensor Kolam A-1",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      changeSensorNameModalBottomSheet(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Ubah Nama Sensor",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700)),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showCustomAlertDialog(
                          context,
                          "Apakah kamu yakin ingin menghapus alat ini?",
                          "Kembali",
                          "Hapus",
                          () {});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Hapus Alat",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstants.red)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  )
                ]),
              ),
            );
          });
    }

    List<Tuple2<String, VoidCallback?>> sensorList = [
      Tuple2<String, VoidCallback?>("Sensor Kolam A-1", () {
        sensorSettingModalBottomSheet(context);
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
