import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:unwind/boxes.dart';
import 'package:unwind/custom_widgets/nue_box.dart';
import 'package:unwind/custom_widgets/nue_buttons.dart';
import 'package:unwind/data/quotes/get_quotes.dart';
// import 'package:unwind/models/meditationoptions.dart';
import 'package:unwind/pages/meditationpage.dart';
import 'package:unwind/pages/privacypage.dart';
import 'package:unwind/pages/settings.dart';
import 'package:unwind/provider/meditation_provider.dart';
import 'package:unwind/provider/quotes_provider.dart';
import 'package:unwind/provider/userdata_provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final optionLists = Provider.of<MeditationProvider>(context);
    final quotesdata = Provider.of<QuotesProvider>(context);
    final userdata =context.watch<UserDataProvider>();
    TextEditingController textController= TextEditingController();
    // final  box =await Hive.openBox<Quotes>('quotesbox');

    return Consumer(
      builder:
          (context, value, child) => Scaffold(
            backgroundColor:
                // Colors.grey.shade400,
                Theme.of(context).colorScheme.surface,

            drawer: Drawer(
            shape: BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(22))),
              child: ListView(
                children: [
                 
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context)=> const SettingsPage()));
                    },
                    child: ListTile(
                      leading: Text("Settings"),
                    
                    ),
                  ), GestureDetector(
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context)=> const PrivacyPage()));
                    },
                    child: ListTile(
                      leading: Text("Privacy Policy"),
                    
                    ),
                  ),
                  
                ],
              )
            ),

            appBar: AppBar(
              forceMaterialTransparency: false,
              shadowColor: Colors.transparent,
              // actionsPadding: EdgeInsets.only(left: 24),
              backgroundColor:
                  // Colors.grey.shade400,
                  Theme.of(context).colorScheme.surface,
            actions:[Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                      border: optionLists.hasMeditatedToday? Border.all(
                        width: 2,
                        color: Colors.deepPurpleAccent
                      ): null,
                      color: Theme.of(context).colorScheme.onSurface,
                      // color: Colors.grey.shade600,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                                      
                        
                                      
                      optionLists.hasMeditatedToday?
                      Lottie.asset(
                        'assets/lottie/Streak Fire.json',
                        height: 52, 
                        backgroundLoading: true,
                      )
                                      
                      :  HugeIcon(
                          icon: HugeIcons.strokeRoundedFire03,
                          color: Colors.grey,
                        ),
                        Text(
                          userdata.userStreak.toString(),
                          style: TextStyle(
                            fontSize: optionLists.hasMeditatedToday?24:18,
                            // fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).colorScheme.inversePrimary,
                                // Colors.white
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ]
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
                  GestureDetector(
                    onTap: () {
                      showDialog(context: context, builder: (context){
                        return  AlertDialog(
      title: const Text('Enter your name'),
      content: TextField(
        // onChanged: (value) {
        //   _enteredText = value;
        // },

        controller: textController,
        decoration: const InputDecoration(hintText: 'Name'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async{
            final String enteredName =textController.text;


            if (enteredName.isNotEmpty){
            userdata.saveName(enteredName);
            }
            // handle save and close
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
                      });
                    },
                    child: Text(
                      'Welcome Back, ${userdata.userName}',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // SizedBox(height: 24,),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(
                          text:
                              '${box.getAt(quotesdata.quoteIndex)?.quote ?? "It always seems impossible until it\'s done."}\n- ${box.getAt(quotesdata.quoteIndex)?.author ?? "Nelson Mandela"}',
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Quote copied to clipboard"),
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () {
                              ScaffoldMessenger.of(
                                context,
                              ).hideCurrentSnackBar();
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
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  // '"Lack of emotion causes lack of progress \n and lack of motivation \n \n \n \t\t\t\t-Tony Robbins',
                                  '${box.getAt(quotesdata.quoteIndex)?.quote ?? "It always seems impossible until it\'s done."}',
                                  style: TextStyle(fontSize: 16),
                                ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 300,
                                child: Text(
                                  '${box.getAt(quotesdata.quoteIndex)?.author ?? "Nelson Mandela"}',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
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
