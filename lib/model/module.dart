class Module {
  int? id;
  int? paketId;
  String? jenisModul;
  String? kodeModul;
  String? modul;
  String? createdAt;
  String? updatedAt;
  String? keterangan;
  int? persentaseHma;
  int? persentaseVendor;
  String? kendala;
  String? path;
  String? type;
  int? size;
  List<Module>? subModuls;

  Module({
    this.id,
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
    this.subModuls,
  });

  Module.fromJson(Map<String, dynamic> json) {
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
      subModuls = <Module>[];
      json['sub_moduls'].forEach((v) {
        subModuls!.add(Module.fromJson(v));
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
      data['pivot_pakets'] = subModuls!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  toString() =>
      "{id: $id, paket_id: $paketId, jenis_modul: $jenisModul}, kode_modul: $kodeModul, modul:$modul";
}

// CONTOH DATA
// {
//   "id": 11,
//   "paket_id": 1,
//   "jenis_modul": "Hardware",
//   "kode_modul": "08",
//   "modul": "Perangkat Taktis (OBD +Radio + Transmiter WFii +Internet) - 16 Paket",
//   "created_at": "2003-04-24T08:49:00.000000Z",
//   "updated_at": "2024-10-27T22:58:39.000000Z",
//   "keterangan": "16 Paket",
//   "persentase_hma": 0,
//   "persentase_vendor": 80,
//   "kendala": "Barang sudah di karoseri 16 unit tapi baru 2 unit yang terpasang",
//   "path": "modul_1725278664",
//   "type": "png",
//   "size": 560445,
//   "sub_moduls": []
// },