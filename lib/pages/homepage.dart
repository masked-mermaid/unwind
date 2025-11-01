import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:unwind/custom_widgets/nue_box.dart';
import 'package:unwind/custom_widgets/nue_buttons.dart';
import 'package:unwind/pages/meditationpage.dart';
import 'package:unwind/provider/meditation_provider.dart';
import 'package:unwind/provider/quotes_provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final optionLists = Provider.of<MeditationProvider>(context);
    final quotesdata = Provider.of<QuotesProvider>(context);

    // final  box =await Hive.openBox<Quotes>('quotesbox');

    return Consumer(
      builder:
          (context, value, child) => Scaffold(
            backgroundColor:
                // Colors.grey.shade400,
                Theme.of(context).colorScheme.surface,

            drawer: const Drawer(
              child: SafeArea(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Settings'),
                      leading: Icon(Icons.settings),
                    ),
                  ],
                ),
              ),
            ),

            appBar: AppBar(
              forceMaterialTransparency: false,
              shadowColor: Colors.transparent,
              // actionsPadding: EdgeInsets.only(left: 24),
              backgroundColor:
                  // Colors.grey.shade400,
                  Theme.of(context).colorScheme.surface,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedFire03,
                          color: Colors.grey,
                        ),
                        Text(
                          '3',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                          ),
                        ),
                      ],
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
                  const Text(
                    'Welcome Back, Jake',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  // SizedBox(height: 24,),
                  GestureDetector(
                    onTap: () async {
                      if (quotesdata.currentQuote != null) {
                        final quote = quotesdata.currentQuote!;
                        await Clipboard.setData(
                          ClipboardData(
                            text: " ${quote.quote} \n- ${quote.author}",
                          ),
                        );
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text("Quote copied to clipboard"),
                            duration: const Duration(seconds: 2),
                            action: SnackBarAction(
                              label: 'OK',
                              onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                            ),
                          ),
                        );
                      }
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
                                quotesdata.currentQuote != null
                                    ? " '' ${quotesdata.currentQuote!.quote} ''"
                                    : "Loading quote...",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 300,
                                child: Text(
                                  quotesdata.currentQuote != null
                                      ? "${quotesdata.currentQuote!.author} - "
                                      : "",
                                  textDirection: TextDirection.rtl,
                                  style: const TextStyle(fontSize: 16),
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
                            builder: (context) => const Meditationpage(),
                          ),
                        );
                        // Play will also start the timer
                        optionLists.play();
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
