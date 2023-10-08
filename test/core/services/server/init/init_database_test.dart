import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mervel_app/core/services/server/init/init_database.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const String kTemporaryPath = 'temporaryPath';
const String kApplicationSupportPath = 'applicationSupportPath';
const String kDownloadsPath = 'downloadsPath';
const String kLibraryPath = 'libraryPath';
const String kApplicationDocumentsPath = 'applicationDocumentsPath';
const String kExternalCachePath = 'externalCachePath';
const String kExternalStoragePath = 'externalStoragePath';

class MockPathProviderPlatform extends Mock with MockPlatformInterfaceMixin implements PathProviderPlatform {
  @override
  Future<String> getTemporaryPath() async {
    return kTemporaryPath;
  }

  @override
  Future<String> getApplicationSupportPath() async {
    return kApplicationSupportPath;
  }

  @override
  Future<String> getLibraryPath() async {
    return kLibraryPath;
  }

  @override
  Future<String> getApplicationDocumentsPath() async {
    return kApplicationDocumentsPath;
  }

  @override
  Future<String> getExternalStoragePath() async {
    return kExternalStoragePath;
  }

  @override
  Future<List<String>> getExternalCachePaths() async {
    return <String>[kExternalCachePath];
  }

  @override
  Future<String> getDownloadsPath() async {
    return kDownloadsPath;
  }
}

void main() {
  group('PathProvider', () {
    TestWidgetsFlutterBinding.ensureInitialized();

    setUp(() async {
      PathProviderPlatform.instance = MockPathProviderPlatform();
    });

    test('getTemporaryDirectory', () async {
      Directory result = await getTemporaryDirectory();
      expect(result.path, kTemporaryPath);
    });
  });

  group('InitDatabase', () {
    TestWidgetsFlutterBinding.ensureInitialized();

    Supabase supabase = Supabase.instance;
    InitDatabase initDatabase = InitDatabase();

    setUp(() async {
      PathProviderPlatform.instance = MockPathProviderPlatform();
      await initDatabase.initSupaBase();
    });

    test('initSupaBase', () {
      expect(supabase.client, isNotNull);
      expect(supabase.client.auth, isNotNull);
      expect(supabase.client.storage, isNotNull);
      expect(supabase.client.realtime, isNotNull);
      expect(supabase.client.auth.currentUser, isNotNull);
      expect(supabase.client.auth.currentUser!.email, isNotNull);
    });
  });
}
