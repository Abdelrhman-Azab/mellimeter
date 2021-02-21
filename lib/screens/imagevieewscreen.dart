import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageVieewScreen extends StatelessWidget {
  final String imageurl;
  final String id;
  ImageVieewScreen(this.imageurl, this.id);

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: PhotoView(
          minScale: 0.38,
          heroAttributes: PhotoViewHeroAttributes(tag: id),
          imageProvider: NetworkImage(imageurl),
        ),
      ),
    );
  }
}
