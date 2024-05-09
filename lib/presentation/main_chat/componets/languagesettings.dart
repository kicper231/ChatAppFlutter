import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            const Divider(),
            ListTile(
              onTap: () => context.setLocale(const Locale('pl', 'PL')),
              title: Text('Polish'.tr()),
              leading: const Icon(Icons.language),
            ),
            const Divider(),
            ListTile(
              onTap: () => context.setLocale(const Locale('en', 'US')),
              title: Text('English'.tr()),
              leading: const Icon(Icons.language),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
