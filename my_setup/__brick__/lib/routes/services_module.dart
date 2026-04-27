// abstract class ModularNavigationRepository {
//   void navigateToLoginAndClearStack();
// }

// class ModularNavigationService implements ModularNavigationRepository {
//   @override
//   void navigateToLoginAndClearStack() {
//     Modular.to.pushNamedAndRemoveUntil('/auth/', (route) => false);
//   }
// }

// class ServicesModule extends {
//   @override
//   void exportedBinds(i) {
// i.addLazySingleton(DioClient.new);
//     i.addLazySingleton<IAppNavigationRepository>(
//         AppNavigationRepositoryImpl.new);

//     i.addLazySingleton<IStorageTokenRepository>(StorageTokenRepositoryImpl.new);
//     i.addSingleton<StorageTokenController>(StorageTokenController.new);

//     i.addLazySingleton<IHiveRepository>(HiveRepositoryImpl.new);
//     i.addSingleton<HiveController>(HiveController.new);
// }
// }
