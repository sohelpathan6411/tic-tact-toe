
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget player2(context) {
  return Neumorphic(
    margin: EdgeInsets.zero,
    style: NeumorphicStyle(
        intensity: 10,
        depth: -1,
        lightSource: LightSource.topLeft,
        color: Colors.transparent,
        shadowDarkColor: Colors.white,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
        shadowLightColorEmboss: Color(0xffF5F1EE),
        shadowDarkColorEmboss: Color(0xff707070).withOpacity(0.4)),
    child: Container(
      width: MediaQuery.of(context).size.width / 3,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          Color(0xff92CBE5),
          Color(0xff7776D3),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Card(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 2),
                        child: SvgPicture.asset(
                          "assets/x.svg",
                          fit: BoxFit.fill,
                          height: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ClipOval(
              child: SizedBox.fromSize(
                size: Size.fromRadius(
                    MediaQuery.of(context).size.width / 12), // Image radius
                child: Image.asset(
                  "assets/player2.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SOHEL",
                  style: GoogleFonts.titilliumWeb(
                      letterSpacing: 1,
                      decorationThickness: 1.5,
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ),
  );
}
