import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_clone/data/response/artists_list_response.dart';
import 'package:spotify_clone/presentation/artist/artist_viewmodel.dart';

import '../resources/font_manager.dart';
import '../resources/provider_manager.dart';
import '../resources/route_manager.dart';
import '../widgets/error_disply.dart';
import '../widgets/song_list_tile.dart';

class ArtistScreen extends ConsumerStatefulWidget {
  const ArtistScreen({super.key, required this.artistData});
  final ArtistsItems artistData;

  @override
  ConsumerState<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends ConsumerState<ArtistScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(artistTracksProvider.notifier)
          .fetchPlaylistsDetails(widget.artistData.data!.uri!.split(":").last);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late Widget tracksContent;
    final artistTracksState = ref.watch(artistTracksProvider);
    if (artistTracksState is ErrorArtistTrackState) {
      tracksContent = ErrorDisplay(
        errTitle: artistTracksState.msg,
        title: "Something went Wrong",
        onRetry: () {
          ref.read(artistTracksProvider.notifier).fetchPlaylistsDetails(
              widget.artistData.data!.uri!.split(":").last);
        },
      );
    } else if (artistTracksState is LoadedArtistTrackState) {
      final tracksData = artistTracksState.trackListData.tracks!;
      tracksContent = ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: tracksData.length,
          itemBuilder: (context, index) {
            final songTitle = tracksData[index].name!;
            final imageUrl = tracksData[index].album!.images!.first.url!;
            return InkWell(
                onTap: () {
                  ref
                      .read(concatenatingAudioSourceProvider.notifier)
                      .update((state) => null);
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
      tracksContent = const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.artistData.data!.profile!.name!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeightManager.bold, fontSize: FontSize.s18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(16),
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(widget.artistData.data!.visuals!.avatarImage!.sources!.first.url!),
                      fit: BoxFit.fill)),
            ),
            // Container(
            //     margin: const EdgeInsets.only(bottom: 16),
            //     width: double.infinity,
            //     child: Text(
            //       "Owner: ${widget.artistData.data!..owner!.name!}",
            //       textAlign: TextAlign.center,
            //       style: const TextStyle(
            //           fontWeight: FontWeightManager.bold,
            //           fontSize: FontSize.s16),
            //     )),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.favorite_border,
                      size: 30,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.loop,
                      size: 30,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.play_circle,
                      size: 60,
                    ),
                  ),
                ],
              ),
            ),
            tracksContent,
          ],
        ),
      ),
    );
  }
}
