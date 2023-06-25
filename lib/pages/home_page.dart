import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:iconoir_flutter/profile_circle.dart';
import 'package:smart_water_meter/components/abnormal_sensor_card.dart';
import 'package:smart_water_meter/components/custom_button.dart';
import 'package:smart_water_meter/components/device_card.dart';
import 'package:smart_water_meter/controllers/devices-dummy.dart';
import 'package:smart_water_meter/enums/color_constant.dart';
import 'package:smart_water_meter/enums/text_style_constant.dart';
import 'package:smart_water_meter/pages/device_detail_page.dart';
import 'package:smart_water_meter/pages/profile_page.dart';
import 'package:smart_water_meter/utils/extensions.dart';
import 'package:smart_water_meter/utils/local_storage.dart';
import 'package:smart_water_meter/utils/notification_manager.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final NotificationManager notificationManager;
  String currentFullName = "";

  final channel =
      IOWebSocketChannel.connect("wss://socketsbay.com/wss/v2/1/demo/");

  String btcUsdtPrice = "0";

  List<dynamic> devices = [];
  List<dynamic> predictions = [];

  void loadData() async {
    final devicesTemp = await DevicesDummyController().getAllDevices();
    final predictionsTemp =
        await DevicesDummyController().getAllAbnormalSensors();
    setState(() {
      devices = devicesTemp;
      predictions = predictionsTemp;
    });
    print("devices: $devices");
    print("predictions: $predictions");
  }

  void goToDeviceDetailPage(String deviceId) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DeviceDetailPage(
                deviceId: deviceId,
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
      }
      return Future.value();
    });
  }

  @override
  void initState() {
    // FirebaseMessaging.onMessage.listen((event) {
    //   if (event.notification == null) return;
    //   showDialog(
    //       context: context,
    //       builder: (builder) {
    //         return Column(
    //           children: [
    //             Text(event.notification?.title ?? ""),
    //             Text(event.notification?.body ?? "")
    //           ],
    //         );
    //       });
    // });
    super.initState();
    //TODO: Recheck
    // notificationManager = NotificationManager();
    // notificationManager.initialize();
    setState(() {
      currentFullName = LocalStorage.getFullName() ?? "NULL";
    });
    loadData();
    // streamListener();
    // notificationManager.init();
  }

  streamListener() async {
    channel.stream.listen((message) async {
      // channel.sink.add("received data");
      // channel.sink.close();
      Map getData = jsonDecode(message);

      setState(() {
        btcUsdtPrice = getData["value"];
      });

      print(btcUsdtPrice);

      await notificationManager.showNotification(
          id: 0, title: "Notification Title", body: btcUsdtPrice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFCFE),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topLeft,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              child: Image(
                image: const AssetImage(
                  'assets/banner-image.jpeg',
                ),
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width,
              ),
            ),

            // MARK: Abnormal Sensors
            if (predictions.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 14, left: 16, bottom: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${predictions.length} Alat Butuh Dicek",
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
                          for (int i = 0; i < predictions.length; i++) ...[
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: AbnormalSensorCard(
                                deviceName: predictions[i]["name"],
                                sensorCount: predictions[i]["predictions"]
                                    .length
                                    .toString(),
                                onBack: () {
                                  goToDeviceDetailPage(predictions[i]["id"]);
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
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Semua Alat",
                      style: const TextStyleConstant().label02,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    for (int i = 0; i < devices.length; i++) ...[
                      DeviceCard(
                        sensorName: devices[i]["name"],
                        onTap: () {
                          goToDeviceDetailPage(devices[i]["id"]);
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
