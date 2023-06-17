import 'package:flutter/material.dart';
import 'package:iconoir_flutter/profile_circle.dart';
import 'package:smart_water_meter/components/abnormal_sensor_card.dart';
import 'package:smart_water_meter/components/custom_button.dart';
import 'package:smart_water_meter/components/sensor_card.dart';
import 'package:smart_water_meter/enums/color_constant.dart';
import 'package:smart_water_meter/enums/text_style_constant.dart';
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

  @override
  void initState() {
    super.initState();
    notificationManager = NotificationManager();
    notificationManager.initialize();
    setState(() {
      currentFullName = LocalStorage.getFullName() ?? "NULL";
    });
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
      backgroundColor: Colors.white,
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      },
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
            Padding(
              padding: const EdgeInsets.only(top: 14, left: 16, bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "2 Sensor Butuh Dicek",
                    style: const TextStyleConstant().label02,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 133,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(right: 6),
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: AbnormalSensorCard(
                            sensorName: "Sensor Kolam A-1",
                            sensorCount: "3",
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: AbnormalSensorCard(
                            sensorName: "Sensor Kolam A-2",
                            sensorCount: "2",
                          ),
                        ),
                        // Container(
                        //   margin: const EdgeInsets.only(right: 10),
                        //   child: AbnormalSensorCard(),
                        // ),
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
                    SensorCard(
                      sensorName: "Sensor Kolam A-1",
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    SensorCard(
                      sensorName: "Sensor Kolam A-2",
                    )
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
