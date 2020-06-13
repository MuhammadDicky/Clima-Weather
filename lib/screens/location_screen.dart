import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({
    this.locationWeather,
  });

  final locationWeather;
  static const String routeName = '/locationScreen';

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();

  int temperature;
  String condition;
  String cityName;
  String weatherMessage;
  String iconWeatherCondition;
  bool getCurrentLocationWeatherStatus = false;
  bool getCityWeatherStatus = false;

  SpinKitCircle loadWeatherButtonIndicator = SpinKitCircle(
    size: 40.0,
    color: Colors.white,
  );

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        cityName = '';
        iconWeatherCondition = null;
        weatherMessage = 'Unable to get weather data';

        // Function end here
        return;
      }

      temperature = weatherData['main']['temp'].toInt();
      condition = weatherModel.getWeatherIcon(weatherData['weather'][0]['id']);
      cityName = weatherData['name'];
      iconWeatherCondition = weatherData['weather'][0]['icon'];
      weatherMessage = weatherModel.getMessage(temperature);
    });

    print(weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: getCurrentLocationWeatherStatus
                        ? null
                        : () async {
                            // Set get current location weather status true
                            setState(() {
                              getCurrentLocationWeatherStatus = true;
                            });

                            // Get new current location weather data
                            updateUI(
                                await weatherModel.getCurrentLocationWeather());

                            // Set get current location weather status false
                            setState(() {
                              getCurrentLocationWeatherStatus = false;
                            });
                          },
                    child: getCurrentLocationWeatherStatus
                        ? loadWeatherButtonIndicator
                        : Icon(
                            Icons.near_me,
                            size: 50.0,
                          ),
                  ),
                  FlatButton(
                    onPressed: getCityWeatherStatus
                        ? null
                        : () async {
                            var cityName = await Navigator.pushNamed(
                              context,
                              CityScreen.routeName,
                              arguments: CityScreenArgs(test: 'test'),
                            );

                            if (cityName is String &&
                                cityName != null &&
                                cityName.isNotEmpty) {
                              // Disable button to prevent open city screen
                              setState(() {
                                getCityWeatherStatus = true;
                              });

                              // Get the weather data by city name
                              var weatherData =
                                  await weatherModel.getCityWeather(cityName);

                              // Update UI
                              updateUI(weatherData);

                              // Enable button back
                              setState(() {
                                getCityWeatherStatus = false;
                              });
                            }
                          },
                    child: getCityWeatherStatus
                        ? loadWeatherButtonIndicator
                        : Icon(
                            Icons.location_city,
                            size: 50.0,
                          ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    iconWeatherCondition != null
                        ? Image.network(
                            'http://openweathermap.org/img/wn/$iconWeatherCondition@2x.png',
                            loadingBuilder: (context, child, loadingProgress) {
                              // Return image
                              if (loadingProgress == null) return child;

                              // Return loading indicator
                              return Container(
                                constraints: BoxConstraints(
                                  maxWidth: 100.0,
                                  maxHeight: double.infinity,
                                ),
                                child: Center(
                                  child: SpinKitCircle(
                                    color: Colors.white,
                                    size: 40.0,
                                  ),
                                ),
                              );
                            },
                          )
                        : Text(
                            'Error',
                            style: kTempTextStyle,
                          ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationScreenArgs {
  LocationScreenArgs({
    this.locationWeather,
  });

  final locationWeather;
}
