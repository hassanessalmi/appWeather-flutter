import 'dart:convert';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WidgetMeteo extends StatefulWidget {
  const WidgetMeteo({Key? key}) : super(key: key);

  @override
  State<WidgetMeteo> createState() => _WidgetMeteoState();
}

class _WidgetMeteoState extends State<WidgetMeteo> {
  var _temp;
  var _pres;
  var _hum;
  var _pays;

  String _cityName = ''; // Add a variable to store the entered city name
 // String url ='https://api.openweathermap.org/data/2.5/weather?q=Kinshasa&appid=e3488685983b3f73c1d290ca96a73ac7&units=metric';
  dynamic weatherData;

  void _getWeatherData() {
    // Update the URL with the user-entered city name
    String updatedUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$_cityName&appid=e3488685983b3f73c1d290ca96a73ac7&units=metric';

    http.get(Uri.parse(updatedUrl)).then((response) {
      print(response.body);
      setState(() {
        weatherData = jsonDecode(response.body);
        _temp = weatherData['main']['temp'];
        _pres = weatherData['main']['pressure'];
        _hum = weatherData['main']['humidity'];
        _pays = weatherData['sys']['country'];
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'METEO',
          style: TextStyle(fontSize: 35, color: Colors.yellow),
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            children: [
              // Add a TextField for user input
              TextField(
                onChanged: (value) {
                  _cityName = value;
                },
                decoration: InputDecoration(
                  labelText: 'Enter City Name',
                  labelStyle: TextStyle(fontSize: 20),
                ),
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Temperature: ',
                    style: TextStyle(fontSize: 35, color: Colors.green),
                  ),
                  SizedBox(width: 20),
                  Text(
                    '$_temp',
                    style: TextStyle(fontSize: 35, color: Colors.green),
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Pression: ',
                    style: TextStyle(fontSize: 35, color: Colors.green),
                  ),
                  SizedBox(width: 20),
                  Text(
                    '$_pres',
                    style: TextStyle(fontSize: 35, color: Colors.green),
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Humidité: ',
                    style: TextStyle(fontSize: 35, color: Colors.green),
                  ),
                  SizedBox(width: 20),
                  Text(
                    '$_hum',
                    style: TextStyle(fontSize: 35, color: Colors.green),
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Pays: ',
                    style: TextStyle(fontSize: 35, color: Colors.green),
                  ),
                  SizedBox(width: 20),
                  Text(
                    '$_pays',
                    style: TextStyle(fontSize: 35, color: Colors.green),
                  ),
                  CountryFlag.fromCountryCode(
                    '$_pays', height:48,
                      width:62,
                      borderRadius:8,

                  )
                ],
              ),
              SizedBox(height: 20),

              IconButton(
                icon: Icon(
                  Icons.refresh,
                  size: 55,
                  color: Colors.amberAccent,
                ),
                onPressed: _getWeatherData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
