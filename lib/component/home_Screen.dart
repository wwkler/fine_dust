import 'package:fine_dust_practice/component/home_AppBar.dart';
import 'package:fine_dust_practice/component/home_Drawer.dart';
import 'package:fine_dust_practice/component/home_Period_Static.dart';
import 'package:fine_dust_practice/component/home_Type_Static.dart';
import 'package:fine_dust_practice/const/const.dart';
import 'package:fine_dust_practice/model/stat_model.dart';
import 'package:fine_dust_practice/model/status_model.dart';
import 'package:fine_dust_practice/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 한글 지역 이름
  String koreaNameRegion = krNameRegions[0];

  ScrollController scrollController = ScrollController();
  bool appBarIsExpanded = true;

  @override
  void initState() {
    super.initState();

    // Listener 등록
    scrollController.addListener(scrollListener);

    // async method
    DataUtils.call_6_ItemCodes();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();

    super.dispose();
  }

  // ScrollListener
  scrollListener() {
    bool appBarIsExpanded = scrollController.offset < 300 - 50;

    if (this.appBarIsExpanded != appBarIsExpanded) {
      setState(() {
        this.appBarIsExpanded = appBarIsExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box<StatModel>(ItemCode.PM10.name).listenable(),
      builder: (BuildContext context, Box box, Widget? child) {
        if (box.keys.isEmpty) {
          return Scaffold(
            backgroundColor: BLUE_COLOR,
            body: SafeArea(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        // PM10의 최신 시간대 StatModel과 StatusModel을 가져온다.
        StatModel recentPM10_Stat = box.values.last;
        StatusModel recentPM10_Status = DataUtils.getStatusModel(
          recentPM10_Stat.getRegionValue(koreaNameRegion),
          recentPM10_Stat.itemCode,
        );

        return Scaffold(
          backgroundColor: BLUE_COLOR,
          // Drawer
          drawer: Home_Drawer(
            koreaNameRegion: koreaNameRegion,
            selectKrNameRegion: (String krNameRegion) {
              setState(() {
                this.koreaNameRegion = krNameRegion;
              });
              Navigator.of(context).pop();
            },
          ),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                await DataUtils.call_6_ItemCodes();
              },
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  // SliverAppBar
                  Home_AppBar(
                    koreaNameRegion: koreaNameRegion,
                    appBarIsExpanded: appBarIsExpanded,
                    recentPM10_stat: recentPM10_Stat,
                    recentPM10_Status: recentPM10_Status,
                  ),

                  // "종류별 통계"
                  Home_Type_Static(koreaNameRegion: koreaNameRegion),

                  // 수직 간격을 정한다.
                  const SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),

                  // "시간별 미세먼지, 시간별 초미세먼지" 등을 보여주는 SliverGridView
                  Home_Period_Static(koreaNameRegion: koreaNameRegion),

                  // 수직 간격을 정한다.
                  const SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
