import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_anamnez/auth/login_screen.dart';
import 'package:e_anamnez/navigation_Screens/account/doctor_ozgecmis.dart';
import 'package:e_anamnez/navigation_Screens/account/doctor_information.dart';
import 'package:e_anamnez/main_srceen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Giriş yapmış kullanıcıyı kontrol et
    User? currentUser = FirebaseAuth.instance.currentUser;

    // Kullanıcı giriş yapmamışsa KullanciYok widget'ını göster
    if (currentUser == null) {
      return const KullanciYok();
    }

    // Kullanıcının Firestore'daki "doctor bilgileri" koleksiyonunu al
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('doctor');

    // Kullanıcı verilerini al ve ekranı oluştur
    return FutureBuilder<QuerySnapshot>(
      future: userCollection.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
              child: Text("Bir hata oluştu. Lütfen tekrar deneyin."));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const KullanciYok(); // Veri yoksa kullanıcı ekranını göster
        }

        // İlk dokümanı al (örnek veri için)
        Map<String, dynamic> data =
            snapshot.data!.docs.first.data() as Map<String, dynamic>;

        // Kullanıcı profil ekranı
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Profil',
              style: TextStyle(letterSpacing: 4, fontSize: 24),
            ),
            centerTitle: true,
            actions: const [
              Padding(
                padding: EdgeInsets.all(18.0),
                child: Icon(Icons.dark_mode),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    data['name'] ?? 'Anonim Kullanıcı',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Divider(thickness: 2, color: Colors.black45),
                ),
                ListTile(
                  leading: const Icon(Icons.medical_services, size: 30),
                  title: const Text('Kişisel Bilgiler',
                      style: TextStyle(fontSize: 18)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DoctorInformation()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.history, size: 30),
                  title: const Text('Doktor Özgeçmişi',
                      style: TextStyle(fontSize: 18)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorOzgecmis(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout, size: 30),
                  title:
                      const Text('Çıkış Yap', style: TextStyle(fontSize: 18)),
                  onTap: () async {
                    try {
                      await FirebaseAuth.instance.signOut();
                      // Çıkış sonrası anasayfaya yönlendirme
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Çıkış yaparken hata oluştu: $e')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class KullanciYok extends StatelessWidget {
  const KullanciYok({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Giriş yapmadınız."),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: const Text("Giriş Yap"),
            ),
          ],
        ),
      ),
    );
  }
}
