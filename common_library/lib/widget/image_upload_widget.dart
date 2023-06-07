import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// 多图片上传组件
class ImageUploadWidget extends StatefulWidget {
  const ImageUploadWidget({super.key, this.maxNum, this.imageSize = 50, this.onChange});

  final int? maxNum;
  final double imageSize;
  final Function(List<File> images)? onChange;

  @override
  State<ImageUploadWidget> createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  final List<File> _images = []; // 用于存储选择的图片

  Future<void> _pickImage() async {
    if (widget.maxNum != null && _images.length >= widget.maxNum!) {
      debugPrint('超过上限${widget.maxNum}张');
      return;
    }

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
        if (widget.onChange != null) {
          widget.onChange!(_images);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      children: [
        ..._images.map((image) => SizedBox(
            height: widget.imageSize,
            width: widget.imageSize,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FullScreenImagePage(imageUrl: image.path, image: Image.file(
                      image,
                      fit: BoxFit.cover,
                    )),
                  ),
                );
              },
              child: Stack(
                children: [
                  SizedBox(
                    height: widget.imageSize,
                    width: widget.imageSize,
                    child: Image.file(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                          width: 20,
                          height: 20,
                          child: InkWell(
                              onTap: () {
                                _images.remove(image);
                                setState(() {});
                              },
                              child: const Icon(Icons.close_sharp)))),
                ],
              ),
            ))),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            color: Colors.grey[300],
            child: SizedBox(
                height: widget.imageSize,
                width: widget.imageSize,
                child: const Icon(Icons.add)),
          ),
        ),
      ],
    );
  }
}


/// 全屏看图
class FullScreenImagePage extends StatelessWidget {

  const FullScreenImagePage({super.key, required this.imageUrl, required this.image});

  final String imageUrl;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Hero(
              tag: imageUrl,
              child: image,
            ),
          ),
        ),
      ),
    );
  }
}

