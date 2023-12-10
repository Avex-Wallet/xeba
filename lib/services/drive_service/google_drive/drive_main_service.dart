// ignore_for_file: depend_on_referenced_packages, curly_braces_in_flow_control_structures

import 'dart:convert' show utf8;
import 'dart:io' as io;

// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:path/path.dart' as path;

import 'package:avex_mobile/services/api_services/api_response.dart';
import 'google_auth_client.dart';

abstract class GoogleClient {
  Future<ApiResponse<GoogleSignInAccount?>> signInGoogle();
  Future<void> signOut();
  Future<drive.DriveApi?> getDriveApi(GoogleSignInAccount googleUser);
  Future<drive.File?> uploadDriveFile({
    required drive.DriveApi driveApi,
    required io.File file,
    String? driveFileId,
  });
  Future<String?> restoreDriveFile({
    required drive.DriveApi driveApi,
    required drive.File driveFile,
    required String targetLocalPath,
  });
  Future<drive.File?> getDriveFile(drive.DriveApi driveApi, String filename);
  Future deleteAllPreviousVersions(drive.DriveApi driveApi, String filename);
}

class GoogleDriveAppData implements GoogleClient {
  /// sign in with google
  @override
  Future<ApiResponse<GoogleSignInAccount?>> signInGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          drive.DriveApi.driveFileScope,
        ],
      );

      GoogleSignInAccount? googleUser =
          await googleSignIn.signInSilently() ?? await googleSignIn.signIn();
      return ApiResponse.success(googleUser, -1);
    } catch (e) {
      //debugprint(e.toString());
      return ApiResponse.error(e.toString(), -1);
    }
  }

  ///sign out from google
  @override
  Future<void> signOut() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  ///get google drive client
  @override
  Future<drive.DriveApi?> getDriveApi(GoogleSignInAccount googleUser) async {
    drive.DriveApi? driveApi;
    try {
      Map<String, String> headers = await googleUser.authHeaders;
      GoogleAuthClient client = GoogleAuthClient(headers);
      driveApi = drive.DriveApi(client);
    } catch (e) {
      //debugprint(e.toString());
    }
    return driveApi;
  }

  /// upload file to google drive
  @override
  Future<drive.File?> uploadDriveFile({
    required drive.DriveApi driveApi,
    required io.File file,
    String? driveFileId,
  }) async {
    try {
      //**  */
      const parentFolderName = 'com.example.avex';
      const parentFolderQuery =
          "name='$parentFolderName' and mimeType='application/vnd.google-apps.folder'";
      final parentFolderList = await driveApi.files.list(q: parentFolderQuery);

      drive.File parentFolder;
      if (parentFolderList.files != null &&
          parentFolderList.files!.isNotEmpty) {
        parentFolder = parentFolderList.files![0];
      } else {
        final folder = drive.File()
          ..name = parentFolderName
          ..mimeType = 'application/vnd.google-apps.folder';

        final parentFolderResponse = await driveApi.files.create(folder);
        parentFolder = parentFolderResponse;
      }

      // Set the parent folder ID to upload the file to the specified directory
      drive.File fileMetadata = drive.File()
        ..name = path.basename(file.absolute.path)
        ..parents = [parentFolder.id!];
      //**  */

      // drive.File fileMetadata = drive.File();
      // fileMetadata.name = path.basename(file.absolute.path);

      late drive.File response;
      if (driveFileId != null) {
        /// [driveFileId] not null means we want to update existing file
        response = await driveApi.files.update(
          fileMetadata,
          driveFileId,
          uploadMedia: drive.Media(file.openRead(), file.lengthSync()),
        );
      } else {
        /// [driveFileId] is null means we want to create new file
        fileMetadata.parents = [];
        response = await driveApi.files.create(
          fileMetadata,
          uploadMedia: drive.Media(file.openRead(), file.lengthSync()),
        );
      }
      return response;
    } catch (e) {
      //debugprint(e.toString());
      return null;
    }
  }

  /// download file from google drive
  @override
  Future<String?> restoreDriveFile({
    required drive.DriveApi driveApi,
    required drive.File driveFile,
    required String targetLocalPath,
  }) async {
    try {
      drive.Media media = await driveApi.files.get(driveFile.id!,
          downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;

      List<int> dataStore = [];

      await media.stream.forEach((element) {
        dataStore.addAll(element);
      });
      // //debugprint(dataStore.)
      var decoded = utf8.decode(dataStore);
      return decoded;
    } catch (e) {
      //debugprint(e.toString());
      return null;
    }
  }

  /// get drive file info
  @override
  Future<drive.File?> getDriveFile(
      drive.DriveApi driveApi, String filename) async {
    try {
      drive.FileList fileList = await driveApi.files
          .list(spaces: 'drive', $fields: 'files(id, name, modifiedTime)');
      List<drive.File>? files = fileList.files;
      drive.File? driveFile =
          files?.firstWhere((element) => element.name == filename);
      return driveFile;
    } catch (e) {
      //debugprint(e.toString());
      return null;
    }
  }

  /// get drive file info
  @override
  Future deleteAllPreviousVersions(
      drive.DriveApi driveApi, String filename) async {
    try {
      drive.FileList fileList = await driveApi.files
          .list(spaces: 'drive', $fields: 'files(id, name, modifiedTime)');
      List<drive.File>? files = fileList.files;
      if (files != null)
        for (var file in files) {
          if (file.name == filename) {
            await driveApi.files.delete(file.id!);
          }
        }
    } catch (e) {
      //debugprint(e.toString());
      return null;
    }
  }
}
