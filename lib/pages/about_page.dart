import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:smart_water_meter/enums/text_style_constant.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    String content =
        '''IkanKu adalah sebuah aplikasi yang dirancang untuk memantau kondisi kolam ikan. Aplikasi ini terintegrasi dengan sensor pintar yang dapat mendeteksi suhu air, kadar pH, salinitas, kadar oksigen terlarut, kekeruhan, dan kadar amonia di dalam air. Dengan adanya IkanKu, para peternak ikan tidak perlu lagi khawatir mengalami kegagalan panen karena mereka dapat memantau kondisi kolam secara real-time melalui aplikasi ini.

Aplikasi ini sangat bermanfaat bagi para peternak ikan karena mereka dapat memantau kondisi kolam dari jarak jauh, tanpa harus mengunjungi kolam fisik mereka. IkanKu juga memungkinkan para peternak ikan untuk mengambil tindakan yang diperlukan jika terdapat masalah dalam kondisi kolam. Dengan memantau kondisi kolam secara teratur melalui aplikasi ini, para peternak ikan dapat meminimalkan risiko kehilangan ikan mereka akibat kondisi yang tidak sesuai.

Untuk menghubungkan sensor pintar dengan aplikasi ini, para pengguna dapat melakukan pairing melalui aplikasi. Hal ini memudahkan pengguna dalam menghubungkan sensor pintar dengan aplikasi tanpa perlu repot-repot memasukkan kode khusus atau melakukan konfigurasi yang rumit. Dengan memanfaatkan teknologi canggih yang dimiliki oleh IkanKu, para peternak ikan dapat meningkatkan produktivitas dan efisiensi dalam usaha budidaya ikan mereka.''';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const iconoir.NavArrowLeft()),
        title: Text(
          "Tentang Aplikasi",
          style: const TextStyleConstant().title03,
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                width: width,
                image: const AssetImage("assets/about-banner.png"),
                fit: BoxFit.fitWidth,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Aplikasi IkanKu",
                      style: const TextStyleConstant().heading03,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Text(
                      content,
                      style: const TextStyleConstant().paragraph02,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
