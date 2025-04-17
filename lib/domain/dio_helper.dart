import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioHelper {
  static Dio? dio;
  static String? _baseUrl;

  static Future<void> init() async {
    _baseUrl = await _getBaseUrl();

    dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl!,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 266),
        receiveTimeout: const Duration(seconds: 266),
      ),
    );
  }

  static Future<String> _getBaseUrl() async {
    const String localhost = '127.0.0.1';
    const String androidEmulatorHost = '10.0.2.2';
    const int port = 5000;

    if (kIsWeb) {
      return 'http://$localhost:$port'; // Web uses localhost directly
    }

    // Check if running on Android emulator
    if (Platform.isAndroid) {
      final isEmulator = await _isAndroidEmulator();
      final host = isEmulator ? androidEmulatorHost : localhost;
      return 'http://$host:$port';
    }

    // iOS and other platforms
    return 'http://$localhost:$port';
  }

  static Future<bool> _isAndroidEmulator() async {
    try {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      return !deviceInfo.isPhysicalDevice;
    } catch (e) {
      // Fallback check for Android
      try {
        final process = await Process.run('getprop', ['ro.boot.qemu']);
        return process.stdout.toString().trim() == '1';
      } catch (_) {
        return false;
      }
    }
  }

  // Rest of your methods remain the same...
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio?.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
    String? token,
    String? contentType,
  }) async {
    dio?.options.headers = {
      if (contentType != null) 'Content-Type': contentType,
      if (token != null) 'Authorization': 'Bearer $token',
    };
    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );
  }

  static Future<Response> uploadVideo({
    required String url,
    required FormData formData,
    String? token,
    void Function(int, int)? onSendProgress,
  }) async {
    dio?.options.headers = {
      if (token != null) 'Authorization': 'Bearer $token',
    };
    return await dio!.post(
      url,
      data: formData,
      onSendProgress: onSendProgress,
      options: Options(
        contentType: 'multipart/form-data',
        responseType: ResponseType.bytes,
      ),
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String lang = 'ar',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': '$token',
    };
    return await dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String url,
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token',
    };
    return await dio!.delete(url);
  }
}
