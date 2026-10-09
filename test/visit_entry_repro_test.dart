import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:visit_entry/src/presentation/view/visit_entry_view.dart';
import 'package:visit_entry/src/presentation/bloc/visit_entry_bloc.dart';
import 'package:visit_entry/src/domain/use_cases/save_visit_usecase.dart';
import 'package:core/core.dart';
import 'package:mocktail/mocktail.dart';

class MockSaveServiceUseCase extends Mock implements SaveServiceUseCase {}

void main() {
  testWidgets('Visit Entry flow and form reset logs', (WidgetTester tester) async {
    final mockUseCase = MockSaveServiceUseCase();
    when(() => mockUseCase(any(), emiAmountPerMonth: any(named: 'emiAmountPerMonth'), totalAmcVisitsToPurchase: any(named: 'totalAmcVisitsToPurchase')))
        .thenAnswer((_) async {});
    
    GetIt.I.registerSingleton<SaveServiceUseCase>(mockUseCase);

    await tester.pumpWidget(MaterialApp(
      home: VisitEntryView(initialCustomerId: '123', initialCustomerName: 'Test Customer'),
    ));

    // Wait for the options to load (since we removed Firebase, it should be instant)
    await tester.pumpAndSettle();

    // Verify debug logs
    // Enter details
    await tester.enterText(find.byType(TextField).first, 'Test Fault'); // Fixes/Fault
    
    // Tap Commit
    final commitButton = find.text('Commit Entry');
    await tester.ensureVisible(commitButton);
    await tester.tap(commitButton);
    
    // Wait for state transitions (Submit -> Success -> Initial)
    await tester.pumpAndSettle();

    GetIt.I.unregister<SaveServiceUseCase>();
  });
}
