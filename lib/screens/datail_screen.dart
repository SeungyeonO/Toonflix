import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/webtoon_episode_model.dart';
import 'package:flutter_application_1/models/webtoon_detail_model.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/theme/colors.dart';
import 'package:flutter_application_1/widgets/episode_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late SharedPreferences prefs;
  bool isLiked = false;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      if (likedToons.contains(widget.id) == true) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      prefs.setStringList('likedToons', []);
    }
  }

  onHeartTap() async {
    final likedToons = prefs.getStringList('likedToons');
    if (isLiked) {
      likedToons!.remove(widget.id);
    } else {
      likedToons!.add(widget.id);
    }
    await prefs.setStringList('likedToons', likedToons);
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatesetEpisodeModel(widget.id);
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neonGreen,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: onHeartTap,
            icon: Icon(
              isLiked ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
            ),
          ),
        ],
        backgroundColor: darkGray,
        foregroundColor: neonGreen,
        surfaceTintColor: neonGreen,
        shadowColor: darkGray,
        elevation: 3.0,
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 23,
            fontFamily: 'ScoreDream7',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 50,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
                    child: Container(
                      width: 250,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 12,
                              offset: const Offset(10, 10),
                              color: Colors.black.withOpacity(0.5),
                            )
                          ]),
                      child: Image.network(
                        widget.thumb,
                        headers: const {
                          'Referer': 'https://comic.naver.com',
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(
                              fontSize: 15, fontFamily: 'ScoreDream4'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('${snapshot.data!.genre} / ${snapshot.data!.age}'),
                      ],
                    );
                  }
                  return const Text('...');
                },
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        for (var episode in snapshot.data!.length > 10
                            ? snapshot.data!.sublist(0, 10)
                            : snapshot.data!)
                          Episode(
                            episode: episode,
                            webtoonId: widget.id,
                          )
                      ],
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
