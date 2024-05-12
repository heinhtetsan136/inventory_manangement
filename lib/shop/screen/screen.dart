import 'package:flutter/material.dart';
import 'package:starlight_utils/starlight_utils.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = context.height * 0.36;
    final width = context.width;
    int totalShop = 5;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: FlutterLogo(
              size: 80,
            ),
          ),
          SizedBox(
            width: context.width,
            height: height,
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: totalShop + 1,
                  itemBuilder: (_, i) {
                    if (i == totalShop) {
                      return OutlinedButton(
                          onPressed: () {},
                          child: const Text("Create New Shop"));
                    }
                    return Card(
                      elevation: 0.5,
                      child: Container(
                        height: 70,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("$i"),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
