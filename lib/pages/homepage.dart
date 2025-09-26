import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:unwind/components/nue_box.dart';
import 'package:unwind/components/nue_buttons.dart';
// import 'package:unwind/models/meditationoptions.dart';
import 'package:unwind/pages/meditationpage.dart';
import 'package:unwind/provider/meditation_provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final optionLists = Provider.of<MeditationProvdier>(context);
    return Consumer(
      builder:
          (context, value, child) => Scaffold(
            backgroundColor:
                // Colors.grey.shade400,
                Theme.of(context).colorScheme.surface,

            drawer: Drawer(
              // child: ,
            ),

            appBar: AppBar(
              shadowColor: Colors.transparent,
              // actionsPadding: EdgeInsets.only(left: 24),
              backgroundColor:
                  // Colors.grey.shade400,
                  Theme.of(context).colorScheme.surface,
              actions: [
                // SizedBox(width: 24,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InnerShadow(
                    shadows: [
                      Shadow(
                        color: Theme.of(context).colorScheme.tertiary,
                        blurRadius: 4,
                        offset: Offset(4, 4),
                      ),
                      Shadow(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        blurRadius: 4,
                        offset: Offset(-4, -4),
                      ),
                    ],
                    child: Container(
                      // height: 30,
                      width: 68,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedFire03,
                            color: Colors.black54,
                          ),
                          Text(
                            '3',
                            style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              // padding: EdgeInsets.all(8),
              padding: const EdgeInsets.only(
                top: 32,
                bottom: 48,
                left: 18,
                right: 12,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Welcome Back, Jake',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  // SizedBox(height: 24,),
                  NeuBox(
                    child: SizedBox(
                      height: 100,
                      width: 340,
                      child: Text(
                        '"Lack of emotion causes lack of progress \n and lack of motivation \n \n \n \t\t\t\t-Tony Robbins',
                      ),
                    ),
                  ),
                  // SizedBox(height: 250,),
                  // timeButtons(),
                  Container(
                    color: Colors.transparent,
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        clipBehavior: Clip.none,
                        itemCount: 8,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final option = optionLists.selectionOptions[index];
                          final bool isSelected =
                              optionLists.selectedOption == option;
                      
                          return NueButtons(
                            isSelected: isSelected,
                            onTap: () {
                               optionLists.setSelectionOption(option);
  print('time changed to ${option.label}');
                               },
                            child: Text(option.label),
                          );
                        },
                      ),
                    ),
                  ),

                  // SizedBox(height: 32,),
                  GestureDetector(
                    onTap: () {
                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Meditationpage(),
                        ),
                      );
                    },
                    child: NeuBox(
                      child: SizedBox(
                        // color: Colors.grey.shade400 ,
                        width: 300,
                        height: 36,
                        child: Center(
                          child: Text(
                            "Start Meditation",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Row timeButtons() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      // children: [
      //   NueButtons(child: Text('5 min'), ),
      //   NueButtons(child: Text('10min')),
      //   NueButtons(
      //     child: Text('15 min'),
      //   ),
      //   NueButtons(
      //     child: DropdownButton(
      //       padding:EdgeInsets.all(0) ,

      //       hint: const Text("Custom"),
      //       items:
      //           ['30min', '45min', '60min']
      //               .map(
      //                 (time) => DropdownMenuItem(
      //                   value: time,
      //                   child: Text(time),
      //                 ),
      //               )
      //               .toList(),
      //       onChanged: (value) {},
      //     ),
      //   ),
      // ],
    );
  }
}
