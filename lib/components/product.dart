import 'package:flutter/material.dart';
import 'package:mobile_project/model/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            width: 100,
            height: 100,
            child: Image.network("https://picsum.photos/200"),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 200,
                      child: Column(
                        children: [
                          Text(
                            product.name ?? "",
                            style: Theme.of(context).textTheme.bodyLarge?.merge(
                                  const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            product.description ?? "",
                            style: Theme.of(context).textTheme.bodyLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    const Spacer(),
                    Material(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Row(
                          children: [
                            Text(
                              "${product.price} TL",
                              style:
                                  Theme.of(context).textTheme.bodyLarge?.merge(
                                        const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.add_shopping_cart,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
