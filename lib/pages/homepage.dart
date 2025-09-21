import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:unwind/components/nue_box.dart';
import 'package:unwind/components/nue_buttons.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, value, child) =>  Scaffold(
      
        backgroundColor:
        // Colors.grey.shade400,
        Theme.of(context).colorScheme.surface,
      
        appBar: AppBar(
          shadowColor: Colors.transparent,
          // actionsPadding: EdgeInsets.only(left: 24),
          backgroundColor:
          // Colors.grey.shade400,
          Theme.of(context).colorScheme.surface ,
          actions: [
            // SizedBox(width: 24,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InnerShadow(
                shadows: [
                  Shadow(color: Theme.of(context).colorScheme.tertiary,blurRadius:4, offset: Offset(4, 4)),
                                Shadow(color: Theme.of(context).colorScheme.secondaryContainer,blurRadius: 4, offset: Offset(-4, -4))
                    
                ],
                child: Container(
                  // height: 30,
                  width: 68,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface ,
                    borderRadius: BorderRadius.circular(12),
                    
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      HugeIcon(icon: HugeIcons.strokeRoundedFire03, color: Colors.black54),
                      Text('3',style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          // padding: EdgeInsets.all(8),
          padding: const EdgeInsets.only(top: 32, bottom: 48,left: 18, right: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Welcome Back, Jake', style: TextStyle( fontSize: 32,fontWeight:FontWeight.bold),),
              // SizedBox(height: 24,),
              NeuBox(

                child: SizedBox(height: 100,width: 
                340, child: Text('"Lack of emotion causes lack of progress \n and lack of motivation \n \n \n \t\t\t\t-Tony Robbins')),
              ),
              // SizedBox(height: 250,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NeuBox(child: Text('5 min')),
                  NeuBox(child: Text('10min')),
                  NeuBox(child: Container(decoration: BoxDecoration(color: Colors.grey.shade400 ,borderRadius: BorderRadius.circular(8)),child: Text('15 min'),)),
                  NeuBox(
                    child: DropdownButton(
                          hint: const Text("Custom"),
                          items: ['30min', '45min', '60min'].map((time) => DropdownMenuItem(value: time, child: Text(time))).toList(),
                          onChanged: (value) {},
                    ),
                  )
                
                ],
              ),
              // SizedBox(height: 32,)/
              // ,
              NeuBox(
                child: SizedBox(
                  // color: Colors.grey.shade400 ,
                  
                  width: 300,
                  height: 36,
                  child: Center( child: Text("Start Meditation",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                ),
              )
            ],
          ),
        ),
      
      ),
    );
  }
}