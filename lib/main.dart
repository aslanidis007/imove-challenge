import 'package:flutter/material.dart';

import 'package:imove_challenge/di/service_locator.dart';
import 'package:imove_challenge/imove_challenge_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupServiceLocator();

  runApp(IMoveChallengeApp());
}
