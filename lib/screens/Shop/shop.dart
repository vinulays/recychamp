import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:recychamp/screens/Shop/bloc/shop_bloc.dart';
import 'package:recychamp/models/product.dart';
import 'package:recychamp/ui/shop_filter.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  void initState() {
    super.initState();
    //fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      //   appBar: AppBar(
      //     title: const Text('Shop'),
      //     actions: [
      //       IconButton(
      //         onPressed: (){
      //           //cart func
      //         },
      //         icon: const Icon(Icons.shopping_cart)
      //         )
      //     ],
      //   ),
      //   body: StreamBuilder<List<Product>>(
      //     stream: widget.bloc.productsStream,
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData){
      //         final List<Product> products = snapshot.data!;
      //         return GridView.builder(
      //           padding: const EdgeInsets.all(8),
      //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //             crossAxisCount: 2,
      //             mainAxisSpacing: 8,
      //             crossAxisSpacing: 8,
      //             childAspectRatio: 0.75,
      //           ),
      //           itemCount: products.length,
      //           itemBuilder: (context, index) {
      //             return _buildProductCard(products[index]);
      //           },
      //         );
      //         } else if (snapshot.hasError) {
      //         return const Center(
      //           child: Text('Error fetching data'),
      //         );
      //       } else {
      //         return const Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }
      //     },
      //   ),
      // );

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 130,
              margin: EdgeInsets.symmetric(
                  horizontal: deviceData.size.width * 0.05),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(
                      "assets/icons/go_back.svg",
                      colorFilter:
                          const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text("Shop",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  const SizedBox(width: 215),
                  const Icon(Icons.shopping_cart)
                ],
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(
                  horizontal: deviceData.size.width * 0.05),
              child: TextField(
                style: GoogleFonts.poppins(
                  fontSize: 17,
                ),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(14),
                    prefixIconConstraints:
                        const BoxConstraints(maxHeight: 26, minWidth: 26),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 13, right: 10),
                      child: SvgPicture.asset(
                        "assets/icons/search.svg",
                      ),
                    ),
                    suffixIconConstraints:
                        const BoxConstraints(maxHeight: 26, minWidth: 26),
                    // todo filter icon must open filter menu
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () {
                          // * filter bottom drawer
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              context: context,
                              builder: (BuildContext context) {
                                return const ShopFilter();
                              });
                        },
                        child: SvgPicture.asset(
                          "assets/icons/filter.svg",
                        ),
                      ),
                    ),
                    filled: true,
                    fillColor: const Color(0xffE6EEEA),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12.62),
                    ),
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 17, color: const Color(0xff75A488)),
                    hintText: "Search Items"),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: deviceData.size.width * 0.05),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        color: const Color.fromRGBO(117, 164, 136,
                            1), // Set your desired background color here
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.network(
                            "https://image.similarpng.com/very-thumbnail/2021/06/Men's-black-blank-T-shirt-template-on-transparent-background-PNG.png",
                            width: 143,
                            height: 143.258,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Text("Eco T-shirt"),
                      const Text("LKR 1450"),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        color: const Color.fromRGBO(117, 164, 136,
                            1), // Set your desired background color here
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.network(
                            "https://image.similarpng.com/very-thumbnail/2021/06/Men's-black-blank-T-shirt-template-on-transparent-background-PNG.png",
                            width: 143,
                            height: 143.258,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Text("Eco T-shirt"),
                      const Text("LKR 1450"),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: deviceData.size.width * 0.05),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        color: const Color.fromRGBO(117, 164, 136,
                            1), // Set your desired background color here
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.network(
                            "https://image.similarpng.com/very-thumbnail/2021/06/Men's-black-blank-T-shirt-template-on-transparent-background-PNG.png",
                            width: 143,
                            height: 143.258,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Text("Eco T-shirt"),
                      const Text("LKR 1450"),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        color: const Color.fromRGBO(117, 164, 136,
                            1), // Set your desired background color here
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.network(
                            "https://image.similarpng.com/very-thumbnail/2021/06/Men's-black-blank-T-shirt-template-on-transparent-background-PNG.png",
                            width: 143,
                            height: 143.258,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Text("Eco T-shirt"),
                      const Text("LKR 1450"),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: deviceData.size.width * 0.05),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        color: const Color.fromRGBO(117, 164, 136,
                            1), // Set your desired background color here
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.network(
                            "https://image.similarpng.com/very-thumbnail/2021/06/Men's-black-blank-T-shirt-template-on-transparent-background-PNG.png",
                            width: 143,
                            height: 143.258,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Text("Eco T-shirt"),
                      const Text("LKR 1450"),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        color: const Color.fromRGBO(117, 164, 136,
                            1), // Set your desired background color here
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.network(
                            "https://image.similarpng.com/very-thumbnail/2021/06/Men's-black-blank-T-shirt-template-on-transparent-background-PNG.png",
                            width: 143,
                            height: 143.258,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Text("Eco T-shirt"),
                      const Text("LKR 1450"),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: deviceData.size.width * 0.05),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        color: const Color.fromRGBO(117, 164, 136,
                            1), // Set your desired background color here
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.network(
                            "https://image.similarpng.com/very-thumbnail/2021/06/Men's-black-blank-T-shirt-template-on-transparent-background-PNG.png",
                            width: 143,
                            height: 143.258,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Text("Eco T-shirt"),
                      const Text("LKR 1450"),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        color: const Color.fromRGBO(117, 164, 136,
                            1), // Set your desired background color here
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.network(
                            "https://image.similarpng.com/very-thumbnail/2021/06/Men's-black-blank-T-shirt-template-on-transparent-background-PNG.png",
                            width: 143,
                            height: 143.258,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Text("Eco T-shirt"),
                      const Text("LKR 1450"),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildProductCard(Product product) {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => ProductDetailsPage(product: product),
  //         ),
  //       );
  //     },
  //     child: Card(
  //       elevation: 2,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Expanded(
  //             child: ClipRRect(
  //               borderRadius: const BorderRadius.only(
  //                 topLeft: Radius.circular(8),
  //                 topRight: Radius.circular(8),
  //               ),
  //               child: Image.network(
  //                 product.imageUrl,
  //                 width: double.infinity,
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(8),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   product.name,
  //                   style: const TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 4),
  //                 Text(
  //                   '\$${product.price.toStringAsFixed(2)}',
  //                   style: const TextStyle(
  //                     color: Colors.green,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
