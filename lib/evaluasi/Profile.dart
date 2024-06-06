class Profile {
  int? id;
  late String logo;
  late String nama;
  late String ibukota;
  late String bupati;
  late String luas;
  late String penduduk;
  late String kecamatan;
  late String kelurahan;
  late String desa;
  late String linkweb;

  Profile(
    this.logo,
    this.nama,
    this.ibukota,
    this.bupati,
    this.luas,
    this.penduduk,
    this.kecamatan,
    this.kelurahan,
    this.desa,
    this.linkweb,
  );

  Profile.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    logo = map['logo'];
    nama = map['nama'];
    ibukota = map['ibukota'];
    bupati = map['bupati'];
    luas = map['luas'];
    penduduk = map['penduduk'];
    kecamatan = map['kecamatan'];
    kelurahan = map['kelurahan'];
    desa = map['desa'];
    linkweb = map['linkweb'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'logo': logo,
      'nama': nama,
      'ibukota': ibukota,
      'bupati': bupati,
      'luas': luas,
      'penduduk': penduduk,
      'kecamatan': kecamatan,
      'kelurahan': kelurahan,
      'desa': desa,
      'linkweb': linkweb,
    };
  }

  @override
  String toString() {
    return 'Profile{id: $id, nama: $nama, ibukota: $ibukota, bupati: $bupati, luas: $luas, penduduk: $penduduk, kecamatan: $kecamatan, kelurahan: $kelurahan, desa: $desa, linkweb: $linkweb}';
  }
}
