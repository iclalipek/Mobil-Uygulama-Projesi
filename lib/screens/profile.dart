import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/components/product.dart';
import 'package:mobile_project/model/product.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Product> items = [];
  bool isLoading = false;

  void getProducts() async {
    setState(() {
      isLoading = true;
    });
    final snapshot =
        await FirebaseFirestore.instance.collection('products').get();
    final products = snapshot.docs
        .map((e) => Product.fromMap(e.data()))
        .toList()
        .where((element) =>
            element.owner == FirebaseAuth.instance.currentUser!.email)
        .toList();
    setState(() {
      items = products;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profil'),
          actions: [
            const Text("Çıkış Yap"),
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Ürünlerim'),
            Expanded(
              child: SizedBox(
                width: size.width,
                height: size.height * 0.85,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ProductItem(product: item),
                          );
                        },
                      ),
              ),
            ),
          ],
        ));
  }
}
