import 'package:flutter/material.dart';
import 'package:smart_water_meter/components/custom_button.dart';
import 'package:smart_water_meter/components/custom_list_view.dart';
import 'package:smart_water_meter/pages/about_page.dart';
import 'package:smart_water_meter/pages/sensor_settings_page.dart';
import 'package:smart_water_meter/pages/terms_and_conditions_page.dart';
import 'package:tuple/tuple.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    List<Tuple2<String, VoidCallback?>> profileList = [
      Tuple2<String, VoidCallback?>("Pengaturan Alat", () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SensorSettingsPage()));
      }),
      Tuple2<String, VoidCallback?>("Tentang Aplikasi", () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AboutPage()));
      }),
      Tuple2<String, VoidCallback?>("Syarat & Ketentuan", () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TermsAndConditionsPage()));
      }),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        title: const Text(
          "Profil",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                // MARK: Profile Header
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  color: Colors.white,
                  child: Column(
                    children: [
                      // MARK: Profile Avatar
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(48),
                            color: Color(0xFFD9D9D9)),
                        child: const Icon(
                          Icons.person,
                          size: 48,
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      // MARK: Edit Username
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Adang Susanyo",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          // IconButton(
                          //     onPressed: () {},
                          //     icon: const Icon(
                          //       Icons.edit_calendar_outlined,
                          //       size: 24,
                          //       color: Colors.black,
                          //     ))
                        ],
                      )
                    ],
                  ),
                ),

                // MARK: ListView
                CustomListView(listItems: profileList)
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: CustomButton(onTap: () {}, text: "Keluar"),
            )
          ],
        ),
      ),
    );
  }
}
