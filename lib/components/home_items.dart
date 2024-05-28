import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/components/input.dart';
import 'package:mobile_project/components/product.dart';
import 'package:mobile_project/model/product.dart';

class HomeItemScreen extends StatefulWidget {
  const HomeItemScreen({super.key});

  @override
  State<HomeItemScreen> createState() => _HomeItemScreenState();
}

class _HomeItemScreenState extends State<HomeItemScreen> {
  bool isLoading = false;
  List<Product> items = [];
  List<Product> filteredItems = [];
  final TextEditingController controller = TextEditingController();

  void filterItems(String value) {
    setState(() {
      filteredItems = items
          .where((element) =>
              element.category!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void getProducts() async {
    setState(() {
      isLoading = true;
    });
    final snapshot =
        await FirebaseFirestore.instance.collection('products').get();
    final products =
        snapshot.docs.map((e) => Product.fromMap(e.data())).toList();
    setState(() {
      items = products;
      filteredItems = products;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getProducts();
    controller.addListener(() {
      if (controller.text.isEmpty) return setState(() => filteredItems = items);
      filterItems(controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height * 0.85,
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: size.height * 0.1,
              child: Row(
                children: [
                  Expanded(
                    child: Input(
                      controller: controller,
                      label: "Arama",
                    ),
                  ),
                  const Icon(Icons.notifications),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductItem(product: item),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
