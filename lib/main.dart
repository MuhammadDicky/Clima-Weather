import 'package:flutter/material.dart';
import 'package:clima/screens/loading_screen.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:clima/screens/city_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: LoadingScreen.routeName,
      routes: {
        LoadingScreen.routeName: (context) => LoadingScreen(),
      },
      onGenerateRoute: (settings) {
        var targetRoute;

        if (settings.name == LocationScreen.routeName) {
          final LocationScreenArgs args = settings.arguments;

          targetRoute = LocationScreen(
            locationWeather: args.locationWeather,
          );
        } else if (settings.name == CityScreen.routeName) {
          // Route to set location
          // Cast the arguments to the correct type: ScreenArguments.
          final CityScreenArgs args = settings.arguments;

          // Then, extract the required data from the arguments and
          // pass the data to the correct screen.
          targetRoute = CityScreen(
            test: args.test,
          );
        }

        // Set route if exist
        if (targetRoute != null) {
          return MaterialPageRoute(
            builder: (context) {
              return targetRoute;
            },
          );
        }

        if (settings.name != '/')
          assert(false, 'Need to implement route: ${settings.name}');
        return null;
      },
    );
  }
}
