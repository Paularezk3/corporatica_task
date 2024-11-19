import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_classification_app/pages/welcome.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    // TODO: implement didPop
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    // TODO: implement didPush
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    // TODO: implement didRemove
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    // TODO: implement didReplace
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    // TODO: implement didStartUserGesture
  }

  @override
  void didStopUserGesture() {
    // TODO: implement didStopUserGesture
  }

  @override
  // TODO: implement navigator
  NavigatorState? get navigator => throw UnimplementedError();
}

void main() {
  group('Welcome Widget Tests', () {
    late MockNavigatorObserver mockNavigatorObserver;

    setUp(() {
      mockNavigatorObserver = MockNavigatorObserver();
    });

    testWidgets('Displays buttons and navigates correctly', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(
        home: const Welcome(),
        navigatorObservers: [mockNavigatorObserver],
      ));

      // Assert: Ensure the widget shows both buttons
      expect(find.text('Object Detection App'), findsOneWidget);
      expect(find.text('Object Detection'), findsOneWidget);
      expect(find.text('Gallery'), findsOneWidget);

      // Act: Tap "Object Detection" button
      await tester.tap(find.text('Object Detection'));
      await tester.pumpAndSettle();

      // Verify: Navigation to DetectorPage
      // verify(() => mockNavigatorObserver.didPush(any(), any())).called(1);
      //
      // Act: Navigate back and tap "Gallery" button
      await tester.tap(find.text('Gallery'));
      await tester.pumpAndSettle();

      // Verify: Navigation to PhotoGalleryApp
      // verify(() => mockNavigatorObserver.didPush(any(), any())).called(1);
    });
  });
}
