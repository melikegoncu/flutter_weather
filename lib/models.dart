class WeatherResponse {
  final String cityName;

  final TemperatureInfo temperatureInfo;

  final WeatherInfo weatherInfo;

  final WindInfo windInfo;

  final CountryInfo countryInfo;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  }

  WeatherResponse({required this.cityName, required this.temperatureInfo, required this.weatherInfo, required this.windInfo, required this.countryInfo});

  factory WeatherResponse.fromJson(Map<String, dynamic>json){
    final cityName= json['name'];

    final tempInfoJson= json['main'];
    final temperatureInfo =TemperatureInfo.fromJson(tempInfoJson);

    final weatherInfoJson= json['weather'][0];
    final weatherInfo =WeatherInfo.fromJson(weatherInfoJson);
    
    final windInfoJson= json['wind'];
    final windInfo =WindInfo.fromJson(windInfoJson);

    final countryInfoJson= json['sys'];
    final countryInfo =CountryInfo.fromJson(countryInfoJson);

    return WeatherResponse(cityName: cityName, temperatureInfo: temperatureInfo, weatherInfo: weatherInfo, windInfo: windInfo, countryInfo:countryInfo);
  }
}

class TemperatureInfo{
  final double temperature;

  TemperatureInfo({required this.temperature});

  factory TemperatureInfo.fromJson(Map<String, dynamic>json){
    final temperature = json['temp'];
    return TemperatureInfo(temperature: temperature);
  }
}

class WeatherInfo {
  final int id;
  final String description;
  final String icon;
  
  WeatherInfo({required this.id,required this.description, required this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic>json){
    final id = json['id'];
    final description = json['description'];
    final icon = json['icon'];

    return WeatherInfo(id: id, description: description, icon: icon);
  }
}

class WindInfo {
  final double windSpeed;

  WindInfo({required this.windSpeed});

  factory WindInfo.fromJson(Map<String, dynamic>json){
    final windSpeed = json['speed'];

    return WindInfo(windSpeed: windSpeed);
  }
}

class CountryInfo {
  final String countryName;

  CountryInfo({required this.countryName});

  factory CountryInfo.fromJson(Map<String, dynamic>json){
    final countryName = json['country'];

    return CountryInfo(countryName: countryName);
  }
}