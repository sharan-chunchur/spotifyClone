import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/application/extension.dart';
import 'package:spotify_clone/presentation/home/home_screen_viewmodel.dart';
import 'package:spotify_clone/presentation/resources/provider_manager.dart';
import 'package:spotify_clone/presentation/widgets/PlayListItem.dart';

import '../resources/font_manager.dart';
import '../resources/route_manager.dart';
import 'error_disply.dart';

class LoadPlaylists extends ConsumerWidget {
  const LoadPlaylists({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late Widget content;

    final playlistState = ref.watch(playlistDetailsProvider);
    if (playlistState is ErrorPlaylistsState) {
      content = ErrorDisplay(
        errTitle: playlistState.msg,
        title: "Something went Wrong",
        onRetry: () {
          ref.read(playlistDetailsProvider.notifier).fetchPlaylistsDetails();
        },
      );
    } else if (playlistState is LoadedPlaylistsState) {
      content = SizedBox(
        height: context.screenSize.height * 0.25,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  final playlistId = playlistState
                      .playlistsData.playlists!.items![index];
                  ref.read(playlistProvider.notifier).update((state) => playlistState.playlistsData.playlists!.items![index]);
                  Navigator.pushNamed(context, Routes.playlistScreenRoute,
                      arguments: playlistState
                          .playlistsData.playlists!.items![index],
                              );
                },
                child: PlayListItem(
                  playlistItems:
                      playlistState.playlistsData.playlists!.items![index],
                ),
              );
            }),
      );
    } else {
      content = const Center(
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
                "Suggested Playlists",
                style: TextStyle(
                    fontWeight: FontWeightManager.bold, fontSize: FontSize.s16),
              ),
              IconButton(
                onPressed: () async {
                  final playlist = ref.read(playlistDetailsProvider);
                  if (playlist is LoadedPlaylistsState) {
                    Navigator.pushNamed(
                        context, Routes.playlistsListScreenRoute,
                        arguments: playlist.playlistsData);
                  }
                },
                icon: const Icon(Icons.more_horiz),
              ),
            ],
          ),
        ),
        content,
      ],
    );
  }
}
