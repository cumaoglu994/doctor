import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DoctorOzgecmis extends StatefulWidget {
  @override
  _DoctorOzgecmisPageState createState() => _DoctorOzgecmisPageState();
}

class _DoctorOzgecmisPageState extends State<DoctorOzgecmis> {
  final TextEditingController _uzmanlikController = TextEditingController();
  final TextEditingController _ozgecmisController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('doctor')
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          var userData = userDoc.data() as Map<String, dynamic>;
          _uzmanlikController.text = userData['uzmanlik'] ?? '';
          _ozgecmisController.text = userData['ozgecmis'] ?? '';

          setState(() {});
        }
      } else {
        print('Kullanıcı bulunamadı.');
      }
    } catch (e) {
      print('Kullanıcı bilgileri çekilirken hata: $e');
    }
  }

  Future<void> _updateUserInfo() async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection('doctor')
            .doc(currentUser.uid)
            .set({
          'uzmanlik': _uzmanlikController.text,
          'ozgecmis': _ozgecmisController.text,
        }, SetOptions(merge: true));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bilgiler başarıyla güncellendi'),
          ),
        );
      } else {
        print('Kullanıcı bulunamadı.');
      }
    } catch (e) {
      print('Güncelleme hatası: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bilgiler güncellenemedi.')),
      );
    }
  }

  Widget _buildTextField(
    double yukseklik,
    String label,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: yukseklik, // Sabit yükseklik ayarı
        decoration: BoxDecoration(
          color:
              const Color.fromARGB(126, 255, 235, 59), // Arka plan rengi sarı
          borderRadius: BorderRadius.circular(15), // Köşe yuvarlaklığı
        ),
        child: TextField(
          controller: controller,
          expands: true, // Container'ın yüksekliğini doldurur
          maxLines: null, // Çok satırlı olmasını sağlar
          minLines: null, // expand ile birlikte kullanılır
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), // İç kenar yuvarlaklığı
              borderSide: BorderSide.none, // Kenar çizgisini kaldır
            ),
            labelText: label,
            contentPadding: EdgeInsets.only(
              left: 10.0, // Yatay padding için sadece sol taraf
              top: 10.0, // Üst padding ile üst köşeye hizalama
            ),
          ),
          style: TextStyle(fontSize: 16),
          textAlignVertical: TextAlignVertical.top, // Metni üstte hizalar
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hesabım'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Center(
              child: Text(
                'Özgeçmiş bilgiler',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _buildTextField(
              60.0,
              'Uzmanlık Alanı:',
              _uzmanlikController,
            ),
            _buildTextField(
              250.0,
              'Özgeçmiş',
              _ozgecmisController,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 20.0),
              ),
              onPressed: () async {
                await _updateUserInfo();
                Navigator.pop(
                    context); // Güncelleme sonrası mevcut sayfayı kapatır ve önceki ekrana döner
              },
              child: Text(
                'KAYDET',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
