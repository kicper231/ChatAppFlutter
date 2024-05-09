import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              onTap: () => context.setLocale(Locale('en', 'US')),
              title: Text('english'.tr()),
              leading: Icon(Icons.language),
            ),
            Divider(),
            ListTile(
              onTap: () => context.setLocale(Locale('de', 'DE')),
              title: Text('german'.tr()),
              leading: Icon(Icons.language),
            ),
            Divider(),
            ListTile(
              title: Text(
                  'current_locale'.tr(args: [context.locale.languageCode])),
            ),
          ],
        ),
      ),
    );
  }
}
