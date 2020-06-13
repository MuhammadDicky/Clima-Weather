import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  CityScreen({
    this.test,
  });

  static const String routeName = '/setLocation';
  final String test;

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  FocusNode inputCityFocus = FocusNode();
  bool inputCityFocusStatus = false;

  String inputCityName;
  String inputCityPlaceholder = 'Enter city Name';

  @override
  void initState() {
    super.initState();

    // Handle focus change
    inputCityFocus.addListener(_handleCityInputFocus);
  }

  @override
  void dispose() {
    super.dispose();

    inputCityFocus.removeListener(_handleCityInputFocus);
    inputCityFocus.dispose();
  }

  void _handleCityInputFocus() {
    setState(() {
      inputCityFocusStatus = inputCityFocus.hasFocus ||
              inputCityName != null && inputCityName.isNotEmpty
          ? true
          : false;
    });
  }

  void searchWeatherByCity() {
    inputCityFocus.unfocus();

    Navigator.pop(context, inputCityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                height: 100.0,
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  onSubmitted: (String submitStr) {
                    searchWeatherByCity();
                  },
                  focusNode: inputCityFocus,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: inputCityPlaceholder,
                    labelText: inputCityFocusStatus
                        ? 'City Name'
                        : inputCityPlaceholder,
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                  ),
                  onChanged: (String cityNameText) {
                    setState(() {
                      inputCityName = cityNameText;
                    });
                  },
                ),
              ),
              FlatButton(
                onPressed: () {
                  searchWeatherByCity();
                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CityScreenArgs {
  CityScreenArgs({
    this.test,
  });

  final String test;
}
