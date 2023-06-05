import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:smart_water_meter/components/abnormal_sensor_card.dart';
import 'package:smart_water_meter/components/sensor_card.dart';
import 'package:smart_water_meter/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3))
        .then((value) => {FlutterNativeSplash.remove()});
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
                      Text("Halo,"),
                      Text(
                        "Adang Susanyo",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  // TODO: Change Icon
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      },
                      icon: Icon(
                        Iconsax.profile_circle5,
                        color: Colors.black,
                      )),
                ],
              ),
            ),

            // MARK: Banner
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              child: Image(image: AssetImage('assets/banner-image.jpeg')),
            ),

            // MARK: Abnormal Sensors
            Padding(
              padding: const EdgeInsets.only(top: 14, left: 16, bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "2 Sensor butuh dicek",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 133,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        // Padding(
                        //   padding: EdgeInsets.only(right: 10),
                        //   child: Container(
                        //       width: 200,
                        //       height: 100,
                        //       color: Colors.blue,
                        //       child: Text("Item 1")),
                        // ),
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: AbnormalSensorCard(),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: AbnormalSensorCard(),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: AbnormalSensorCard(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // MARK: All Sensors
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Semua Sensor",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    SensorCard(),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
