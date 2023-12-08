import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_clone/presentation/playlist/playlist_viewmodel.dart';
import 'package:spotify_clone/presentation/resources/provider_manager.dart';
import '../../data/response/playlist_list.dart';
import '../resources/font_manager.dart';
import '../resources/route_manager.dart';
import '../widgets/error_disply.dart';
import '../widgets/song_list_tile.dart';

class PlaylistScreen extends ConsumerStatefulWidget {
  const PlaylistScreen({super.key, required this.playlistData});

  final PlaylistItems playlistData;

  @override
  ConsumerState<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends ConsumerState<PlaylistScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final playlistData = ref.read(playlistProvider);
      ref
          .read(playlistTracksProvider.notifier)
          .fetchPlaylistsDetails(playlistData!.data!.uri!.split(":").last);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late Widget tracksContent;
    final playlistTracksState = ref.watch(playlistTracksProvider);
    if (playlistTracksState is ErrorPlaylistTrackState) {
      tracksContent = ErrorDisplay(
        errTitle: playlistTracksState.msg,
        title: "Something went Wrong",
        onRetry: () {
          ref.read(playlistTracksProvider.notifier).fetchPlaylistsDetails(
              widget.playlistData.data!.uri!.split(":").last);
        },
      );
    } else if (playlistTracksState is LoadedPlaylistTrackState) {
      final tracksData = playlistTracksState.trackItems;
      tracksContent = ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: tracksData.length,
          itemBuilder: (context, index) {
            final track = tracksData[index].track!;
            final songTitle = track.name;
            final imageUrl = track.album!.images!.first.url;
            return InkWell(
              onTap: () {
                ref.read(concatenatingAudioSourceProvider.notifier).update((state) => null);
                final playlist = ConcatenatingAudioSource(
                  children: tracksData.map((trackItem) {
                    return AudioSource.uri(
                        Uri.parse(
                          trackItem.track!.previewUrl!,
                        ),
                        tag: MediaItem(
                            id: trackItem.track!.id!,
                            title: trackItem.track!.name!,
                            artist: trackItem.track!.artists!.map((artist) {
                              return artist.name;
                            }).join(", "),
                            artUri: Uri.parse(
                                trackItem.track!.album!.images!.first.url!)));
                  }).toList(),
                );
                ref.read(concatenatingAudioSourceProvider.notifier).update((state) => playlist);
                ref
                    .read(currentTrackIndexProvider.notifier)
                    .update((state) => index);
                Navigator.pushNamed(context, Routes.trackPlayScreen);
              },
              child: SongListTile(
                url: imageUrl!,
                title: songTitle!,
              ),
            );
          });
    } else {
      tracksContent = const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.playlistData.data!.name!,
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
                      image: NetworkImage(widget.playlistData.data!.images!
                          .items!.first.sources!.first.url!),
                      fit: BoxFit.fill)),
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 16),
                width: double.infinity,
                child: Text(
                  "Owner: ${widget.playlistData.data!.owner!.name!}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeightManager.bold,
                      fontSize: FontSize.s16),
                )),
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
