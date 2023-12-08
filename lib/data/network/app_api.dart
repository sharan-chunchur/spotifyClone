import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:spotify_clone/data/response/album_list_response.dart';

import '../../application/constants.dart';
import '../response/artists_list_response.dart';
import '../response/playlist_list.dart';
import '../response/playlist_tracks_response.dart';

import '../response/recom_track_list_response.dart';
import '../response/track_list_response.dart';
import '../response/artists_list_response.dart' as artists;

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @GET("/albums/")
  Future<List<Albums>?> fetchAlbumTracks(@Query('ids') String id);

  @GET("/tracks/")
  Future<List<SongTrack>?> fetchTrack(@Query('ids') String id);

  @GET("/search/")
  Future<PlaylistsList> fetchPlalists(@Query('q') String q,
      @Query('type') String type, @Query('limit') String limit);

  @GET("/search/")
  Future<artists.ArtistsList> fetchArtists(@Query('q') String q,
      @Query('type') String type, @Query('limit') String limit);

  @GET("/recommendations/")
  Future<RecommendedTrackList> fetchRecommendedTracks(
      @Query('limit') String limit, @Query('seed_genres') String seedGenres);


  @GET("/playlist_tracks/")
  Future<PlaylistsTracksResponse> fetchPlaylistTracks(
      @Query('id') String id, @Query('limit') String limit);

  @GET("/recommendations/")
  Future<RecommendedTrackList> fetchArtistTracks(
      @Query('limit') String limit, @Query('seed_artists') String seedArtists);


}
