import 'dart:async';

// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'datamodels/driver.dart';

FirebaseUser currentFirebaseUser;

String mapKey = 'AIzaSyAs7RzDWGtIFP_XGkO_og4-gInfY4EK9ZY';
final CameraPosition googlePlex = CameraPosition(
  target: LatLng(30.3308401, 71.247499),
  zoom: 14.4746,
);

StreamSubscription<Position> homeTabPositionStream;
StreamSubscription<Position> ridePositionStream;

// final assetsAudioPlayer = AssetsAudioPlayer();
Position currentPosition;

DatabaseReference rideRef;
Driver currentDriverInfo;
