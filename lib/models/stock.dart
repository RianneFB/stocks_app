import 'dart:convert';


AlphaVantageDailyResponse alphaVantageDailyResponseFromJson(String str) =>
    AlphaVantageDailyResponse.fromJson(json.decode(str));


String alphaVantageDailyResponseToJson(AlphaVantageDailyResponse data) =>
    json.encode(data.toJson());

class MetaData {
  final String information;
  final String symbol;
  final DateTime lastRefreshed;
  final String outputSize;
  final String timeZone;

  MetaData({
    required this.information,
    required this.symbol,
    required this.lastRefreshed,
    required this.outputSize,
    required this.timeZone,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      information: json["1. Information"],
      symbol: json["2. Symbol"],
      lastRefreshed: DateTime.parse(json["3. Last Refreshed"]),
      outputSize: json["4. Output Size"],
      timeZone: json["5. Time Zone"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "1. Information": information,
      "2. Symbol": symbol,
      "3. Last Refreshed": lastRefreshed.toIso8601String(),
      "4. Output Size": outputSize,
      "5. Time Zone": timeZone,
    };
  }
}

class DailyBar {
  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;
  final int volume;

  DailyBar({
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  factory DailyBar.fromAlphaVantage(String dateStr, Map<String, dynamic> day) {
    return DailyBar(
      date: DateTime.parse(dateStr),
      open: double.parse(day["1. open"]),
      high: double.parse(day["2. high"]),
      low: double.parse(day["3. low"]),
      close: double.parse(day["4. close"]),
      volume: int.parse(day["5. volume"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date.toIso8601String(),
      "open": open,
      "high": high,
      "low": low,
      "close": close,
      "volume": volume,
    };
  }
}

class AlphaVantageDailyResponse {
  final MetaData meta;
  final List<DailyBar> bars;

  AlphaVantageDailyResponse({
    required this.meta,
    required this.bars,
  });

  factory AlphaVantageDailyResponse.fromJson(Map<String, dynamic> json) {
    final metaJson = (json["Meta Data"] as Map).cast<String, dynamic>();
    final seriesJson =
        (json["Time Series (Daily)"] as Map).cast<String, dynamic>();

    final bars =
        seriesJson.entries.map((entry) {
          final dateStr = entry.key;
          final day = (entry.value as Map).cast<String, dynamic>();
          return DailyBar.fromAlphaVantage(dateStr, day);
        }).toList();

    bars.sort((a, b) => b.date.compareTo(a.date));

    return AlphaVantageDailyResponse(
      meta: MetaData.fromJson(metaJson),
      bars: bars,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Meta Data": meta.toJson(),
      "Time Series (Daily)": {
        for (var bar in bars)
          bar.date.toIso8601String().split('T').first: {
            "1. open": bar.open.toString(),
            "2. high": bar.high.toString(),
            "3. low": bar.low.toString(),
            "4. close": bar.close.toString(),
            "5. volume": bar.volume.toString(),
          }
      }
    };
  }

  static AlphaVantageDailyResponse fromRawJson(String raw) =>
      AlphaVantageDailyResponse.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );

  static String toRawJson(AlphaVantageDailyResponse data) =>
      jsonEncode(data.toJson());

  static AlphaVantageDailyResponse fromEmpty() => AlphaVantageDailyResponse(
        meta: MetaData(
          information: '',
          symbol: '',
          lastRefreshed: DateTime.now(),
          outputSize: '',
          timeZone: '',
        ),
        bars: [],
      );
}