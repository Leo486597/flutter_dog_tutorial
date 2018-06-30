import 'package:flutter/material.dart';
import 'package:dog_tutorial/model/dog.dart';
import 'package:dog_tutorial/pages/dog_detail.dart';

class DogCard extends StatefulWidget {
  final Dog dog;

  DogCard(this.dog);

  @override
  _DogCardState createState() => _DogCardState(this.dog);
}

class _DogCardState extends State<DogCard> {
  Dog dog;
  String renderUrl;

  _DogCardState(this.dog);

  // State classes run this method when the state is created.
  // You shouldn't do async work in initState, so we'll defer it
  // to another method.
  void initState() {
    super.initState();
    renderDogPic();
  }

  @override
  Widget build(BuildContext context) {
    // InkWell is a special Material widget
    // It makes it's children tappable,
    // And adds Material Design ink response when tapped
    return new InkWell(
      onTap: showDogDetailPage,
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: new Container(
          height: 115.0,
          child: new Stack(
            children: <Widget>[
              new Positioned(right: 0.0, child: dogCard),
              new Positioned(top: 7.5, child: dogImage),
            ],
          ),
        ),
      ),
    );
  }

  showDogDetailPage() {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new DogDetailPage(dog);
      }),
    );
  }

  Widget get dogImage {
    // Wrap the entire widget in a 'Hero' widget, as a child
    var dogAvatar = new Hero(
      // Give your hero a tag
      // Basically, Flutter looks for two widgets on two
      // different pages, and if they have the same tag
      // It animates them between the two pages
      tag: dog,
      child: new Container(
        // you can explicity set heights and widths on Containers.
        // otherwise they take up as much space as their children.
        width: 100.0,
        height: 100.0,
        // decoration is a property that lets you style the container.
        // It expects a BoxDecoration
        decoration: new BoxDecoration(
          // BoxDecorations have many possible properties
          // Using BoxShape with a background image
          // is the easiest way to make a circle cropped avatar style
          // image.
          shape: BoxShape.circle,
          image: new DecorationImage(
            // Just like CSS's `imagesize` property
            fit: BoxFit.cover,
            // A NetworkImage widget is a widget that
            // takes a URL to an image.
            // ImageProviders (such as NetworkImage)
            // are ideal when your image needs to be laoded or can
            // change.
            // Use the null check to avoid an error.
            image: new NetworkImage(renderUrl ?? ''),
          ),
        ),
      ),
    );
    return dogAvatar;
  }

  Widget get dogCard {
    // A new container
    // The height and width are arbitrary numbers for styling
    return new Container(
      width: 310.0,
      height: 115.0,
      child: new Card(
        color: Colors.black87,
        // Wrap children in a Padding widget in order to give padding.
        child: new Padding(
          // The class that controls padding is called 'EdgeInsets'
          // The EdgeInsets.only constructor is used to set
          // paddings explicitly to each side of the child.
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
            left: 64.0,
          ),
          // Column is another layout widget -- like stack -- that
          // takes a list of widgets as children, and lays the
          // widgets out from top to bottom
          child: new Column(
            // these alignment properties function exactly like
            // CSS flexbox properties.
            // The main axis of a column is the vertical axis,
            // `MainAxisAlignment.spaceAround` is equivelent of
            // CSS's 'justify-content: space-around' in a vertically
            // laid out flexbox.
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Text(widget.dog.name,
                  // Themes are set inthe MaterialApp widget at the root of your app.
                  // They have default values -- which we're using because we didn't set our own.
                  // They're great for having consistent, app wide styling that's easily changable.
                  style: Theme.of(context).textTheme.headline),
              new Text(widget.dog.location,
                  style: Theme.of(context).textTheme.subhead),
              new Row(
                children: <Widget>[
                  new Icon(
                    Icons.star,
                  ),
                  new Text(': ${widget.dog.rating} / 10')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // IRL, we'd want the Dog class itself to get the image
  // but this is a simpler way to explain Flutter basics
  void renderDogPic() async {
    // this makes the service call
    await dog.getImageUrl();
    // setState tells Flutter to rerender anything that's been changed.
    // setState cannot be async, so we use a variable that can be overwritten
    setState(() {
      renderUrl = dog.imageUrl;
    });
  }
}
