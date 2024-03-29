import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:smart_water_meter/components/custom_alert.dart';
import 'package:smart_water_meter/components/custom_button.dart';
import 'package:smart_water_meter/components/custom_list_view.dart';
import 'package:smart_water_meter/components/custom_snackbar.dart';
import 'package:smart_water_meter/controllers/devices.dart';
import 'package:smart_water_meter/enums/color_constant.dart';
import 'package:smart_water_meter/enums/text_style_constant.dart';
import 'package:smart_water_meter/models/device_model.dart';
import 'package:tuple/tuple.dart';

class DeviceSettingsPage extends StatefulWidget {
  const DeviceSettingsPage({super.key});

  @override
  State<DeviceSettingsPage> createState() => _DeviceSettingsPageState();
}

class _DeviceSettingsPageState extends State<DeviceSettingsPage> {
  String newSensorName = "";
  bool isSensorNameFieldFocus = false;
  String snackBarMessage = "";

  String selectedSensorId = "";
  String selectedSensorName = "";

  String allNewSensorName = "";
  String allNewSensorId = "";
  bool isAllNewSensorNameFieldFocus = false;
  bool isAllNewSensorIdFieldFocus = false;

  List<DeviceModel> devices = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void handleSensorNameChange(String value) {
    setState(() {
      newSensorName = value;
    });
  }

  void handleAllSensorNameChange(String value) {
    setState(() {
      allNewSensorName = value;
    });
  }

  void handleAllNewSensorIdChange(String value) {
    setState(() {
      allNewSensorId = value;
    });
  }

  void handleSensorNameFieldFocusChange(bool isFocused) {
    setState(() {
      isSensorNameFieldFocus = isFocused;
    });
  }

  void handleNewSensorIdFieldFocusChange(bool isFocused) {
    setState(() {
      isAllNewSensorIdFieldFocus = isFocused;
    });
  }

  void handleNewSensorNameFieldFocusChange(bool isFocused) {
    setState(() {
      isAllNewSensorNameFieldFocus = isFocused;
    });
  }

  void setSnackBarMessage(String value) {
    setState(() {
      snackBarMessage = value;
    });
  }

  void setSelectedSensor(String sensorId, String sensorName) {
    setState(() {
      selectedSensorId = sensorId;
      selectedSensorName = sensorName;
    });
  }

  void loadData() async {
    final allDevices = await DevicesController().getAllDevices();

    setState(() {
      devices = allDevices.devices ?? [];
    });
    print("devices: $devices");
  }

  void closeAllModalBottomSheet() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  bool isAbleToChangeSensorName() {
    return newSensorName != "" && newSensorName != selectedSensorName;
  }

  bool isAbleToAddNewSensor() {
    return allNewSensorName != "" && allNewSensorId != "";
  }

  void showDeleteDeviceAlertDialog(
      BuildContext context,
      String content,
      String cancelButtonText,
      String confirmationButtonText,
      VoidCallback? onTap,
      [String? title,
      bool? isDanger]) async {
    bool? dialogResult = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withOpacity(0),
      builder: (BuildContext context) {
        return CustomAlert(
            content: content,
            cancelButtonText: cancelButtonText,
            confirmationButtonText: confirmationButtonText,
            onTap: onTap);
      },
    );

    if (dialogResult == true) {
      var responseStatusCode =
          await DevicesController().deletePoolById(selectedSensorId);
      if (responseStatusCode == 200) {
        setSnackBarMessage("Alat berhasil dihapus");
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(CustomSnackBar().showSnackBar(snackBarMessage));
          Navigator.of(context).pop();
        }
        loadData();
      } else {
        setSnackBarMessage("Penghapusan alat gagal!");
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(CustomSnackBar().showSnackBar(snackBarMessage));
          Navigator.of(context).pop();
        }
      }
      setSnackBarMessage("");
      handleSensorNameChange("");
    }
  }

  void changeDeviceName(BuildContext context) async {
    int responseStatusCode = await DevicesController()
        .changeDeviceNameById(selectedSensorId, newSensorName);
    if (responseStatusCode == 200) {
      setSnackBarMessage("Nama berhasil diubah");
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBar().showSnackBar(snackBarMessage));
        closeAllModalBottomSheet();
      }
      loadData();
    } else {
      setSnackBarMessage("Pengubahan nama alat gagal!");
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBar().showSnackBar(snackBarMessage));
        closeAllModalBottomSheet();
      }
    }
    setSnackBarMessage("");
    setSelectedSensor("", "");
    handleSensorNameChange("");
  }

  void addNewDevice(BuildContext context) async {
    int responseStatusCode =
        await DevicesController().addNewPool(allNewSensorId, allNewSensorName);
    if (responseStatusCode == 200) {
      setSnackBarMessage("Alat berhasil ditambahkan");
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBar().showSnackBar(snackBarMessage));
        Navigator.of(context).pop();
      }
      loadData();
    } else {
      setSnackBarMessage("Penambahan alat gagal!");
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBar().showSnackBar(snackBarMessage));
        Navigator.of(context).pop();
      }
    }
    setSnackBarMessage("");
    handleSensorNameChange("");
  }

  @override
  Widget build(BuildContext context) {
    void changeSensorNameModalBottomSheet(BuildContext context) {
      handleSensorNameChange("");
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          barrierColor: Colors.black.withOpacity(0.4),
          builder: (context) {
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
                                  child: const iconoir.NavArrowLeft()),
                              const SizedBox(
                                width: 8,
                              ),
                              Text("Ubah Nama Alat",
                                  style: const TextStyleConstant().title03),
                            ],
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Nama Alat",
                                    style: const TextStyleConstant()
                                        .body03
                                        .copyWith(
                                            color: isSensorNameFieldFocus
                                                ? ColorConstant.colorssecondary
                                                : ColorConstant
                                                    .colorsNeutral50)),
                                const SizedBox(
                                  height: 4,
                                ),
                                Focus(
                                  onFocusChange: (isFocus) {
                                    setModalState(() {
                                      handleSensorNameFieldFocusChange(isFocus);
                                    });
                                  },
                                  child: Column(children: [
                                    TextField(
                                      onChanged: (value) {
                                        setModalState(() {
                                          handleSensorNameChange(
                                              value.toString());
                                        });
                                      },
                                      maxLength: 32,
                                      style: const TextStyleConstant().body02,
                                      decoration: InputDecoration(
                                        hintText: selectedSensorName,
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.all(12),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstant
                                                    .colorsNeutral50)),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstant
                                                    .colorssecondary)),
                                      ),
                                    ),
                                  ]),
                                )
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: AbsorbPointer(
                            absorbing: !isAbleToChangeSensorName(),
                            child: CustomButton(
                                isDisabled: !isAbleToChangeSensorName(),
                                onTap: () async {
                                  changeDeviceName(context);
                                },
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

    void sensorSettingModalBottomSheet(context) {
      showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          barrierColor: Colors.black.withOpacity(0.4),
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
                            child: const iconoir.Cancel()),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(selectedSensorName,
                            style: const TextStyleConstant().title03),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      changeSensorNameModalBottomSheet(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Ubah Nama Alat",
                              style: const TextStyleConstant().label02),
                          const iconoir.NavArrowRight(),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDeleteDeviceAlertDialog(
                          context,
                          "Apakah kamu yakin ingin menghapus alat ini?",
                          "Kembali",
                          "Hapus",
                          () {});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Hapus Alat",
                              style: const TextStyleConstant()
                                  .label02
                                  .copyWith(color: ColorConstant.colorsdanger)),
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

    void addSensorModalBottomSheet(BuildContext context) {
      handleAllNewSensorIdChange("");
      handleAllSensorNameChange("");
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          barrierColor: Colors.black.withOpacity(0.4),
          builder: (context) {
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
                              Text("Tambah Alat",
                                  style: const TextStyleConstant().title03),
                            ],
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("ID Alat",
                                    style: const TextStyleConstant()
                                        .body03
                                        .copyWith(
                                            color: isAllNewSensorIdFieldFocus
                                                ? ColorConstant.colorssecondary
                                                : ColorConstant
                                                    .colorsNeutral50)),
                                const SizedBox(
                                  height: 4,
                                ),
                                Focus(
                                  onFocusChange: (isFocus) {
                                    setModalState(() {
                                      handleNewSensorIdFieldFocusChange(
                                          isFocus);
                                    });
                                  },
                                  child: Column(children: [
                                    TextField(
                                      onChanged: (value) {
                                        setModalState(() {
                                          handleAllNewSensorIdChange(
                                              value.toString());
                                        });
                                      },
                                      maxLength: 32,
                                      style: const TextStyleConstant().body02,
                                      decoration: const InputDecoration(
                                        hintText: "ID Alat Baru",
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(12),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstant
                                                    .colorsNeutral50)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstant
                                                    .colorssecondary)),
                                      ),
                                    ),
                                  ]),
                                ),
                                Text("Nama Alat",
                                    style: const TextStyleConstant()
                                        .body03
                                        .copyWith(
                                            color: isAllNewSensorNameFieldFocus
                                                ? ColorConstant.colorssecondary
                                                : ColorConstant
                                                    .colorsNeutral50)),
                                const SizedBox(
                                  height: 4,
                                ),
                                Focus(
                                  onFocusChange: (isFocus) {
                                    setModalState(() {
                                      handleNewSensorNameFieldFocusChange(
                                          isFocus);
                                    });
                                  },
                                  child: Column(children: [
                                    TextField(
                                      onChanged: (value) {
                                        setModalState(() {
                                          handleAllSensorNameChange(
                                              value.toString());
                                        });
                                      },
                                      maxLength: 32,
                                      style: const TextStyleConstant().body02,
                                      decoration: const InputDecoration(
                                        hintText: "Nama Alat Baru",
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(12),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstant
                                                    .colorsNeutral50)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstant
                                                    .colorssecondary)),
                                      ),
                                    ),
                                  ]),
                                )
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: AbsorbPointer(
                            absorbing: !isAbleToAddNewSensor(),
                            child: CustomButton(
                                isDisabled: !isAbleToAddNewSensor(),
                                onTap: () async {
                                  addNewDevice(context);
                                },
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

    List<Tuple2<String, VoidCallback?>> getSensorList() {
      List<Tuple2<String, VoidCallback?>> sensorList = [];
      for (var device in devices) {
        sensorList.add(Tuple2<String, VoidCallback?>(device.name ?? "", () {
          setSelectedSensor(device.id ?? "", device.name ?? "");
          sensorSettingModalBottomSheet(context);
        }));
      }
      return sensorList;
    }

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const iconoir.NavArrowLeft()),
          title: Text(
            "Pengaturan Alat",
            style: const TextStyleConstant().title03,
          )),
      backgroundColor: ColorConstant.colorsVariant90,
      body: SafeArea(
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SafeArea(child: CustomListView(listItems: getSensorList())),
              Container(
                padding: EdgeInsets.fromLTRB(
                    16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
                color: Colors.white,
                child: CustomButton(
                  onTap: () {
                    addSensorModalBottomSheet(context);
                  },
                  text: "Tambah Alat",
                  backgroundColor: Colors.white,
                  foregroundColor: ColorConstant.colorsprimary,
                  borderColor: ColorConstant.colorsNeutral40,
                ),
              )
            ],
          )),
    );
  }
}
