import 'package:confetti/confetti.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Widgets/player1.dart';
import 'Widgets/player2.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool oTurn = true;

  // 1st player is O
  List<String> cardItem = ['', '', '', '', '', '', '', '', ''];

  // Score vars
  int oPlayer = 0;
  int xPlayer = 0;

  // This var is to check draw case
  int checkedItems = 0;

  // for win amimation
  late ConfettiController _controllerCenter;

  // for glowing border around profile to highlight who's turn
  late AnimationController _resizableController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff000000), // status bar color
      statusBarIconBrightness: Brightness.light, // status bar icon color
      systemNavigationBarIconBrightness:
          Brightness.light, // color of navigation controls
    ));

    _controllerCenter =
        ConfettiController(duration: const Duration(milliseconds: 100));

    _resizableController = new AnimationController(
      vsync: this,
      duration: new Duration(
        milliseconds: 1000,
      ),
    );
    _resizableController.addStatusListener((animationStatus) {
      switch (animationStatus) {
        case AnimationStatus.completed:
          _resizableController.reverse();
          break;
        case AnimationStatus.dismissed:
          _resizableController.forward();
          break;
        case AnimationStatus.forward:
          break;
        case AnimationStatus.reverse:
          break;
      }
    });
    _resizableController.forward();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xff000000),
            Color(0xff81B2DC),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        oTurn
                            ? new AnimatedBuilder(
                                animation: _resizableController,
                                builder: (context, child) {
                                  return Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.rectangle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.green,
                                              blurRadius:
                                                  _resizableController.value *
                                                      5,
                                              spreadRadius:
                                                  _resizableController.value *
                                                      8,
                                            ),
                                          ]),
                                      child: player1(context));
                                })
                            : player1(context),
                        Row(
                          children: [
                            Text(
                              oPlayer.toString(),
                              style: GoogleFonts.titilliumWeb(
                                  letterSpacing: 1,
                                  decorationThickness: 1.5,
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              "-",
                              style: GoogleFonts.titilliumWeb(
                                  letterSpacing: 1,
                                  decorationThickness: 1.5,
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              xPlayer.toString(),
                              style: GoogleFonts.titilliumWeb(
                                  letterSpacing: 1,
                                  decorationThickness: 1.5,
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        oTurn
                            ? player2(context)
                            : new AnimatedBuilder(
                                animation: _resizableController,
                                builder: (context, child) {
                                  return Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.rectangle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.green,
                                              blurRadius:
                                                  _resizableController.value *
                                                      5,
                                              spreadRadius:
                                                  _resizableController.value *
                                                      8,
                                            ),
                                          ]),
                                      child: player2(context));
                                }),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: GridView.builder(
                        itemCount: 9,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.all(7.0),
                            child: Neumorphic(
                              margin: EdgeInsets.zero,
                              style: NeumorphicStyle(
                                  intensity: 10,
                                  depth: -8,
                                  lightSource: LightSource.topLeft,
                                  border: NeumorphicBorder(
                                      color: Colors.grey, width: 0.30),
                                  color: Colors.white,
                                  shadowDarkColor: Colors.white,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(5)),
                                  shadowLightColorEmboss:
                                      Colors.black.withOpacity(0.45),
                                  shadowDarkColorEmboss:
                                      Colors.black.withOpacity(0.1)),
                              child: GestureDetector(
                                onTap: () {
                                  _tapped(index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white)),
                                  child: Center(
                                    child: cardItem[index] == "X"
                                        ? SvgPicture.asset(
                                            "assets/x.svg",
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                10,
                                          )
                                        : cardItem[index] == "O"
                                            ? SvgPicture.asset(
                                                "assets/o.svg",
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    8,
                                              )
                                            : Container(),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (oTurn && cardItem[index] == '') {
        cardItem[index] = 'O';
        checkedItems++;
        oTurn = !oTurn;
        _checkResult();
      } else if (!oTurn && cardItem[index] == '') {
        cardItem[index] = 'X';
        checkedItems++;
        oTurn = !oTurn;
        _checkResult();
      }
    });
  }

  // To Clear Items on round over
  void _clearItems() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        cardItem[i] = '';
      }
    });

    checkedItems = 0;
  }

  void _checkResult() {
    // To check if result found

    // Rows
    if (cardItem[0] == cardItem[1] &&
        cardItem[0] == cardItem[2] &&
        cardItem[0] != '') {
      _WinnerDialog(cardItem[0]);
    } else if (cardItem[3] == cardItem[4] &&
        cardItem[3] == cardItem[5] &&
        cardItem[3] != '') {
      _WinnerDialog(cardItem[3]);
    } else if (cardItem[6] == cardItem[7] &&
        cardItem[6] == cardItem[8] &&
        cardItem[6] != '') {
      _WinnerDialog(cardItem[6]);
    } else if (cardItem[0] == cardItem[3] &&
        cardItem[0] == cardItem[6] &&
        cardItem[0] != '') {
      _WinnerDialog(cardItem[0]);
    } else if (cardItem[1] == cardItem[4] &&
        cardItem[1] == cardItem[7] &&
        cardItem[1] != '') {
      _WinnerDialog(cardItem[1]);
    } else if (cardItem[2] == cardItem[5] &&
        cardItem[2] == cardItem[8] &&
        cardItem[2] != '') {
      _WinnerDialog(cardItem[2]);
    } else if (cardItem[0] == cardItem[4] &&
        cardItem[0] == cardItem[8] &&
        cardItem[0] != '') {
      _WinnerDialog(cardItem[0]);
    } else if (cardItem[2] == cardItem[4] &&
        cardItem[2] == cardItem[6] &&
        cardItem[2] != '') {
      _WinnerDialog(cardItem[2]);
    } else if (checkedItems == 9) {
      _MatchDrawDialog();
    }
  }

  // Winner
  void _WinnerDialog(String item) {
    _controllerCenter.play();
    var playerName = "";

    if (item == 'O') {
      playerName = "EMILY B";
      oPlayer++;
    } else if (item == 'X') {
      playerName = "SOHEL";
      xPlayer++;
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [
                Color(0xffffffff),
                Colors.green.withOpacity(0.6),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            height: MediaQuery.of(context).size.height / 2.5,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Winner!!!",
                          style: GoogleFonts.titilliumWeb(
                              letterSpacing: 1,
                              decorationThickness: 1.5,
                              color: Colors.green,
                              fontSize: 22,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          playerName,
                          style: GoogleFonts.titilliumWeb(
                              letterSpacing: 1,
                              decorationThickness: 1.5,
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        _controllerCenter.stop();
                        _clearItems();
                        Navigator.of(context).pop();
                      },
                      child: Neumorphic(
                        margin: EdgeInsets.zero,
                        style: NeumorphicStyle(
                            intensity: 10,
                            depth: -2,
                            lightSource: LightSource.topLeft,
                            color: Colors.transparent,
                            shadowDarkColor: Colors.white,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(10)),
                            shadowLightColorEmboss: Color(0xffF5F1EE),
                            shadowDarkColorEmboss:
                                Color(0xff707070).withOpacity(0.2)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 25),
                            child: Text(
                              "Play Again!",
                              style: GoogleFonts.titilliumWeb(
                                  letterSpacing: 1,
                                  decorationThickness: 1.5,
                                  color: Colors.black.withOpacity(0.9),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  alignment: Alignment.topCenter,
                  child: ConfettiWidget(
                    numberOfParticles: 25,
                    confettiController: _controllerCenter,
                    blastDirectionality: BlastDirectionality.explosive,
                    // don't specify a direction, blast randomly
                    shouldLoop: true,
                    // start again as soon as the animation is finished
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple
                    ], // manually specify the colors to be used
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Match Draw
  void _MatchDrawDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [
                Color(0xffffffff),
                Colors.red.withOpacity(0.6),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            height: MediaQuery.of(context).size.height / 2.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Match draw",
                      style: GoogleFonts.titilliumWeb(
                          letterSpacing: 1,
                          decorationThickness: 1.5,
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    _clearItems();
                    Navigator.of(context).pop();
                  },
                  child: Neumorphic(
                    margin: EdgeInsets.zero,
                    style: NeumorphicStyle(
                        intensity: 10,
                        depth: -2,
                        lightSource: LightSource.topLeft,
                        color: Colors.transparent,
                        shadowDarkColor: Colors.white,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(10)),
                        shadowLightColorEmboss: Color(0xffF5F1EE),
                        shadowDarkColorEmboss:
                            Color(0xff707070).withOpacity(0.2)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 25),
                        child: Text(
                          "Play Again!",
                          style: GoogleFonts.titilliumWeb(
                              letterSpacing: 1,
                              decorationThickness: 1.5,
                              color: Colors.black.withOpacity(0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
