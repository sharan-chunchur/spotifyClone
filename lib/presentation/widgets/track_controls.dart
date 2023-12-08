import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class TrackControl extends StatelessWidget {
  const TrackControl({super.key, required this.audioPlayer});

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.shuffle),
          iconSize: 30,
        ),
        IconButton(
          onPressed: audioPlayer.seekToPrevious,
          icon: Icon(Icons.skip_previous_outlined),
          iconSize: 60,
        ),
        StreamBuilder(
            stream: audioPlayer.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;
              if (!(playing ?? false)) {
                return IconButton(
                  onPressed: audioPlayer.play,
                  iconSize: 80,
                  color: Colors.white,
                  icon: const Icon(Icons.play_circle),
                );
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                  onPressed: audioPlayer.pause,
                  iconSize: 80,
                  color: Colors.white,
                  icon: const Icon(Icons.pause_circle),
                );
              }
              return Icon(
                Icons.play_arrow_rounded,
                size: 80,
                color: Colors.white,
              );
            }),
        IconButton(
          onPressed: audioPlayer.seekToNext,
          icon: Icon(Icons.skip_next_outlined),
          iconSize: 60,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.loop),
          iconSize: 30,
        ),
      ],
    );
  }
}
