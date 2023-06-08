import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:smart_water_meter/components/custom_alert.dart';
import 'package:smart_water_meter/components/custom_button.dart';
import 'package:smart_water_meter/components/custom_list_view.dart';
import 'package:smart_water_meter/components/custom_snackbar.dart';
import 'package:smart_water_meter/enums/color_constant.dart';
import 'package:smart_water_meter/enums/text_style_constant.dart';
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
  String newFullName = "";
  bool isFullNameFieldFocus = false;
  bool isSnackbarShown = false;
  String snackBarMessage = "";

  void handleFullNameChange(String value) {
    setState(() {
      newFullName = value;
    });
  }

  void handleFullNameFieldFocusChange(bool isFocused) {
    setState(() {
      isFullNameFieldFocus = isFocused;
    });
  }

  void handleShowSnackBar(bool value) {
    setState(() {
      isSnackbarShown = value;
    });
  }

  void handlsnackBarMessage(String value) {
    setState(() {
      snackBarMessage = value;
    });
  }

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
    ).then((value) => {
          // if (isSnackbarShown)
          //   {
          //     ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          //       content: Text(snackBarMessage),
          //     )),
          //     handleShowSnackBar(false)
          //   }
        });
  }

  void changeSensorNameModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        builder: (bc) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
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
                            child: const iconoir.Cancel()),
                        const SizedBox(
                          width: 8,
                        ),
                        Text("Ubah Nama",
                            style: const TextStyleConstant().title03),
                      ],
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nama Lengkap",
                              style: TextStyle(
                                  color: isFullNameFieldFocus
                                      ? ColorConstant.colorssecondary
                                      : ColorConstant.colorsNeutral50)),
                          const SizedBox(
                            height: 4,
                          ),
                          Focus(
                            onFocusChange: (isFocus) {
                              setModalState(() {
                                handleFullNameFieldFocusChange(isFocus);
                              });
                            },
                            child: Column(children: [
                              TextField(
                                onChanged: (value) {
                                  handleFullNameChange(value.toString());
                                },
                                maxLength: 32,
                                style: const TextStyleConstant().body02,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: iconoir.User(
                                        color: isFullNameFieldFocus
                                            ? ColorConstant.colorsprimary
                                            : Colors.black),
                                  ),
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(12),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorConstant.colorsprimary)),
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
                          handlsnackBarMessage("Sukses");
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //     CustomSnackBar(content: Text(snackBarMessage)));

                          Navigator.of(context).pop();
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
      backgroundColor: ColorConstant.colorsVariant90,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const iconoir.NavArrowLeft()),
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(48.0),
                        child: const Image(
                            height: 96,
                            width: 96,
                            image: AssetImage("assets/profile-avatar.png")),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      // MARK: Edit Username
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Adang Susanyo",
                            style: const TextStyleConstant().title02,
                          ),
                          IconButton(
                              onPressed: () {
                                changeSensorNameModalBottomSheet(context);
                              },
                              icon: const iconoir.EditPencil(
                                color: ColorConstant.colorssecondary,
                              ))
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
              child: CustomButton(
                onTap: () {
                  showCustomAlertDialog(
                      context, "Kamu yakin ingin keluar?", "Batal", "Keluar",
                      () {
                    Navigator.of(context).pop();
                  });
                },
                text: "Keluar",
                backgroundColor: ColorConstant.colorsdanger,
              ),
            )
          ],
        ),
      ),
    );
  }
}
