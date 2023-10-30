import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'dart:io';

class ImageUploader {
  static const _timeOutConnection = 15;
  static const _host = 'http://ship-dev.ap-northeast-2.elasticbeanstalk.com/api/v1/users/experts/6/images';

  static List<XFile> images = [];

  static Future<String> uploadImage({required Map<String, String> data}) async {
    late Future<String> serverResponse;
    int? statusCode;

    final dio = Dio();  // Dio 클라이언트 생성

    if (images.isNotEmpty) {


      for (final img in images) {
        final imageName = img.path.split("/").last;
        final stream = File(img.path).readAsBytes().asStream();
        final length = File(img.path).lengthSync();

        final formData = FormData.fromMap({
          "sellerId": data["sellerId"]!,
          "productName": data['productName']!,
          "description": data['description']!,
          "price": data['price']!,
          "stock": data['stock']!,
          "token": data["token"]!,

        });

        Stream<List<int>> compressImageAsStream(File imageFile) async* {
          final originalBytes = await imageFile.readAsBytes();
          final compressedBytes = await FlutterImageCompress.compressWithList(
            originalBytes,
            quality: 50, // 이미지 품질 조정 (원하는 대로 조절)
          );

          yield compressedBytes;
        }

        final imageFile = File(img.path);
        final compressedImageStream = compressImageAsStream(imageFile);

        Future<void> uploadCompressedImage(List<int> compressedBytes) async {
          try {
            final response = await dio.put(
              _host,
              data: formData,
              queryParameters: {
                // 다른 필요한 query 파라미터 추가 가능
              },
              options: Options(
                headers: {
                  HttpHeaders.contentTypeHeader: 'multipart/form-data',
                },
              ),
              onSendProgress: (sent, total) {
                final progress = (sent / total * 100).toStringAsFixed(2);
                print('Uploading: $progress%');
              },
            );

            if (response.statusCode == 200) {
              print('이미지 업로드 성공!');
              print('서버 응답: ${response.data}');
            } else {
              print('이미지 업로드 실패: ${response.statusCode}');
            }
          } catch (e) {
            print('오류 발생: $e');
          }
        }

        compressedImageStream.listen((compressedBytes) {
          uploadCompressedImage(compressedBytes);
        });
      }


    } else {
      serverResponse = Future.value(jsonEncode(
        {
          "error": true,
          "message": "No image selected",
          "data": {},
        },
      ));
      _showCustomToast(messages: "Please select at least one image");
    }

    return serverResponse;
  }

  static _showCustomToast({required String messages}) {
    return Fluttertoast.showToast(
      msg: messages,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}