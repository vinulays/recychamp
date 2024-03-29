import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recychamp/utils/articles_filters.dart';

class ArticleFilter extends StatefulWidget {
  const ArticleFilter({super.key});

  @override
  State<ArticleFilter> createState() => _ArticleFilterState();
}

class _ArticleFilterState extends State<ArticleFilter> {
  Set<String> filters = <String>{};
  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.all(
              deviceData.size.width * 0.05,
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset("assets/icons/close.svg"),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 45),
                      child: Text(
                        "Filters",
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                      "Reset All",
                      style: GoogleFonts.poppins(
                          color: const Color(0xFF75A488),
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Article Categories",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black.withOpacity(0.699999988079071),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                  spacing: 9,
                  children: articleFilters.map((filterName) {
                    return FilterChip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(
                          color: Colors.black.withOpacity(0.05),
                        ),
                      ),
                      showCheckmark: false,
                      selected: filters.contains(filterName),
                      selectedColor: const Color(0xFF75A488),
                      onSelected: (bool selected) => {
                        setState(() {
                          if (selected) {
                            filters.add(filterName);
                          } else {
                            filters.remove(filterName);
                          }
                        }),
                      },
                      label: Text(
                        filterName,
                        style: GoogleFonts.poppins(
                            fontSize: 13, fontWeight: FontWeight.w700),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 5,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Show only completed challenges",
                //       style: GoogleFonts.poppins(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w700,
                //         color: Colors.black.withOpacity(0.699999988079071),
                //       ),
                //     ),
                //     Switch(
                //         activeColor: const Color(0xFF75A488),
                //         thumbColor:
                //             const MaterialStatePropertyAll(Colors.white),
                //         value: isCompletedSelected,
                //         onChanged: (bool value) {
                //           setState(() {
                //             isCompletedSelected = value;
                //           });
                //         })
                //   ],
                // ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
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
                          const EdgeInsets.symmetric(
                              horizontal: 93.61, vertical: 17.88)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    child: Text(
                      "Confirm",
                      style: GoogleFonts.poppins(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
