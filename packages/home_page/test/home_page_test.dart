import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core_ui/core_ui.dart';
import 'package:home_page/src/domain/entities/home_data.dart';
import 'package:home_page/src/domain/use_cases/get_home_data_usecase.dart';
import 'package:home_page/src/presentation/bloc/home_bloc.dart';
import 'package:home_page/src/presentation/bloc/home_event.dart';
import 'package:home_page/src/presentation/bloc/home_state.dart';
import 'package:home_page/src/presentation/view/home_page_view.dart';
import 'package:home_page/src/presentation/widgets/new_sells_summary_card.dart';

// Mocks
class MockGetHomeDataUseCase extends Mock implements GetHomeDataUseCase {}

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

void main() {
  group('Home Page Tests', () {
    late MockGetHomeDataUseCase mockGetHomeDataUseCase;
    
    final dummyData = const HomeData(
      newSells: 10,
      activeRentals: 20,
      activeAmcs: 30,
      resolutionRatePercent: 90,
      pendingComplaintsCount: 2,
      todaySchedules: [],
      pendingComplaints: [],
      amcProgresses: [],
      todaySellsSummary: 5,
      weekSellsSummary: 15,
      projectedGrowth: '+10%',
    );

    setUp(() {
      mockGetHomeDataUseCase = MockGetHomeDataUseCase();
    });

    group('HomeBloc Logic', () {
      test('initial state is HomeState.initial', () {
        expect(
          HomeBloc(getHomeDataUseCase: mockGetHomeDataUseCase).state,
          const HomeState.initial(),
        );
      });

      blocTest<HomeBloc, HomeState>(
        'emits [loading, loaded] when LoadHomeData is added and usecase succeeds',
        build: () {
          when(() => mockGetHomeDataUseCase.call())
              .thenAnswer((_) => Stream.value(dummyData));
          return HomeBloc(getHomeDataUseCase: mockGetHomeDataUseCase);
        },
        act: (bloc) => bloc.add(const HomeEvent.loadHomeData()),
        expect: () => [
          const HomeState.loading(),
          HomeState.loaded(data: dummyData),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'emits [loading, error] when LoadHomeData is added and usecase fails',
        build: () {
          when(() => mockGetHomeDataUseCase.call())
              .thenAnswer((_) => Stream.error('Error fetching data'));
          return HomeBloc(getHomeDataUseCase: mockGetHomeDataUseCase);
        },
        act: (bloc) => bloc.add(const HomeEvent.loadHomeData()),
        expect: () => [
          const HomeState.loading(),
          const HomeState.error(message: 'Error fetching data'),
        ],
      );
    });

    group('HomePageView UI Tests', () {
      late MockHomeBloc mockHomeBloc;

      setUp(() {
        mockHomeBloc = MockHomeBloc();
      });

      Widget createWidgetUnderTest() {
        return MaterialApp(
          home: HomePageView(bloc: mockHomeBloc),
        );
      }

      testWidgets('shows loading indicator when state is loading', (tester) async {
        when(() => mockHomeBloc.state).thenReturn(const HomeState.loading());

        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('shows error text when state is error', (tester) async {
        when(() => mockHomeBloc.state).thenReturn(const HomeState.error(message: 'Failed to load'));

        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.text('Error: Failed to load'), findsOneWidget);
      });

      testWidgets('renders UI components correctly when state is loaded', (tester) async {
        when(() => mockHomeBloc.state).thenReturn(HomeState.loaded(data: dummyData));

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Verify some components are rendered
        expect(find.byType(SummaryCard), findsNWidgets(4));
        expect(find.byType(NewSellsSummaryCard), findsOneWidget);
        expect(find.text('10 New Sells'), findsOneWidget); // From dummy data
        expect(find.text('90% Resolved'), findsOneWidget);
      });
    });

    group('Model Serialization Tests', () {
      test('HomeData toMap and fromMap matches', () {
        final data = const HomeData(
          newSells: 12,
          activeRentals: 45,
          activeAmcs: 99,
          resolutionRatePercent: 88,
          pendingComplaintsCount: 3,
          todaySchedules: [
            ScheduleItem(title: 'T1', subtitle: 'S1', time: '10:00 AM', isUrgent: true),
          ],
          pendingComplaints: [
            ComplaintItem(customerName: 'C1', customerId: 'ID1', issueType: 'I1', status: 'urgent'),
          ],
          amcProgresses: [
            AmcProgress(companyName: 'Co1', progress: 0.5, statusText: 'ST1', isUrgent: false),
          ],
          todaySellsSummary: 3,
          weekSellsSummary: 10,
          projectedGrowth: '+5%',
        );

        final map = data.toMap();
        final reconstructed = HomeData.fromMap(map);

        expect(reconstructed, equals(data));
      });
    });
  });
}
