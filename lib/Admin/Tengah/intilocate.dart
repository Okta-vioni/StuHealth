// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class AdminHalamanLocate extends StatelessWidget {
  const AdminHalamanLocate({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;

    final bodyHeight = mediaQueryHeight;

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            /////////////////////////////////////////////////////////  Header  //////////////////////////////////////////////////////////
            Container(
              padding: const EdgeInsets.only(top: 70, left: 20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(64, 158, 158, 158),
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(4, 4))
                  ]),
              height: bodyHeight * 0.14,
              width: double.infinity,
              child: const Text(
                'Cari Fasilitas Kesehatan',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                    color: Colors.black),
                textAlign: TextAlign.start,
              ),
            ),

            /////////////////////////////////////////////////////  Peta  ///////////////////////////////////////////////////////
            Expanded(
                child: ListView(
              padding: EdgeInsets.only(top: 10, bottom: 30),
              children: [
                Link(
                  target: LinkTarget.blank,
                  uri: Uri.parse(
                      'https://www.google.com/maps/search/puskesmas+terdekat/@1.1399435,104.0606756,13z/data=!3m1!4b1?authuser=0&entry=ttu'),
                  builder: (context, followLink) => MaterialButton(
                      onPressed: followLink,
                      child: Image.asset('img/peta.png')),
                ),
                ////////////////////////////////////////////////////////  Dropdown  //////////////////////////////////////////////////////
                const DropdownPuskesmas(),
                ///////////////////////////////////////////////////////  Kotak Lokasi  //////////////////////////////////////////////////
                const KotakLokasiTerdekat(
                    NamaRumahsakit: 'UPT Puskesmas Baloi Permai ',
                    LokasiTempat: 'Perum. Legenda Malaka Komplek Graha Legenda',
                    JauhJarak: '3,1 KM',
                    TujuanHalaman: 'https://maps.app.goo.gl/g2ZGKxNa97acD5uKA'),
                const KotakLokasiTerdekat(
                    NamaRumahsakit: 'UPT Puskesmas Sei Panas',
                    LokasiTempat:
                        'Jl. Laksamana Bintan, Bengkong Indah, Bengkong',
                    JauhJarak: '5 KM',
                    TujuanHalaman: 'https://maps.app.goo.gl/EyZUXYCvFXxonzLh8')
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class DropdownPuskesmas extends StatefulWidget {
  const DropdownPuskesmas({super.key});

  @override
  State<DropdownPuskesmas> createState() => _DropdownPuskesmasState();
}

class _DropdownPuskesmasState extends State<DropdownPuskesmas> {
  String pertanyaanpertama = 'Puskesmas';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          padding: const EdgeInsets.only(left: 10),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          isExpanded: true,
          iconEnabledColor: const Color.fromARGB(255, 2, 128, 144),
          iconSize: 30,
          ////////////////////////////////////////////////////////////////////////////////////
          value: pertanyaanpertama, // Nilai awal dropdown
          onChanged: (String? newValue) {
            setState(() {
              pertanyaanpertama = newValue!;
            });
          },
          items: <String>[
            'Puskesmas',
            'Apotek',
            'Rumah Sakit',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      color: Colors.black)),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class KotakLokasiTerdekat extends StatefulWidget {
  const KotakLokasiTerdekat({
    super.key,
    required this.NamaRumahsakit,
    required this.LokasiTempat,
    required this.JauhJarak,
    required this.TujuanHalaman,
  });

  final String NamaRumahsakit;
  final String LokasiTempat;
  final String JauhJarak;
  final String TujuanHalaman;
  @override
  State<KotakLokasiTerdekat> createState() => _KotakLokasiTerdekatState();
}

class _KotakLokasiTerdekatState extends State<KotakLokasiTerdekat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              color: Color.fromARGB(255, 2, 128, 144),
            ),
            child: Text(
              widget.NamaRumahsakit,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                  color: Colors.white),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10))),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.all(10), // Use padding instead of margin
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Color.fromARGB(255, 2, 128, 144),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            widget.LokasiTempat,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(30, 5, 20, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.JauhJarak,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 2, 128, 144),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(70, 0, 0, 0),
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(1, 1))
                          ],
                        ),
                        child: Link(
                          target: LinkTarget.blank,
                          uri: Uri.parse(widget.TujuanHalaman),
                          builder: (context, followLink) => MaterialButton(
                            onPressed: followLink,
                            child: Text(
                              'Ikuti',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
