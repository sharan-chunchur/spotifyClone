

import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/response/playlist_tracks_response.dart';
import '../resources/provider_manager.dart';
import '../widgets/media_metadata.dart';
import '../widgets/track_controls.dart';

class TrackPlayScreen extends ConsumerStatefulWidget {
  const TrackPlayScreen({super.key});

  @override
  ConsumerState<TrackPlayScreen> createState() => _TrackPlayScreenState();
}

class _TrackPlayScreenState extends ConsumerState<TrackPlayScreen> {
  late AudioSource? trackItem;
  late AudioPlayer _audioPlayer;
  late ConcatenatingAudioSource? playlist;
  late int? currentTrackIndex;

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _audioPlayer.positionStream,
          _audioPlayer.bufferedPositionStream,
          _audioPlayer.durationStream,
          (position, bufferPostion, duration) =>
              PositionData(position, bufferPostion, duration ?? Duration.zero));

  @override
  void initState() {
    playlist = ref.read(concatenatingAudioSourceProvider);
    currentTrackIndex = ref.read(currentTrackIndexProvider);
    _audioPlayer = AudioPlayer();
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await _audioPlayer.setLoopMode(LoopMode.all);
    await _audioPlayer.setAudioSource(playlist!, initialIndex: currentTrackIndex);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Now Playing"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StreamBuilder(stream: _audioPlayer.sequenceStateStream, builder: (context, snapshot){
              final state = snapshot.data;
              if(state?.sequence.isEmpty ?? true){
                print("helo");
                return const SizedBox();
              }
              final metadata = state!.currentSource!.tag as MediaItem;
              return MediaMetaData(imageurl: metadata.artUri.toString(),
                artist: metadata.artist ?? '', title: metadata.title,

              );
            }),
            StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final postionData = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: ProgressBar(
                      barHeight: 8,
                      baseBarColor: Colors.grey[600],
                      bufferedBarColor: Colors.grey,
                      progressBarColor: Colors.red,
                      thumbColor: Colors.red,
                      timeLabelTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      progress: postionData?.position ?? Duration.zero,
                      buffered: postionData?.bufferPosition ?? Duration.zero,
                      total: postionData?.duration ?? Duration.zero,
                      onSeek: _audioPlayer.seek,
                    ),
                  );
                }),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TrackControl(
                    audioPlayer: _audioPlayer,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PositionData {
  const PositionData(this.position, this.bufferPosition, this.duration);

  final Duration position;
  final Duration bufferPosition;
  final Duration duration;
}
