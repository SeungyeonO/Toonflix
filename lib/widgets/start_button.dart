import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_screen.dart';

class StartButton extends StatelessWidget {
  const StartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = 0.0;
              var end = 1.0;
              var tween = Tween(begin: begin, end: end);
              var fadeAnimation = animation.drive(tween);

              return FadeTransition(
                opacity: fadeAnimation,
                child: child,
              );
            },
          ),
        );
      },
      backgroundColor: const Color.fromARGB(255, 21, 255, 169),
      shape: const CircleBorder(
        side: BorderSide(
          width: 0.1,
        ),
      ),
      child: const Text(
        "Start",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 77, 77, 77),
          fontFamily: 'BriemHand',
        ),
      ),
    );
  }
}
