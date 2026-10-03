import 'package:core/core.dart';
import 'package:customer_directory/customer_directory.dart';
import 'package:visit_entry/visit_entry.dart';
import 'package:emi_page/emi_page.dart';
import 'package:calendar/calendar.dart';
import 'package:home_page/home_page.dart';
import 'package:history_page/history_page.dart';

Future<void> init() async {
  // Feature: Customer Directory
  sl.registerLazySingleton<ICustomerRemoteDataSource>(
      () => SupabaseCustomerRemoteDataSource(client: SupabaseClientProvider.client));
  sl.registerLazySingleton<ICustomerRepository>(
      () => CustomerRepository(remoteDataSource: sl()));

  // Feature: Service Entry
  sl.registerLazySingleton<IVisitEntryRemoteDataSource>(
      () => SupabaseVisitEntryRemoteDataSource(client: SupabaseClientProvider.client));
  sl.registerLazySingleton<IVisitEntryRepository>(
      () => VisitEntryRepository(remoteDataSource: sl()));
  sl.registerLazySingleton(() => SaveServiceUseCase(sl()));

  // Feature: EMI Page
  sl.registerLazySingleton<IEmiRemoteDataSource>(
      () => SupabaseEmiRemoteDataSource(client: SupabaseClientProvider.client));
  sl.registerLazySingleton<EmiRepositoryInterface>(
      () => EmiRepository(remoteDataSource: sl()));
  sl.registerLazySingleton(() => GetEmiDashboardDataUseCase(sl()));
  sl.registerLazySingleton(() => MarkEmiPaidUseCase(sl()));
  sl.registerLazySingleton(() => AddEmiPaymentUseCase(sl()));
  sl.registerLazySingleton(() => GetPaymentHistoryUseCase(sl()));

  // Feature: Home Page
  sl.registerLazySingleton<IHomeRemoteDataSource>(
      () => SupabaseHomeRemoteDataSource(client: SupabaseClientProvider.client));
  sl.registerLazySingleton<IHomeRepository>(
      () => HomeRepository(remoteDataSource: sl()));
  sl.registerLazySingleton(() => GetHomeDataUseCase(sl()));
  sl.registerFactory(() => HomeBloc(getHomeDataUseCase: sl()));

  // Feature: Calendar
  sl.registerLazySingleton<ICalendarRemoteDataSource>(
      () => SupabaseCalendarRemoteDataSource(client: SupabaseClientProvider.client));
  sl.registerLazySingleton<ICalendarRepository>(
      () => CalendarRepository(remoteDataSource: sl()));
  sl.registerLazySingleton(() => GetCalendarSchedulesUseCase(sl()));
  sl.registerLazySingleton(() => DismissScheduleUseCase(sl()));
  sl.registerFactory(() => CalendarBloc(
    getCalendarSchedulesUseCase: sl(),
    dismissScheduleUseCase: sl(),
  ));

  // Feature: History Page
  sl.registerLazySingleton<IHistoryRemoteDataSource>(
      () => SupabaseHistoryRemoteDataSource(client: SupabaseClientProvider.client));
  sl.registerLazySingleton<IHistoryRepository>(
      () => HistoryRepository(remoteDataSource: sl()));
  sl.registerLazySingleton(() => GetAllServicesUseCase(sl()));
  sl.registerFactory(() => HistoryBloc(
    getAllServicesUseCase: sl(),
  ));

  // Other features...
}
