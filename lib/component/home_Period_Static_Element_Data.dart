import 'package:fine_dust_practice/const/const.dart';
import 'package:fine_dust_practice/model/stat_model.dart';
import 'package:fine_dust_practice/model/status_model.dart';
import 'package:fine_dust_practice/utils/data_utils.dart';
import 'package:flutter/material.dart';

class Home_Period_Static_Element_Data extends StatelessWidget {
  final String koreaNameRegion;
  final double width;
  final StatModel stat;

  const Home_Period_Static_Element_Data({
    required this.koreaNameRegion,
    required this.width,
    required this.stat,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Stat에 기반한 StatusModel을 가져온다.
    StatusModel status = DataUtils.getStatusModel(
      stat.getRegionValue(koreaNameRegion),
      stat.itemCode,
    );

    return Container(
      alignment: Alignment.topCenter,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '${stat.dataTime.hour} 시',
            style: kanitFont.copyWith(
              fontSize: 15.0,
              color: Color(0xFFFF8868),
            ),
          ),
          Image.asset(
            status.image,
            width: 40.0,
          ),
          Text(
            status.title,
            style: kanitFont.copyWith(
              fontSize: 14.0,
              color: Color(0xFFFF8868),
            ),
          ),
          Text(
            '${stat.getRegionValue(koreaNameRegion)} ${DataUtils.getUnitItemCodeName(stat.itemCode)}',
            style: kanitFont.copyWith(
              fontSize: 14.0,
              color: Color(0xFFFF8868),
            ),
          ),
        ],
      ),
    );
  }
}
