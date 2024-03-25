import 'package:cached_network_image/cached_network_image.dart';
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

                  child: CachedNetworkImage(
                    imageUrl: widget.cartItem.imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 100,
                      width: 100,
                      decoration: ShapeDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0))),
                    ),
                    placeholder: (context, url) => const SizedBox(
                      height: 100,
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [CircularProgressIndicator()],
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
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
                              onTap: () {
                                context.read<CartBloc>().add(
                                    RemoveItemQuantityEvent(
                                        widget.cartItem.name));
                              },
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
                              onTap: () {
                                context.read<CartBloc>().add(
                                    AddItemQuantityEvent(widget.cartItem.name));
                              },
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
