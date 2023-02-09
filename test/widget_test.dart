import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:planney/ui/components/home/avatar.dart';

void main() {
  const avatar = Avatar(
    userName: 'Rafael Morais',
    userBalance: 200,
    path: '',
  );

  testWidgets(
    'Test Avatar',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: Material(child: avatar),
        ),
      );
      expect(find.textContaining('Rafael', findRichText: true), findsOneWidget);
      expect(find.textContaining('200,00'), findsOneWidget);
      expect(find.text('Morais'), findsNothing);
    },
  );
}
