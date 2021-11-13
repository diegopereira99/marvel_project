import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_test/modules/character/widgets/button_sheet_item.dart';

import '../../../helpers/make_testable_widget.dart';

void main() {
  testWidgets('Should display the button sheet with the expected behavior',
      (WidgetTester tester) async {
    bool isClicked = false;
    final widget = ButtonSheetItem(
      title: 'Titulo',
      onTap: () {
        isClicked = true;
      },
    );
    await tester.pumpWidget(makeTestableWidget(widget));

    final tile = find.text('Titulo');

    expect(tile, findsOneWidget);

    await tester.tap(tile);

    expect(isClicked, equals(true));
  });
}
