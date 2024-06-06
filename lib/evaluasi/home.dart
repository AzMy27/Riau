import 'package:flutter/material.dart';
import 'package:p11_tugas/evaluasi/Profile.dart';
import 'package:p11_tugas/evaluasi/db_helpers.dart';
import 'package:p11_tugas/evaluasi/entry_form.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _count = 0;
  List<Profile> _profileList = [];
  List<Profile> _filteredprofileList = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterprofiles);
    updateListView();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterprofiles() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredprofileList = _profileList;
      } else {
        _filteredprofileList = _profileList
            .where((profile) => profile.nama
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evaluasi Modul 11'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search profiles',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: createListView(),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          tooltip: 'Tambah Profile',
          onPressed: () async {
            var profile = await navigateToEntryForm(
                context, Profile("", "", "", "", "", "", "", "", "", ""));
            addprofile(profile);
          }),
    );
  }

  Future<Profile> navigateToEntryForm(
      BuildContext context, Profile profile) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return EntryForm(profile);
        },
      ),
    );
    return result;
  }

  ListView createListView() {
    return ListView.builder(
      itemCount: _filteredprofileList.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 2.0,
          child: ListTile(
            leading: Container(
              width: 50, // Set the desired width
              height: 50, // Set the desired height
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(_filteredprofileList[index].logo),
                  fit: BoxFit.cover, // Adjust image fit
                ),
                borderRadius:
                    BorderRadius.circular(8), // Adjust border radius as needed
              ),
            ),
            title: Text(
              _filteredprofileList[index].nama,
            ),
            subtitle: Text(
              _filteredprofileList[index].ibukota.toString(),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: const Icon(Icons.edit),
                  onTap: () async {
                    var profile = await navigateToEntryForm(
                      context,
                      _filteredprofileList[index],
                    );
                    editprofile(profile);
                  },
                ),
                SizedBox(width: 8),
                GestureDetector(
                  child: const Icon(Icons.delete),
                  onTap: () {
                    deleteprofile(_filteredprofileList[index].id!);
                  },
                ),
              ],
            ),
            onTap: () async {
              var profile = await navigateToProfileInfo(
                context,
                _filteredprofileList[index],
              );
              // Tambahkan fungsi untuk menampilkan informasi profile
              showProfileInfoDialog(context, profile);
            },
          ),
        );
      },
    );
  }

  Future<void> showProfileInfoDialog(
      BuildContext context, Profile profile) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Center(
                child: Image.network(
                  profile.logo,
                  width: 150, // Atur lebar gambar sesuai kebutuhan
                  height: 200, // Atur tinggi gambar sesuai kebutuhan
                  fit: BoxFit.cover, // Sesuaikan tampilan gambar
                ),
              ),
              SizedBox(height: 10), // Jarak antara logo dan teks
              Text('Profile'),
            ],
          ),
          content: SingleChildScrollView(
            child: DataTable(
              columns: [
                DataColumn(label: Text('')),
                DataColumn(label: Text('')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('Nama')),
                  DataCell(Text(profile.nama)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Ibukota')),
                  DataCell(Text(profile.ibukota)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Bupati/Walikota')),
                  DataCell(Text(profile.bupati)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Luas')),
                  DataCell(Text(profile.luas)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Jumlah Penduduk')),
                  DataCell(Text(profile.penduduk.toString())),
                ]),
                DataRow(cells: [
                  DataCell(Text('Kecamatan')),
                  DataCell(Text(profile.kecamatan)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Kelurahan')),
                  DataCell(Text(profile.kelurahan)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Desa')),
                  DataCell(Text(profile.desa)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Website')),
                  DataCell(
                    GestureDetector(
                      onTap: () {
                        launchURL(profile.linkweb);
                      },
                      child: Tooltip(
                        message: "Kunjungi situs web",
                        child: Text(
                          profile.linkweb,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<Profile> navigateToProfileInfo(
      BuildContext context, Profile profile) async {
    // Anda bisa menambahkan halaman khusus untuk menampilkan info profile jika diperlukan
    return profile;
  }

  void addprofile(Profile profile) async {
    int result = await DbHelper.insert(profile);
    if (result > 0) {
      updateListView();
    }
  }

  void editprofile(Profile profile) async {
    int result = await DbHelper.update(profile);
    if (result > 0) {
      updateListView();
    }
  }

  void deleteprofile(int id) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi"),
          content: Text("Anda yakin ingin menghapus profile ini?"),
          actions: <Widget>[
            TextButton(
              child: Text("Hapus"),
              onPressed: () async {
                Navigator.of(context).pop();
                int result = await DbHelper.delete(id);
                if (result > 0) {
                  updateListView();
                }
              },
            ),
            TextButton(
              child: Text("Batal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = DbHelper.db();
    dbFuture.then((database) {
      Future<List<Profile>> profileListFuture = DbHelper.getProfileList();
      profileListFuture.then((profileList) {
        setState(() {
          _profileList = profileList;
          _filteredprofileList = profileList;
          _count = profileList.length;
          _filterprofiles();
        });
      });
    });
  }
}
