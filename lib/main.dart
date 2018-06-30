import 'package:flutter/material.dart';
import 'package:dog_tutorial/model/dog.dart';
// import 'package:dog_tutorial/widget/dog_card.dart';
import 'package:dog_tutorial/pages/dog_list.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
          // primarySwatch: Colors.blue,
          brightness: Brightness.dark),
      home: new MyHomePage(title: 'Flutter Dog Tutorial'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    /// Scaffold is the base for a page.
    /// It gives an AppBar for the top,
    /// Space for the main body, bottom navigation, and more.
    return new Scaffold(
      /// App bar has a ton of functionality, but for now lets
      /// just give it a color and a title.
      appBar: new AppBar(
        /// Access this widgets properties with 'widget'
        title: new Text(widget.title),
        backgroundColor: Colors.black87,
      ),

      /// Container is a convenience widget that lets us style it's
      /// children. It doesn't take up any space itself, so it
      /// can be used as a placeholder in your code.
      body: new Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            // Add one stop for each color.
            // Stops should increase
            // from 0 to 1
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              // Colors are easy thanks to Flutter's
              // Colors class.
              Colors.indigo[800],
              Colors.indigo[700],
              Colors.indigo[600],
              Colors.indigo[400],
            ],
          ),
        ),
        child: new Center(
          child: new DogList(dogs),
        ),
      ),
    );
  }

  // Cascade notation (..)
  // Get an object, call its functions or get its property in a fluit way
  List<Dog> dogs = []
    ..add(new Dog('Rubyy', 'Portland, OR, USA',
        'Ruby is a very good girl. Yes: Fetch, loungin\'. No: Dogs who get on furniture.'))
    ..add(new Dog('Rex', 'Seattle, WA, USA', 'Best in Show 1999'))
    ..add(new Dog('Rod Stewart', 'Prague, CZ',
        'Star good boy on international snooze team.'))
    ..add(new Dog('Herbert', 'Dallas, TX, USA', 'A Very Good Boy'))
    ..add(
        new Dog('Buddy', 'North Pole, Earth', 'Self problaimed human lover.'));
}
