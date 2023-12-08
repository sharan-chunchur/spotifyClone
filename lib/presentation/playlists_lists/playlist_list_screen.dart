import 'package:flutter/material.dart';
import 'package:spotify_clone/presentation/widgets/PlayListItem.dart';

import '../../data/response/playlist_list.dart';
import '../resources/route_manager.dart';

class PlaylistsListScreen extends StatelessWidget {
  const PlaylistsListScreen({super.key, required this.playlistsList});

  final PlaylistsList playlistsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Playlists"),centerTitle: true,),
      body: SafeArea(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 4 / 4),
            itemCount: playlistsList.playlists!.items!.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Routes.playlistScreenRoute);
                },
                child: PlayListItem(
                    playlistItems: playlistsList.playlists!.items![index]),
              );
            }),
      ),
    );
  }
}
