import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:recychamp/screens/Community/bloc/posts_bloc.dart';
import 'package:recychamp/screens/Community/bloc/posts_event.dart';
import 'package:recychamp/screens/Community/bloc/posts_state.dart';

import 'package:recychamp/screens/CreatePost/createpost.dart';
import 'package:recychamp/services/post_service.dart';
import 'package:recychamp/ui/post-card.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  late final PostService _postService;
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _postService = PostService(
        firestore: FirebaseFirestore.instance,
        storage: FirebaseStorage.instance);
    context.read<PostBloc>().add(FetchPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    //Screen Responsiveness
    var deviceData = MediaQuery.of(context);
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        final postBloc = BlocProvider.of<PostBloc>(context);
        return (state is PostLoaded)
            ? Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: deviceData.size.width * 0.07),
                      // * Headline row with settings button
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // * Headline left column
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Challenges",
                                style: GoogleFonts.poppins(
                                  // color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          // todo Settings button (must link to settings page)
                          SvgPicture.asset(
                            "assets/icons/Settings.svg",
                            height: 24,
                            width: 24,
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 60,
                      margin: EdgeInsets.symmetric(
                          horizontal: deviceData.size.width * 0.05),
                      child: TextField(
                        // * calling search event when user clicks ok on the keyboard after editing the search field
                        onSubmitted: (query) {},

                        style: GoogleFonts.poppins(
                          fontSize: 17,
                        ),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(14),
                            prefixIconConstraints: const BoxConstraints(
                                maxHeight: 26, minWidth: 26),
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.only(left: 13, right: 10),
                              child: InkWell(
                                // * search posts when tapped search icon
                                onTap: () {
                                  postBloc.add(
                                      SearchPostsEvent(_searchController.text));
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/search.svg",
                                ),
                              ),
                            ),
                            suffixIconConstraints: const BoxConstraints(
                                maxHeight: 26, minWidth: 26),
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
                                        return Container();
                                        // return ChallengeFiltersBottomSheet(
                                        //   applyFiltersCallBack: applyFilters,
                                        //   initialFilters: selectedFilters,
                                        //   initialCompletedSelected:
                                        //       selectedIsCompleted,
                                        // );
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
                            hintText: "Search Posts"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // const PostCard()
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: state.posts.length,
                        itemBuilder: (BuildContext context, index) {
                          return PostCard(
                              post: state.posts[index],
                              postService: _postService);
                        },
                      ),
                    )
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    // Add functionality for the floating action button
                    showGeneralDialog(
                      context: context,
                      pageBuilder: (BuildContext buildContext,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        return const CreatePost(
                          isUpdate: false,
                        );
                      },
                    );
                  },
                  backgroundColor: const Color(0xFF75A488),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 40.0,
                  ),
                ),
              )
            : (state is PostLoading)
                ? const Center(
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      strokeWidth: 5,
                      color: Color(0xff75A488),
                    ),
                  )
                : (state is PostError)
                    ? Container(child: Text(state.errorMessage))
                    : Container();
      },
    );
  }
}
