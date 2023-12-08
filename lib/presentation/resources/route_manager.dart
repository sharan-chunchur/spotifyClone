import 'package:flutter/material.dart';
import 'package:spotify_clone/data/response/artists_list_response.dart';
import 'package:spotify_clone/presentation/home/home_screen.dart';
import 'package:spotify_clone/presentation/playlist/playlist_screen.dart';
import 'package:spotify_clone/presentation/track/track_screen.dart';

import '../../data/response/playlist_list.dart';
import '../artist/artist_screen.dart';
import '../artists_list/artists_list_screen.dart';
import '../playlists_lists/playlist_list_screen.dart';


class Routes {
  static const String splashRoute = "/";
  static const String homeScreenRoute = "/home";
  static const String playlistScreenRoute = '/playlistListScreen';
  static const String playlistsListScreenRoute = '/playlistScreen';
  static const String artistsListScreenRoute = '/artistsListScreen';
  static const String artistsScreenRoute = '/artistScreen';
  static const String trackPlayScreen = '/trackPlayScreen';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {

      case Routes.homeScreenRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.playlistsListScreenRoute:
        return MaterialPageRoute(builder: (_) =>  PlaylistsListScreen(playlistsList: routeSettings.arguments as PlaylistsList));
      case Routes.artistsListScreenRoute:
        return MaterialPageRoute(builder: (_) =>  ArtistsListScreen(artists: routeSettings.arguments as Artists,));
      case Routes.artistsScreenRoute:
        return MaterialPageRoute(builder: (_) =>  ArtistScreen(artistData: routeSettings.arguments as ArtistsItems,));
      case Routes.playlistScreenRoute:
        return MaterialPageRoute(builder: (_) =>  PlaylistScreen(playlistData: routeSettings.arguments as PlaylistItems));
      case Routes.trackPlayScreen:
        return MaterialPageRoute(builder: (_) => const TrackPlayScreen());
        default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "no_route_found",
          ),
        ),
        body: const Center(
          child: Text("no route found"),
        ),
      ),
    );
  }
}

