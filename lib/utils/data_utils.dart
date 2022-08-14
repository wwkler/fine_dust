
import 'package:dio/dio.dart';
import 'package:fine_dust_practice/const/const.dart';
import 'package:fine_dust_practice/model/stat_model.dart';
import 'package:fine_dust_practice/model/status_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataUtils {
  // PM10, PM25... 6개 종류별 API를 동시 다발적으로 호출하는 Method
  static Future<void> call_6_ItemCodes() async {
    try {
      List<Future> statss = [];

      DateTime currentDateTime = DateTime.now().add(
        Duration(hours: 9),
      );

      currentDateTime = DateTime(
        currentDateTime.year,
        currentDateTime.month,
        currentDateTime.day,
        currentDateTime.hour,
      );

      // Box에 데이터가 있는 경우, 최신 시간대이면 API를 호출하지 않는다.
      Box<StatModel> pm10Box = Hive.box<StatModel>(ItemCode.PM10.name);
      if (pm10Box.isNotEmpty &&
          currentDateTime.isAtSameMomentAs(DateTime.parse(pm10Box.keys.last))) {
        Fluttertoast.showToast(
          msg: '최신 시간대이므로 데이터를 요청하지 않습니다.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red[100],
          textColor: Colors.white,
          fontSize: 15.0,
        );

        return;
      }

      // Box에 데이터가 비어있거나
      // 같은 Hour이 아니면 API를 호출한다.

      // option1
      for (ItemCode itemCode in ItemCode.values) {
        // async Method
        Future<List<StatModel>> stats = getAPIData(itemCode);
        statss.add(stats);
      }

      // map으로 하니까 안받아오지네
      // ItemCode.values.map(
      //   (ItemCode itemCode) {
      //     //async Method
      //     Future<List<StatModel>> stats = getAPIData(itemCode);
      //     statss.add(stats);
      //   },
      // );

      // 요청한 순서대로 차곡차곡 적립
      final result = await Future.wait(statss);

      useHiveBox(result);
    }

    // NetWork가 연결되어 있지 않을 떄
    on DioError {
      Fluttertoast.showToast(
        msg: '네트워크가 연결되어있지 않습니다.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[100],
        textColor: Colors.white,
        fontSize: 15.0,
      );
    }
  }

  // ItemCode.name 별로 API 호출하고 Model Class로 변환하는 Method
  static Future<List<StatModel>> getAPIData(ItemCode itemCode) async {
    final response = await Dio().get(
      URL,
      queryParameters: {
        'serviceKey': SERVICE_KEY,
        'returnType': RETURN_TYPE,
        'numOfRows': NUMOFROWS,
        'pageNo': PAGENO,
        'itemCode': itemCode.name,
        'dataGubun': DATAGUBUN,
        'searchCondition': SEARCHCONDITION,
      },
    );

    // Model Class로 변환하는 부분
    return response.data['response']['body']['items'].map<StatModel>(
      (jsonElement) {
        return StatModel.fromJson(jsonElement);
      },
    ).toList();
  }

  // Hive Box에 Model Class를 저장하는 Method
  static void useHiveBox(final result) {
    // Hive Box에 Data 저장하기
    for (int i = 0; i < result.length; i++) {
      Box<StatModel> box = Hive.box<StatModel>(ItemCode.values[i].name);

      List<StatModel> stats = result[i];

      for (StatModel stat in stats) {
        // 무조건 차례대로 들어가는 것이 아니라 Key값에 따라 정렬되서 들어간다....
        box.put(stat.dataTime.toString(), stat);
      }

      // Box에 언제나 데이터가 5개만 가질 수 있도록 하는 Code
      if (box.length > 5) {
        final partialKeys = box.keys.toList().sublist(0, box.length - 5);

        box.deleteAll(partialKeys);
      }

      // Box에 데이터가 5개인지 확인하는 Test Code
      print('Box Name : ${ItemCode.values[i].name}');
      print('Key List : ${box.keys.toList()}');
    }

    // 데이터를 호출했다는 Toast Message 띄우기
    Fluttertoast.showToast(
      msg: '데이터를 호출했습니다.',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red[100],
      textColor: Colors.white,
      fontSize: 15.0,
    );
  }

  // StatModel에 있는 info를 바탕으로 StatusModel을 가져오는 Method
  static StatusModel getStatusModel(
    String number,
    ItemCode itemCode,
  ) {
    return statusList.lastWhere(
      (status) {
        if (itemCode.name == 'PM10') {
          return status.minPM10 < double.parse(number);
        } else if (itemCode.name == 'PM25') {
          return status.minPM25 < double.parse(number);
        } else if (itemCode.name == 'O3') {
          return status.minO3 < double.parse(number);
        } else if (itemCode.name == 'NO2') {
          return status.minO3 < double.parse(number);
        } else if (itemCode.name == 'CO') {
          return status.minCO < double.parse(number);
        } else if (itemCode.name == 'SO2') {
          return status.minSO2 < double.parse(number);
        } else {
          throw ('Error 입니다.');
        }
      },
    );
  }

  // Seconds까지 자세히 나온 시간대를 Minute까지만 표현하는 Method
  static String changeTimeFormat(DateTime dataTime) {
    return '${dataTime.year}-${padLeftTime(dataTime.month.toString())}-${padLeftTime(dataTime.day.toString())} ${padLeftTime(dataTime.hour.toString())}:${padLeftTime(dataTime.second.toString())}';
  }

  // Month, Day, Hour, Minute 모두 2자리로 나타나게 하는 Method
  static String padLeftTime(String time) {
    return time.padLeft(2, '0');
  }

  // ItemCode.name에 따라 한글을 가져오는 Method
  static String getKrItemCodeName(ItemCode itemCode) {
    if (itemCode.name == 'PM10') {
      return '미세먼지';
    } else if (itemCode.name == 'PM25') {
      return '초미세먼지';
    } else if (itemCode.name == 'O3') {
      return '오존';
    } else if (itemCode.name == 'NO2') {
      return '이산화질소';
    } else if (itemCode.name == 'CO') {
      return '일산화탄소';
    } else if (itemCode.name == 'SO2') {
      return '아황산가스';
    } else {
      throw ('에러');
    }
  }

  // ItemCode.name에 따라 단위를 가져오는 Method
  static String getUnitItemCodeName(ItemCode itemCode) {
    switch (itemCode) {
      case ItemCode.PM10:
        return '㎍/m³';

      case ItemCode.PM25:
        return '㎍/m³';

      default:
        return 'ppm';
    }
  }
}
