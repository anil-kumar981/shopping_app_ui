import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_ui/cart_provide.dart';

class ProductDetail extends StatefulWidget {
  final Map<String, Object> product;

  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int selectedSize = 0;
  void onTap() {
    if (selectedSize != 0) {
      Provider.of<CartProvider>(context, listen: false).addProduct({
        'id': widget.product['id'],
        'title': widget.product['title'],
        'price': widget.product['price'],
        'company': widget.product['company'],
        'imageUrl': widget.product['imageUrl'],
        'size': selectedSize,
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Added Successfull!")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please select a size!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final String image = widget.product["imageUrl"] as String;
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            "Details",
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              widget.product["title"] as String,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const Spacer(),
          Image.asset(
            image,
          ),
          const Spacer(
            flex: 2,
          ),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
                color: const Color.fromARGB(218, 231, 231, 231),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "\$${widget.product['price']}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (widget.product['size'] as List<int>).length,
                      itemBuilder: (context, index) {
                        final size =
                            (widget.product['size'] as List<int>)[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSize = size;
                                });
                              },
                              child: Chip(
                                  backgroundColor: selectedSize == size
                                      ? Colors.yellowAccent
                                      : const Color.fromARGB(
                                          218, 231, 231, 231),
                                  label: Text(size.toString()))),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          minimumSize: const Size(double.infinity, 50)),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
