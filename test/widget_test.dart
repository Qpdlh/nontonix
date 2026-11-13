import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nontonix/main.dart';

void main() {
  testWidgets('beranda menampilkan slider film dan dapat digeser', (
    tester,
  ) async {
    await tester.pumpWidget(const NontonixApp());

    expect(find.text('nontonix'), findsOneWidget);
    expect(find.text('Spider-Man: Into the Spider-Verse'), findsOneWidget);

    await tester.drag(find.byType(PageView), const Offset(-300, 0));
    await tester.pumpAndSettle();

    expect(
      find.text("JoJo's Bizarre Adventure: Steel Ball Run"),
      findsOneWidget,
    );
  });
}
