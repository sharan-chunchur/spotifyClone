
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/dependency_injection.dart';
import '../../data/network/app_api.dart';
import '../../data/response/playlist_tracks_response.dart';


abstract class PlaylistsTracksState{}

class InitialPlaylistTrackState extends PlaylistsTracksState{}

class LoadingPlaylistTrackState extends PlaylistsTracksState{}

class LoadedPlaylistTrackState extends PlaylistsTracksState{
  List<TrackItems> trackItems;
  LoadedPlaylistTrackState({required this.trackItems});
}

class ErrorPlaylistTrackState extends PlaylistsTracksState{
  int? code;
  String msg;
  ErrorPlaylistTrackState({required this.msg, this.code});
}

class PlaylistsTrackNotifier extends StateNotifier<PlaylistsTracksState>{
  PlaylistsTrackNotifier(): super(InitialPlaylistTrackState());

  void fetchPlaylistsDetails(String playlistId) async{

    try{
      state = LoadingPlaylistTrackState();
      final fetchedData = await instance<AppServiceClient>().fetchPlaylistTracks(playlistId, "100",);
      state = LoadedPlaylistTrackState(trackItems: fetchedData.items!);
    }catch(e){
      state = ErrorPlaylistTrackState(msg: e.toString());
    }
  }
}

final playlistTracksProvider = StateNotifierProvider<PlaylistsTrackNotifier, PlaylistsTracksState>((ref) => PlaylistsTrackNotifier());