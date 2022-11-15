import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixabay/model/search_model.dart';
import 'package:pixabay/view/home/bloc/pixabay_bloc.dart';

import '../../../api/api_service/api_service.dart';
import '../../../util/app_ constant.dart';
import '../../../util/app_color.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ImageViewBloc imageViewBloc;
  List<SearchModel> searchList = [];
  List<SearchModel> tempSearchList = [];
  bool isSearch = false;
  TextEditingController searchController = TextEditingController();

  onItemChanged(String value) {
    if (value == "") {
      setState(() {
        isSearch = false;
        tempSearchList.clear();
      });
    } else {
      setState(() {
        isSearch = true;
        tempSearchList = searchList
            .where((SearchModel data) =>
                data.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    imageViewBloc = ImageViewBloc(RepositoryProvider.of<APIService>(context));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => imageViewBloc,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              searchArea(),
              dividerH(),
              Expanded(
                child: Padding(
                  padding: commonPaddingLR5,
                  child: BlocConsumer(
                    listener: (context, state) {
                      if (state is ImageViewLoadedState) {
                        searchList.clear();
                        for (int i = 0; i < state.response.hits!.length; i++) {
                          searchList.add(
                            SearchModel(
                              name: state.response.hits![i].tags.toString(),
                            ),
                          );
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is NoInternetState) {}
                      if (state is ImageViewInitialState) {
                        //shimmer
                      }
                      if (state is ImageViewLoadingState) {
                        //shiimer
                      }
                      if (state is ImageViewLoadedState) {
                        return imageViewUi(
                            isSearch ? tempSearchList : searchList, );
                      }
                      if (state is ErrorState) {
                        return const Center(
                          child: Text(
                            'Something went wrong',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                        );
                      }
                      if (state is UnAuthorizedState) {
                        return const Center(
                          child: Text(
                            'Please Logout!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        );
                      } else {
                        return imageViewUi(
                            isSearch ? tempSearchList : searchList,);
                      }
                    },
                  ),
                ),
              ),
              dividerH(),
            ],
          ),
        ),
      ),
    );
  }

  //search bar
  Widget searchArea() {
    return Column(children: [
      SizedBox(
        height: 50,
        child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                onItemChanged(value);
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  hintText: "Search....",
                  suffixIcon: IconButton(
                    onPressed: () {
                      isSearch ? clearSearch() : doSearch();
                    },
                    icon: isSearch
                        ? const Icon(
                            Icons.clear,
                            color: Colors.black,
                          )
                        : const Icon(Icons.search, color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(color: AppColor.kBlue, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(color: AppColor.kBlue, width: 1.8),
                  )),
            )),
      ),
    ]);
  }

  //image view
  Widget imageViewUi(List<SearchModel> list) {
    return GridView.count(
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
    );
  }

  clearSearch() {
    setState(() {
      searchController.clear();
      isSearch = false;
    });
  }

  doSearch() {
    setState(() {
      onItemChanged(searchController.text.toString());
    });
  }
}
