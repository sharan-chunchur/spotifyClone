import 'package:flutter/material.dart';
import 'package:spotify_clone/data/response/playlist_list.dart';

class PlayListItem extends StatelessWidget {
  const PlayListItem( {super.key, required this.playlistItems});

  final PlaylistItems playlistItems;

  Widget build(BuildContext context) {
    final playlistImageUrl = playlistItems.data!.images!.items![0].sources![0].url;
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              width: 180,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(playlistImageUrl!),
                      fit: BoxFit.fill)),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Icon(
                  Icons.star_border_outlined,
                  size: 25,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ));
  }
}
