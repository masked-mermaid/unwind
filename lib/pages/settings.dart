// import 'package:flutter/material.dart';
// import 'package:unwind/custom_widgets/nue_box.dart';


// class Settings extends StatelessWidget {
//   const Settings({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
//           NeuBox(child: ListTile(
// leading: Text("Theme"),
// trailing: ,
//           ))
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unwind/theme/theme_provider.dart';
// Import your theme provider file

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. WATCH the theme provider to get the current mode status
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Toggle between light and dark themes'),
            
            // 2. Control the Switch state
            //    This reads the status from the provider: true if dark, false if light.
            value: themeProvider.isDarkMode,
            
            // 3. Handle the switch change
            onChanged: (bool newValue) {
              // Use READ to call the method to change the theme.
              // We don't use the 'newValue' here; we just call the toggle function.
              context.read<ThemeProvider>().toggleTheme();
            },
            secondary: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
          ),
          // ... other settings items
        ],
      ),
    );
  }
}