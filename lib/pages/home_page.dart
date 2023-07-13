import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iconoir_flutter/profile_circle.dart';
import 'package:smart_water_meter/components/abnormal_sensor_card.dart';
import 'package:smart_water_meter/components/device_card.dart';
import 'package:smart_water_meter/controllers/devices.dart';
import 'package:smart_water_meter/enums/color_constant.dart';
import 'package:smart_water_meter/enums/text_style_constant.dart';
import 'package:smart_water_meter/models/device_model.dart';
import 'package:smart_water_meter/pages/device_detail_page.dart';
import 'package:smart_water_meter/pages/profile_page.dart';
import 'package:smart_water_meter/utils/extensions.dart';
import 'package:smart_water_meter/utils/local_storage.dart';
import 'package:smart_water_meter/utils/notification_manager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final NotificationManager notificationManager;

  String currentFullName = "";

  bool isLoading = true;

  List<DeviceModel> devices = [];
  List<DeviceModel> anomalyDevices = [];
  List<dynamic> predictions = [];

  void loadData() async {
    setState(() {
      isLoading = true;
    });

    final allDevices = await DevicesController().getAllDevices();

    setState(() {
      devices = allDevices.devices ?? [];
      anomalyDevices =
          devices.where((device) => device.anomalies.isNotEmpty).toList();

      Future.delayed(Duration(milliseconds: 500)).then((value) => {
            setState(() {
              isLoading = false;
            })
          });
    });
    print("devices: ${devices}");
    print("anomalies: $anomalyDevices");
  }

  void goToDeviceDetailPage(String deviceId, String deviceName) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DeviceDetailPage(
                deviceId: deviceId,
                deviceName: deviceName,
              )),
    ).then((result) async {
      if (result != null && mounted) {
        loadData();
      }
      return Future.value();
    });
  }

  void goToProfilePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    ).then((result) async {
      if (result != null && mounted) {
        loadData();
        setState(() {
          currentFullName = LocalStorage.getFullName() ?? "NULL";
        });
      }
      return Future.value();
    });
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      currentFullName = LocalStorage.getFullName() ?? "NULL";
    });
    loadData();
  }

  final spinkit = const SpinKitRing(
    color: ColorConstant.colorsprimary,
    size: 50,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFCFE),
      body: SafeArea(
        child: isLoading
            ? spinkit
            : Align(
                alignment: Alignment.topLeft,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // MARK: Heading
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Halo,",
                                  style: const TextStyleConstant().paragraph02,
                                ),
                                Text(
                                  currentFullName.toTitleCase(),
                                  style: const TextStyleConstant().heading04,
                                )
                              ],
                            ),
                            // MARK: Change Icon
                            IconButton(
                                onPressed: goToProfilePage,
                                icon: const ProfileCircle(
                                  height: 32,
                                  width: 32,
                                  color: ColorConstant.colorsprimary,
                                )),
                          ],
                        ),
                      ),

                      // MARK: Banner
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 16),
                        child: Image(
                          image: const AssetImage(
                            'assets/banner-image.jpeg',
                          ),
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),

                      // MARK: Abnormal Sensors
                      if (anomalyDevices.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 14, left: 16, bottom: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${anomalyDevices.length} Alat Butuh Dicek",
                                style: const TextStyleConstant().label02,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 133,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.only(right: 6),
                                  children: [
                                    for (int i = 0;
                                        i < anomalyDevices.length;
                                        i++) ...[
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: AbnormalSensorCard(
                                          deviceName:
                                              anomalyDevices[i].name ?? "NULL",
                                          sensorCount: anomalyDevices[i]
                                              .anomalies
                                              .length
                                              .toString(),
                                          onBack: () {
                                            goToDeviceDetailPage(
                                                anomalyDevices[i].id ?? "",
                                                anomalyDevices[i].name ?? "");
                                          },
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                      // MARK: All Sensors
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                devices.isNotEmpty
                                    ? "Semua Alat"
                                    : "Tidak ada alat",
                                style: const TextStyleConstant().label02,
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              for (int i = 0; i < devices.length; i++) ...[
                                DeviceCard(
                                  sensorName: devices[i].name ?? "",
                                  onTap: () {
                                    goToDeviceDetailPage(devices[i].id ?? "",
                                        devices[i].name ?? "");
                                  },
                                ),
                                SizedBox(
                                  height: (i < devices.length - 1) ? 14 : 0,
                                )
                              ],
                            ]),
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.all(16),
                      //   child: CustomButton(
                      //       onTap: () async {
                      //         await notificationManager.showNotification(
                      //             id: 0,
                      //             title: "Notification Title",
                      //             body: "Notification Body");
                      //       },
                      //       text: "Trigger Notif"),
                      // )
                    ]),
              ),
      ),
    );
  }
}
