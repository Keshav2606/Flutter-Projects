import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class FullScreen extends StatefulWidget {
  final String imageUrl;
  const FullScreen({super.key, required this.imageUrl});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  setWallpaper() async {
    int location = WallpaperManagerFlutter.BOTH_SCREENS;
    var filePath = await DefaultCacheManager().getSingleFile(widget.imageUrl);

    WallpaperManagerFlutter().setwallpaperfromFile(filePath, location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
              child: Image.network(
            widget.imageUrl,
            fit: BoxFit.cover,
          )),
          SizedBox(
            width: double.infinity,
            height: 30,
            child: Center(
                child: GestureDetector(
                    onTap: () {}, child: const Text('Set Wallpaper'))),
          )
        ],
      ),
    );
  }
}
