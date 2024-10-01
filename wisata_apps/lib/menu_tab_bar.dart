import 'package:flutter/material.dart';
import 'package:wisata_apps/profil_page.dart';

import 'list_wisata.dart';
import 'map_wisata.dart';

class MenuTabBar extends StatefulWidget {
  const MenuTabBar({super.key});

  @override
  State<MenuTabBar> createState() => _MenuTabBarState();
}

class _MenuTabBarState extends State<MenuTabBar>
  with SingleTickerProviderStateMixin {
    TabController? tabController;

    @override
    void initState() {
  super.initState();
  tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(controller: tabController, children: const [
        ListWisata(nama_wisata: 'Nama Wisata', kategori: 'kategori', gambar: 'gambar', lokasi: 'lokasi',),
        MapWisata(),
        ProfilPage(),
  ]),
  bottomNavigationBar: BottomAppBar(
  child: TabBar(
  labelColor: Colors.green,
  unselectedLabelColor: Colors.grey,
  controller: tabController,
  tabs: const[
    Tab(
  text: 'List Wisata',
  icon: Icon(Icons.list_alt_outlined),
  ),
  Tab(
  text: 'Map Wisata',
  icon: Icon(Icons.map),
  ),
  Tab(
  text: 'profil',
  icon: Icon(Icons.person),
  ),
  ],
  ),
  ),
    );
  }
}

