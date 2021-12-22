import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(
  const MaterialApp(
    title: "Weather App",
        home: Home(),
  )
);

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}
class _HomeState extends State<Home>{
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather () async {
    http.Response response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=Boston&units=imperial&appid=9c12f76087a8b71ccc09caf0dabd8120"));
    var results = jsonDecode(response.body);
  setState(() {
    temp = results['main']['temp'];
    description = results['weather'][0]['description'];
    currently = results['weather'][0]['main'];
    humidity = results['main']['humidity'];
    windSpeed = results['wind']['speed'];
    });
  }
  @override
  void initState(){
    super.initState();
    getWeather();
  }
  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: Column(
        children:<Widget>[
          Container(
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width,
            color: Colors.lightGreenAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "Currently in Boston",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
                Text(
                  temp!=null ? temp.toString()+"\u00B0": "Loading",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "Rain",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children:<Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: const Text("Temperature"),
                    trailing: Text(temp!=null ? temp.toString()+"\u00B0": "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: const Text("Weather"),
                    trailing: Text(description!=null ? description.toString(): "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Humidity"),
                    trailing: Text(humidity!=null ? humidity.toString(): "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind Speed"),
                    trailing: Text(windSpeed!=null ? windSpeed.toString(): "Loading"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}