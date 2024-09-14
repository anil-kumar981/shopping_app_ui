import 'package:flutter/material.dart';
import 'package:shopping_app_ui/global_data.dart';
import 'package:shopping_app_ui/product_cart.dart';
import 'package:shopping_app_ui/product_details_page.dart';
class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filter = ["All", " Addidas", "Nike", "Joadern"];
  late String selectString;
 
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    selectString = filter[0];
  }
  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(left: Radius.circular(35)),
    );
    return SafeArea(
        child: Column(children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Shoes\nCollection",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Expanded(
                  child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: border,
                  focusedBorder: border,
                ),
              ))
            ],
          ),
          SizedBox(
            height: 80,
            child: ListView.builder(
                itemCount: filter.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final fil = filter[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectString = fil;
                        });
                      },
                      child: Chip(
                        backgroundColor: selectString == fil
                            ? Colors.yellowAccent
                            : const Color.fromARGB(218, 231, 231, 231),
                        side: const BorderSide(
                          color: Color.fromARGB(245, 228, 226, 226),
                        ),
                        label: Text(fil),
                        labelStyle: const TextStyle(
                          fontSize: 16,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: product.length,
                itemBuilder: (context, index) {
                  final prod = product[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ProductDetail(product: prod);
                      }));
                    },
                    child: ProductCart(
                        title: prod['title'] as String,
                        price: prod['price'] as double,
                        image: prod['imageUrl'] as String,
                        backgroundColor: index.isEven
                            ? const Color.fromARGB(215, 157, 236, 250)
                            : const Color.fromARGB(245, 255, 230, 230)),
                  );
                }),
          )
        ]),
      );
  }
}