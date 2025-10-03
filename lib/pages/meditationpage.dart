import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';
import 'package:unwind/custom_widgets/nue_box.dart';

class Meditationpage extends StatelessWidget {
  const Meditationpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 12),
          Stack(
            children: [
              // Lottie.asset('assets/lottie/Meditating Fox.json',height: 250),
              Lottie.asset('assets/lottie/Wave Animation.json',height: 250),
              Lottie.asset('assets/lottie/Meditating Rabbit.json',height: 250,frameRate:FrameRate(0.2)),
            ],
          ),

          SizedBox(
            width: 300,
            child: SliderTheme(
              data: SliderTheme.of(
                context,
              ).copyWith(thumbColor: Colors.blueGrey),

              child: Slider(
                activeColor: Colors.deepPurpleAccent,
                min: 0,
                max: 100,
                value: 80,
                onChanged: (value) {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 60),
                GestureDetector(
                  onTap: () {},
                  child: NeuBox(
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedGoBackward10Sec,
                      color: Colors.black,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedPause,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
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
                        
                        Navigator.pop(context);
                      },
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedCancelSquare,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Background music feature currently under development",
                            ),
                          ),
                        );
                      },
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedMusicNote01,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context). showSnackBar(SnackBar(content: Text("added 30 seconds to the timer"),duration: Duration(milliseconds: 500),));
                      },
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedGoForward30Sec,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context). showSnackBar(SnackBar(content: Text("removed 30 seconds from the timer"), duration: Duration(milliseconds: 500)));

                      },
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
    );
  }
}
