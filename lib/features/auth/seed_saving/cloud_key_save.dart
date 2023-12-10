// ignore_for_file: use_build_context_synchronously, implementation_imports, depend_on_referenced_packages, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'dart:async';
import 'dart:io';
import 'package:avex_mobile/features/auth/seed_saving/seed_saving_state_notifier.dart';
import 'package:dio/dio.dart';
import 'package:dropbox_client/dropbox_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:bip32_ed25519/src/bip32_ed25519/ed25519_extended.dart';

void showCloudKeyBackup({
  required BuildContext context,
  required String driveKey,
  required ExtendedSigningKey edwardsKey,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Consumer(builder: (context, ref, child) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      avatar: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 20),
                      label: Text(
                        'Backup Cloud Key',
                        style: inter.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white.withOpacity(0.9),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        ref
                            .read(seedSavingStateNotifierProvider.notifier)
                            .driveFunction(driveKey, edwardsKey); //
                        Navigator.pop(context);
                      },
                      icon: Image.asset(
                        'assets/icons/google-drive.png',
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  DriveWidget(driveKey: driveKey),
                ],
              ),
            ],
          ),
        );
      });
    },
  );
}

class DriveWidget extends StatefulWidget {
  const DriveWidget({super.key, this.flag = true, required this.driveKey});
  final bool flag;
  final String driveKey;

  @override
  State<DriveWidget> createState() => _DriveWidgetState();
}

class _DriveWidgetState extends State<DriveWidget> {
  String? accessToken;
  String? credentials;
  bool showInstruction = false;

  @override
  void initState() {
    super.initState();

    initDropbox();
  }

  Future initDropbox() async {
    if (Env.dropboxKey == 'dropbox_key') {
      showInstruction = true;
      return;
    }

    await Dropbox.init(Env.dropboxClientId, Env.dropboxKey, Env.dropboxSecret);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('dropboxAccessToken');
    credentials = prefs.getString('dropboxCredentials');

    setState(() {});
  }

  Future<bool> checkAuthorized(bool authorize) async {
    final _credentials = await Dropbox.getCredentials();
    if (_credentials != null) {
      if (credentials == null || _credentials.isEmpty) {
        credentials = _credentials;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('dropboxCredentials', credentials!);
      }
      return true;
    }

    final token = await Dropbox.getAccessToken();
    if (token != null) {
      if (accessToken == null || accessToken!.isEmpty) {
        accessToken = token;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('dropboxAccessToken', accessToken!);
      }
      return true;
    }

    if (authorize) {
      if (credentials != null && credentials!.isNotEmpty) {
        await Dropbox.authorizeWithCredentials(credentials!);
        final _credentials = await Dropbox.getCredentials();
        if (_credentials != null) {
          return true;
        }
      }
      if (accessToken != null && accessToken!.isNotEmpty) {
        await Dropbox.authorizeWithAccessToken(accessToken!);
        final token = await Dropbox.getAccessToken();
        if (token != null) {
          return true;
        }
      } else {
        await Dropbox.authorize();
      }
    }
    return false;
  }

  Future authorize() async {
    await Dropbox.authorize();
  }

  Future authorizePKCE() async {
    await Dropbox.authorizePKCE();
  }

  Future unlinkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('dropboxAccessToken');

    setState(() {
      accessToken = null;
    });
    await Dropbox.unlink();
  }

  Future unlinkCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('dropboxCredentials');

    setState(() {
      credentials = null;
    });
    await Dropbox.unlink();
  }

  Future authorizeWithAccessToken() async {
    await Dropbox.authorizeWithAccessToken(accessToken!);
  }

  Future authorizeWithCredentials() async {
    await Dropbox.authorizeWithCredentials(credentials!);
  }

  Future getAccountName() async {
    if (await checkAuthorized(true)) {
      final user = await Dropbox.getAccountName();
    }
  }

  Future listFolder(path) async {
    if (await checkAuthorized(true)) {
      final result = await Dropbox.listFolder(path);
      logger.t('result $result');
      final url = await Dropbox.getTemporaryLink('/AvexWalletBackupSecret');
      final res = await Dio().get(url ?? '');
      logger.t(res.data);
      setState(() {
        list.clear();
        list.addAll(result);
      });
    }
  }

  Future uploadTest() async {
    if (await checkAuthorized(true)) {
      var tempDir = await getTemporaryDirectory();
      var filepath = '${tempDir.path}/dropbox_file.txt';
      File(filepath).writeAsStringSync(
          'contents.. from ${Platform.isIOS ? 'iOS' : 'Android'}\n');

      final result = await Dropbox.upload(
          filepath, '/test_upload.txt', (uploaded, total) {});
    }
  }

  Future downloadTest() async {
    if (await checkAuthorized(true)) {
      var tempDir = await getTemporaryDirectory();
      var filepath = '${tempDir.path}/dropbox_file.txt'; // for iOS only!!

      final result = await Dropbox.download(
          '/dropbox_file.txt', filepath, (downloaded, total) {});
      {
        final File file =
            File('/data/user/0/com.example.gtx123/cache/dropbox_file.txt');
        final text = await file.readAsString();
        logger.d(text);
      }
    }
  }

  Future<String?> getTemporaryLink(path) async {
    final result = await Dropbox.getTemporaryLink(path);
    return result;
  }

  final list = List<dynamic>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return widget.flag
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white.withOpacity(0.9),
            ),
            child: Consumer(builder: (context, ref, child) {
              return IconButton(
                onPressed: () async {
                  // await authorize();
                  try {
                    if (await checkAuthorized(true)) {
                      var tempDir = await getTemporaryDirectory();
                      var filepath = '${tempDir.path}/AvexWalletBackupSecret';
                      File(filepath).writeAsStringSync(widget.driveKey);

                      final result = await Dropbox.upload(filepath,
                          '/AvexWalletBackupSecret', (uploaded, total) {});
                      // //print(result);

                      // Verify
                      final url = await Dropbox.getTemporaryLink(
                          '/AvexWalletBackupSecret');
                      final res = await Dio().get(url ?? '');
                      if (res.data == widget.driveKey) {
                        ref
                                .read(seedSavingStateNotifierProvider.notifier)
                                .state =
                            ref.read(seedSavingStateNotifierProvider).copyWith(
                                  status: SeedSavingStateNotifierStatus.initial,
                                  driveUploadLoading: false,
                                  driveUploadSuccessful: true,
                                );
                      }
                      Navigator.pop(context);
                    } else {
                      await authorize();
                    }
                  } catch (e) {
                    await authorize();
                    logger.e(e);
                  }
                },
                icon: Image.asset(
                  'assets/icons/dropbox.png',
                  height: 40,
                  width: 40,
                ),
              );
            }),
          )
        : SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Wrap(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: authorize,
                      child: const Text('authorize'),
                    ),
                    ElevatedButton(
                      onPressed:
                          accessToken == null ? null : authorizeWithAccessToken,
                      child: const Text('authorizeWithAccessToken'),
                    ),
                    ElevatedButton(
                      onPressed: unlinkToken,
                      child: const Text('unlink'),
                    ),
                  ],
                ),
                Wrap(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: authorizePKCE,
                      child: const Text('authorizePKCE'),
                    ),
                    ElevatedButton(
                      onPressed:
                          credentials == null ? null : authorizeWithCredentials,
                      child: const Text('authorizeWithCredentials'),
                    ),
                    ElevatedButton(
                      onPressed: unlinkCredentials,
                      child: const Text('unlink'),
                    ),
                    ElevatedButton(
                      onPressed: getAccountName,
                      child: const Text('getAccoutName'),
                    ),
                    ElevatedButton(
                      onPressed: () async {},
                      child: const Text('Logout'),
                    ),
                  ],
                ),
                Wrap(
                  children: <Widget>[
                    ElevatedButton(
                      child: const Text('list root folder'),
                      onPressed: () async {
                        await listFolder('');
                      },
                    ),
                    ElevatedButton(
                      child: const Text('test upload'),
                      onPressed: () async {
                        await uploadTest();
                      },
                    ),
                    ElevatedButton(
                      child: const Text('test download'),
                      onPressed: () async {
                        await downloadTest();
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final item = list[index];
                      final filesize = item['filesize'];
                      final path = item['pathLower'];
                      bool isFile = false;
                      var name = item['name'];
                      if (filesize == null) {
                        name += '/';
                      } else {
                        isFile = true;
                      }
                      return ListTile(
                          title: Text(name),
                          onTap: () async {
                            if (isFile) {
                              final link = await getTemporaryLink(path);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(link ??
                                          'getTemporaryLink error: $path')));
                            } else {
                              await listFolder(path);
                            }
                          });
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
