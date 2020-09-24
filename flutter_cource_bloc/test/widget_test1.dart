import 'package:flutter/material.dart';
import 'package:flutter_cource_authorization/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AuthScreen test1', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    var login = find.byKey(Key('login'));
    var pass = find.byKey((Key('password')));
    expect(login, findsOneWidget);
    expect(pass, findsOneWidget);
  });

  testWidgets('AuthScreen test2', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    var loginCont = find.byKey(Key('loginCont'));
    var button = find.byKey(Key('enter'));

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pump();
    var t = (tester.firstWidget(loginCont) as Container).decoration
        as BoxDecoration;
    expect(t.color, Colors.red);
  });
}
