import 'package:cab_nurse/globalVariables.dart';
import 'package:cab_nurse/screens/main_page.dart';
import 'package:cab_nurse/widgets/taxi_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../brand_colors.dart';

class VehicleInfoPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void showSnackBar(String title) {
    final snackbar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  static const String id = 'vehicleinfo';

  var carModelController = TextEditingController();
  var carColorController = TextEditingController();
  var vehicleNumberController = TextEditingController();

  void updateProfile(context) {
    String id = currentFirebaseUser.uid;
    DatabaseReference driverRef = FirebaseDatabase.instance
        .reference()
        .child('drivers/$id/vehicle_details');

    Map map = {
      'car_color': carColorController.text,
      'car_model': carModelController.text,
      'vehicle_number': vehicleNumberController.text,
    };
    driverRef.set(map);
    Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 70),
              Container(
                height: 200,
                width: 200,
                child: Lottie.asset('images/nurse.json'),
              ),
              // Image.asset('images/logo.png', height: 110, width: 110),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 30),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Enter Your Details',
                      style: TextStyle(fontSize: 22, fontFamily: 'Brand-Bold'),
                    ),
                    SizedBox(height: 25),

                    ///Car Model
                    TextField(
                      controller: carModelController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Car Model',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10),

                    ///Car Color
                    TextField(
                      controller: carColorController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Car Color',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10),

                    ///VehicleInfo
                    TextField(
                      controller: vehicleNumberController,
                      maxLength: 11,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        counterText: '',
                        labelText: 'Vehicle Number',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 40),

                    ///Taxi Button
                    TaxiButton(
                      color: BrandColors.colorGreen,
                      title: 'Proceed',
                      onPressed: () {
                        if (carModelController.text.length < 3) {
                          showSnackBar('Please provide valid car model');
                          return;
                        }

                        if (carColorController.text.length < 3) {
                          showSnackBar('Please provide valid car color');
                          return;
                        }

                        if (vehicleNumberController.text.length < 3) {
                          showSnackBar('Please provide valid vehicle number');
                          return;
                        }
                        updateProfile(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
