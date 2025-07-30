part of 'main.dart';

void paymentRequest() {
  final shouldSkip = kIsWeb
      ? true
      : ![TargetPlatform.android].contains(defaultTargetPlatform);

  skippableTestWidgets('enablePaymentRequest', (WidgetTester tester) async {
    final completer = Completer<InAppWebViewController>();
    bool? result;

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: InAppWebView(
          key: GlobalKey(),
          onWebViewCreated: (controller) async {
            completer.complete(controller);
            result = await controller.enablePaymentRequest();
          },
        ),
      ),
    );

    await completer.future;
    expect(result, isTrue);
  }, skip: shouldSkip);
}
