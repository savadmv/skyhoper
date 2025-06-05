import 'package:flutter/material.dart';
import 'package:sky_hopper_fun_widget/widgets/game_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  MyPlaceholderWidget(),
    );
  }
}

class MyPlaceholderWidget extends StatefulWidget {
  @override
  _MyPlaceholderWidgetState createState() => _MyPlaceholderWidgetState();
}

class _MyPlaceholderWidgetState extends State<MyPlaceholderWidget> {
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    // Simulate a network call
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          // _hasError = true; // Uncomment to simulate an error
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Loading awesome stuff...", style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),
          SizedBox(
            height: 300, // Give the game some space
            width: double.infinity, // Or a fixed width
            child: GameView(), // <-- HERE'S THE MAGIC!
          ),
        ],
      );
    }

    if (_hasError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Oops! Something went wrong.", style: TextStyle(fontSize: 20, color: Colors.red)),
          SizedBox(height: 20),
          Text("Why not play a game while we try to fix it?", textAlign: TextAlign.center),
          SizedBox(
            height: 300,
            width: double.infinity,
            child: GameView(), // <-- EVEN ERRORS CAN BE FUN!
          ),
        ],
      );
    }

    return Center(child: Text("Welcome to the App!", style: TextStyle(fontSize: 24)));
  }
}
