import 'package:flutter/material.dart';
import '../../data/response/artists_list_response.dart';


class ArtistsListScreen extends StatelessWidget {
  const ArtistsListScreen({super.key, required this.artists});

  final Artists artists;

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
            itemCount: artists.items!.length,
            itemBuilder: (context, index) {
              return  Container(
                height: 100,
                width: 180,
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: NetworkImage(artists.items![index].data!.visuals!.avatarImage!.sources!.first.url!), fit: BoxFit.fill),
                ),
              );
            }),
      ),
    );
  }
}
