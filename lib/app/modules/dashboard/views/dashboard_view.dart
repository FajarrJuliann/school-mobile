import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_mobile/app/data/provider/user_provider.dart';
import 'package:school_mobile/app/data/utils/color.dart';
import 'package:school_mobile/app/routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imageList = [
      'assets/images/info1.png',
      'assets/images/info2.jpg',
      'assets/images/info3.jpg',
    ];

    final List<Map<String, dynamic>> categories = [
      {'name': 'Prasekolah', 'icon': Icons.child_care},
      {'name': 'SD | MI', 'icon': Icons.school},
      {'name': 'SMP | MTS', 'icon': Icons.business},
      {'name': 'SMA | MA', 'icon': Icons.account_balance},
      {'name': 'SMK | MAK', 'icon': Icons.build},
      {'name': 'KAMPUS', 'icon': Icons.location_city},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: SizedBox(
          height: 40,
          child: TextField(
            decoration: InputDecoration(
              hintText: "Cari sekolah...",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
        ),
        actions: [
          /// **Container untuk membungkus dua ikon dengan pembatas**
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26), // Outline hitam pudar
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
                                  middleText: "Apakah Anda yakin ingin keluar?",
                                  textConfirm: "Ya",
                                  textCancel: "Batal",
                                  confirmTextColor: Colors.white,
                                  onConfirm: () async {
                                    final userProvider = UserProvider();
                                    await userProvider.logout(); // Hapus token

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
                      Get.snackbar(
                        "Maintenance",
                        "Fitur sedang dalam masa perkembangan",
                      );
                    },
                    child: Icon(Icons.notifications,
                        size: 22), // Mengecilkan ukuran ikon
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),

            /// **Carousel Slider**
            CarouselSlider(
              options: CarouselOptions(
                height: 170.0,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayInterval: Duration(seconds: 3),
                viewportFraction: 0.8,
              ),
              items: imageList.map((item) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    item,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 20),

            /// **Kategori Sekolah (Horizontal Scroll)**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(Icons.category,
                      size: 20, color: Colors.black), // Ikon sebelum teks
                  SizedBox(width: 5), // Jarak antara ikon dan teks
                  Text(
                    "Kategori Sekolah",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.snackbar("Kategori", "Fitur Belum Tersedia");
                            // Bisa diarahkan ke halaman lain dengan Get.toNamed()
                            // Get.toNamed(Routes.KATEGORI, arguments: category['name']);
                          },
                          child: Card(
                            shape: CircleBorder(),
                            color: Colors.white,
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Icon(category['icon'], size: 18),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          category['name'],
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 5),

            /// **Rekomendasi Sekolah (Horizontal Scroll)**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.school,
                          size: 20, color: Colors.black), // Ikon sebelum teks
                      SizedBox(width: 5), // Jarak antara ikon dan teks
                      Text(
                        "Rekomendasi Sekolah",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAllNamed(Routes.LIST_SEKOLAH);
                    },
                    child: Row(
                      children: [
                        Text(
                          "Lihat Semua",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.arrow_forward_ios,
                            size: 16, color: Colors.black),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            // Rekomen List
            SizedBox(
              height: 250,
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (controller.sekolahList.isEmpty) {
                  return Center(child: Text("Tidak ada data sekolah"));
                }

                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: controller.sekolahList.map((school) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Container(
                          width: 150,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // **Logo di tengah (Sementara menggunakan placeholder)**
                              Center(
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/info1.png'),
                                  radius: 30,
                                ),
                              ),
                              SizedBox(height: 20),

                              // **Nama Sekolah & Alamat**
                              Text(
                                school.sekolah,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                                overflow:
                                    TextOverflow.ellipsis, // Handle overflow
                              ),
                              Text(
                                school.alamatJalan,
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                                overflow:
                                    TextOverflow.ellipsis, // Handle overflow
                              ),
                              SizedBox(height: 15),

                              // **Kota**
                              Row(
                                children: [
                                  Icon(Icons.location_on,
                                      size: 14, color: Colors.red),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      school.kabupatenKota,
                                      style: TextStyle(fontSize: 12),
                                      overflow: TextOverflow
                                          .ellipsis, // Handle overflow
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              // **Rating & Akreditasi**
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      size: 14, color: Colors.amber),
                                  SizedBox(width: 5),
                                  Text(
                                    "Akreditasi: A",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              // **Tombol Pendaftaran**
                              ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(Routes.LIST_SEKOLAH);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColor,
                                  minimumSize: Size(double.infinity, 30),
                                ),
                                child: Text(
                                  "Buka Pendaftaran",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
            ),

            SizedBox(height: 20),

            /// Reward
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(Icons.star, size: 20, color: Colors.black),
                  SizedBox(width: 5),
                  Text(
                    "Dapatkan Reward",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            /// **Card Utama yang berisi Scrollable Cards**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.black], // Warna gradasi
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26, // Bayangan untuk efek depth
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Card(
                  color: Colors
                      .transparent, // Biar warna card tidak menutupi gradasi
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation:
                      0, // Hilangkan elevation agar bayangan hanya dari Container
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// **Judul dengan Ikon**
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Membuat ikon ke kanan
                            children: [
                              /// **Ikon Promo & Teks**
                              Row(
                                children: [
                                  Icon(Icons.local_offer,
                                      color: Colors.white, size: 24),
                                  SizedBox(width: 8),
                                  Text(
                                    "Potongan Harga",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors
                                          .white, // Kontras dengan background
                                    ),
                                  ),
                                ],
                              ),

                              /// **Ikon Panah Kanan dengan Background Bulat Putih**
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white, // Background bulat putih
                                  shape: BoxShape.circle, // Bentuk bulat
                                ),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: Colors.black, size: 18),
                              ),
                            ],
                          ),
                        ),

                        /// **ScrollView untuk 2 Card di dalam Card Utama**
                        SizedBox(
                          height: 120,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              /// **Card Diskon 1**
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 2,
                                  child: SizedBox(
                                    width: 300,
                                    height: 120,
                                    child: Row(
                                      children: [
                                        /// **Gambar Diskon**
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                          child: Image.asset(
                                            'assets/images/info1.png',
                                            width: 150,
                                            height: 120,
                                            fit: BoxFit.cover,
                                          ),
                                        ),

                                        /// **Teks Promo**
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Diskon 50% Biaya Semester",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  "Berlaku hingga 30 April 2025",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              /// **Card Diskon 2**
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 2,
                                  child: SizedBox(
                                    width: 300,
                                    height: 120,
                                    child: Row(
                                      children: [
                                        /// **Gambar Beasiswa**
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                          child: Image.asset(
                                            'assets/images/info1.png',
                                            width: 150,
                                            height: 120,
                                            fit: BoxFit.cover,
                                          ),
                                        ),

                                        /// **Teks Promo**
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Beasiswa 100% Kuliah Gratis",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  "Kuota terbatas, daftar sekarang!",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
