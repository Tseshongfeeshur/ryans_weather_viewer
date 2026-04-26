import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

/// 获取位置服务权限
/// 0 - 定位权限已被授予
/// 1 - 定位服务未开启
/// 2 - 定位权限被拒绝一次
/// 3 - 定位权限被永久拒绝
Future<int> getPositionAccess() async {
  bool serviceEnabled;
  LocationPermission permission;

  // 检查定位服务是否已启用
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // 定位服务未开启
    return 1;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // 定位权限被拒绝
      return 2;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // 定位权限被永久拒绝
    return 3;
  }

  return 0;
}

Future<Position?> getLastPosition() async {
  int code = await getPositionAccess();
  return code == 0 ? await Geolocator.getLastKnownPosition() : null;
}

Future<Position?> getPosition() async {
  int code = await getPositionAccess();
  return code == 0 ? await Geolocator.getCurrentPosition() : null;
}
