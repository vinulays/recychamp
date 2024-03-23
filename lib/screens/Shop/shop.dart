import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:recychamp/screens/Cart/bloc/cart_bloc.dart';
import 'package:recychamp/screens/Cart/cart.dart';
import 'package:recychamp/screens/ProductDetails/product_details.dart';
import 'package:recychamp/screens/Shop/bloc/shop_bloc.dart';
import 'package:recychamp/models/product.dart';
import 'package:recychamp/ui/shop_filter.dart';

import 'package:badges/badges.dart' as badges;

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  void initState() {
    super.initState();
    context.read<ShopBloc>().add(FetchShopEvent());
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
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
                        colorFilter: const ColorFilter.mode(
                            Colors.black, BlendMode.srcIn),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text("Shop",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),
                    const SizedBox(width: 215),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Cart(),
                          ),
                        );
                      },
                      // child: const Icon(Icons.shopping_cart),
                      child: BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          if (state is CartLoadedState) {
                            return badges.Badge(
                              showBadge: state.cart.items.isNotEmpty,
                              badgeContent: Container(),
                              child: const Icon(Icons.shopping_cart),
                            );
                          } else {
                            return const Icon(Icons.shopping_cart);
                          }
                        },
                      ),
                    )
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
              if (state is ShopLoading)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      strokeWidth: 5,
                      color: Color(0xff75A488),
                    ),
                  ),
                ),
              if (state is ShopLoadedError) Text(state.errorMessage),
              if (state is ShopLoaded)
                Expanded(
                    child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Wrap(
                    spacing: 1, // Adjust the spacing between items as needed
                    runSpacing: 20,
                    children: List.generate(state.products.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                product: state.products[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: deviceData.size.width * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: const Color.fromRGBO(117, 164, 136,
                                    1), // Set your desired background color here
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Image.network(
                                    state.products[index].imageUrl,
                                    width: 143,
                                    height: 143.258,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                state.products[index].name,
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                ("LKR ${state.products[index].price.toStringAsFixed(2)}"),
                                style: GoogleFonts.poppins(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                )),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
