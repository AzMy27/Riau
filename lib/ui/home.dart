import 'package:flutter/material.dart';
import 'package:p11_tugas/helpers/dbhelper.dart';
import 'package:p11_tugas/models/contact.dart';
import 'entryform.dart';
import 'package:sqflite/sqflite.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _count = 0;
  List<Contact> _contactList = [];
  List<Contact> _filteredContactList = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterContacts);
    updateListView();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterContacts() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredContactList = _contactList;
      } else {
        _filteredContactList = _contactList
            .where((contact) => contact.name
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
        title: const Text('Coba Akses SQLite'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Contacts',
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
          tooltip: 'Tambah Contact',
          onPressed: () async {
            var contact = await navigateToEntryForm(context, Contact("", ""));
            addContact(contact);
          }),
    );
  }

  Future<Contact> navigateToEntryForm(
      BuildContext context, Contact contact) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return EntryForm(contact);
        },
      ),
    );
    return result;
  }

  ListView createListView() {
    return ListView.builder(
      itemCount: _filteredContactList.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 2.0,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.people),
            ),
            title: Text(
              _filteredContactList[index].name,
            ),
            subtitle: Text(
              _filteredContactList[index].phone.toString(),
            ),
            trailing: GestureDetector(
              child: const Icon(Icons.delete),
              onTap: () {
                deleteContact(_filteredContactList[index].id!);
              },
            ),
            onTap: () async {
              var contact = await navigateToEntryForm(
                  context, _filteredContactList[index]);
              editContact(contact);
            },
          ),
        );
      },
    );
  }

  void addContact(Contact contact) async {
    int result = await DbHelper.insert(contact);
    if (result > 0) {
      updateListView();
    }
  }

  void editContact(Contact contact) async {
    int result = await DbHelper.update(contact);
    if (result > 0) {
      updateListView();
    }
  }

  void deleteContact(int id) async {
    int result = await DbHelper.delete(id);
    if (result > 0) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = DbHelper.db();
    dbFuture.then((database) {
      Future<List<Contact>> contactListFuture = DbHelper.getContactList();
      contactListFuture.then((contactList) {
        setState(() {
          _contactList = contactList;
          _filteredContactList = contactList;
          _count = contactList.length;
          _filterContacts();
        });
      });
    });
  }
}
