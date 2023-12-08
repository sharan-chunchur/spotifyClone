
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/data/response/album_list_response.dart';

import '../../../application/dependency_injection.dart';
import '../../data/network/app_api.dart';


abstract class AlbumDetailsState{}

class InitialAlbumDetailsState extends AlbumDetailsState{}

class LoadingAlbumDetailsState extends AlbumDetailsState{}

class LoadedAlbumDetailsState extends AlbumDetailsState{
  List<Albums> albums;
  LoadedAlbumDetailsState({required this.albums});
}

class ErrorAlbumDetailsState extends AlbumDetailsState{
  int? code;
  String msg;
  ErrorAlbumDetailsState({required this.msg, this.code});
}

class AlbumDetailsNotifier extends StateNotifier<AlbumDetailsState>{
  AlbumDetailsNotifier(): super(InitialAlbumDetailsState());

  void fetchAlbumDetails(String albumid) async{

    try{
      state = LoadingAlbumDetailsState();
      final fetchedData = await instance<AppServiceClient>().fetchAlbumTracks(albumid);
        state = LoadedAlbumDetailsState(albums: fetchedData!);
    }catch(e){
      state = ErrorAlbumDetailsState(msg: e.toString());
    }
  }
}

final albumDetailsProvider = StateNotifierProvider<AlbumDetailsNotifier, AlbumDetailsState>((ref) => AlbumDetailsNotifier());