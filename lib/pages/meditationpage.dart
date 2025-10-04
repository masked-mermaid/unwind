// import 'package:flutter/material.dart';
// import 'package:hugeicons/hugeicons.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:unwind/custom_widgets/nue_box.dart';
// import 'package:unwind/provider/meditation_provider.dart';

// class Meditationpage extends StatelessWidget {
//   const Meditationpage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<MeditationProvdier>
//     (
//       builder: (context, value, child) {

//         String formatTime(Duration duration){
//         String twoDigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2,'0');
//         String formatTime= "${duration.inMinutes}:$twoDigitSeconds";
//         return formatTime;
//       }

// fnal double sliderMax= (value.selectedOption?.value.inSeconds.toDouble());
//       return Scaffold(
//         backgroundColor: Theme.of(context).colorScheme.surface,
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SizedBox(height: 12),
//             Stack(
//               children: [
//                 // Lottie.asset('assets/lottie/Meditating Fox.json',height: 250),
//                 Lottie.asset('assets/lottie/Wave Animation.json',height: 250),
//                 Lottie.asset('assets/lottie/Meditating Rabbit.json',height: 250,frameRate:FrameRate(0.2)),
//               ],
//             ),
      
//             SizedBox(
//               width: 300,
//               child: SliderTheme(
//                 data: SliderTheme.of(
//                   context,
//                 ).copyWith(thumbColor: Colors.blueGrey),
      
//                 child: SliderTheme(
//                   data: SliderThemeData(
//                     activeTrackColor: const Color.fromARGB(255, 129, 84, 255),
                    
//                   ),
//                   child: Slider(
//                     activeColor: Colors.deepPurpleAccent,
//                     min: 0,
//                     max:  value.selectedOption.inSeconds.toDouble();
//                     value: value.timer.to DOuble()
//                     onChanged: (value) {},
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 0.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   SizedBox(width: 60),
//                   GestureDetector(
//                     onTap: () {
//                       value.goTenBackwards();
//                     },
//                     child: NeuBox(
//                       child: HugeIcon(
//                         icon: HugeIcons.strokeRoundedGoBackward10Sec,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       if(value.isPlaying){
//                         value.pause();
//                       }
//                       else{
//                         value.play();
//                       }
//                     },
//                     child: HugeIcon(
//                       icon:value.isPlaying? HugeIcons.strokeRoundedPause: HugeIcons.strokeRoundedPlay,
//                       color: Colors.black,
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       value.skipTenForward();
                      
//                     },
//                     child: NeuBox(
//                       child: HugeIcon(
//                         icon: HugeIcons.strokeRoundedGoForward10Sec,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 60),
//                 ],
//               ),
//             ),
//             SizedBox(height: 8),
//             Hero(
//               tag: 0010,
//               child: SizedBox(
//                 width: 350,
//                 height: 69,
//                 child: NeuBox(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
                          
//                           Navigator.pop(context);
//                         },
//                         child: HugeIcon(
//                           icon: HugeIcons.strokeRoundedCancelSquare,
//                           color: Colors.black,
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text(
//                                 "Background music feature currently under development",
//                               ),
//                             ),
//                           );
//                         },
//                         child: HugeIcon(
//                           icon: HugeIcons.strokeRoundedMusicNote01,
//                           color: Colors.black,
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           ScaffoldMessenger.of(context). showSnackBar(SnackBar(content: Text("added 30 seconds to the timer"),duration: Duration(milliseconds: 500),));
//                         },
//                         child: HugeIcon(
//                           icon: HugeIcons.strokeRoundedGoForward30Sec,
//                           color: Colors.black,
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           ScaffoldMessenger.of(context). showSnackBar(SnackBar(content: Text("removed 30 seconds from the timer"), duration: Duration(milliseconds: 500)));
      
//                         },
//                         child: HugeIcon(
//                           icon: HugeIcons.strokeRoundedGoBackward30Sec,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 24),
//           ],
//         ),
//       );
//   });
//   }
// }
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:unwind/custom_widgets/nue_box.dart';
import 'package:unwind/provider/meditation_provider.dart';

// Assuming NueButtons is a custom widget similar to NeuBox but for buttons.
// Since the original snippet was: NueButtons(isSelected: isSelected, onTap: ...),
// and it's not present in this code, I'll focus on fixing the provided code.

class Meditationpage extends StatelessWidget {
  const Meditationpage({super.key});

  @override
  Widget build(BuildContext context) {
    // Using Consumer for state management
    return Consumer<MeditationProvdier>(
      builder: (context, value, child) {

        // Function to format the duration/timer
        String formatTime(Duration duration){
          String twoDigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2,'0');
          // Format as "Minutes:Seconds"
          String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";
          return formattedTime;
        }

        // Safely determine the max value for the slider.
        // If no option is selected, use a default (e.g., 5 minutes)
        final double sliderMax = (value.selectedOption?.value ?? const Duration(minutes: 5)).inSeconds.toDouble();
        
        // Safely determine the current value for the slider.
        // If the timer is null (not started), use the max value.
        final double sliderValue = (value.timer ?? value.selectedOption?.value ?? const Duration(minutes: 5)).inSeconds.toDouble();


        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 12),

              // Timer Display (Added for context)
              if (value.timer != null)
                Text(
                  formatTime(value.timer!),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),

              Stack(
                children: [
                  // Lottie.asset('assets/lottie/Meditating Fox.json',height: 250),
                  Lottie.asset('assets/lottie/Wave Animation.json',height: 250),
                  Lottie.asset('assets/lottie/Meditating Rabbit.json',height: 250,frameRate:const FrameRate(0.2)),
                ],
              ),
        
              SizedBox(
                width: 300,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbColor: Colors.blueGrey,
                    activeTrackColor: const Color.fromARGB(255, 129, 84, 255),
                  ),
                  
                  // Slider Implementation
                  child: Slider(
                    activeColor: Colors.deepPurpleAccent,
                    min: 0,
                    // ✅ FIX 1: Correctly assign max, using null safety
                    max: sliderMax, 
                    // ✅ FIX 2: Correctly assign value, using null safety and .toDouble()
                    value: sliderValue, 
                    // The user should not be able to change the time via the slider in this setup
                    onChanged: (newValue) {
                      // You might add logic here to manually set the timer position if needed
                    },
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(width: 60),

                    // Go 10 Seconds Backwards Button
                    GestureDetector(
                      onTap: () {
                        // Check if timer is set before attempting adjustment
                        if (value.timer != null) {
                          value.goTenBackwards();
                        }
                      },
                      child: const NeuBox(
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedGoBackward10Sec,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    // Play/Pause Button
                    GestureDetector(
                      onTap: () {
                        // Ensure a time option is selected before playing
                        if (value.selectedOption != null) {
                          if(value.isPlaying){
                            value.pause();
                          } else {
                            value.play();
                          }
                        } else {
                           ScaffoldMessenger.of(context).showSnackBar(
                             const SnackBar(content: Text("Please select a meditation time first.")),
                           );
                        }
                      },
                      child: HugeIcon(
                        icon: value.isPlaying ? HugeIcons.strokeRoundedPause : HugeIcons.strokeRoundedPlay,
                        color: Colors.black,
                      ),
                    ),

                    // Go 10 Seconds Forward Button
                    GestureDetector(
                      onTap: () {
                        // Check if timer is set before attempting adjustment
                        if (value.timer != null) {
                          value.skipTenForward();
                        }
                      },
                      child: const NeuBox(
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedGoForward10Sec,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 60),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Bottom Control Box (Hero is a stylistic choice, kept for fidelity)
              Hero(
                tag: 0010,
                child: SizedBox(
                  width: 350,
                  height: 69,
                  child: NeuBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Cancel Button
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const HugeIcon(
                            icon: HugeIcons.strokeRoundedCancelSquare,
                            color: Colors.black,
                          ),
                        ),

                        // Music Button
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Background music feature currently under development",
                                ),
                              ),
                            );
                          },
                          child: const HugeIcon(
                            icon: HugeIcons.strokeRoundedMusicNote01,
                            color: Colors.black,
                          ),
                        ),

                        // Add 30 Seconds Button
                        GestureDetector(
                          onTap: () {
                            // ✅ FIX 3: Hook up the provider method
                            if (value.timer != null) {
                              value.add30Sconds();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Added 30 seconds to the timer"),
                                  duration: Duration(milliseconds: 500),
                                ),
                              );
                            }
                          },
                          child: const HugeIcon(
                            icon: HugeIcons.strokeRoundedGoForward30Sec,
                            color: Colors.black,
                          ),
                        ),

                        // Remove 30 Seconds Button
                        GestureDetector(
                          onTap: () {
                            // ✅ FIX 4: Hook up the provider method
                            if (value.timer != null) {
                              value.remove30Sconds();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Removed 30 seconds from the timer"), 
                                  duration: Duration(milliseconds: 500)
                                ),
                              );
                            }
                          },
                          child: const HugeIcon(
                            icon: HugeIcons.strokeRoundedGoBackward30Sec,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      }
    );
  }
}