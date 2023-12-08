import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/application/dependency_injection.dart';
import 'package:spotify_clone/application/extension.dart';
import 'package:spotify_clone/data/network/dio_factory.dart';
import 'package:spotify_clone/presentation/home/home_screen_viewmodel.dart';

import 'package:spotify_clone/presentation/resources/font_manager.dart';
import 'package:spotify_clone/presentation/track/track_viewmodel.dart';
import 'package:spotify_clone/presentation/widgets/load_playlists.dart';
import '../../data/network/app_api.dart';

import '../artists_list/artists_viewmodel.dart';
import '../resources/route_manager.dart';
import '../widgets/load_artists.dart';
import '../widgets/load_recommendation_tracks.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callMethodChannel();
      ref.read(artistDetailsProvider.notifier).fetchArtistsDetails();
      ref.read(playlistDetailsProvider.notifier).fetchPlaylistsDetails();
      ref.read(recommendedTrackProvider.notifier).fetchPlaylistsDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spotify"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    showSearch(
                        context: context, delegate: CustomSearchDeligate());
                  },
                  icon: Icon(Icons.search),
                ),
                Column(
                  children: [
                    LoadPlaylists(),
                    LoadArtists(),
                    LoadRecommendationTracks(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void callMethodChannel() async{
    print("MethodChannel Called");
    await MethodChannel("com.dynamicIcon").invokeMethod("launcherSecond");
  }
}

class CustomSearchDeligate extends SearchDelegate {
  List<String> searchTerms = [
    "sharan",
    "arun",
    "kiran",
    "Varun"
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if(query.isEmpty){
            close(context, null);
          }
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> searchResults = [];
    for (String searchItem in searchTerms) {
      if (searchItem.toLowerCase().contains(query.toLowerCase())) {
        searchResults.add(searchItem);
      }
    }


    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        var result = searchResults[index];
        return ListTile(
          title: Text(result, style: TextStyle(color: Colors.red),),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> searchResults = [];
    for (String searchItem in searchTerms) {
      if (searchItem.toLowerCase().contains(query.toLowerCase())) {
        searchResults.add(searchItem);
      }
    }

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        var result = searchResults[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
