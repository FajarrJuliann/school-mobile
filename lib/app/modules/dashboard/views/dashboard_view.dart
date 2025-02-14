import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Get.snackbar("Notifikasi", "Belum ada notifikasi baru");
            },
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
                height: 200.0,
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
                              child: Icon(category['icon'], size: 30),
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

            SizedBox(height: 20),

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
                          width: 170,
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
                                    "Rating: 4.5",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  SizedBox(width: 10),
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
                                  backgroundColor: Colors.blue,
                                  minimumSize: Size(double.infinity, 30),
                                ),
                                child: Text(
                                  "Buka Pendaftaran",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
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
          ],
        ),
      ),
    );
  }
}
