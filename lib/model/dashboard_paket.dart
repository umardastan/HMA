class DashboardPaketModel {
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
  String? projectLeader;
  String? sumPersenSoft;
  String? countSoft;
  String? totalPersen;
  String? sumPersenSoftV;
  String? totalPersenV;
  String? sumPersenHardV;
  String? countHard;
  String? totalPersenHardV;
  String? sumPersenAll;
  String? countAll;
  String? totalPersenAll;

  DashboardPaketModel({
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
    this.projectLeader,
    this.sumPersenSoft,
    this.countSoft,
    this.totalPersen, //sofware HMA
    this.sumPersenSoftV,
    this.totalPersenV, // software Vendor
    this.sumPersenHardV,
    this.countHard,
    this.totalPersenHardV, // hardware
    this.sumPersenAll,
    this.countAll,
    this.totalPersenAll, // SH Vendor
  });

  DashboardPaketModel.fromJson(Map<String, dynamic> json) {
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
    projectLeader = json['project_leader'];
    sumPersenSoft = json['sum_persen_soft'];
    countSoft = json['count_soft'];
    totalPersen = json['total_persen'];
    sumPersenSoftV = json['sum_persen_soft_v'];
    totalPersenV = json['total_persen_v'];
    sumPersenHardV = json['sum_persen_hard_v'];
    countHard = json['count_hard'];
    totalPersenHardV = json['total_persen_hard_v'];
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
    data['project_leader'] = projectLeader;
    data['sum_persen_soft'] = sumPersenSoft;
    data['count_soft'] = countSoft;
    data['total_persen'] = totalPersen;
    data['sum_persen_soft_v'] = sumPersenSoftV;
    data['total_persen_v'] = totalPersenV;
    data['sum_persen_hard_v'] = sumPersenHardV;
    data['count_hard'] = countHard;
    data['total_persen_hard_v'] = totalPersenHardV;
    data['sum_persen_all'] = sumPersenAll;
    data['count_all'] = countAll;
    data['total_persen_all'] = totalPersenAll;
    return data;
  }

  @override
  toString() =>
      '{id: $id, kode_paket: $kodePaket, tahun: $tahun, project_leader: $projectLeader}';
}
