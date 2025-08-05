import 'package:flutter/material.dart';

import 'app.dart';
import 'core/utils/status_bar_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  StatusBarManager.setGlobalStatusBar();
  runApp(const MyApp());
}

