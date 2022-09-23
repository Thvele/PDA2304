import 'package:flutter/material.dart';
import 'package:flutter_pr1_v1/layoutNav.dart';

class LayoutWelcome extends StatefulWidget {
  const LayoutWelcome({super.key});

  @override
  State<LayoutWelcome> createState() => _LayoutWelcomeState();
}

class _LayoutWelcomeState extends State<LayoutWelcome> {
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
                      'medinow',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'RegulatorHeavy',
                        fontSize: 36,
                      ),
                    ),
                    Text(
                      'Meditate With Us!',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Eina02',
                        fontSize: 14,
                      ),
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
                                    builder: (context) => const LayoutNav()));
                          },
                          child: Container(
                            width: 330,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35)),
                            child: const Text(
                              'Sign in with Apple',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Eina02',
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
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LayoutNav()));
                          },
                          child: Container(
                            width: 330,
                            height: 50,
                            alignment: Alignment.center,
                            child: const Text(
                              'Continue with Email or Phone',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Eina02',
                                  fontSize: 16),
                            ),
                          ),
                        )),
                    const Padding(padding: EdgeInsets.all(5)),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LayoutNav()));
                      },
                      child: Container(
                        width: 500,
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text(
                          'Continue With Google',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Eina02',
                              fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                Image.asset(
                  'assets/images/chel.png',
                  width: 370,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20))
              ]),
            )));
  }
}
