import 'package:flutter/material.dart';

class MediaMetaData extends StatelessWidget {
  final String imageurl;
  final String title;
  final String artist;

  const MediaMetaData(
      {super.key,
      required this.imageurl,
      required this.title,
      required this.artist});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(2, 4), blurRadius: 4),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageurl,
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          artist,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
