import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/data/response/album_list_response.dart';
import 'package:spotify_clone/presentation/song/song_view_model.dart';
import 'package:text_scroll/text_scroll.dart';

import '../resources/font_manager.dart';
import '../widgets/error_disply.dart';

class SongScreen extends ConsumerStatefulWidget {
  SongScreen( this.songId, this.index, this.album, {super.key});

  final String songId;
  int index;
  final Albums album;

  @override
  ConsumerState<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends ConsumerState<SongScreen> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position=newPosition;
      });
    });

    // Future.delayed(Duration(seconds: 2)).then((value) {
    //   ref
    //       .read(songsDetailsProvider.notifier)
    //       .fetchSongDetails(widget.id);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final songsState = ref.watch(songsDetailsProvider);
    final songId = widget.album.tracks!.items![widget.index].id!;
    Widget content;
    if (songsState is ErrorSongDetailsState) {
      content = ErrorDisplay(
        errTitle: songsState.msg,
        title: songId,
        onRetry: () {
          ref
              .read(songsDetailsProvider.notifier)
              .fetchSongDetails(songId);
        },
      );
    } else if (songsState is LoadedSongDetailsState) {
      final song = songsState.songs[0];
      print("************");
      print(widget.index);
      print(song.album!.images![0].url!);
      content = SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 25,
                    ),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        const Text(
                          "PLAYING FROM ALBUM",
                          style: TextStyle(
                              fontWeight: FontWeightManager.light,
                              fontSize: FontSize.s10),
                        ),
                        Text(
                          song.name!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeightManager.bold,
                              fontSize: FontSize.s20),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_vert))
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height *0.5,
                        child: Image.network(song.album!.images![0].url!)),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextScroll(
                                song.name!,
                                intervalSpaces: 10,
                                pauseBetween: Duration(seconds: 2),
                                velocity: const Velocity(
                                    pixelsPerSecond: Offset(50, 0)),
                                style: const TextStyle(
                                    fontWeight: FontWeightManager.bold,
                                    fontSize: FontSize.s20),
                              ),
                              Text(song.artists![0].name!)
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_border,
                              size: 40,
                            )),
                      ],
                    ),
                    Slider(
                      min: 0,
                      max: duration.inSeconds.toDouble(),
                      value: position.inSeconds.toDouble(),
                      onChanged: (value) async {
                        final position = Duration(seconds: value.toInt());
                        await audioPlayer.seek(position);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatDuration(position)),
                        Text("00:29"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.shuffle,
                              size: 40,
                            )),
                        IconButton(
                            onPressed: () {
                              if(widget.index>0){
                                setState(() {
                                  audioPlayer.stop();
                                  duration = Duration.zero;
                                  position = Duration.zero;
                                });
                                widget.index--;
                                final song_id = widget.album.tracks!.items![widget.index].id!;
                                ref
                                    .read(songsDetailsProvider.notifier)
                                    .fetchSongDetails(song_id);

                              }
                            },
                            icon: Icon(
                              Icons.skip_previous,
                              size: 40,
                            )),
                        IconButton(
                            onPressed: () async {
                              if (isPlaying) {
                                await audioPlayer.pause();
                              } else {
                                await audioPlayer
                                    .play(UrlSource(song.previewUrl!));
                              }
                              setState(() {
                                isPlaying = !isPlaying;
                              });
                            },
                            icon: Icon(
                              isPlaying ? Icons.pause : Icons.play_circle,
                              size: 70,
                            )),
                        IconButton(
                            onPressed: () {
                              if(widget.index< widget.album.totalTracks!-1){
                                setState(() {
                                  audioPlayer.stop();
                                  duration = Duration.zero;
                                  position = Duration.zero;
                                });
                                widget.index++;
                                final song_id = widget.album.tracks!.items![widget.index].id!;
                                ref
                                    .read(songsDetailsProvider.notifier)
                                    .fetchSongDetails(song_id);
                              }
                            },
                            icon: Icon(
                              Icons.skip_next,
                              size: 40,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.repeat,
                              size: 40,
                            )),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    } else {
      content = const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: content,
    );
  }
}

String formatDuration(Duration duration) {
  // Use the Duration to format it as "mm:ss"
  final minutes = duration.inMinutes;
  final seconds = duration.inSeconds % 60;

  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}
