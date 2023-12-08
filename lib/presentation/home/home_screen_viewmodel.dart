
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/data/response/playlist_list.dart';

import '../../../application/dependency_injection.dart';
import '../../data/network/app_api.dart';


abstract class PlaylistsState{}

class InitialPlaylistsState extends PlaylistsState{}

class LoadingPlaylistsState extends PlaylistsState{}

class LoadedPlaylistsState extends PlaylistsState{
  PlaylistsList playlistsData;
  LoadedPlaylistsState({required this.playlistsData});
}

class ErrorPlaylistsState extends PlaylistsState{
  int? code;
  String msg;
  ErrorPlaylistsState({required this.msg, this.code});
}

class PlaylistsNotifier extends StateNotifier<PlaylistsState>{
  PlaylistsNotifier(): super(InitialPlaylistsState());

  void fetchPlaylistsDetails() async{

    try{
      state = LoadingPlaylistsState();
      final fetchedData = await instance<AppServiceClient>().fetchPlalists("suggested", "playlists", "20");
      state = LoadedPlaylistsState(playlistsData: fetchedData);
    }catch(e){
      state = ErrorPlaylistsState(msg: e.toString());
    }
  }
}

final playlistDetailsProvider = StateNotifierProvider<PlaylistsNotifier, PlaylistsState>((ref) => PlaylistsNotifier());