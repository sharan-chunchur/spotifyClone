
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/data/response/album_list_response.dart';
import 'package:spotify_clone/data/response/track_list_response.dart';

import '../../../application/dependency_injection.dart';
import '../../data/network/app_api.dart';


abstract class SongDetailsState{}

class InitialSongDetailsState extends SongDetailsState{}

class LoadingSongDetailsState extends SongDetailsState{}

class LoadedSongDetailsState extends SongDetailsState{
  List<SongTrack> songs;
  LoadedSongDetailsState({required this.songs});
}

class ErrorSongDetailsState extends SongDetailsState{
  int? code;
  String msg;
  ErrorSongDetailsState({required this.msg, this.code});
}

class SongDetailsNotifier extends StateNotifier<SongDetailsState>{
  SongDetailsNotifier(): super(InitialSongDetailsState());

  void fetchSongDetails(String songId) async{

    try{
      state = LoadingSongDetailsState();
      final fetchedData = await instance<AppServiceClient>().fetchTrack(songId);
      state = LoadedSongDetailsState(songs: fetchedData!);
    }catch(e){
      state = ErrorSongDetailsState(msg: e.toString());
    }
  }
}

final songsDetailsProvider = StateNotifierProvider<SongDetailsNotifier, SongDetailsState>((ref) => SongDetailsNotifier());