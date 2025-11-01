import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:unwind/custom_widgets/nue_box.dart';
import 'package:unwind/provider/meditation_provider.dart';

class Meditationpage extends StatelessWidget {
  const Meditationpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MeditationProvider>(
      builder: (context, value, child) {
        String formatTime(Duration duration) {
          String twoDigitSeconds = duration.inSeconds
              .remainder(60)
              .toString()
              .padLeft(2, '0');
          String formatTime = "${duration.inMinutes}:$twoDigitSeconds";
          return formatTime;
        }

        return Stack(
          children: [
            Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 12),
                  Stack(
                    children: [
                      // Lottie.asset('assets/lottie/Meditating Fox.json',height: 250),
                      Lottie.asset(
                        'assets/lottie/Wave Animation.json',
                        height: 250,
                      ),
                      Lottie.asset(
                        'assets/lottie/Meditating Rabbit.json',
                        height: 250,
                        frameRate: FrameRate(0.2),
                      ),
                    ],
                  ),

                  SizedBox(
                    width: 300,
                    child: SliderTheme(
                      data: SliderTheme.of(
                        context,
                      ).copyWith(thumbColor: Colors.blueGrey),

                      child: SliderTheme(
                        data: SliderThemeData(
                          activeTrackColor: const Color.fromARGB(
                            255,
                            129,
                            84,
                            255,
                          ),
                        ),
                        child: Slider(
                          min: 0,
                          // Max is the total session time (in seconds)
                          max: 100,
                          // value.medTime!.inSeconds.toDouble(),
                          // Value is the time remaining (in seconds)
                          value: value.slider,
                          onChanged: (newTime) {},
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 48.0, right: 48),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatTime(value.sliderTime)),
                        Text(formatTime(value.medTime?? Duration.zero)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(width: 60),
                        GestureDetector(
                          onTap: value.btn? () {
                            value.goTenBackwards();
                          }:null,
                          child: NeuBox(
                            child: HugeIcon(
                              icon: HugeIcons.strokeRoundedGoBackward10Sec,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:value.btn? () {
                            if (value.isPlaying) {
                              value.pause();
                            } else {
                              value.play();
                            }
                          }:null,
                          child: HugeIcon(
                            icon:
                                value.isPlaying
                                    ? HugeIcons.strokeRoundedPause
                                    : HugeIcons.strokeRoundedPlay,
                            color: Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap:value.btn? () {
                            value.skipTenForward();
                          }:null,
                          child: NeuBox(
                            child: HugeIcon(
                              icon: HugeIcons.strokeRoundedGoForward10Sec,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 60),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Hero(
                    tag: 0010,
                    child: SizedBox(
                      width: 350,
                      height: 69,
                      child: NeuBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                            onTap: () {
                                value.stopSession();
                                Navigator.pop(context);
                              },
                              child: HugeIcon(
                                icon: HugeIcons.strokeRoundedCancelSquare,
                                color: Colors.black,
                              ),
                            ),
                            GestureDetector(
                              onTap: value.btn ? () {
                                value.add30Seconds();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Background music feature currently under development",
                                    ),
                                  ),
                                );
                              }:null,
                              child: HugeIcon(
                                icon: HugeIcons.strokeRoundedMusicNote01,
                                color: Colors.black,
                              ),
                            ),
                            GestureDetector(
                              onTap: value.btn ? () {
                                value.add30Seconds();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "added 30 seconds to the timer",
                                    ),
                                    duration: Duration(milliseconds: 500),
                                    action: SnackBarAction(
                                      label: "OK",
                                      onPressed: () {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).hideCurrentSnackBar();
                                      },
                                    ),
                                  ),
                                );
                              }:null,
                              child: HugeIcon(
                                icon: HugeIcons.strokeRoundedGoForward30Sec,
                                color: Colors.black,
                              ),
                            ),
                            GestureDetector(
                              onTap:value.btn?() {
                                value.remove30Sconds();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "removed 30 seconds from the timer",
                                    ),
                                    duration: Duration(milliseconds: 500),
                                    action: SnackBarAction(
                                      label: "OK",
                                      onPressed: () {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).hideCurrentSnackBar();
                                      },
                                    ),
                                  ),
                                );
                              }:null,
                              child: HugeIcon(
                                icon: HugeIcons.strokeRoundedGoBackward30Sec,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),

            Positioned(
              top: 0,
              left: 0,
              child: ConfettiWidget(
                confettiController: value.confettiController,
                blastDirectionality: BlastDirectionality.directional,
                blastDirection: 3.14 / 4, // 45 degrees toward bottom-right
                maxBlastForce: 20,
                minBlastForce: 10,
                emissionFrequency: 0.05,
                numberOfParticles: 50,
                gravity: 0.1,
              ),
            ),

            // Top-right confetti
            Positioned(
              top: 0,
              right: 0,
              child: ConfettiWidget(
                confettiController: value.confettiController,
                blastDirectionality: BlastDirectionality.directional,
                blastDirection: 3.14 * 3 / 4, // 135 degrees toward bottom-left
                maxBlastForce: 20,
                minBlastForce: 10,
                emissionFrequency: 0.05,
                numberOfParticles: 50,
                gravity: 0.1,
              ),
            ),
          ],
        );
      },
    );
  }
}
