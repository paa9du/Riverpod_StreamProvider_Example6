import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_6_stream_provider/counter.dart';
import 'package:riverpod_6_stream_provider/home.dart';
import 'package:riverpod_6_stream_provider/user.dart';

//streamProvider
// final streamProvider = StreamProvider<int>((ref) {
//   return Stream.periodic(
//     Duration(seconds: 2),
//     (computationCount) => computationCount,
//   );
// });

//family Modifier
// final nameProvider = Provider<String>((ref) {
//   return "pavan";
// });
//single parameter
// final nameProvider = Provider.family<String, String>((ref, name) {
//   return "Hello $name";
// });
//multiple
final nameProvider = Provider.family<String, User>((ref, User) {
  return "Hello ${User.name} and Address :  ${User.address}";
});

//Theme Change
final themeProvider = StateProvider<bool>((ref) => true);

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightTheme = ref.watch(themeProvider);
    return MaterialApp
        // .router
        (
      title: 'Flutter Demo',
      theme: isLightTheme ? ThemeData.light() : ThemeData.dark(),
      // home: const MyHomePage(),
      //  routerConfig: _router,
      home: MyHomePage(),
      //Main(),
    );
  }
}

// class MyHomePage extends ConsumerWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final streamData = ref.watch(streamProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Stream Provider'),
//       ),
//       body: streamData.when(
//         data: ((data) => Center(
//               child: Text(
//                 data.toString(),
//                 style: TextStyle(fontSize: 25),
//               ),
//             )),
//         error: ((error, stackTrace) => Text(error.toString())),
//         loading: () => Center(
//           child: CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }
// }

// // /AutoDispose Modifier with Timeout Based Caching Strategy
// final GoRouter _router = GoRouter(routes: [
//   GoRoute(
//     path: "/",
//     builder: (context, state) => Home(),
//   ),
//   GoRoute(
//     path: "/counter",
//     builder: (context, state) => Counter(),
//   )
// ]);

// //FamilyModifier
// class Main extends ConsumerStatefulWidget {
//   const Main({super.key});

//   @override
//   ConsumerState<Main> createState() => _MainState();
// }

// class _MainState extends ConsumerState<Main> {
//   @override
//   Widget build(BuildContext context) {
//     final name = ref.watch(nameProvider(User("pavan", "Bnglr")));
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Family Modifier"),
//       ),
//       body: Center(
//         child: Text(name),
//       ),
//     );
//   }
// }

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightTheme = ref.watch(themeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Theme"),
      ),
      body: Center(
        child: Switch(
            value: isLightTheme,
            onChanged: (value) =>
                ref.read(themeProvider.notifier).state = value),
      ),
    );
  }
}
