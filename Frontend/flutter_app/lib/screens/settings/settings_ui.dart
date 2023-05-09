import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/database_version.dart';
import 'package:flutter_app/network/helper/download_data_helper.dart';
import 'package:flutter_app/network/response/response.dart';
import 'package:flutter_app/utils/hive_helper.dart';
import 'package:flutter_app/utils/shared_prefs_helper.dart';

class SettingsUi extends StatefulWidget {
  const SettingsUi({super.key});

  @override
  State<SettingsUi> createState() => _SettingsUiState();
}

class _SettingsUiState extends State<SettingsUi> {
  bool checkingForUpdate = false;
  bool updatesAvailable = false;

  String buttonText = 'Check for updates';

  checkForUpdates() async {
    setState(() {
      checkingForUpdate = true;
      buttonText = 'Loading...';
    });

    Response response = await DownloadDataHelper.downloadDatabaseVersion();

    if (response.success) {
      DatabaseVersion databaseVersion = response.obj as DatabaseVersion;
      double availableDbVersion = double.parse(
        databaseVersion.databaseVersion ?? '0',
      );
      double currentDbVersion = double.parse(
        HiveHelper.getDatabaseVersion().databaseVersion ?? '1000',
      );

      if (currentDbVersion >= availableDbVersion) {
        setState(() {
          buttonText = 'You have the latest version! :)';
        });
      } else {
        setState(() {
          checkingForUpdate = false;
          updatesAvailable = true;
          buttonText = 'Download updates!';
        });
      }
    } else {
      setState(() {
        checkingForUpdate = false;
        buttonText = 'Check failed. Retry!';
      });
    }
  }

  downloadUpdates() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Ready to update?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'The app will restart and download the necessary data',
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: const Text('OK'),
                      onPressed: () {
                        SharedPrefsHelper.instance
                            .setIsDataDownloaded(false)
                            .then((value) {
                          Navigator.of(context).popUntil((route) => false);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyApp(),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        children: [
          const Text(
            'Update',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Check for updates including new cards, archetypes and much more!',
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: checkingForUpdate
                ? null
                : () {
                    if (updatesAvailable) {
                      downloadUpdates();
                    } else {
                      checkForUpdates();
                    }
                  },
            child: Text(buttonText),
          ),
          const SizedBox(height: 16),
          const Divider(thickness: 2),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
