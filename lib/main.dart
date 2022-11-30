import 'package:flutter/material.dart';
import 'package:flutter_weather/loading_screen.dart';
import 'data_service.dart';
import 'location.dart';
import 'models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.purple,
          )
      ),
      home: const MyHomePage(title: 'Flutter Weather'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _dataService = DataService();
  late LocationHelper locationData;
  Future<void> getLocationData() async{
    locationData = LocationHelper();
    await locationData.getCurrentLocation();

    if(locationData.latitute == null || locationData.longitude == null){
      print("Konum bilgileri gelmiyor.");
    }
    else{
      locationData.latitute=41.0082;
      locationData.longitude=28.9784;
    }
  }

  void getWeatherData() async{
    await getLocationData();

    final weatherResponse = await _dataService.getWeather(lat: locationData.latitute, lon: locationData.longitude);
    setState(() => _response = weatherResponse);
  }


  @override
  void initState() {
    super.initState();
    getWeatherData();
  }
  final _cityTextController = TextEditingController();
  WeatherResponse? _response;
  
            
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf9f9f9),
      appBar: AppBar(
        title: Text(widget.title, ),
        actions: <Widget>[
          IconButton(onPressed: (() {
            
          }), 
          icon: const Icon(Icons.settings, color: Colors.white,))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_response != null)
                Column(
                  children: [
                    Padding(padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('${_response!.cityName.toUpperCase()}',
                      style: const TextStyle(fontSize: 20)),
                    )),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
      //set border radius more than 50% of height and width to make circle
  ),                        child: Container(decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage("assets/day66-travel.png"),
                  fit:BoxFit.cover
                ),
              ),
                          child: Column(
                            children: [
                            Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text('${_response?.weatherInfo.description.toUpperCase()}',
                              style: const TextStyle(fontSize: 20),),
                            ),
                              Image.network(_response!.iconUrl),
                            ],),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                '${_response!.temperatureInfo.temperature.ceil()}°',
                                style: const TextStyle(fontSize: 55),
                              ),
                            ),
                            Padding(padding: const EdgeInsets.all(10.0),
                            child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Padding(
                            padding: const EdgeInsets.all(20),
                            child: Icon(Icons.wind_power_outlined,
                            size:35),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text('${_response?.windInfo.windSpeed.ceil()} m/sn',
                              style: const TextStyle(fontSize: 30),
                            ),
                          ),
                          ]
                      ),)
                            ]
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              if(_response==null)
              const LoadingScreen(),
              Padding(
                padding: const EdgeInsets.all(50),
                child: SizedBox(
                  width: 150,
                  child: TextField(
                      controller: _cityTextController,
                      decoration: InputDecoration(labelText: 'City',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {_clear();},
                        icon: Icon(Icons.clear),
                      ),),
                      textAlign: TextAlign.center),
                ),
              ),
              ElevatedButton(onPressed: (){_cityTextController.text.isNotEmpty 
              ?_search()
              :ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Please enter a city name."),
            ));
              }, child: const Text('Search')),
            ],
          ),
        ),
      ),
    );
  }

    _search() async {
    final weatherResponse = await _dataService.getWeather(city: _cityTextController.text);
    setState(() => _response = weatherResponse);
  }
  _clear(){
    _cityTextController.clear();
  }
}