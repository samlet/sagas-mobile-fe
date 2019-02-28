// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'dart:io';

Future printDailyNewsDigest() async {
  String news = await gatherNewsReports();
  print(news);
}

final _httpClient = new HttpClient();

void main() {
  printDailyNewsDigest();
  printWinningLotteryNumbers();
  printWeatherForecast();
  printBaseballScore();
}

void printWinningLotteryNumbers() {
  print('Winning lotto numbers: [23, 63, 87, 26, 2]');
}

void printWeatherForecast() {
  print('Tomorrow\'s forecast: 70F, sunny.');
}

void printBaseballScore() {
  print('Baseball score: Red Sox 10, Yankees 0');
}

Future<String> _getRequest(Uri uri) async {
  var request = await _httpClient.getUrl(uri);
  var response = await request.close();

  return response.transform(utf8.decoder).join();
}

// Imagine that this function is more complex and slow. :)
Future gatherNewsReports() async {
  String path = 'www.dartlang.org';
  return (await _getRequest(Uri.https(path, "f/dailyNewsDigest.txt")));
}
