import 'package:flutter/material.dart';

class NueButtons extends StatelessWidget {
  final Widget? child;
  final bool isSelected;
  final VoidCallback onTap;

  const NueButtons({super.key, required this.child,
   required this.isSelected
   ,required this.onTap
   });


  @override
  Widget build(BuildContext context) {
    // bool? isSelected=false;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: 60,
        margin: EdgeInsets.only(right: 18),
        decoration: BoxDecoration(
          
          borderRadius: BorderRadius.circular(24),
          color: 
          // Colors.grey.shade400,
          Theme.of(context).colorScheme.surface,
           boxShadow:isSelected?[
            BoxShadow(
              color:
               isSelected? Theme.of(context).colorScheme.tertiary : Colors.transparent,
              // Theme.of(context).colorScheme.tertiary,
              
              offset: const Offset(5, 5),
              blurRadius: 8,
            ),
            BoxShadow(
              color: Theme.of(context).colorScheme.secondaryContainer,
              offset: const Offset(-5, -5),
              blurRadius: 8,
            ),
          ]:[],
        ),
        padding: const EdgeInsets.all(18),
        child: Center(child: child),
      ),
    );
  }
}
