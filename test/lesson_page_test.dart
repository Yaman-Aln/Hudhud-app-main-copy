// test/lesson_page_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hudhud_quran_app_new/screens/lesson_screen.dart';

void main() {
  testWidgets('LessonPage displays lesson content', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LessonPage(lessonId: 'alfatiha'),
      ),
    );

    // Wait for the lesson to load
    await tester.pumpAndSettle();

    expect(find.text('Al-Fatiha'), findsOneWidget);
    expect(find.byType(Text), findsWidgets);
  });

  testWidgets('Listen/Stop button toggles playback', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LessonPage(lessonId: 'alfatiha'),
      ),
    );

    // Wait for the lesson to load
    await tester.pumpAndSettle();

    // Initial state should show 'Listen'
    expect(find.text('Listen'), findsOneWidget);

    // Tap the Listen button
    await tester.tap(find.text('Listen'));
    await tester.pump();

    // After tapping, it should show 'Stop'
    expect(find.text('Stop'), findsOneWidget);
  });

  testWidgets('Record button shows placeholder message', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LessonPage(lessonId: 'alfatiha'),
      ),
    );

    // Wait for the lesson to load
    await tester.pumpAndSettle();

    // Tap the Record button
    await tester.tap(find.text('Record'));
    await tester.pump();

    // Verify that a SnackBar is shown
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Recording feature coming soon.'), findsOneWidget);
  });
}
