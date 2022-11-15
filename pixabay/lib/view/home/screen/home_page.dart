import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixabay/data/api_service/api_service.dart';
import 'package:pixabay/util/app_%20constant.dart';
import 'package:pixabay/view/home/bloc/pixabay_bloc.dart';
import 'package:pixabay/view/widget/app_text_view.dart';

import '../../../util/app_color.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return BlocProvider(
      create: (context) =>
          ImageViewBloc(RepositoryProvider.of<APIService>(context)),
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              dividerH(),
              //search area
              Row(
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
                      onPressed: () {},
                      child: appTextView(
                          name: 'Submit', isBold: true, color: AppColor.kWhite),
                    ),
                  ),
                ],
              ),
              dividerH(),
              Padding(
                padding: commonPaddingLR,
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1 / 1,
                  children: List.generate(
                    20,
                    (index) {
                      return Container(
                        width: screenWidth(context),
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: NetworkImage(
                                'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
