import 'package:flutter/material.dart';

import 'common/values/envs.dart';
import 'app.dart';
import 'core/factories/factory_helper.dart';
import 'io/logging/logging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpLogging();
  await initializeFactory(Environments.DEV);
  runApp(MainApplication());
}
