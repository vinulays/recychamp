import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recychamp/models/cart_item.dart';
import 'package:recychamp/screens/Cart/bloc/cart_bloc.dart';

class CartItemCard extends StatefulWidget {
  final CartItem cartItem;
  const CartItemCard({super.key, required this.cartItem});

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.05),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100, // Specify the width you want
                  height: 100, // Specify the height you want
                  child: Image.network(
                    widget.cartItem.imageUrl,
                    fit: BoxFit.cover, // Adjust the fit as per your requirement
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cartItem.name,
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "LKR ${widget.cartItem.price.toStringAsFixed(2)}",
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black.withOpacity(0.4)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            GestureDetector(
                              child: const Icon(Icons.remove_circle_outline),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${widget.cartItem.quantity}",
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black.withOpacity(0.4)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              child: const Icon(Icons.add_circle_outline),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              context
                  .read<CartBloc>()
                  .add(RemoveItemEvent(widget.cartItem.name));
            },
            child: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
