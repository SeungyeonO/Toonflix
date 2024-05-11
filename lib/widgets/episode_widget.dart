import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/webtoon_episode_model.dart';
import 'package:flutter_application_1/theme/colors.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Episode extends StatelessWidget {
  const Episode({
    super.key,
    required this.episode,
    required this.webtoonId,
  });

  final WebtoonEpisodeModel episode;
  final String webtoonId;

  onButtonTap() async {
    await launchUrlString(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}");
  }

  @override
  Widget build(BuildContext context) {
    String title = ' ';
    bool long = false;
    if (episode.title.length > 24) {
      title = episode.title.substring(0, 24);
      long = true;
    } else {
      title = episode.title;
    }
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.5,
            color: darkGray,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                (long) ? '$title...' : title,
                style: TextStyle(
                    color: darkGray,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'ScoreDream4'),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }
}
