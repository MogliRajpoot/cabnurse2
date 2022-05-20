import 'package:cab_nurse/datamodels/tripdetails.dart';
import 'package:cab_nurse/globalVariables.dart';
import 'package:cab_nurse/helpers/helpermethods.dart';
import 'package:cab_nurse/screens/new_trip_page.dart';
import 'package:cab_nurse/widgets/brand_divider.dart';
import 'package:cab_nurse/widgets/progress_dialogue.dart';
import 'package:cab_nurse/widgets/taxi_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../brand_colors.dart';
import 'TaxiOutlineButton.dart';

class NotificationDialoge extends StatelessWidget {
  final TripDetails tripDetails;
  NotificationDialoge({this.tripDetails});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(4),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30),
            Image.asset('images/nearby_nurse.png', width: 100),
            SizedBox(height: 16),
            Text('New Request',
                style: TextStyle(fontFamily: 'Brand-Bold', fontSize: 18)),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('images/pickicon.png', height: 16, width: 16),
                      SizedBox(width: 18),
                      Expanded(
                        child: Container(
                          child: Text(tripDetails.pickupAddress,
                              style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('images/desticon.png', height: 16, width: 16),
                      SizedBox(width: 18),
                      Expanded(
                        child: Container(
                          child: Text(tripDetails.destinationAddress,
                              style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            BrandDivider(),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: TaxiOutlineButton(
                        title: 'DECLINE',
                        color: BrandColors.colorLightGrayFair,
                        onPressed: () {
                          Navigator.pop(context);
                          // assetsAudioPlayer.stop();
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      child: TaxiButton(
                        title: 'ACCEPT',
                        color: BrandColors.colorGreen,
                        onPressed: () {
                          checkAvailablity(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkAvailablity(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => ProgressDialogue(
              status: 'Accepting . . .  ',
            ));
    DatabaseReference newRideRef = FirebaseDatabase.instance
        .reference()
        .child('drivers/${currentFirebaseUser.uid}/newtrip');

    newRideRef.once().then((DataSnapshot snapshot) {
      Navigator.pop(context);
      Navigator.pop(context);
      String thisRideID = '';
      if (snapshot != null) {
        thisRideID = snapshot.value.toString();
      } else {
        Toast.show("Nurse not found.", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
      if (thisRideID == tripDetails.rideID) {
        newRideRef.set('accepted');
        // assetsAudioPlayer.stop();
        HelperMethods.disableHomeTabLocationUpdate();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewTripPage(tripDetails: tripDetails),
            ));
      } else if (thisRideID == 'cancelled') {
        Toast.show("Request is cancelled.", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } else if (thisRideID == 'timeout') {
        Toast.show("Request timeout.", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } else {
        Toast.show("Nurse not found.", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    });
  }
}
