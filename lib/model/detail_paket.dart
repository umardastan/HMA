class DetailPaket {
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
  List<Moduls>? moduls;
  String? totalPersen;
  String? sumPersenSoft;
  String? countSoft;
  String? totalPersenV;
  String? sumPersenSoftV;
  String? totalPersenHardV;
  String? countHard;
  String? sumPersenHardV;
  String? sumPersenAll;
  String? countAll;
  String? totalPersenAll;

  DetailPaket(
      {this.id,
      this.kodePaket,
      this.judul,
      this.tahun,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.keterangan,
      this.tglDeadline,
      this.kendala,
      this.moduls,
      this.totalPersen,
      this.sumPersenSoft,
      this.countSoft,
      this.totalPersenV,
      this.sumPersenSoftV,
      this.totalPersenHardV,
      this.countHard,
      this.sumPersenHardV,
      this.sumPersenAll,
      this.countAll,
      this.totalPersenAll});

  DetailPaket.fromJson(Map<String, dynamic> json) {
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
    if (json['moduls'] != null) {
      moduls = <Moduls>[];
      json['moduls'].forEach((v) {
        moduls!.add(Moduls.fromJson(v));
      });
    }
    totalPersen = json['total_persen'];
    sumPersenSoft = json['sum_persen_soft'];
    countSoft = json['count_soft'];
    totalPersenV = json['total_persen_v'];
    sumPersenSoftV = json['sum_persen_soft_v'];
    totalPersenHardV = json['total_persen_hard_v'];
    countHard = json['count_hard'];
    sumPersenHardV = json['sum_persen_hard_v'];
    sumPersenAll = json['sum_persen_all'];
    countAll = json['count_all'];
    totalPersenAll = json['total_persen_all'];
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
    if (moduls != null) {
      data['moduls'] = moduls!.map((v) => v.toJson()).toList();
    }
    data['total_persen'] = totalPersen;
    data['sum_persen_soft'] = sumPersenSoft;
    data['count_soft'] = countSoft;
    data['total_persen_v'] = totalPersenV;
    data['sum_persen_soft_v'] = sumPersenSoftV;
    data['total_persen_hard_v'] = totalPersenHardV;
    data['count_hard'] = countHard;
    data['sum_persen_hard_v'] = sumPersenHardV;
    data['sum_persen_all'] = sumPersenAll;
    data['count_all'] = countAll;
    data['total_persen_all'] = totalPersenAll;
    return data;
  }

  @override
  String toString() => '{id: $id, kode_paket: $kodePaket, judul: $judul, tahun: $tahun, modul: $moduls}';
}

// CONTOH DATA DETAIL PAKET
// {
//   "id": 10,
//   "kode_paket": "ADM",
//   "judul": "Administrasi IT Dept.",
//   "tahun": "2024",
//   "created_at": "2024-04-03T03:50:51.000000Z",
//   "updated_at": "2024-04-04T08:22:31.000000Z",
//   "deleted_at": null,
//   "keterangan": "Administrasi IT Dept.",
//   "tgl_deadline": "",
//   "kendala": null,
//   "moduls": [
//       {
//           "id": 2,
//           "paket_id": 10,
//           "jenis_modul": "All",
//           "kode_modul": "01",
//           "modul": "Surat Menyurat",
//           "created_at": "2003-04-24T08:49:00.000000Z",
//           "updated_at": "2024-04-04T08:11:06.000000Z",
//           "keterangan": "Persiapan, pembuatan dan pengelolaan surat menyurat IT Dept",
//           "persentase_hma": "0",
//           "persentase_vendor": "0",
//           "kendala": null,
//           "path": null,
//           "type": null,
//           "size": null,
//           "sub_moduls": []
//       },
//   ],
//   "total_persen": "0",
//   "sum_persen_soft": "0",
//   "count_soft": "0",
//   "total_persen_v": "0",
//   "sum_persen_soft_v": "0",
//   "total_persen_hard_v": "0",
//   "count_hard": "0",
//   "sum_persen_hard_v": "0",
//   "sum_persen_all": "0",
//   "count_all": "700",
//   "total_persen_all": "0"
// },

class Moduls {
  int? id;
  int? paketId;
  String? jenisModul;
  String? kodeModul;
  String? modul;
  String? createdAt;
  String? updatedAt;
  String? keterangan;
  String? persentaseHma;
  String? persentaseVendor;
  String? kendala;
  String? path;
  String? type;
  int? size;
  List<Moduls>? subModuls;

  Moduls(
      {this.id,
      this.paketId,
      this.jenisModul,
      this.kodeModul,
      this.modul,
      this.createdAt,
      this.updatedAt,
      this.keterangan,
      this.persentaseHma,
      this.persentaseVendor,
      this.kendala,
      this.path,
      this.type,
      this.size,
      this.subModuls});

  Moduls.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paketId = json['paket_id'];
    jenisModul = json['jenis_modul'];
    kodeModul = json['kode_modul'];
    modul = json['modul'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    keterangan = json['keterangan'];
    persentaseHma = json['persentase_hma'];
    persentaseVendor = json['persentase_vendor'];
    kendala = json['kendala'];
    path = json['path'];
    type = json['type'];
    size = json['size'];
    if (json['sub_moduls'] != null) {
      subModuls = <Moduls>[];
      json['sub_moduls'].forEach((v) {
        subModuls!.add(Moduls.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['paket_id'] = paketId;
    data['jenis_modul'] = jenisModul;
    data['kode_modul'] = kodeModul;
    data['modul'] = modul;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['keterangan'] = keterangan;
    data['persentase_hma'] = persentaseHma;
    data['persentase_vendor'] = persentaseVendor;
    data['kendala'] = kendala;
    data['path'] = path;
    data['type'] = type;
    data['size'] = size;
    if (subModuls != null) {
      data['sub_moduls'] = subModuls!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() =>
      "{id: $id, paket_id: $paketId, jenis_module: $jenisModul, kode_modul: $kodeModul}";
}

// CONTOH DATA MODULS
// {
//   "id": 138,
//   "paket_id": 6,
//   "jenis_modul": "Hardware",
//   "kode_modul": "A3",
//   "modul": "Fingerprint scanner 10 FP with membrane - 66 Unit",
//   "created_at": "2003-04-24T08:49:00.000000Z",
//   "updated_at": "2024-08-30T09:32:53.000000Z",
//   "keterangan": null,
//   "persentase_hma": "0",
//   "persentase_vendor": "90",
//   "kendala": "Digudang E23",
//   "path": "modul_1724728619",
//   "type": "png",
//   "size": 908141,
//   "sub_moduls": []
// },