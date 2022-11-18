import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pixabay/data/api_model/pixabar_response.dart';
import 'package:pixabay/data/api_service/api_service.dart';
import 'package:pixabay/util/app_%20constant.dart';
import 'package:pixabay/view/home/bloc/pixabay_bloc.dart';
import 'package:pixabay/view/shimmer/home_shimmer.dart';
import 'package:pixabay/view/widget/app_text_view.dart';
import '../../../util/app_color.dart';
import '../../widget/no_internet.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //for search

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            dividerH(),
            //search area
            searchArea(context),
            dividerH(),
            BlocProvider(
              create: (context) =>
                  //bloc add
                  ImageViewBloc(RepositoryProvider.of<APIService>(context))..add(const ImageViewApiEvent('Flutter')),
              //demo data
              child: BlocBuilder<ImageViewBloc, ImageViewState>(
                builder: (context, state) {
                  if (state is NoInternetState) {
                    //no internet screen
                    return noInternetWidget(context, '/home');
                  }
                  if (state is ImageViewInitialState) {
                    return Center(
                      child: appTextView(name: 'Search Any Item', isBold: true),
                    );
                  }
                  if (state is ImageViewLoadingState) {
                    //shimmer
                    return homeShimmer(context);
                  }
                  if (state is ImageViewLoadedState) {
                    //loaded state
                    if (state.response.hits!.isNotEmpty) {
                      return imageListUI(context, state.response.hits);
                    } else {
                      return Center(
                        child:
                            appTextView(name: 'No Image Found!', isBold: true),
                      );
                    }
                  }
                  if (state is ErrorState) {
                    //error state
                    return Center(
                      child: appTextView(
                          name: 'Something Went Wrong', isBold: true),
                    );
                  }
                  if (state is UnAuthorizedState) {
                    //404 state
                    return Center(
                      child: appTextView(name: 'Please Log Out', isBold: true),
                    );
                  }
                  return Center(
                    child: appTextView(name: 'Search Any Item', isBold: true),
                  );
                },
              ),
            ),
            dividerSH(),
          ],
        ),
      ),
    );
  }

  Widget searchArea(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 45,
          width: screenWidth(context) * 0.7,
          child: CupertinoSearchTextField(
            controller: searchController,
            autocorrect: true,
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: AppColor.kBlack,
            ),
            suffixIcon: const Icon(
              Icons.close,
              color: AppColor.kBlack,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1),
            ),
            style: const TextStyle(
              color: AppColor.kBlack,
            ),
          ),
        ),
        SizedBox(
          height: 45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {
              if (searchController.text == "") {
                EasyLoading.showToast('Search Item');
              } else {
                //api added area
                ImageViewBloc(RepositoryProvider.of<APIService>(context))
                    .add(ImageViewApiEvent(searchController.text.toString()));
              }
            },
            child: appTextView(
                name: 'Submit', isBold: true, color: AppColor.kWhite),
          ),
        ),
      ],
    );
  }

  //mainUI
  Widget imageListUI(
    BuildContext context,
    List<Hits>? hits,
  ) {
    return Padding(
      padding: commonPaddingLR,
      child: GridView.count(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1 / 1,
        children: List.generate(
          hits!.length,
          (index) {
            String imageUrl = hits[index].webformatURL.toString();
            String largeImage = hits[index].largeImageURL.toString();
            return InkWell(
              child: Container(
                width: screenWidth(context),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/imageView',
                    arguments: largeImage);
              },
            );
          },
        ),
      ),
    );
  }
}
