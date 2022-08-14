import 'package:fine_dust_practice/component/home_Period_Static_Element_Data.dart';
import 'package:fine_dust_practice/const/const.dart';
import 'package:fine_dust_practice/model/stat_model.dart';
import 'package:fine_dust_practice/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home_Perid_Static_Element extends StatelessWidget {
  final String koreaNameRegion;
  final ItemCode itemCode;
  List<StatModel> recent5stats = [];

  Home_Perid_Static_Element({
    required this.koreaNameRegion,
    required this.itemCode,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box<StatModel>(itemCode.name).listenable(),
      builder: (BuildContext context, Box box, Widget? child) {
        // Box에 최신 5개 데이터만 가져오려고 한다.
        for (int i = 1; i <= box.length; i++) {
          recent5stats.add(
            box.getAt(box.length - i),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 12.0,
          ),
          child: Card(
            color: Color(0xFFFFDE66),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '시간별 ${DataUtils.getKrItemCodeName(itemCode)}',
                    style: kanitFont.copyWith(
                      color: Colors.black45,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      double width = constraints.maxWidth / 1;
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        physics: PageScrollPhysics(),
                        children: recent5stats
                            .map(
                              (StatModel stat) =>
                                  Home_Period_Static_Element_Data(
                                      koreaNameRegion: koreaNameRegion,
                                      width: width,
                                      stat: stat),
                            )
                            .toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
