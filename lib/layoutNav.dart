import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pr1_v1/LayoutWelcome.dart';
import 'package:flutter_pr1_v1/LayoutMeditateMain.dart';

import 'LayoutMeditateSessions.dart';

class LayoutNav extends StatefulWidget {
  const LayoutNav({super.key});

  @override
  State<LayoutNav> createState() => _LayoutNavState();
}

class _LayoutNavState extends State<LayoutNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: const Color.fromARGB(255, 3, 158, 162),
            alignment: Alignment.center,
            child: SafeArea(
              child: Column(children: [
                const Padding(padding: EdgeInsets.all(45)),
                Column(
                  children: const [
                    Text(
                      'Navigation Page',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'RegulatorHeavy',
                        fontSize: 48,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'for your comfort\nPress any button on the selected page to return!',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Eina02',
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(25)),
                Column(
                  children: [
                    Material(
                        borderRadius: BorderRadius.circular(35),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LayoutWelcome()));
                          },
                          child: Container(
                            width: 330,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35)),
                            child: const Text(
                              'Page 1',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'RegulatorHeavy',
                                  fontSize: 16),
                            ),
                          ),
                        )),
                    const Padding(padding: EdgeInsets.all(5)),
                    Material(
                        borderRadius: BorderRadius.circular(35),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LayoutMeditateSessions()));
                          },
                          child: Container(
                            width: 330,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35)),
                            child: const Text(
                              'Page 2',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'RegulatorHeavy',
                                  fontSize: 16),
                            ),
                          ),
                        )),
                    const Padding(padding: EdgeInsets.all(5)),
                    Material(
                        borderRadius: BorderRadius.circular(35),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LayoutMeditateMain()));
                          },
                          child: Container(
                            width: 330,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35)),
                            child: const Text(
                              'Page 3',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'RegulatorHeavy',
                                  fontSize: 16),
                            ),
                          ),
                        )),
                    const Padding(padding: EdgeInsets.all(5)),
                    Material(
                        borderRadius: BorderRadius.circular(35),
                        color: const Color.fromARGB(255, 205, 253, 254),
                        child: InkWell(
                          onTap: () {
                            exit(0);
                          },
                          child: Container(
                            width: 330,
                            height: 50,
                            alignment: Alignment.center,
                            child: const Text(
                              'Exit',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Eina02',
                                  fontSize: 16),
                            ),
                          ),
                        )),
                  ],
                )
              ]),
            )));
  }
}
