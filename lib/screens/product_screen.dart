import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/components/input.dart';
import 'package:mobile_project/model/product.dart';
import 'package:uuid/uuid.dart';

enum Category { elektronik, giyim, diger }

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  String id = const Uuid().v4();
  Category category = Category.elektronik;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  // final TextEditingController imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürün Ekle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Input(
              controller: nameController,
              label: 'Ürün Adı',
            ),
            Input(
              controller: priceController,
              label: 'Ürün Fiyatı',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownMenu(
                    width: 320,
                    inputDecorationTheme: InputDecorationTheme(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(55),
                      ),
                    ),
                    label: const Text('Kategori'),
                    dropdownMenuEntries: Category.values
                        .map((e) => DropdownMenuEntry(
                            value: e, label: e.toString().split('.').last))
                        .toList(),
                    onSelected: (value) {
                      setState(() {
                        category = value as Category;
                      });
                    }),
              ],
            ),
            Input(
              controller: descriptionController,
              label: 'Ürün Açıklaması',
            ),
            // TextField(
            //   controller: imageUrlController,
            //   decoration: const InputDecoration(
            //     labelText: 'Ürün Resmi',
            //   ),
            // ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final product = Product(
                  name: nameController.text,
                  price: priceController.text,
                  description: descriptionController.text,
                  image: 'https://picsum.photos/200',
                  category: category.toString().split('.').last,
                  owner: FirebaseAuth.instance.currentUser!.email,
                );

                try {
                  FirebaseFirestore.instance
                      .collection('products')
                      .doc(id)
                      .set(product.toMap());

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Ürün başarıyla eklendi'),
                    ),
                  );
                  id = const Uuid().v4();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Bir hata oluştu'),
                    ),
                  );
                }
              },
              child: const Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
