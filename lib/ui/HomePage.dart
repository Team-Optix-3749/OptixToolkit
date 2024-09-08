// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:OptixToolkit/services/database.dart';
import 'package:OptixToolkit/ui/tools/ToolLine.dart';

class homePage extends StatelessWidget {
  final Function(int) changePage;
  homePage({Key? key, required this.changePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      FutureProvider<List<Part>>.value(
          value: Database.getParts(Provider.of<firebase.IdTokenResult>(context)), initialData: [],),
      FutureProvider<Map<String, List<Tool>>>.value(
          value:
              Database.getToolsReversed(Provider.of<firebase.IdTokenResult>(context)), initialData: {},),
      FutureProvider<int>.value(
          value: Database.getTime(Provider.of<firebase.IdTokenResult>(context), context), initialData: 0,)
    ], child: homePage2(changePage: this.changePage));
  }
}

class homePage2 extends StatefulWidget {
  final Function(int) changePage;
  homePage2({Key? key, required this.changePage })
      : super(key: key);

  @override
  _homePage2State createState() => _homePage2State();
}

class _homePage2State extends State<homePage2> {
  @override
  Widget build(BuildContext context) {
    var toolsMap = Provider.of<Map<String, List<Tool>>>(context);
    var time = Provider.of<int>(context);

    List<Tool> tools = [];

    toolsMap.forEach((k, v) => tools += v);

    String msToTime(duration) {
      var hours = ((duration / (1000*60*60))).floor();
      var minutes = ((duration / (1000*60)) % 60).floor();
      var seconds = ((duration / 1000) % 60).floor();

      var hoursStr = "${(hours < 10) ? "0${hours}" : hours}";
      var minutesStr = "${(minutes < 10) ? "0${minutes}" : minutes}";
      var secondsStr = "${(seconds < 10) ? "0${seconds}" : seconds}";

      print(hoursStr);
      print(minutesStr);
      print(secondsStr);

      return hoursStr + " hr, " + minutesStr + " min, " + secondsStr + " sec";
    }

    return Container(
      child: Column(
        children: [
          Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xff3a3d41),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Hey there, ',
                                    style: GoogleFonts.rubik(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                    )),
                                TextSpan(
                                  text: Provider.of<firebase.User>(context)
                                      .displayName
                                      ?.split(" ")[0],
                                  style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 25.0,
                                  ),
                                ),
                                TextSpan(
                                  text: '!',
                                  style: GoogleFonts.rubik(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xff3a3d41),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: msToTime(time),
                          style: GoogleFonts.rubik(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  widget.changePage(1);
                },
                child: Container(
                  margin:
                      EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
                  width: 400,
                  height: MediaQuery.of(context).size.height * 0.50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xff3a3d41),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Tool ',
                                      style: GoogleFonts.rubik(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                      )),
                                  TextSpan(
                                    text: 'Reservations',
                                    style: GoogleFonts.rubik(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 25.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Expanded(
                          child: ListView(
                              children: tools
                                  .map<Widget>((tool) =>
                                      ToolLine(tool: tool, status: tool.status))
                                  .toList()
                                  .reversed
                                  .toList()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // GestureDetector(
              //   onTap: () {
              //     changePage(2);
              //   },
              //   child: Container(
              //     margin:
              //         EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
              //     width: 400,
              //     height: MediaQuery.of(context).size.height * 0.35,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10.0),
              //       color: Color(0xff3a3d41),
              //     ),
              //     child: Padding(
              //       padding: EdgeInsets.all(15.0),
              //       child: Column(
              //         children: [
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: <Widget>[
              //               RichText(
              //                 text: TextSpan(
              //                   children: <TextSpan>[
              //                     TextSpan(
              //                         text: 'Incoming ',
              //                         style: GoogleFonts.rubik(
              //                           color: Colors.white,
              //                           fontSize: 25.0,
              //                         )),
              //                     TextSpan(
              //                       text: 'Parts',
              //                       style: GoogleFonts.rubik(
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.white,
              //                         fontSize: 25.0,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //           Expanded(
              //             child: ListView(
              //               children: parts
              //                   .map<Widget>((part) => PartLine(part: part))
              //                   .toList()
              //                   .reversed
              //                   .toList()
              //                   .sublist(0, min(4, parts.length)),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
