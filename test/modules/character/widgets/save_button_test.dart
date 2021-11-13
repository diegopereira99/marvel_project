import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_test/modules/character/widgets/button_sheet_item.dart';
import 'package:marvel_test/modules/character/widgets/save_button.dart';

import '../../../helpers/make_testable_widget.dart';

void main() {
  testWidgets('Should display the button with the expected behavior',
      (WidgetTester tester) async {
    bool isClicked = false;
    final widget = SaveButton(
      text: 'Titulo',
      onPressed: () {
        isClicked = true;
      },
    );
    await tester.pumpWidget(makeTestableWidget(widget));

    final button = find.text('Titulo');

    expect(button, findsOneWidget);

    await tester.tap(button);

    expect(isClicked, equals(true));
  });
}
