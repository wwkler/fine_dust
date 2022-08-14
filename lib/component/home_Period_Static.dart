import 'package:fine_dust_practice/component/home_Period_Static_Element.dart';
import 'package:fine_dust_practice/model/stat_model.dart';
import 'package:flutter/material.dart';

class Home_Period_Static extends StatelessWidget {
  final String koreaNameRegion;

  const Home_Period_Static({required this.koreaNameRegion, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      childAspectRatio: 0.95,
      children: ItemCode.values
          .map(
            (ItemCode itemCode) => Home_Perid_Static_Element(
                koreaNameRegion: koreaNameRegion, itemCode: itemCode),
          )
          .toList(),
    );
  }
}
