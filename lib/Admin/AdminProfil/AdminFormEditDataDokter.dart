// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminFormEditDataDokter extends StatefulWidget {
  const AdminFormEditDataDokter({super.key});

  @override
  State<AdminFormEditDataDokter> createState() =>
      _AdminFormEditDataDokterState();
}

class _AdminFormEditDataDokterState extends State<AdminFormEditDataDokter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          leading: IconButton(
            padding: const EdgeInsets.only(top: 20, left: 20),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: const Color.fromARGB(255, 2, 128, 144),
            iconSize: 25,
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Edit Data',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ////////////////////////////////////////////////////  Nama  ////////////////////////////////////////////////
              const Text(
                'Nama Dokter',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const TextField(
                  maxLines: 1, // Jumlah baris yang bisa dimasukkan
                  decoration: InputDecoration.collapsed(
                    hintText: 'Berikan Nama',
                    hintStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ),
              ////////////////////////////////////////////////////  Foto  /////////////////////////////////////////////////////
              const Text(
                'Foto',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
              const UploadFotoChat(),
              SizedBox(
                height: 10,
              ),
              ///////////////////////////////////////////////////////  Kategori  /////////////////////////////////////////////
              const Text(
                'Kategori',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const TextField(
                  maxLines: 1, // Jumlah baris yang bisa dimasukkan
                  decoration: InputDecoration.collapsed(
                    hintText: 'Berikan Kategori Dokter',
                    hintStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ),
              ///////////////////////////////////////////////////////////  Limit Konsultasi  ///////////////////////////////////////////////
              const Text(
                'Limit Konsultasi',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const TextField(
                  maxLines: 1, // Jumlah baris yang bisa dimasukkan
                  decoration: InputDecoration.collapsed(
                    hintText: 'Berikan Limit Konsultasi',
                    hintStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ),
              ///////////////////////////////////////////////////////////  Status Ketersediaan  ///////////////////////////////////////////////
              const Text(
                'Status Ketersediaan',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
              const DropDownKelompokStatusKetersediaan(),
///////////////////////////////////////////////////////////////  Tombol  //////////////////////////////////////////////////////////
              Container(
                margin: const EdgeInsets.only(top: 30),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 2, 128, 144),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                width: double.infinity,
                child: MaterialButton(
                    child: const Text('Simpan',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700)),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////  Upload Foto  //////////////////////////////////////////////////////
class UploadFotoChat extends StatefulWidget {
  const UploadFotoChat({super.key});

  @override
  State<UploadFotoChat> createState() => _UploadFotoChatState();
}

class _UploadFotoChatState extends State<UploadFotoChat> {
  File? image;

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery);

    if (imagePicked != null) {
      image = File(imagePicked.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final bodyHeight = mediaQueryHeight;
    final bodyWidth = mediaQueryWidth;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        image != null
            ? Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 2, 128, 144)),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: SizedBox(
                      width: bodyWidth * 0.6,
                      height: bodyHeight * 0.3,
                      child: Image.file(
                        image!,
                        fit: BoxFit.cover,
                      )),
                ),
              )
            : Container(
                width: bodyWidth * 0.6,
                height: bodyHeight * 0.3,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 2, 128, 144)),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: MaterialButton(
                  onPressed: () async {
                    await getImage();
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image,
                        color: Colors.grey,
                      ),
                      Text(
                        'Please select an image',
                        style: TextStyle(
                            fontFamily: 'Poppins', color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.only(right: 20, left: 20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color.fromARGB(255, 2, 128, 144),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(64, 158, 158, 158),
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: Offset(4, 4))
            ],
          ),
        ),
      ],
    );
  }
}

//////////////////////////////////////////////////////////////////////////  Dropdown  ///////////////////////////////////////////////////
class DropDownKelompokStatusKetersediaan extends StatefulWidget {
  const DropDownKelompokStatusKetersediaan({super.key});

  @override
  State<DropDownKelompokStatusKetersediaan> createState() =>
      _DropDownKelompokStatusKetersediaanState();
}

class _DropDownKelompokStatusKetersediaanState
    extends State<DropDownKelompokStatusKetersediaan> {
  String pertanyaanpertama = 'Tidak Tersedia';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          padding: const EdgeInsets.only(left: 10, right: 10),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          iconEnabledColor: const Color.fromARGB(255, 2, 128, 144),
          isExpanded: true,
          iconSize: 30,
          value: pertanyaanpertama,
          onChanged: (String? newValue) {
            setState(() {
              pertanyaanpertama = newValue!;
            });
          },
          items: <String>['Tidak Tersedia', 'Tersedia']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(fontFamily: 'Poppins'),
                ));
          }).toList(),
        ),
      ),
    );
  }
}
