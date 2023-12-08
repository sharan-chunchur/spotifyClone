
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/data/response/playlist_list.dart';

import '../../../application/dependency_injection.dart';
import '../../data/network/app_api.dart';
import '../../data/response/artists_list_response.dart';


abstract class ArtistsState{}

class InitialArtistsState extends ArtistsState{}

class LoadingArtistsState extends ArtistsState{}

class LoadedArtistsState extends ArtistsState{
  Artists artistsData;
  LoadedArtistsState({required this.artistsData});
}

class ErrorArtistsState extends ArtistsState{
  int? code;
  String msg;
  ErrorArtistsState({required this.msg, this.code});
}

class ArtistsNotifier extends StateNotifier<ArtistsState>{
  ArtistsNotifier(): super(InitialArtistsState());

   fetchArtistsDetails() async{

    try{
      state = LoadingArtistsState();
      final fetchedData = await instance<AppServiceClient>().fetchArtists("suggested", "artists", "20");
      state = LoadedArtistsState(artistsData: fetchedData.artists!);
    }catch(e){
      state = ErrorArtistsState(msg: e.toString());
    }
  }

}

final artistDetailsProvider = StateNotifierProvider<ArtistsNotifier, ArtistsState>((ref) => ArtistsNotifier());