import 'package:fine_dust_practice/component/home_Type_Static_Data.dart';
import 'package:fine_dust_practice/const/const.dart';
import 'package:fine_dust_practice/model/stat_model.dart';
import 'package:fine_dust_practice/model/status_model.dart';
import 'package:fine_dust_practice/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home_Type_Static extends StatelessWidget {
  final String koreaNameRegion;

  const Home_Type_Static({
    required this.koreaNameRegion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        // color: BLUE_COLOR,
        height: 225,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 12.0,
          ),
          child: Card(
            color: Color(0xFFFFDE66),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
            child: Column(
              children: [
                // "종류별 통계 Text"
                Container(
                  margin: EdgeInsets.only(
                    top: 5.0,
                    bottom: 20.0,
                  ),
                  child: Text(
                    '종류별 통계',
                    style: kanitFont.copyWith(
                      color: Colors.black45,
                    ),
                  ),
                ),

                // Horizontal ListView
                Expanded(
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      double width = constraints.maxWidth / 2;
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        physics: PageScrollPhysics(),
                        children: ItemCode.values
                            .map(
                              (ItemCode itemCode) => Home_Type_Static_Element(
                                koreaNameRegion: koreaNameRegion,
                                width: width,
                                itemCode: itemCode,
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
