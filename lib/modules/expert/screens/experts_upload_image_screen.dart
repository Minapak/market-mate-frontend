import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path_provider/path_provider.dart';


class ExpertsUploadImageScreen extends StatefulWidget {
  @override
  _ExpertsUploadImageScreenState createState() => _ExpertsUploadImageScreenState();
}

class _ExpertsUploadImageScreenState extends State<ExpertsUploadImageScreen> {
  List<XFile> images = <XFile>[];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Upload Example'),
        ),
        body: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: loadAssets,
              child: Text('Pick images'),
            ),
            Expanded(
              child: buildGridView(),
            ),
            ElevatedButton(
              onPressed: () async {
                await uploadImages(images);
              },
              child: Text('Upload Images'),
            )
          ],

        ),
      ),
    );
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        XFile image = images[index];
        return Image.file(File(image.path));
      }),
    );
  }

  Future<void> loadAssets() async {

    List<Asset> resultList = <Asset>[];


    try {


      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
      );

      List<XFile> xFileList = await convertAssetsToXFiles(resultList);

      if (!mounted) return;

      setState(() {
        images = xFileList;
        images[0].path; // 첫 번째 이미지의 경로
        for (int i = 0; i < images.length; i++) {
          String imagePath = images[i].path;
          print('Image $i path: $imagePath');
        }
      });
    } on Exception catch (e) {
      print('Error: $e');
    }
  }

  Future<List<XFile>> convertAssetsToXFiles(List<Asset> assets) async {
    List<XFile> xFiles = <XFile>[];

    for (var asset in assets) {
      ByteData byteData = await asset.getByteData();
      Uint8List uint8List = byteData.buffer.asUint8List();

      // 파일 이름 (필요하면 고유한 이름을 생성할 수 있습니다)
      String fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';

      // 바이트를 임시 파일에 저장
      File tempFile = File('${(await getTemporaryDirectory()).path}/$fileName');
      await tempFile.writeAsBytes(uint8List);

      // 파일을 XFile로 변환
      XFile xFile = XFile(tempFile.path);

      xFiles.add(xFile);
    }

    return xFiles;
  }
  final List<XFile> assets = <XFile>[];

  Future<void> uploadImages(List<XFile> images) async {
    if (images.isEmpty) {
      print("No images selected");
      return;
    }

    Dio dio = Dio();

    try {
      FormData formData = FormData.fromMap({
        "package_photo": images.map((image) {
          final file = File(image.path);
          return MultipartFile.fromFile(
            file.path,
            filename: file.uri.toString(),
            //   contentType: MediaType("image", "jpg"),
          );
        }).toList(),
      });

      var response = await dio.put(
        'http://ship-dev.ap-northeast-2.elasticbeanstalk.com/api/v1/users/experts/6/images',
        data: formData,
      );

      print('Response: $response');
    } catch (e) {
      print('Error: $e');
    }
  }
}

class ImageCompressService {
  final Asset asset;

  ImageCompressService({required this.asset});

  exec() async {
    return await _compressAndGetFile(asset);
  }

  Future<XFile?> _compressAndGetFile(Asset asset) async {
    ByteData byteData = await asset.getByteData();
    Uint8List uint8List = byteData.buffer.asUint8List();

    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = "${dir.path}/image_$timestamp.jpg";

    final result = await FlutterImageCompress.compressAndGetFile(
      uint8List as String,
      targetPath,
      minWidth: 600,
      minHeight: 600,
      quality: 50,
    );


    return result;
  }
}