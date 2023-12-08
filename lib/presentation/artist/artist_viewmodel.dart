
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/dependency_injection.dart';
import '../../data/network/app_api.dart';
import '../../data/response/playlist_tracks_response.dart';
import '../../data/response/recom_track_list_response.dart';


abstract class ArtistTrackState{}

class InitialArtistTrackState extends ArtistTrackState{}

class LoadingArtistTrackState extends ArtistTrackState{}

class LoadedArtistTrackState extends ArtistTrackState{
  RecommendedTrackList trackListData;
  LoadedArtistTrackState({required this.trackListData});
}

class ErrorArtistTrackState extends ArtistTrackState{
  int? code;
  String msg;
  ErrorArtistTrackState({required this.msg, this.code});
}

class ArtistTrackNotifier extends StateNotifier<ArtistTrackState>{
  ArtistTrackNotifier(): super(InitialArtistTrackState());

  void fetchPlaylistsDetails(String artistsId) async{

    try{
      state = LoadingArtistTrackState();
      final fetchedData = await instance<AppServiceClient>().fetchArtistTracks("100", artistsId);
      fetchedData.tracks!.removeWhere((track) {
        var check = true;
        for(var artist in track.artists!){
          print(artist.id);
          print("%%%%%");
          if(artist.id == artistsId){
            check = false;
          }
        }
        print(artistsId);
        print(check);
        return check;
      });
      state = LoadedArtistTrackState(trackListData: fetchedData);
    }catch(e){
      state = ErrorArtistTrackState(msg: e.toString());
    }
  }
}

final artistTracksProvider = StateNotifierProvider<ArtistTrackNotifier, ArtistTrackState>((ref) => ArtistTrackNotifier());