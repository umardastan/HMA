import 'package:login/model/module.dart';

class Pakets {
  int? id;
  String? kodePaket;
  String? judul;
  String? tahun;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? keterangan;
  String? tglDeadline;
  String? kendala;
  // List<Module>? moduls;

  Pakets({
    this.id,
    this.kodePaket,
    this.judul,
    this.tahun,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.keterangan,
    this.tglDeadline,
    this.kendala,
    // this.moduls,
  });

  Pakets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kodePaket = json['kode_paket'];
    judul = json['judul'];
    tahun = json['tahun'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    keterangan = json['keterangan'];
    tglDeadline = json['tgl_deadline'];
    kendala = json['kendala'];
    // if (json['moduls'] != null) {
    //   moduls = <Module>[];
    //   json['sub_moduls'].forEach((v) {
    //     moduls!.add(Module.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['kode_paket'] = kodePaket;
    data['judul'] = judul;
    data['tahun'] = tahun;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['keterangan'] = keterangan;
    data['tgl_deadline'] = tglDeadline;
    data['kendala'] = kendala;
    // if (moduls != null) {
    //   data['moduls'] = moduls!.map((v) => v.toJson()).toList();
    // }
    return data;
  }

  @override
  toString() =>
      "id: $id, kode_paket: $kodePaket, judul: $judul, tahun: $tahun, keterangan: $keterangan, tgl_deadline: $tglDeadline, kendala: $kendala";

  selectSuggestion(paket) {}

  // untuk handle ketika masuk ke halaman edit pengguna data ada tapi terbaca tidak sama
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Pakets && other.id == id && other.judul == judul;
  }

  @override
  int get hashCode => id.hashCode ^ judul.hashCode;
}

// [
//   {
//     "id": 10,
//     "kode_paket": "ADM",
//     "judul": "Administrasi IT Dept.",
//     "tahun": "2024",
//     "created_at": "2024-04-03T03:50:51.000000Z",
//     "updated_at": "2024-04-04T08:22:31.000000Z",
//     "deleted_at": null,
//     "keterangan": "Administrasi IT Dept.",
//     "tgl_deadline": "",
//     "kendala": null,
//     "moduls": [],
//     "total_persen": 0,
//     "total_persen_v": 0,
//     "total_persen_hard_v": 0,
//     "sum_persen_all": 0,
//     "count_all": 700,
//     "total_persen_all": 0,
//   },
//   {
//     "id": 1,
//     "kode_paket": "P1",
//     "judul": "T1 13/6-Pengadaan Perangkat Sekuritas Influential Personal Berbasis Interference Signal pada Kejaksaan Republik Indonesia",
//     "tahun": "2024",
//     "created_at": "2024-04-03T02:15:20.000000Z",
//     "updated_at": "2024-10-27T22:44:20.000000Z",
//     "deleted_at": null,
//     "keterangan": "Pengadaan Perangkat Sekuritas Influential Personal Berbasis Interference Signal pada Kejaksaan Republik Indonesia\r\nNomor: SP-01/PPK.10/SARPRAS-2024/03/2024\r\nPekerjaan: 25 Maret 2024 - 1 September 2024 (180 hari) - Adendum Waktu\r\nPT. Argaphana Antar Nusa\r\nPPK: Hary Prasetyo, S.E\r\nPL: Anwar\r\nDirektur: M. Zaini\r\n\r\nKegiatan Pemeriksaan 60%= Done\r\nBerkas Laporan Progres Pekerjaan 60%=Done\r\nBerkas Berita Acara Pemeriksaan 60%=Done\r\n\r\nKegiatan Pemeriksaan 100%=\r\nBerkas Berita Acara Pemeriksaan 100%=\r\nBerkas Berita Acara Uji Fungsi 100%=\r\nBerkas Laporan Progres Pekerjaan 100%=\r\nBerkas BAST=\r\n\r\nPelatihan=\r\nBerkas Manual Book=",
//     "tgl_deadline": "20-09-2024",
//     "kendala": "Paket terkena adendum waktu dikarenakan ada keterlambatan unit fortuner (PIC Tim Sambas).\r\n\r\nAdendum waktu sampai dengan tanggal 25 Desember 2024",
//     "moduls": [],
//     "sum_persen_soft": 800,/
//     "count_soft": 800,/
//     "total_persen": 100,/
//     "sum_persen_soft_v": 800,/
//     "total_persen_v": 100,/
//     "sum_persen_hard_v": 753,/
//     "count_hard": 1000,/
//     "total_persen_hard_v": "75.30",/
//     "sum_persen_all": 1553,/
//     "count_all": 1800,
//     "total_persen_all": "86.28"
//   }
// ]
