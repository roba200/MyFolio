import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ui/pages/detail_page.dart';
import 'package:ui/widgets/rounded_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchText = "";
  TextEditingController _searchcontroller = TextEditingController();
  Future<void> refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchcontroller,
            onChanged: (value) {
              setState(() {
                searchText = _searchcontroller.text;
                print(searchText);
              });
            },
            decoration: InputDecoration(
                filled: true,
                hintStyle: TextStyle(color: Colors.grey),
                hintText: "Search",
                fillColor: Colors.white),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: searchText.isNotEmpty
            ? FirebaseFirestore.instance
                .collection('users')
                .where('name', isGreaterThanOrEqualTo: searchText)
                .where('name', isLessThanOrEqualTo: searchText + '\uf8ff')
                .snapshots()
            : FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: refresh,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final documentSnapshot = snapshot.data?.docs[index];
                final data = documentSnapshot?.data();
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(data!["url"]),
                  ),
                  title: Text(data['name']),
                  subtitle: Text(data['career']),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(document: data)));
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
