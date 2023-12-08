import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/application/extension.dart';


import '../artists_list/artists_viewmodel.dart';
import '../resources/font_manager.dart';
import '../resources/provider_manager.dart';
import '../resources/route_manager.dart';
import 'error_disply.dart';

class LoadArtists extends ConsumerWidget {
  const LoadArtists({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final artistsContent;
    final artistsState = ref.watch(artistDetailsProvider);
    if (artistsState is ErrorArtistsState) {
      artistsContent = ErrorDisplay(
        errTitle: artistsState.msg,
        title: "Something went Wrong",
        onRetry: () {
          ref.read(artistDetailsProvider.notifier).fetchArtistsDetails();
        },
      );
    } else if (artistsState is LoadedArtistsState) {
      final artistsData = artistsState.artistsData.items;
      artistsContent = Container(
        height: context.screenSize.height * 0.25,
        child: ListView.builder(itemCount: 5, scrollDirection: Axis.horizontal, itemBuilder: (context, index) {
          final imageUrl = artistsData![index].data!.visuals!.avatarImage!.sources!.first.url;
          return InkWell(
            onTap: (){
              ref.read(artistPlaylistProvider.notifier).update((state) => artistsState.artistsData.items![index]);
              Navigator.pushNamed(context, Routes.artistsScreenRoute,arguments: artistsState
                  .artistsData!.items![index],);
            },
            child: Container(
              height: 100,
              width: 180,
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: NetworkImage(imageUrl!), fit: BoxFit.fill),
              ),
            ),
          );
        }),
      );
    } else {
      artistsContent = Center(child: CircularProgressIndicator(),);
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Suggested Artists", style: TextStyle(
                  fontWeight: FontWeightManager.bold,
                  fontSize: FontSize.s16),),
              IconButton(onPressed: () async {
                final artistsList = ref.read(artistDetailsProvider);
                if(artistsList is LoadedArtistsState){
                  Navigator.pushNamed(context, Routes.artistsListScreenRoute, arguments: artistsList.artistsData);
                }
              }, icon: const Icon(Icons.more_horiz),),
            ],
          ),
        ),
        artistsContent,
      ],
    );
  }
}
