import 'package:flutter/material.dart';

import 'intihome.dart' as home;
import 'intidocumen.dart' as document;
import 'intikonsul.dart' as konsultasi;
import 'intichat.dart' as chat;

class AdminIntiAplikasi extends StatefulWidget {
  const AdminIntiAplikasi({super.key});

  @override
  State<AdminIntiAplikasi> createState() => _AdminIntiAplikasiState();
}

class _AdminIntiAplikasiState extends State<AdminIntiAplikasi>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 222, 222),
      body: TabBarView(
        controller: controller,
        children: const [
          home.AdminHalamanHome(),
          document.AdminHalamanDocument(),
          konsultasi.AdminKonsultasi(),
          chat.AdminHalamanChat(),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
          controller: controller,
          indicatorColor: Colors.white,
          unselectedLabelColor: Colors.grey, // Warna ikon ketika tidak dipilih
          labelColor:
              Color.fromARGB(255, 2, 128, 144), // Warna ikon ketika dipilih
          tabs: const [
            Tab(
              icon: Icon(Icons.home, size: 20),
            ),
            Tab(
              icon: Icon(Icons.calendar_month_sharp, size: 20),
            ),
            Tab(
              icon: Icon(Icons.mark_email_unread, size: 20),
            ),
            Tab(
              icon: Icon(Icons.forum, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
