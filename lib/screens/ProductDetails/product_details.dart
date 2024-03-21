import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recychamp/models/product.dart';

class ProductDetails extends StatefulWidget {
  final Product product;

  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: FractionallySizedBox(
              child: Container(
                width: double.infinity,
                decoration: const ShapeDecoration(
                  color: Color(0xff75A488),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(42.07),
                      bottomRight: Radius.circular(42.07),
                    ),
                  ),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: 54.96,
                      left: 29.58,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset(
                          "assets/icons/go_back.svg",
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 54.96,
                      left: 330.58,
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Image.network(widget.product.imageUrl))
                  ],
                ),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(
                  horizontal: deviceData.size.width * 0.05),
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.product.name,
                        style: GoogleFonts.poppins(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "LKR ${widget.product.price.toStringAsFixed(2)}",
                        style: GoogleFonts.poppins(fontSize: 25),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.product.description,
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                    ],
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
                          "Add to cart",
                          style: GoogleFonts.poppins(
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
