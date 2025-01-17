import 'package:flutter/material.dart';

class KayitliHasta extends StatelessWidget {
  KayitliHasta({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "doctor name",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Geri gitmek için Navigator kullanılır
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white, // Daha belirgin bir arka plan rengi
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12, // Gölgelendirme rengi
                      blurRadius: 6,
                      offset: Offset(2, 4), // Hafif gölge için ayar
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor:
                          Colors.grey[200], // Hafif bir arka plan rengi
                      child: Image.asset(
                        'assets/images/logo.png',
                      ), // Database'den çekilecek
                    ),
                    SizedBox(width: 15), // Geniş boşluk
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment:
                            MainAxisAlignment.center, // Ortaya hizalama
                        children: [
                          Text(
                            "Doctor Adı",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(
                              height:
                                  5), // Başlık ve alt başlık arasında boşluk
                          Text(
                            "Uzmanlık Alanı",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        title: Text(
                          'Mail adresi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "mustafacuma120@gmail.com",
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                        trailing: Icon(
                          Icons.email,
                          color: Colors.green,
                          size: 30, // Simge boyutu
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.9, 0),
                        child: Text(
                          'hakkimda ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Title(
                            color: Colors.white,
                            child: Text(
                              'Dr. ayse  taha, Kardiyoloji Uzmanı .\n'
                              'İstanbul Üniversitesi Tıp Fakültesi mezunu ve 20 yılı aşkın deneyime sahip bir kardiyoloji uzmanıdır. Koroner arter hastalığı, kalp yetmezliği ve hipertansiyon tedavisinde uzmanlaşmıştır. Hastalarına bireysel tedavi yaklaşımları sunar ve hasta iletişimine büyük önem verir.',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.9, 0),
                        child: Text(
                          'adress ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Title(
                            color: Colors.white,
                            child: Text(
                              'Üniversite, Fırat Ünv., 23119 Elâzığ Merkez/Elazığ',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(15),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent, // Buton rengi
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Yuvarlatılmış köşeler
            ),
            padding:
                EdgeInsets.symmetric(vertical: 14, horizontal: 30), // İç boşluk
          ),
          child: Text(
            'Görüşme için randevu oluştur',
            style: TextStyle(
              fontSize: 18, // Metin boyutu
              fontWeight: FontWeight.bold, // Kalın metin
              color: Colors.white, // Metin rengi
            ),
          ),
        ),
      ),
    );
  }
}
