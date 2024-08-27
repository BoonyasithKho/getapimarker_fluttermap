// To parse this JSON data, do
//
//     final floodwarningModel = floodwarningModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FloodwarningModel floodwarningModelFromJson(String str) => FloodwarningModel.fromJson(json.decode(str));

String floodwarningModelToJson(FloodwarningModel data) => json.encode(data.toJson());

class FloodwarningModel {
  int status;
  String errMsg;
  List<Datum> data;

  FloodwarningModel({
    required this.status,
    required this.errMsg,
    required this.data,
  });

  FloodwarningModel copyWith({
    int? status,
    String? errMsg,
    List<Datum>? data,
  }) =>
      FloodwarningModel(
        status: status ?? this.status,
        errMsg: errMsg ?? this.errMsg,
        data: data ?? this.data,
      );

  factory FloodwarningModel.fromJson(Map<String, dynamic> json) => FloodwarningModel(
        status: json["status"],
        errMsg: json["errMsg"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "errMsg": errMsg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  double percentage;
  dynamic discharge;
  dynamic flowRate;
  double value;
  DateTime datetime;
  String sid;
  String stationOldCode;
  String stationName;
  double minBank;
  dynamic groundLevel;
  dynamic agencyName;
  dynamic basinName;
  String provinceName;
  String amphoeName;
  String tumbonName;
  int classify;
  double latitude;
  double longitude;

  Datum({
    required this.percentage,
    required this.discharge,
    required this.flowRate,
    required this.value,
    required this.datetime,
    required this.sid,
    required this.stationOldCode,
    required this.stationName,
    required this.minBank,
    required this.groundLevel,
    required this.agencyName,
    required this.basinName,
    required this.provinceName,
    required this.amphoeName,
    required this.tumbonName,
    required this.classify,
    required this.latitude,
    required this.longitude,
  });

  Datum copyWith({
    double? percentage,
    dynamic? discharge,
    dynamic? flowRate,
    double? value,
    DateTime? datetime,
    String? sid,
    String? stationOldCode,
    String? stationName,
    double? minBank,
    dynamic? groundLevel,
    dynamic agencyName,
    dynamic basinName,
    String? provinceName,
    String? amphoeName,
    String? tumbonName,
    int? classify,
    double? latitude,
    double? longitude,
  }) =>
      Datum(
        percentage: percentage ?? this.percentage,
        discharge: discharge ?? this.discharge,
        flowRate: flowRate ?? this.flowRate,
        value: value ?? this.value,
        datetime: datetime ?? this.datetime,
        sid: sid ?? this.sid,
        stationOldCode: stationOldCode ?? this.stationOldCode,
        stationName: stationName ?? this.stationName,
        minBank: minBank ?? this.minBank,
        groundLevel: groundLevel ?? this.groundLevel,
        agencyName: agencyName ?? this.agencyName,
        basinName: basinName ?? this.basinName,
        provinceName: provinceName ?? this.provinceName,
        amphoeName: amphoeName ?? this.amphoeName,
        tumbonName: tumbonName ?? this.tumbonName,
        classify: classify ?? this.classify,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        percentage: json["percentage"]?.toDouble(),
        discharge: json["discharge"]?.toDouble(),
        flowRate: json["flow_rate"]?.toDouble(),
        value: json["value"]?.toDouble(),
        datetime: DateTime.parse(json["datetime"]),
        sid: json["sid"],
        stationOldCode: json["station_old_code"],
        stationName: json["station_name"],
        minBank: json["min_bank"]?.toDouble(),
        groundLevel: json["ground_level"]?.toDouble(),
        agencyName: json["agency_name"],
        basinName: json["basin_name"],
        provinceName: json["province_name"],
        amphoeName: json["amphoe_name"],
        tumbonName: json["tumbon_name"],
        classify: json["classify"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "percentage": percentage,
        "discharge": discharge,
        "flow_rate": flowRate,
        "value": value,
        "datetime": datetime.toIso8601String(),
        "sid": sid,
        "station_old_code": stationOldCode,
        "station_name": stationName,
        "min_bank": minBank,
        "ground_level": groundLevel,
        "agency_name": agencyName,
        "basin_name": basinName,
        "province_name": provinceName,
        "amphoe_name": amphoeName,
        "tumbon_name": tumbonName,
        "classify": classify,
        "latitude": latitude,
        "longitude": longitude,
      };
}
