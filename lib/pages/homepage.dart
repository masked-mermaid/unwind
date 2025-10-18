import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:unwind/boxes.dart';
import 'package:unwind/custom_widgets/nue_box.dart';
import 'package:unwind/custom_widgets/nue_buttons.dart';
import 'package:unwind/data/quotes/get_quotes.dart';
// import 'package:unwind/models/meditationoptions.dart';
import 'package:unwind/pages/meditationpage.dart';
import 'package:unwind/provider/meditation_provider.dart';
import 'package:unwind/provider/quotes_provider.dart';


class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final optionLists = Provider.of<MeditationProvdier>(context);
    final quotesdata =Provider.of<QuotesProvider>(context);
    
    // final  box =await Hive.openBox<Quotes>('quotesbox');

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
                   GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text:" ${box.getAt(quotesdata.quoteIndex)?.quote} \n- ${box.getAt(quotesdata.quoteIndex)?.author}"));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Quote copied to clipboard"),
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            },
                          ),
                        ),
                      );
                    },
                     child: NeuBox(
                        child: SizedBox(
                            height: 100,
                            width: 340,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                // '"Lack of emotion causes lack of progress \n and lack of motivation \n \n \n \t\t\t\t-Tony Robbins',
                                                         " '' ${box.getAt(quotesdata.quoteIndex)?.quote} ''",style: TextStyle(
                                fontSize: 16
                              ),),
                            ),
                            
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 300,
                                child: Text(
                                    "${box.getAt(quotesdata.quoteIndex)?.author} - ",
                                    textDirection:TextDirection.rtl ,style: TextStyle(
                                fontSize: 16
                              )
                                ),
                              ),
                            )
                            ]
                          ),
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
                              // print('time changed to ${option.label}');
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
                      if (optionLists.selectedOption == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please select a time"),
                            action: SnackBarAction(
                              label: "Ok",
                              onPressed:
                                  ScaffoldMessenger.of(
                                    context,
                                  ).hideCurrentSnackBar,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Meditationpage(),
                            
                          ),
                        );
                        optionLists.setplaying();
                        optionLists.settimer();

                      }
                    },
                    child: NeuBox(
                      child: Hero(
                        tag: 001,
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
                  ),
                ],
              ),
            ),
          ),
    );
  }
}