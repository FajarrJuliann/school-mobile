import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_mobile/app/routes/app_pages.dart';
import '../controllers/list_sekolah_controller.dart';

class ListSekolahView extends GetView<ListSekolahController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.offAllNamed(Routes.MAIN_PAGE);
          },
        ),
        title: Container(
          margin: EdgeInsets.only(right: 10),
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller.searchController,
            onChanged: (value) {
              controller.onSearchChanged(
                  value); // Panggil pencarian setiap input berubah
            },
            decoration: InputDecoration(
              hintText: "Cari sekolah...",
              suffixIcon: Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
          ),
        ),
        titleSpacing: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.sekolahList.isEmpty) {
          return Center(child: Text("Tidak ada data sekolah"));
        }

        return Padding(
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Dua kolom
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7, // Menyesuaikan tinggi dan lebar card
            ),
            itemCount: controller.sekolahList.length,
            itemBuilder: (context, index) {
              var sekolah = controller.sekolahList[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipRRect(
                          // Atur radius sesuai keinginan
                          child: Image.asset(
                            'assets/images/logo-sekolah.png',
                            width: 100, // Sesuaikan ukuran gambar
                            height: 100,
                            fit: BoxFit
                                .cover, // Agar gambar menyesuaikan ukuran dengan baik
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        sekolah.sekolah,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        sekolah.alamatJalan,
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 14, color: Colors.red),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              sekolah.kabupatenKota,
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.star, size: 14, color: Colors.amber),
                          SizedBox(width: 5),
                          Text(sekolah.propinsi,
                              style: TextStyle(fontSize: 10)),
                          SizedBox(width: 10),
                        ],
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          // Get.toNamed(Routes.LIST_SEKOLAH);
                          Get.toNamed(Routes.SEKOLAH_DETAIL,
                              arguments: sekolah.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: Size(double.infinity, 30),
                        ),
                        child: Text("Lihat Sekolah",
                            style:
                                TextStyle(fontSize: 12, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
