
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/data/response/playlist_list.dart';

import '../../../application/dependency_injection.dart';
import '../../data/network/app_api.dart';
import '../../data/response/recom_track_list_response.dart';


abstract class RecommendedTrackState{}

class InitialRecommendedTrackState extends RecommendedTrackState{}

class LoadingRecommendedTrackState extends RecommendedTrackState{}

class LoadedRecommendedTrackState extends RecommendedTrackState{
  RecommendedTrackList trackListData;
  LoadedRecommendedTrackState({required this.trackListData});
}

class ErrorRecommendedTrackState extends RecommendedTrackState{
  int? code;
  String msg;
  ErrorRecommendedTrackState({required this.msg, this.code});
}

class RecommandedTracksNotifier extends StateNotifier<RecommendedTrackState>{
  RecommandedTracksNotifier(): super(InitialRecommendedTrackState());

  void fetchPlaylistsDetails() async{

    try{
      state = LoadingRecommendedTrackState();
      final fetchedData = await instance<AppServiceClient>().fetchRecommendedTracks("10", 'classical,country');
      fetchedData.tracks!.removeWhere((track) => track.previewUrl == null);
      state = LoadedRecommendedTrackState(trackListData: fetchedData);
    }catch(e){
      state = ErrorRecommendedTrackState(msg: e.toString());
    }
  }
}

final recommendedTrackProvider = StateNotifierProvider<RecommandedTracksNotifier, RecommendedTrackState>((ref) => RecommandedTracksNotifier());