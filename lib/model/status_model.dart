// 최고, 좋음, 양호, 보통, 나쁨, 상당히 나쁨, 최악
// StatusModel를 담는 List 입니다.
List<StatusModel> statusList = [
  StatusModel(
    title: '최고',
    minPM10:  0,
    minPM25: 0,
    minO3: 0,
    minNO2: 0,
    minCO: 0,
    minSO2: 0,
    image: 'assets/imgs/3094840_emoji_happy_emoticon_smile.png',
    comment: '최고단계 입니다.',
  ),
  StatusModel(
    title: '좋음',
    minPM10: 16,
    minPM25: 9,
    minO3: 0.02,
    minNO2: 0.02,
    minCO: 1,
    minSO2: 0.01,
    image: 'assets/imgs/3094844_happy_emoji_fake_smile_emoticon.png',
    comment: '좋음단계 입니다.',
  ),
  StatusModel(
    title: '양호',
    minPM10: 31,
    minPM25: 16,
    minO3: 0.03,
    minNO2: 0.03,
    minCO: 2,
    minSO2: 0.02,
    image: 'assets/imgs/3094820_emoticon_happy_emoji_satisfacted_smile.png',
    comment: '양호단계 입니다.',
  ),
  StatusModel(
    title: '보통',
    minPM10: 41,
    minPM25: 21,
    minO3: 0.06,
    minNO2: 0.05,
    minCO: 5.5,
    minSO2: 0.04,
    image: 'assets/imgs/3094828_positive_smile_happy_emoji_emoticon_emotion_wink.png',
    comment: '보통단계 입니다.',
  ),
  StatusModel(
    title: '나쁨',
    minPM10: 51,
    minPM25: 26,
    minO3: 0.09,
    minNO2: 0.06,
    minCO: 9,
    minSO2: 0.05,
    image: 'assets/imgs/3094832_emoticon_sad_pain_emoji.png',
    comment: '나쁨단계 입니다.',
  ),
  StatusModel(
    title: '상당히나쁨',
    minPM10: 76,
    minPM25: 38,
    minO3: 0.12,
    minNO2: 0.13,
    minCO: 12,
    minSO2: 0.1,
    image: 'assets/imgs/3094830_emoji_emoticon_sad_upset.png',
    comment: '상당히나쁨 단계 입니다.',
  ),
  StatusModel(
    title: '매우 나쁨',
    minPM10: 101,
    minPM25: 51,
    minO3: 0.15,
    minNO2: 0.2,
    minCO: 15,
    minSO2: 0.15,
    image: 'assets/imgs/3094834_emoticon_emoji_crying_sad_tears.png',
    comment: '매우나쁨 단계 입니다.',
  ),
  StatusModel(
    title: '최악',
    minPM10: 151,
    minPM25: 76,
    minO3: 0.38,
    minNO2: 1.1,
    minCO: 32,
    minSO2: 0.16,
    image: 'assets/imgs/3094838_omg_emoticon_anime_manga_surprised_emoji.png',
    comment: '최악 단계 입니다.',
  ),
];

class StatusModel {
  // 최고, 좋음, 보통 ..을 표시
  final String title;

  // 최저 PM10(미세먼지) 농도
  final double minPM10;

  // 최저 PM25(초미세먼지) 농도
  final double minPM25;

  // 최저 O3(오존) 농도
  final double minO3;

  // 최저 NO2(이산화질소) 농도
  final double minNO2;

  // 최저 CO(일산화탄소) 농도
  final double minCO;

  // 최저 SO2(아황산가스) 농도
  final double minSO2;

  // 이미지
  final String image;

  // 부연 설명
  final String comment;

  // Default Constructor
  StatusModel({
    required this.title,
    required this.minPM10,
    required this.minPM25,
    required this.minO3,
    required this.minNO2,
    required this.minCO,
    required this.minSO2,
    required this.image,
    required this.comment,
  });
}
