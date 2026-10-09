import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:customer_directory/src/presentation/view/new_client_profile_view.dart';
import 'package:customer_directory/src/presentation/bloc/new_customer_bloc.dart';
import 'package:customer_directory/src/domain/repositories/customer_repository_interface.dart';
import 'package:customer_directory/src/domain/entities/customer.dart';
import 'package:core/core.dart';
import 'package:mocktail/mocktail.dart';

class MockCustomerRepository extends Mock implements ICustomerRepository {}

void main() {
  testWidgets('New Client Profile optional fields and defaults', (WidgetTester tester) async {
    final mockRepo = MockCustomerRepository();
    when(() => mockRepo.checkCustomerExistsByPhone(any())).thenAnswer((_) async => false);
    when(() => mockRepo.createCustomer(any())).thenAnswer((_) async => 'doc_123');
    
    GetIt.I.registerSingleton<ICustomerRepository>(mockRepo);

    await tester.pumpWidget(MaterialApp(
      home: NewClientProfileView(),
    ));

    // Case 1: Fully empty form + Save
    final saveButton = find.text('Save Client Profile');
    await tester.ensureVisible(saveButton);
    await tester.tap(saveButton);
    await tester.pumpAndSettle();
    
    expect(find.text('Enter at least one detail to save'), findsOneWidget);
    verifyNever(() => mockRepo.createCustomer(any()));

    // Wait for snackbar to disappear
    await tester.pump(Duration(seconds: 4));

    // Case 2: Only one field filled (phone)
    final textFields = find.byType(TextField);
    // index 1 is Phone in NewClientFormCard
    await tester.enterText(textFields.at(1), '9999999999');
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    // Verify it saved with defaults
    final captured = verify(() => mockRepo.createCustomer(captureAny())).captured;
    final customer = captured.first as Customer;
    expect(customer.name, 'Unknown');
    expect(customer.number, '9999999999');
    expect(customer.address, 'Not provided');
    expect(customer.locality, 'Not provided');
    expect(customer.note, 'Not provided');
    expect(customer.roType, 'Not provided');

    GetIt.I.unregister<ICustomerRepository>();
  });
}
