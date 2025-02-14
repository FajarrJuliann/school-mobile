// To parse this JSON data, do
//
//     final sekolah = sekolahFromJson(jsonString);

import 'dart:convert';

Sekolah sekolahFromJson(String str) => Sekolah.fromJson(json.decode(str));

String sekolahToJson(Sekolah data) => json.encode(data.toJson());

class Sekolah {
  int id;
  String kodeProp;
  String propinsi;
  String kodeKabKota;
  String kabupatenKota;
  String kodeKec;
  String kecamatan;
  String npsn;
  String sekolah;
  String bentuk;
  String status;
  String alamatJalan;
  String lintang;
  String bujur;
  DateTime createdAt;
  DateTime updatedAt;
  String isDelete;

  Sekolah({
    required this.id,
    required this.kodeProp,
    required this.propinsi,
    required this.kodeKabKota,
    required this.kabupatenKota,
    required this.kodeKec,
    required this.kecamatan,
    required this.npsn,
    required this.sekolah,
    required this.bentuk,
    required this.status,
    required this.alamatJalan,
    required this.lintang,
    required this.bujur,
    required this.createdAt,
    required this.updatedAt,
    required this.isDelete,
  });

  factory Sekolah.fromJson(Map<String, dynamic> json) => Sekolah(
        id: json["id"] ?? 0,
        kodeProp: json["kode_prop"] ?? "",
        propinsi: json["propinsi"] ?? "",
        kodeKabKota: json["kode_kab_kota"] ?? "",
        kabupatenKota: json["kabupaten_kota"] ?? "",
        kodeKec: json["kode_kec"] ?? "",
        kecamatan: json["kecamatan"] ?? "",
        npsn: json["npsn"] ?? "",
        sekolah: json["sekolah"] ?? "",
        bentuk: json["bentuk"] ?? "",
        status: json["status"] ?? "",
        alamatJalan: json["alamat_jalan"] ?? "",
        lintang: json["lintang"] ?? "",
        bujur: json["bujur"] ?? "",
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : DateTime.now(),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : DateTime.now(),
        isDelete: json["is_delete"] ??
            "0", // Sesuaikan dengan nilai default yang sesuai
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode_prop": kodeProp,
        "propinsi": propinsi,
        "kode_kab_kota": kodeKabKota,
        "kabupaten_kota": kabupatenKota,
        "kode_kec": kodeKec,
        "kecamatan": kecamatan,
        "npsn": npsn,
        "sekolah": sekolah,
        "bentuk": bentuk,
        "status": status,
        "alamat_jalan": alamatJalan,
        "lintang": lintang,
        "bujur": bujur,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_delete": isDelete,
      };
}
