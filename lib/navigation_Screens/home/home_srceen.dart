import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_anamnez/Widget/hasta_info.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(225, 19, 220, 123),
        title: Row(
          children: [
            Icon(
              Icons.local_hospital,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 10),
            Text(
              'Welcome',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            color: const Color.fromARGB(225, 19, 220, 123),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value.trim();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search your hasta',
                      hintStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.filter_list,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                stream: _searchQuery.isEmpty
                    ? FirebaseFirestore.instance
                        .collection('hasta')
                        .orderBy('name')
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('hasta')
                        .where('name', isGreaterThanOrEqualTo: _searchQuery)
                        .where('name', isLessThan: _searchQuery + '\uf8ff')
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No hasta found'));
                  }

                  final hastaDocs = snapshot.data!.docs;

                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: hastaDocs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final hastaData = hastaDocs[index].data();
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HastaInfo(data: hastaData),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8), // Yatay ve dikey boşluk
                          padding: EdgeInsets.all(10),
                          // height: 150, // Container yüksekliği
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Profil resmi
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey[200],
                                backgroundImage: AssetImage(
                                  hastaData['gender'] == "erkek"
                                      ? 'assets/images/male.webp'
                                      : 'assets/images/female.webp',
                                ),
                              ),
                              SizedBox(
                                  width:
                                      20), // Profil resmi ve yazı arasında boşluk
                              // Hasta bilgileri
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    hastaData['name'] ?? 'Hasta Name',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width -
                                        200, // Container genişliği sınırı
                                    child: Text(
                                      hastaData['sikayati'] ??
                                          'Yüksek Ateş, Baş Ağrısı, Kas Ağrıları, Boğaz Ağrısı, Burun Akıntısı, Öksürük ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
