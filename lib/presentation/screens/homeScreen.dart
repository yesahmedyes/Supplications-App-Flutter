import 'package:flutter/material.dart';
import 'package:supplications_app/presentation/widgets/homeAppBar.dart';
import 'package:supplications_app/presentation/widgets/homeCategories.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ScrollController scrollController = ScrollController();

  void openDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF2f2f2),
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text("Supplications", style: TextStyle(color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.w600)),
                    SizedBox(height: 16),
                    Text(
                      "Regular Duas & Azkars",
                      style: TextStyle(color: Colors.black87, fontSize: 17, fontWeight: FontWeight.w500, height: 1.8),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text("By Wafaa Quran Institute", style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w500)),
                    SizedBox(height: 14),
                    Text("c 2022", style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            HomeAppBar(scrollController: scrollController, openDrawer: () => openDrawer(context)),
          ];
        },
        body: const HomeCategories(),
      ),
    );
  }
}
