

// class AuthGuard extends RouteGuard {
//   AuthGuard() : super(redirectTo: "/auth/");

//   @override
//   FutureOr<bool> canActivate(String path, ParallelRoute route) async {
//     final storage = Modular.get<IStorageTokenRepository>();
//     final token = await storage.getIdToken();
//     debugPrint(
//       'AuthGuard: Mengecek token. Hasil: ${token != null && token.isNotEmpty}',
//     );
//     return token != null && token.isNotEmpty;
//   }
// }
