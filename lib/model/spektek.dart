import 'package:login/model/module.dart';
import 'package:login/model/paket.dart';

class Spektek {
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
  int? subModulId;
  List<Module>? subModul;
  Pakets? pakets;

  Spektek(
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
      this.subModulId,
      this.subModul,
      this.pakets});

  Spektek.fromJson(Map<String, dynamic> json) {
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
    subModulId = json['sub_modul_id'];
    subModul = json['sub_modul'];
    pakets = json['pakets'] != null ? Pakets.fromJson(json['pakets']) : null;
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
    data['sub_modul_id'] = subModulId;
    data['sub_modul'] = subModul;
    if (pakets != null) {
      data['pakets'] = pakets!.toJson();
    }
    return data;
  }

  @override
  String toString() =>
      "{id: $id, paket_id: $paketId, jenis_module: $jenisModul, kode_module: $kodeModul}";
}
