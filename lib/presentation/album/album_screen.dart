import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/presentation/album/album_viewmodel.dart';
import 'package:text_scroll/text_scroll.dart';

import '../resources/font_manager.dart';
import '../song/song_screen.dart';
import '../song/song_view_model.dart';
import '../widgets/error_disply.dart';

class AlbumScreen extends ConsumerStatefulWidget {
  const AlbumScreen({super.key});

  @override
  ConsumerState<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends ConsumerState<AlbumScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(albumDetailsProvider.notifier)
          .fetchAlbumDetails("0zRUzTXH7GtGLxt6uVdARD");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final albumsState = ref.watch(albumDetailsProvider);

    Widget content;
    if (albumsState is ErrorAlbumDetailsState) {
      content = ErrorDisplay(
        errTitle: albumsState.msg,
        title: "0zRUzTXH7GtGLxt6uVdARD",
        onRetry: () {
          ref
              .read(albumDetailsProvider.notifier)
              .fetchAlbumDetails("0zRUzTXH7GtGLxt6uVdARD");
        },
      );
    } else if (albumsState is LoadedAlbumDetailsState) {
      final album = albumsState.albums[0];
      content = SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 40, 8, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 160,
                      width: double.infinity,
                      child: Image.network(album.images![1].url!),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      album.name!,
                      style: const TextStyle(
                          fontWeight: FontWeightManager.bold, fontSize: 24),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      album.artists![0].name!,
                      style: const TextStyle(
                        fontWeight: FontWeightManager.bold,
                      ),
                    ),
                    Text(
                      "${album.albumType!} • 2023",
                      style: const TextStyle(
                        fontWeight: FontWeightManager.light,
                      ),
                    ),
          Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.favorite_border,
                            size: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.download_for_offline_outlined,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.more_vert,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.shuffle,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: InkWell(
                            onTap: (){
                              final song_id = album.tracks!.items![0].id!;
                              final trackNum = album.tracks!.items![0].trackNumber!;
                              ref
                                  .read(songsDetailsProvider.notifier)
                                  .fetchSongDetails(song_id);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SongScreen(song_id, 0, album)));

                            },
                            child: Icon(
                              Icons.play_circle,
                              color: Colors.green,
                              size: 60,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: album.totalTracks,
                        itemBuilder: (context, index) {
                          String artistNames = album
                              .tracks!.items![index].artists!
                              .map((artist) => artist.name!)
                              .join(', ');
                          return InkWell(
                            onTap: (){
                              final song_id = album.tracks!.items![index].id!;
                              final trackNum = album.tracks!.items![index].trackNumber;
                              ref
                                  .read(songsDetailsProvider.notifier)
                                  .fetchSongDetails(song_id);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SongScreen(song_id, index, album)));

                            },
                            child: ListTile(
                              title: Text(
                                album.tracks!.items![index].name!,
                                style: const TextStyle(
                                    fontWeight: FontWeightManager.bold,
                                    color: Colors.white),
                              ),
                              subtitle: Text(
                                artistNames,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 12),
                              ),
                              trailing: Icon(
                                Icons.more_vert,
                                size: 30,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        }),
                    // ListView(
                    //   shrinkWrap: true,
                    //   children: [
                    //     ListTile(
                    //       title: Text("Kavalaya"),
                    //       subtitle: Text("Anirud"),
                    //       trailing: Icon(
                    //         Icons.more_vert,
                    //         size: 30,
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
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
