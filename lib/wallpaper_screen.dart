
// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_interpolation_to_compose_strings

import 'dart:convert';

import'package:flutter/material.dart';
import'package:http/http.dart' as http;
import 'package:wallpaper_app/full_screen_image.dart';

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({super.key});

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {

  List images = [];
  int page =1;
  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  fetchApi() async{ // Function created to fetch the images from pexels.
    await http.get( // We will call this function to fetch the images.
      Uri.parse(
        'https://api.pexels.com/v1/curated?per_page=80'
        //Here , '?per_page=80' is added from our side and the url is taken from pexels api documentation which you can read at
        // https://www.pexels.com/api/documentation/#photos-curated
      ),
      headers:{
        'Authorization' : 'C9mqOZmoHrvjoSXnsGcLQ3UlRk9KK6oWxCzWqOPguV3riqK9xkQWKOZC'
      }).then((value) {
        Map result = json.decode(value.body);
        setState(() {
          images = result['photos'];
        });
        print(images); 
        print(images.length);
        //printing to check the id's and the no.of images we are fetching per page
      });
  }

  loadMore() async{
    setState(() {
      page = page++;
    });
    String url = 'https://api.pexels.com/v1/curated?per_page=80&page=' 
    + page.toString();
    await http.get( 
      Uri.parse(url),
      headers:{
        'Authorization' : 'C9mqOZmoHrvjoSXnsGcLQ3UlRk9KK6oWxCzWqOPguV3riqK9xkQWKOZC'
      }).then((value) {
        Map result = json.decode(value.body);
        setState(() {
          images.addAll(result['photos']);
        });
      });
        
      
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pexels Wallpapers'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Color.fromARGB(0, 0, 0, 1),
              child: GridView.builder(
                itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  childAspectRatio: 2/3,
                ), 
                itemBuilder: (context ,index){
                  return InkWell(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => FullScreenImage(
                          imageUrl: images[index]['src']['large2x'],
                        )
                      ));
                    },
                    child: Container(
                      child: Image.network(
                        images[index]['src']['tiny'],
                        fit: BoxFit.cover,
                      ),
                      color: Colors.white,
                    ),
                  );
                }
              )
            )
          ),
          Container(
            height: 45,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey,),
              borderRadius: BorderRadius.circular(5),
              color:Colors.blue,
            ),
            child: TextButton(
              onPressed: loadMore,
              child: Text(
                'Load More',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                )
              )
            ),
          )
        ]
      )
    );
  }
}

//Line No.67 : If you go through the documentation you will understand that the id's of images are stored inside the 'src' list and there are different types of images for each e.g. tiny , 2x so in the grid view we are going to fetch the tiny images . Hence , we wrote images[index]['src']['tiny']