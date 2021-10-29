import 'package:flutter/material.dart';
import 'package:mobile_tracker/datamodels/user_location.dart';
import 'package:mobile_tracker/services/location_service.dart';
import 'package:mobile_tracker/views/home_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    UserLocation initialLocation = LocationService().getLocation() as UserLocation;
    return FutureProvider<UserLocation>(
      initialData: initialLocation,
      create: (context) => LocationService().getLocation(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Scaffold(
            body: HomeView(),
          )),
    );
  }
}