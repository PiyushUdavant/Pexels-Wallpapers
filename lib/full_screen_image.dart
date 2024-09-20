// ignore: unused_import
import 'dart:io';

import'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_plus/wallpaper_manager_plus.dart';

class FullScreenImage extends StatefulWidget {
  final String imageUrl;
  const FullScreenImage({super.key,required this.imageUrl});

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {

  Future<void> setWallpaper() async{
    int location = WallpaperManagerPlus.homeScreen;
    var file = await DefaultCacheManager().getSingleFile(widget.imageUrl);
    String? result = await WallpaperManagerPlus().setWallpaper(file, location); 
    bool isSuccess = result != null && result.toLowerCase() == 'success';
    if(isSuccess){
      // ignore: avoid_print
      print('Wallpaper Set Successfully !!!');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children:[
            Expanded(
              child:Container(
                child:Image.network(
                  widget.imageUrl,
                  fit:BoxFit.cover,
                  ),
              )
            ),
            Center(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,),
                  borderRadius: BorderRadius.circular(5),
                  color:Colors.blue,
                ),
                child: TextButton(
                  onPressed: setWallpaper,
                  child: const Text(
                    'Set Wallpaper',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    )
                  )
                ),
              ),
            )
          ]
        )
      )
    );
  }
}

//Things done from my side: 
// 1) added path_provider dependency
// 2) added enableOnInovkedCallBack = true in AndroidManifest.xml
// 3) added ensureInitialized inside void main() of main.dart file