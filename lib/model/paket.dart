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

  Pakets(
      {this.id,
      this.kodePaket,
      this.judul,
      this.tahun,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.keterangan,
      this.tglDeadline,
      this.kendala});

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
