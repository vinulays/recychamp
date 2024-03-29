import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recychamp/models/cart_item.dart';
import 'package:recychamp/screens/Cart/bloc/cart_bloc.dart';
import 'package:recychamp/screens/Home/home.dart';
import 'package:recychamp/ui/cart_item_card.dart';
import 'package:http/http.dart' as http;

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<CartItem> items = [];
  Map<String, dynamic>? paymentIntent;
  int cartTotal = 0;

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoadedState) {
          cartTotal = (state.cart.total * 100).truncate();
        }
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
                    onPressed: () {
                      payment();
                    },
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

  void payment() async {
    try {
      Map<String, dynamic> body = {
        "amount": cartTotal.toString(),
        "currency": "LKR",
      };
      var response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        headers: {
          "Authorization": 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          //pk
          //sk
          "Content-type": "application/x-www-form-urlencoded"
        },
        body: body,
      );
      paymentIntent = json.decode(response.body);
    } catch (error) {
      throw Exception(error);
    }

    await Stripe.instance
        .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret: paymentIntent!['client_secret'],
                // style: ThemeMode.light,
                merchantDisplayName: 'RecyChamp'))
        .then((value) => {});

    try {
      await Stripe.instance.presentPaymentSheet().then((value) => {
            BlocProvider.of<CartBloc>(context).add(
              ResetCartEvent(),
            )
          });
    } catch (error) {
      throw Exception(error);
    }

    if (mounted) {
      showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          context: context,
          builder: (BuildContext context) {
            var deviceData = MediaQuery.of(context);

            return Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 130,
                        width: 130,
                        child: Image.asset("assets/icons/payment-success.png"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Payment Successful!",
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Order will received within 2 - 3 business days.",
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black.withOpacity(0.5)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        right: deviceData.size.width * 0.05,
                        left: deviceData.size.width * 0.05,
                        bottom: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const Home()));
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                          "Go back to Home",
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
          });
    }
  }
}
