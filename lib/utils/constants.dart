import 'package:flutter/material.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];
const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
  'DOGE',
  'XRP',
  'USDT',
  'ADA',
  'DOT',
];
const coinApiBaseURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'your_api_key_here';
const kCardTextStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);