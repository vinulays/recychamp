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
  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
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
                    if (state is CartLoadedState)
                      Column(
                        children: List.generate(
                            state.cart.items.length,
                            (index) => Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: CartItemCard(
                                      key: ValueKey(
                                          state.cart.items[index].name),
                                      cartItem: CartItem(
                                          name: state.cart.items[index].name,
                                          imageUrl:
                                              state.cart.items[index].imageUrl,
                                          price: state.cart.items[index].price,
                                          quantity: state
                                              .cart.items[index].quantity)),
                                )),
                      )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    right: deviceData.size.width * 0.02,
                    left: deviceData.size.width * 0.02,
                    bottom: 10),
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
