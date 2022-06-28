import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop/controller/bottom.dart';
import 'package:shop/pages/add_to_cart.dart';
import 'package:shop/pages/product_List.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNavigation(),
    );
  }
}

// ignore: non_constant_identifier_names
final data_control = Get.put(Controller());

// ignore: must_be_immutable
class BottomNavigation extends StatelessWidget {
  BottomNavigation({
    this.currentIndex,
    Key? key,
  }) : super(key: key);

  int? currentIndex;
  List<String> title = [
    'Home',
    'CartList',
  ];
  init() {
    if (currentIndex != null) {
      data_control.selectedIndex = currentIndex!;
    }
  }

  @override
  Widget build(BuildContext context) {
    init();

    List<Widget> _widgetOption = [ProductList(), AddToCart()];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: GetBuilder<Controller>(
          id: 'indexchange',
          builder: (controller) {
            return Text(title[data_control.selectedIndex],
                style: GoogleFonts.lato(
                  textStyle:
                      const TextStyle(color: Colors.white, letterSpacing: .5),
                ));
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<Controller>(
          init: Controller(),
          id: 'indexchange',
          builder: (controller) {
            return _widgetOption[controller.selectedIndex];
          }),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.black,
            primaryColor: Colors.red,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: const TextStyle(color: Colors.yellow))),
        child: GetBuilder<Controller>(
          id: 'indexchange',
          builder: (controller) {
            return BottomNavyBar(
              showElevation: true,
              onItemSelected: controller.onItemTapped,
              selectedIndex: controller.selectedIndex,
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                    icon: const Icon(Icons.home),
                    title: Text('Product List',
                        style:
                            GoogleFonts.tillana(fontWeight: FontWeight.bold)),
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey),
                BottomNavyBarItem(
                  icon: const Icon(Icons.bookmark_border),
                  title: Text('Cart List',
                      style: GoogleFonts.tillana(fontWeight: FontWeight.bold)),
                  activeColor: Colors.black,
                  inactiveColor: Colors.grey,
                ),
                // BottomNavyBarItem(
                //   icon: const Icon(Icons.shopping_cart),
                //   title: Text('Detail ',
                //       style: GoogleFonts.tillana(fontWeight: FontWeight.bold)),
                //   activeColor: Colors.black,
                //   inactiveColor: Colors.grey,
                // ),
                // BottomNavyBarItem(
                //   icon: const Icon(Icons.topic),
                //   title: Text('Profile',
                //       style: GoogleFonts.tillana(fontWeight: FontWeight.bold)),
                //   activeColor: Colors.black,
                //   inactiveColor: Colors.grey,
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
