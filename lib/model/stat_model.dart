import 'package:hive/hive.dart';

part 'stat_model.g.dart';

@HiveType(typeId: 0)
enum ItemCode {
  // 미세먼지
  @HiveField(0)
  PM10,

  @HiveField(1)
  // 초미세먼지
  PM25,

  @HiveField(2)
  // 오존
  O3,

  @HiveField(3)
  // 이산화질소
  NO2,

  @HiveField(4)
  // 일산화탄소
  CO,

  @HiveField(5)
  // 아황산가스
  SO2,
}

@HiveType(typeId: 1)
class StatModel {
  @HiveField(0)
  final String daegu;
  @HiveField(1)
  final String chungnam;
  @HiveField(2)
  final String incheon;
  @HiveField(3)
  final String daejeon;
  @HiveField(4)
  final String gyeongbuk;
  @HiveField(5)
  final String sejong;
  @HiveField(6)
  final String gwangju;
  @HiveField(7)
  final String jeonbuk;
  @HiveField(8)
  final String gangwon;
  @HiveField(9)
  final String ulsan;
  @HiveField(10)
  final String jeonnam;
  @HiveField(11)
  final String seoul;
  @HiveField(12)
  final String busan;
  @HiveField(13)
  final String jeju;
  @HiveField(14)
  final String chungbuk;
  @HiveField(15)
  final String gyeongnam;
  @HiveField(16)
  final String gyeonggi;
  @HiveField(17)
  final DateTime dataTime;
  @HiveField(18)
  final ItemCode itemCode;

  // Default Constructor
  StatModel({
    required this.daegu,
    required this.chungnam,
    required this.incheon,
    required this.daejeon,
    required this.gyeongbuk,
    required this.sejong,
    required this.gwangju,
    required this.jeonbuk,
    required this.gangwon,
    required this.ulsan,
    required this.jeonnam,
    required this.seoul,
    required this.busan,
    required this.jeju,
    required this.chungbuk,
    required this.gyeongnam,
    required this.gyeonggi,
    required this.dataTime,
    required this.itemCode,
  });

  // JSON Data를 Model Class로 변환하는 Constructor
  StatModel.fromJson(Map<String, dynamic> jsonElement)
      : daegu = jsonElement['daegu'] ?? '0',
        chungnam = jsonElement['chungnam'] ?? '0',
        incheon = jsonElement['incheon'] ?? '0',
        daejeon = jsonElement['daejeon'] ?? '0',
        gyeongbuk = jsonElement['gyeongbuk'] ?? '0',
        sejong = jsonElement['sejong'] ?? '0',
        gwangju = jsonElement['gwangju'] ?? '0',
        jeonbuk = jsonElement['jeonbuk'] ?? '0',
        gangwon = jsonElement['gangwon'] ?? '0',
        ulsan = jsonElement['ulsan'] ?? '0',
        jeonnam = jsonElement['jeonnam'] ?? '0',
        seoul = jsonElement['seoul'] ?? '0',
        busan = jsonElement['busan'] ?? '0',
        jeju = jsonElement['jeju'] ?? '0',
        chungbuk = jsonElement['chungbuk'] ?? '0',
        gyeongnam = jsonElement['gyeongnam'] ?? '0',
        gyeonggi = jsonElement['gyeonggi'] ?? '0',
        dataTime = DateTime.parse(jsonElement['dataTime']),
        itemCode = getCorrectItemCode(jsonElement['itemCode']);

  // ItemCode Name를 알맞게 바꾸는 Method
  // Why needed? : json에 있는 itemCode가 PM2.5로 나오므로 이를 PM25로 바꿔야 한다.
  static ItemCode getCorrectItemCode(String jsonItemCode) {
    if (jsonItemCode == 'PM2.5') {
      return ItemCode.PM25;
    }

    return ItemCode.values
        .firstWhere((itemCode) => itemCode.name == jsonItemCode);
  }

  // 한글 지역 이름을 가지고, 농도 값을 찾는 Method
  String getRegionValue(String krNameRegion) {
    if (krNameRegion == '대구') {
      return this.daegu;
    } else if (krNameRegion == '충남') {
      return this.chungnam;
    } else if (krNameRegion == '인천') {
      return this.incheon;
    } else if (krNameRegion == '대전') {
      return this.daejeon;
    } else if (krNameRegion == '경북') {
      return this.gyeongbuk;
    } else if (krNameRegion == '세종') {
      return this.sejong;
    } else if (krNameRegion == '광주') {
      return this.gwangju;
    } else if (krNameRegion == '전북') {
      return this.jeonbuk;
    } else if (krNameRegion == '강원') {
      return this.gangwon;
    } else if (krNameRegion == '울산') {
      return this.ulsan;
    } else if (krNameRegion == '전남') {
      return this.jeonnam;
    } else if (krNameRegion == '서울') {
      return this.seoul;
    } else if (krNameRegion == '부산') {
      return this.busan;
    } else if (krNameRegion == '제주') {
      return this.jeju;
    } else if (krNameRegion == '충북') {
      return this.chungbuk;
    } else if (krNameRegion == '경기') {
      return this.gyeonggi;
    } else {
      throw ('지역 에러');
    }
  }
}
