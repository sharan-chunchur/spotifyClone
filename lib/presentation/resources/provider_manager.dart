

import 'package:just_audio/just_audio.dart';
import 'package:riverpod/riverpod.dart';

import '../../data/response/artists_list_response.dart';
import '../../data/response/playlist_list.dart';
import '../../data/response/playlist_tracks_response.dart';

final playlistListsProvider = StateProvider<PlaylistsList?>((ref) => null);

final playlistProvider = StateProvider<PlaylistItems?>((ref) => null);

final artistPlaylistProvider = StateProvider<ArtistsItems?>((ref) => null);


final currentTrackIndexProvider = StateProvider<int?>((ref) => null);

final concatenatingAudioSourceProvider = StateProvider<ConcatenatingAudioSource?>((ref) => null);

