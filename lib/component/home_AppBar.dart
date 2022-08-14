import 'package:fine_dust_practice/const/const.dart';
import 'package:fine_dust_practice/model/stat_model.dart';
import 'package:fine_dust_practice/model/status_model.dart';
import 'package:fine_dust_practice/utils/data_utils.dart';
import 'package:flutter/material.dart';

class Home_AppBar extends StatelessWidget {
  final String koreaNameRegion;
  final bool appBarIsExpanded;
  final StatModel recentPM10_stat;
  final StatusModel recentPM10_Status;

  const Home_AppBar({
    required this.koreaNameRegion,
    required this.appBarIsExpanded,
    required this.recentPM10_stat,
    required this.recentPM10_Status,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: BLUE_COLOR,
      toolbarHeight: 50.0,
      expandedHeight: 300.0,
      pinned: true,
      centerTitle: true,
      title: appBarIsExpanded
          ? null
          : Text(
              '${koreaNameRegion} ${DataUtils.changeTimeFormat(recentPM10_stat.dataTime)}',
              style: kanitFont,
            ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          margin: EdgeInsets.only(top: 50.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Image.asset(
                  recentPM10_Status.image,
                  width: 150.0,
                ),
                SizedBox(
                  width: 30.0,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        koreaNameRegion,
                        style: kanitFont,
                      ),
                      Text(
                        DataUtils.changeTimeFormat(recentPM10_stat.dataTime),
                        style: kanitFont,
                      ),
                      Text(
                        recentPM10_Status.title,
                        style: kanitFont,
                      ),
                      Text(
                        '미세먼지 :  ${recentPM10_stat.getRegionValue(koreaNameRegion)} ${DataUtils.getUnitItemCodeName(recentPM10_stat.itemCode)}',
                        style: kanitFont,
                      ),
                      Text(
                        recentPM10_Status.comment,
                        style: kanitFont,
                      ),
                    ],
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
