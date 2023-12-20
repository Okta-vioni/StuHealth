import 'package:flutter/material.dart';

import 'intihome.dart' as home;
import 'intidocumen.dart' as document;
import 'intichat.dart' as chat;
import 'intilocate.dart' as locate;

class IntiAplikasi extends StatefulWidget {
  const IntiAplikasi({super.key});

  @override
  State<IntiAplikasi> createState() => _IntiAplikasiState();
}

class _IntiAplikasiState extends State<IntiAplikasi>
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
          home.HalamanHome(),
          document.HalamanDocument(),
          chat.HalamanChat(),
          locate.HalamanLocate(),
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
              icon: Icon(Icons.forum, size: 20),
            ),
            Tab(
              icon: Icon(Icons.location_city, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
