import 'package:flutter/material.dart';
import 'package:flutter_pr1_v1/layoutNav.dart';

class LayoutMeditateSessions extends StatefulWidget {
  const LayoutMeditateSessions({super.key});

  @override
  State<LayoutMeditateSessions> createState() => _LayoutMeditateSessionsState();
}

class _LayoutMeditateSessionsState extends State<LayoutMeditateSessions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: SafeArea(
          child: Column(children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                      //color: Colors.black,
                      image: const DecorationImage(
                          image:
                              AssetImage('assets/images/pirs_s_chaikoi.png')),
                      borderRadius: BorderRadius.circular(20)),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 15)),
                const SizedBox(
                  width: 300,
                  child: Text(
                    'Peter Mach',
                    style: TextStyle(
                        color: Color.fromARGB(255, 136, 136, 136),
                        fontSize: 12,
                        fontFamily: 'Eina02'),
                    textAlign: TextAlign.left,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 3)),
                const SizedBox(
                  width: 300,
                  child: Text(
                    'Mind Deep Relax',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Eina02-bold',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                const SizedBox(
                    width: 300,
                    child: Text(
                      'Join the Community as we prepare over 33 days to relax and feel joy with the mind and happnies session across the World.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontFamily: 'Eina02-light'),
                    )),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                Material(
                    borderRadius: BorderRadius.circular(35),
                    color: const Color.fromARGB(255, 3, 158, 162),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LayoutNav()));
                      },
                      child: Container(
                          width: 320,
                          height: 50,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.play_arrow_outlined,
                                color: Colors.white,
                              ),
                              Text(
                                'Play Next Session',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Eina02-light',
                                    fontSize: 16),
                              )
                            ],
                          )),
                    )),
                const Padding(padding: EdgeInsets.only(bottom: 35)),
                Column(
                  children: [
                    Row(
                      children: [
                        Material(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(255, 47, 128, 237),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LayoutNav()));
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.play_arrow_outlined,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            )),
                        const Padding(padding: EdgeInsets.only(left: 13)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Sweet Memories',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'Eina02'),
                            ),
                            Text(
                              'December 29 Pre-Launch',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 136, 136, 136),
                                  fontSize: 12,
                                  fontFamily: 'Eina02'),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Material(
                            borderRadius: BorderRadius.circular(15),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LayoutNav()));
                              },
                              child: const Text(
                                '···',
                                style: TextStyle(
                                    color: Color.fromARGB(70, 136, 136, 136),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                    fontFamily: 'Eina02',
                                    height: 1),
                              ),
                            )),
                        const Padding(padding: EdgeInsets.only(right: 20))
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 25)),
                    Row(
                      children: [
                        Material(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(255, 3, 158, 162),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LayoutNav()));
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.play_arrow_outlined,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            )),
                        const Padding(padding: EdgeInsets.only(left: 13)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'A Day Dream',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'Eina02'),
                            ),
                            Text(
                              'December 29 Pre-Launch',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 136, 136, 136),
                                  fontSize: 12,
                                  fontFamily: 'Eina02'),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Material(
                            borderRadius: BorderRadius.circular(15),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LayoutNav()));
                              },
                              child: const Text(
                                '···',
                                style: TextStyle(
                                    color: Color.fromARGB(70, 136, 136, 136),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                    fontFamily: 'Eina02',
                                    height: 1),
                              ),
                            )),
                        const Padding(padding: EdgeInsets.only(right: 20))
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 25)),
                    Row(
                      children: [
                        Material(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(255, 240, 146, 53),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LayoutNav()));
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.play_arrow_outlined,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            )),
                        const Padding(padding: EdgeInsets.only(left: 13)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Mind Explore',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'Eina02'),
                            ),
                            Text(
                              'December 29 Pre-Launch',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 136, 136, 136),
                                  fontSize: 12,
                                  fontFamily: 'Eina02'),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Material(
                            borderRadius: BorderRadius.circular(15),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LayoutNav()));
                              },
                              child: const Text(
                                '···',
                                style: TextStyle(
                                    color: Color.fromARGB(70, 136, 136, 136),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                    fontFamily: 'Eina02',
                                    height: 1),
                              ),
                            )),
                        const Padding(padding: EdgeInsets.only(right: 20))
                      ],
                    )
                  ],
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
