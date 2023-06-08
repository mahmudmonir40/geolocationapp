import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GeoLocationApp',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GeoLocationApp(),
    );
  }
}


class GeoLocationApp extends StatefulWidget {
  const GeoLocationApp({Key? key}) : super(key: key);

  @override
  State<GeoLocationApp> createState() => _GeoLocationAppState();
}

class _GeoLocationAppState extends State<GeoLocationApp> {

  //first of all let's add the dependencies that we need
  //now we need to add the user permission in our android manifest file
  //now we can run our app, make sure that you run the app only after modifying the manifest file

  @override
  Widget build(BuildContext context) {
    //now let's create the logic of the app
    Position? _currentLocation;
    late bool servicePermission = false;
    late LocationPermission permission;

    String _currentAdress = "";
    Future<Position> _getCurrentLocation() async {
      //let's first of all check if we have permission to aces location service

      servicePermission = await Geolocator.isLocationServiceEnabled();
      if(!servicePermission){
        print("service disable");
      }

      //the service is enabled on major phones, but it's always okay to check it
      permission = await Geolocator.checkPermission();
      if(permission == LocationPermission.denied){
        permission = await Geolocator.requestPermission();
      }

      return await Geolocator.getCurrentPosition();
    }

    //now let's test our app
    //let's geocode the coordinate and convert them into addresses


    //let's start by creating a basic ui for our app
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,

        title: Text("Get User Location",style: TextStyle(color: Colors.white),),

        centerTitle: true,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Text("Location Coordinates",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.teal),),

            SizedBox(height: 6,),
            Text("Coordinates"),

            SizedBox(height: 30,),
            Text("Latitude = ${_currentLocation!.latitude}, Longitude = ${_currentLocation.longitude}",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.teal),),

            SizedBox(height: 6,),
            Text("${_currentAdress}"),

            SizedBox(height: 50,),
            ElevatedButton(onPressed: () async {
              //get current location here
             setState(() async {
               _currentLocation = await _getCurrentLocation();
               print("${_currentLocation}");
             });
            },

                child: Text("Get Location"),
            ),
          ],
        ),
      ),
    );
  }
}


