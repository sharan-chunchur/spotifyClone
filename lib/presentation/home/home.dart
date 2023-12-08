import 'package:flutter/material.dart';
import 'package:spotify_clone/presentation/resources/color_manager.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.black,
      body:  SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Good Afternoon",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Row(
                      children: [
                        Icon(Icons.notifications_none),
                        SizedBox(width: 16),
                        Icon(Icons.history),
                        SizedBox(width: 16),
                        Icon(Icons.settings),
                      ],
                    ),
                  ],
                ),
              ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   physics: BouncingScrollPhysics(),
              //   padding: EdgeInsets.all(16),
              //   child: Row(
              //     children: [
              //       AlbumCard(
              //         label: "Best Mode",
              //         image: AssetImage("assets/album7.jpg"), onTap: (){},
              //       ),
              //       SizedBox(width: 16),
              //       AlbumCard(
              //         onTap: (){},
              //         label: "Mot6ivation Mix",
              //         image: AssetImage("assets/album2.jpg"),
              //       ),
              //       SizedBox(width: 16),
              //       AlbumCard(
              //         onTap: (){},
              //         label: "Top 50-Global",
              //         image: AssetImage("assets/top50.jpg"),
              //       ),
              //       SizedBox(width: 16),
              //       AlbumCard(
              //         onTap: (){},
              //         label: "Power Gaming",
              //         image: AssetImage("assets/album1.jpg"),
              //       ),
              //       SizedBox(width: 16),
              //       AlbumCard(
              //         onTap: (){},
              //         label: "Top songs - Global",
              //         image: AssetImage("assets/album9.jpg"),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class AlbumCard extends StatelessWidget {
  final ImageProvider image;
  final String label;
  final Function onTap;
  final double size;
  const AlbumCard({
    required this.image,
    required this.label,
    required this.onTap,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => AlbumView(
        //       image: image,
        //     ),
        //   ),
        // );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: image,
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Text(label),
        ],
      ),
    );
  }
}
