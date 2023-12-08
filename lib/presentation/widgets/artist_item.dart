import 'package:flutter/material.dart';
import '../../data/response/artists_list_response.dart' as artist;

class ArtistItem extends StatelessWidget {
  const ArtistItem({super.key, required this.artistItem});
  final artist.ArtistsItems artistItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 100,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
        ),

      ),
    );
  }
}
