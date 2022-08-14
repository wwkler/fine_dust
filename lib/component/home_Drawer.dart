import 'package:fine_dust_practice/const/const.dart';
import 'package:flutter/material.dart';

typedef SelectKrNameRegion = void Function(String krNameRegion);

class Home_Drawer extends StatelessWidget {
  final String koreaNameRegion;
  final SelectKrNameRegion selectKrNameRegion;

  const Home_Drawer({
    required this.koreaNameRegion,
    required this.selectKrNameRegion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // DrawerHeader
          // DrawerHeader에 image 넣을 예정
          DrawerHeader(
            decoration: BoxDecoration(
              color: BLUE_COLOR,
            ),
            child: Text(
              '지역선택',
              style: kanitFont.copyWith(color: Colors.blue),
            ),
          ),

          // ListTiles
          ...krNameRegions.map(
            (String krNameRegion) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  margin: EdgeInsets.only(bottom: 20.0),
                  elevation: 2.0,
                  child: ListTile(
                    title: Text(
                      krNameRegion,
                      style: kanitFont.copyWith(
                        fontSize: 15.0,
                        color: Colors.blue,
                      ),
                    ),
                    onTap: () {
                      selectKrNameRegion(krNameRegion);
                    },
                    selected: koreaNameRegion == krNameRegion,
                    selectedTileColor: Colors.yellow[300],
                  ),
                ),
              );
            },
          ).toList(),
        ],
      ),
    );
  }
}
