import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_clone/presentation/track/track_viewmodel.dart';
import 'package:spotify_clone/presentation/widgets/song_list_tile.dart';

import '../resources/font_manager.dart';
import '../resources/provider_manager.dart';
import '../resources/route_manager.dart';
import 'artist_item.dart';
import 'error_disply.dart';

class LoadRecommendationTracks extends ConsumerWidget {
  const LoadRecommendationTracks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final tracksContent;
    final trackState = ref.watch(recommendedTrackProvider);
    if (trackState is ErrorRecommendedTrackState) {
      tracksContent = ErrorDisplay(
        errTitle: trackState.msg,
        title: "Something went Wrong",
        onRetry: () {
          //ref.read(artistDetailsProvider.notifier).fetchArtistsDetails();
        },
      );
    } else if (trackState is LoadedRecommendedTrackState) {
      final tracksData = trackState.trackListData.tracks!;
      print(tracksData.length);
      tracksContent = ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: tracksData.length,
          itemBuilder: (context, index) {
            final songTitle = tracksData[index].name!;
            final imageUrl = tracksData[index].album!.images!.first.url!;
            return InkWell(
                onTap: () {
                  ref.read(concatenatingAudioSourceProvider.notifier).update((state) => null);
                  print(
                    tracksData.map((trackItem) {
                      return trackItem.previewUrl!;
                    }).toList(),
                  );
                  final playlist = ConcatenatingAudioSource(
                    children: tracksData.map((trackItem) {
                      return AudioSource.uri(
                        Uri.parse(
                          trackItem.previewUrl!,
                        ),
                        tag: MediaItem(
                          id: trackItem.id!,
                          title: trackItem.name!,
                          artist: trackItem.artists!.map((artist) {
                            return artist.name;
                          }).join(", "),
                          artUri:
                              Uri.parse(trackItem.album!.images!.first.url!),
                        ),
                      );
                    }).toList(),
                  );
                  ref
                      .read(concatenatingAudioSourceProvider.notifier)
                      .update((state) => playlist);
                  ref
                      .read(currentTrackIndexProvider.notifier)
                      .update((state) => index);
                  Navigator.pushNamed(context, Routes.trackPlayScreen);
                },
                child: SongListTile(url: imageUrl, title: songTitle));
          });
    } else {
      tracksContent = Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recommended for you",
                style: TextStyle(
                    fontWeight: FontWeightManager.bold, fontSize: FontSize.s16),
              ),
              IconButton(
                onPressed: () async {
                  // final playlist = ref.read(playlistDetailsProvider);
                  // Navigator.pushNamed(context, Routes.playListScreenRoute, arguments: {
                  //
                  // });
                },
                icon: const Icon(Icons.more_horiz),
              ),
            ],
          ),
        ),
        tracksContent,
      ],
    );
  }
}
