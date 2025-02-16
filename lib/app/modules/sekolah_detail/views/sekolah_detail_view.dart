import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:school_mobile/app/data/provider/user_provider.dart';
import '../controllers/sekolah_detail_controller.dart';
import 'package:marquee/marquee.dart';
import 'package:url_launcher/url_launcher.dart';

void openGoogleMaps(double lat, double lng) async {
  final Uri url =
      Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    debugPrint("Tidak dapat membuka Google Maps.");
  }
}

class SekolahDetailView extends GetView<SekolahDetailController> {
  const SekolahDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Jumlah tab
      child: Scaffold(
        appBar: AppBar(
          actions: [
            /// **Container untuk membungkus dua ikon dengan pembatas**
            Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.black26), // Outline hitam pudar
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: 2, vertical: 2), // Mengurangi padding
              margin: EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Supaya ukuran sekecil mungkin
                children: [
                  /// **Ikon Titik Tiga Horizontal (More Options)**
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: Icon(Icons.settings),
                                title: Text("Pengaturan"),
                                onTap: () {
                                  Get.back(); // Tutup Bottom Sheet
                                  Get.snackbar("Pengaturan",
                                      "Menu pengaturan belum tersedia");
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.help_outline),
                                title: Text("Bantuan"),
                                onTap: () {
                                  Get.back();
                                  Get.snackbar(
                                      "Bantuan", "Menu bantuan belum tersedia");
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.logout),
                                title: Text("Keluar"),
                                onTap: () async {
                                  Get.back(); // Tutup Bottom Sheet

                                  // **Tampilkan Dialog Konfirmasi**
                                  Get.defaultDialog(
                                    title: "Konfirmasi Logout",
                                    middleText:
                                        "Apakah Anda yakin ingin keluar?",
                                    textConfirm: "Ya",
                                    textCancel: "Batal",
                                    confirmTextColor: Colors.white,
                                    onConfirm: () async {
                                      final userProvider = UserProvider();
                                      await userProvider
                                          .logout(); // Hapus token

                                      Get.offAllNamed(
                                          '/login'); // Redirect ke login
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        backgroundColor:
                            Colors.transparent, // Agar tampilan lebih menarik
                        isScrollControlled:
                            true, // Bisa diperbesar jika kontennya banyak
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4), // Mengurangi jarak antar ikon
                      child: Icon(Icons.more_horiz,
                          size: 22), // Mengecilkan ukuran ikon
                    ),
                  ),
                  SizedBox(width: 5),

                  /// **Pembatas Vertical**
                  Container(
                    height: 20, // Mengecilkan tinggi pembatas
                    width: 1,
                    color: Colors.black26, // Warna hitam pudar
                  ),

                  /// **Ikon Close Outlined**
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10), // Mengurangi jarak antar ikon
                    child: GestureDetector(
                      onTap: () {
                        Get.back(); // Untuk kembali ke halaman sebelumnya
                      },
                      child: Icon(Icons.close,
                          size: 22), // Mengecilkan ukuran ikon
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Obx(() {
          if (!controller.isConnected.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_off, size: 50, color: Colors.red),
                  SizedBox(height: 10),
                  Text(
                    "Tidak ada koneksi internet",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => controller.checkInternetConnection(),
                    child: Text("Coba Lagi"),
                  ),
                ],
              ),
            );
          }

          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          final sekolah = controller.sekolah.value;
          double latitude = double.tryParse(sekolah.lintang) ?? 0.0;
          double longitude = double.tryParse(sekolah.bujur) ?? 0.0;

          if (latitude == 0.0 || longitude == 0.0) {
            debugPrint(
                "Warning: Koordinat tidak valid! Menggunakan default koordinat.");
            latitude = -6.2088; // Jakarta
            longitude = 106.8456;
          }

          return Column(
            children: [
              // Nama Sekolah dengan Running Text
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.blueGrey],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Marquee(
                  text: "Selamat Datang di ${sekolah.sekolah}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  blankSpace: 80.0,
                  velocity: 30.0,
                  pauseAfterRound: Duration(seconds: 1),
                  startPadding: 10.0,
                ),
              ),

              // Peta
              Container(
                height: 300,
                width: double.infinity,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: GestureDetector(
                  onTap: () {
                    openGoogleMaps(latitude, longitude);
                  },
                  child: Stack(
                    children: [
                      AbsorbPointer(
                        absorbing: true,
                        child: FlutterMap(
                          mapController: MapController(),
                          options: MapOptions(
                            initialCenter: LatLng(latitude, longitude),
                            initialZoom: 15,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: LatLng(latitude, longitude),
                                  child: Icon(
                                    Icons.location_pin,
                                    size: 50,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // TabBar
              TabBar(
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.black54,
                indicatorColor: Colors.blue,
                indicatorSize:
                    TabBarIndicatorSize.tab, // Menjadikan garis indikator full
                tabs: [
                  Tab(text: "Profil"),
                  Tab(text: "Info Pendaftaran"),
                ],
              ),

              // TabBar View
              Expanded(
                child: TabBarView(
                  children: [
                    // Tab Profil Sekolah
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Card dengan Logo Sekolah dan Informasi
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 4,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    // Logo Sekolah di Kiri
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        'assets/images/logo-sekolah.png',
                                        width: 100, // Sesuaikan ukuran gambar
                                        height: 100,
                                        fit: BoxFit
                                            .cover, // Agar gambar menyesuaikan ukuran dengan baik
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            15), // Jarak antara logo dan teks

                                    // Informasi Sekolah di Kanan
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            sekolah.sekolah,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.star,
                                                  size: 14,
                                                  color: Colors.amber),
                                              SizedBox(width: 5),
                                              Text(sekolah.npsn,
                                                  style:
                                                      TextStyle(fontSize: 10)),
                                              SizedBox(width: 10),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.location_on,
                                                  size: 14, color: Colors.red),
                                              SizedBox(width: 5),
                                              Expanded(
                                                child: Text(
                                                  sekolah.kecamatan,
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),

                    // Tab Info Pendaftaran
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Card untuk Informasi Pendaftaran
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Judul Informasi
                                    Row(
                                      children: [
                                        Icon(Icons.info, color: Colors.blue),
                                        SizedBox(width: 8),
                                        Text(
                                          "Informasi Pendaftaran",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),

                                    // Tanggal Pendaftaran
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text:
                                                  "📌 Pendaftaran dibuka mulai "),
                                          TextSpan(
                                            text: "1 Maret - 30 April 2025.",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 15),

                                    // Syarat Pendaftaran
                                    Row(
                                      children: [
                                        Icon(Icons.check_circle,
                                            color: Colors.green),
                                        SizedBox(width: 8),
                                        Text(
                                          "Syarat Pendaftaran:",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),

                                    // List Syarat Pendaftaran dengan Icon
                                    Padding(
                                      padding: EdgeInsets.only(left: 25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          syaratItem("Fotokopi Akta Kelahiran"),
                                          syaratItem("Fotokopi Kartu Keluarga"),
                                          syaratItem("Pas Foto 3x4 (3 lembar)"),
                                          syaratItem(
                                              "Ijazah SD/SMP (jika ada)"),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),

                                    // Tombol Daftar Sekarang
                                    Center(
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          // Aksi pendaftaran
                                        },
                                        icon: Icon(Icons.app_registration,
                                            color: Colors.white),
                                        label: Text(
                                          "Daftar Sekarang",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 40, vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

// Widget untuk menampilkan syarat dengan icon
Widget syaratItem(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Icon(Icons.check, color: Colors.green, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    ),
  );
}
