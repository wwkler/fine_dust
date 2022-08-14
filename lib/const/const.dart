// API 호출할 떄 필요한 것들
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const URL = 'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst';
const SERVICE_KEY =
    'Doqer/+XMnxMumQAMxOS46MCMeyBiPlPeV2k/0Ey9JjeER14MAH2G39d5dTr1mvQyAAGRWKMsHnPVZQNFWmbNQ==';
const RETURN_TYPE = 'json';
const NUMOFROWS = 100;
const PAGENO = 1;

const DATAGUBUN = 'HOUR';
const SEARCHCONDITION = 'WEEK';

// 한글 지역
const krNameRegions = [
  '대구',
  '충남',
  '인천',
  '대전',
  '경북',
  '세종',
  '광주',
  '전북',
  '강원',
  '울산',
  '전남',
  '서울',
  '부산',
  '제주',
  '충북',
  '경기',
];

// 색깔
const BLUE_COLOR = Color(0xFF7bbee8);

// Text에 Google Font, Font Size, Font Color 적용
final kanitFont = GoogleFonts.kanit(
  textStyle: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
    color: Colors.white,
  ),
);
