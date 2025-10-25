import 'package:tutorial/core/env/env.dart';
import 'package:tutorial/core/localstorage/local_storage.dart';
import 'package:tutorial/core/localstorage/local_storage_secure.dart';
import 'package:tutorial/core/network/http_client.dart';
import 'package:tutorial/core/network/service/network_service.dart';
import 'package:tutorial/core/utils/app_event/app_event_broadcaster.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

class MainModule {
  const MainModule._();

  static Future<void> init() async {
    await dotenv.load(fileName: ".env");

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // network
    GetIt.instance.registerSingleton(
      NetworkService(dioClient: Dio()..init(Env.baseUrl)),
    );

    // local storage
    GetIt.instance.registerSingleton<LocalStorage>(
      LocalStorageSecure()..init(),
    );

    // app event
    GetIt.instance.registerSingleton(AppEventBroadcaster());
  }
}
