import 'package:fine_dust_practice/const/const.dart';
import 'package:fine_dust_practice/model/stat_model.dart';
import 'package:fine_dust_practice/model/status_model.dart';
import 'package:fine_dust_practice/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home_Type_Static_Element extends StatelessWidget {
  final String koreaNameRegion;
  final double width;
  final ItemCode itemCode;

  const Home_Type_Static_Element({
    required this.koreaNameRegion,
    required this.width,
    required this.itemCode,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box<StatModel>(itemCode.name).listenable(),
      builder: (BuildContext context, Box box, Widget? child) {
        // PM10, PM25 Box에서 가장 최신 StatModel을 가져온다.
        StatModel recentStatModel = box.values.last;
        StatusModel recentStatusModel = DataUtils.getStatusModel(
          recentStatModel.getRegionValue(koreaNameRegion),
          itemCode,
        );

        return Container(
          width: width,
          child: Column(
            children: [
              // 이름
              Text(
                DataUtils.getKrItemCodeName(itemCode),
                style: kanitFont.copyWith(
                  fontSize: 20.0,
                  color: Color(0xFFFF8868),
                ),
              ),

              // 아이콘
              Image.asset(
                recentStatusModel.image,
                width: 50.0,
              ),

              // 코멘트
              Text(
                recentStatusModel.comment,
                style: kanitFont.copyWith(
                  fontSize: 15.0,
                  color: Color(0xFFFF8868),
                ),
              ),

              // 수치
              Text(
                '${recentStatModel.getRegionValue(koreaNameRegion)} ${DataUtils.getUnitItemCodeName(itemCode)}',
                style: kanitFont.copyWith(
                  fontSize: 15.0,
                  color: Color(0xFFFF8868),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
