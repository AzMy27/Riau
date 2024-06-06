import 'package:p11_tugas/evaluasi/Profile.dart';
import 'package:flutter/material.dart';

class EntryForm extends StatefulWidget {
  final Profile profile;
  const EntryForm(this.profile, {Key? key}) : super(key: key);
  @override
  _EntryFormState createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  Profile? _profile;
  _EntryFormState();
  final TextEditingController _logoController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _ibukotaController = TextEditingController();
  final TextEditingController _bupatiController = TextEditingController();
  final TextEditingController _luasController = TextEditingController();
  final TextEditingController _pendudukController = TextEditingController();
  final TextEditingController _kecamatanController = TextEditingController();
  final TextEditingController _kelurahanController = TextEditingController();
  final TextEditingController _desaController = TextEditingController();
  final TextEditingController _linkwebController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _profile = widget.profile;
    if (_profile!.nama != "") {
      _logoController.text = _profile!.logo;
      _namaController.text = _profile!.nama;
      _ibukotaController.text = _profile!.ibukota;
      _bupatiController.text = _profile!.bupati;
      _luasController.text = _profile!.luas;
      _pendudukController.text = _profile!.penduduk;
      _kecamatanController.text = _profile!.kecamatan;
      _kelurahanController.text = _profile!.kelurahan;
      _desaController.text = _profile!.desa;
      _linkwebController.text = _profile!.linkweb;
    }
    return Scaffold(
      appBar: AppBar(
        title: _profile!.nama == ""
            ? const Text('Tambah Data')
            : const Text('Ubah Data'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: _logoController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'URL Gambar',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: _namaController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: _ibukotaController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Ibukota',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: _bupatiController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Bupati/Walikota',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: _luasController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Luas',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: _pendudukController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Jumlah Penduduk',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: _kecamatanController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Kecamatan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: _kelurahanController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Kelurahan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: _desaController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Desa',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: _linkwebController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Website',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      child: const Text(
                        'Simpan',
                      ),
                      onPressed: () {
                        if (_profile == null) {
                          _profile = Profile(
                            _logoController.text,
                            _namaController.text,
                            _ibukotaController.text,
                            _bupatiController.text,
                            _luasController.text,
                            _pendudukController.text,
                            _kecamatanController.text,
                            _kelurahanController.text,
                            _desaController.text,
                            _linkwebController.text,
                          );
                        } else {
                          _profile?.logo = _logoController.text;
                          _profile?.nama = _namaController.text;
                          _profile?.ibukota = _ibukotaController.text;
                          _profile?.bupati = _bupatiController.text;
                          _profile?.luas = _luasController.text;
                          _profile?.penduduk = _pendudukController.text;
                          _profile?.kecamatan = _kecamatanController.text;
                          _profile?.kelurahan = _kelurahanController.text;
                          _profile?.desa = _desaController.text;
                          _profile?.linkweb = _linkwebController.text;
                        }
                        Navigator.pop(context, _profile);
                      },
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: const Text(
                        'Batal',
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
