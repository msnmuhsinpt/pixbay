import 'package:flutter/material.dart';
import 'package:pixabay/util/app_color.dart';
import 'package:shimmer/shimmer.dart';

import '../../util/app_ constant.dart';

bool _enabled = true;

Widget homeShimmer(BuildContext context) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.withOpacity(0.6),
    highlightColor: Colors.grey,
    enabled: _enabled,
    child: Padding(
      padding: commonPaddingLR,
      child: GridView.count(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1 / 1,
        children: List.generate(
          3,
          (index) {
            return Container(
              width: screenWidth(context),
              decoration: BoxDecoration(
                color: AppColor.kBlack,
                borderRadius: BorderRadius.circular(10),
              ),
            );
          },
        ),
      ),
    ),
  );
}
