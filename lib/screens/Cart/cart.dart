import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recychamp/models/cart_item.dart';
import 'package:recychamp/screens/Cart/bloc/cart_bloc.dart';
import 'package:recychamp/ui/cart_item_card.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<CartItem> items = [];

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
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
                    Text("Shopping Cart",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              if (state is CartLoadedState)
                Expanded(
                  child: ListView.builder(
                      itemCount: state.cart.items.length,
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: CartItemCard(
                              cartItem: CartItem(
                                  name: state.cart.items[index].name,
                                  imageUrl: state.cart.items[index].imageUrl,
                                  price: state.cart.items[index].price,
                                  quantity: state.cart.items[index].quantity)),
                        );
                      }),
                ),
              Container(
                margin: EdgeInsets.only(
                    right: deviceData.size.width * 0.05,
                    left: deviceData.size.width * 0.05,
                    bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: GoogleFonts.poppins(
                        fontSize: 19,
                      ),
                    ),
                    if (state is CartLoadedState)
                      Text(
                        "LKR ${state.cart.total.toStringAsFixed(2)}",
                        style: GoogleFonts.poppins(
                            fontSize: 19, fontWeight: FontWeight.w700),
                      ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    right: deviceData.size.width * 0.05,
                    left: deviceData.size.width * 0.05,
                    bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.8),
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 17.88)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    child: Text(
                      "Checkout",
                      style: GoogleFonts.poppins(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
