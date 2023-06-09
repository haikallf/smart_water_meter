import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:smart_water_meter/components/custom_alert.dart';
import 'package:smart_water_meter/components/custom_button.dart';
import 'package:smart_water_meter/components/custom_list_view.dart';
import 'package:smart_water_meter/components/custom_snackbar.dart';
import 'package:smart_water_meter/controllers/auth.dart';
import 'package:smart_water_meter/enums/color_constant.dart';
import 'package:smart_water_meter/enums/text_style_constant.dart';
import 'package:smart_water_meter/models/user_response_model.dart';
import 'package:smart_water_meter/pages/about_page.dart';
import 'package:smart_water_meter/pages/login_page.dart';
import 'package:smart_water_meter/pages/device_settings_page.dart';
import 'package:smart_water_meter/utils/extensions.dart';
import 'package:smart_water_meter/utils/local_storage.dart';
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

  String fullName = "";

  @override
  void initState() {
    super.initState();
    fullName = LocalStorage.getFullName() ?? "";
  }

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

  void setSnackBarMessage(String value) {
    setState(() {
      snackBarMessage = value;
    });
  }

  bool isAbleToChangeFullName() {
    return newFullName != "" && newFullName != fullName;
  }

  void showCustomAlertDialog(
    BuildContext context,
    String content,
    String cancelButtonText,
    String confirmationButtonText,
  ) async {
    bool? dialogResult = await showDialog<bool>(
        context: context,
        barrierColor: Colors.black.withOpacity(0.4),
        builder: (BuildContext context) {
          return CustomAlert(
              content: content,
              cancelButtonText: cancelButtonText,
              confirmationButtonText: confirmationButtonText,
              onTap: () {});
        });

    if (context.mounted) {
      if (dialogResult == true) {
        await LocalStorage.clearEmail();
        await SessionManager().remove("token");
        if (context.mounted) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginPage()),
              (Route<dynamic> route) => false);
        }
      }
    }
  }

  void changeFullNameModalBottomSheet(BuildContext context) {
    handleFullNameChange("");
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        barrierColor: Colors.black.withOpacity(0.4),
        builder: (bc) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Wrap(
                children: [
                  Container(
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
                                      setModalState(() {
                                        handleFullNameChange(value.toString());
                                      });
                                    },
                                    textCapitalization:
                                        TextCapitalization.words,
                                    maxLength: 32,
                                    style: const TextStyleConstant().body02,
                                    decoration: InputDecoration(
                                      hintText: fullName,
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
                                              color:
                                                  ColorConstant.colorsprimary)),
                                    ),
                                  ),
                                ]),
                              )
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: AbsorbPointer(
                          absorbing: !isAbleToChangeFullName(),
                          child: CustomButton(
                              onTap: () {
                                changeFullName(context);
                                // setSnackBarMessage("Nama berhasil diubah");
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //     CustomSnackBar()
                                //         .showSnackBar(snackBarMessage));
                                // Navigator.of(context).pop();
                                // setSnackBarMessage("");
                              },
                              isDisabled: !isAbleToChangeFullName(),
                              text: "Simpan"),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                    ]),
                  )
                ],
              ),
            );
          });
        });
  }

  void changeFullName(BuildContext context) async {
    UserResponseModel response = await AuthController().changeName(newFullName);
    if (response.responseStatusCode == 200) {
      setSnackBarMessage("Nama berhasil diubah");
      await LocalStorage.setFullName('${response.currentUser?.name}');
      setState(() {
        fullName = LocalStorage.getFullName() ?? "NULL";
      });
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBar().showSnackBar(snackBarMessage));
        Navigator.of(context).pop();
      }
      setSnackBarMessage("");
    } else {
      setSnackBarMessage("Pengubahan nama gagal!");
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBar().showSnackBar(snackBarMessage));
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Tuple2<String, VoidCallback?>> profileList = [
      Tuple2<String, VoidCallback?>("Pengaturan Alat", () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const DeviceSettingsPage()));
      }),
      Tuple2<String, VoidCallback?>("Tentang Aplikasi", () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AboutPage()));
      }),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorConstant.colorsVariant90,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context, true),
            icon: const iconoir.NavArrowLeft()),
        title: Text(
          "Profil",
          style: const TextStyleConstant().title03,
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
                            fullName.toTitleCase(),
                            style: const TextStyleConstant().title02,
                          ),
                          IconButton(
                              onPressed: () {
                                changeFullNameModalBottomSheet(context);
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
                    context,
                    "Kamu yakin ingin keluar?",
                    "Batal",
                    "Keluar",
                  );
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
