import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/screens/datail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = const Offset(0, 1.0);
              var end = Offset.zero;
              var curve = Curves.ease;
              var tween = Tween(
                begin: begin,
                end: end,
              ).chain(
                CurveTween(
                  curve: curve,
                ),
              );
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            pageBuilder: (context, animation, secondaryAnimation) =>
                DetailScreen(title: title, thumb: thumb, id: id),
            fullscreenDialog: false,
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      offset: const Offset(0, 0),
                      color: const Color.fromARGB(255, 21, 255, 169)
                          .withOpacity(0.5),
                    )
                  ]),
              child: Image.network(
                thumb,
                headers: const {
                  'Referer': 'https://comic.naver.com',
                },
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Color.fromARGB(255, 21, 255, 169),
              fontSize: 22,
              fontFamily: 'ScoreDream7',
            ),
          ),
        ],
      ),
    );
  }
}
