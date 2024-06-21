// screens/user_details_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anucivil_client/notifiers/user_details_notifier.dart';

class UserDetailsScreen extends ConsumerStatefulWidget {
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends ConsumerState<UserDetailsScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _townController = TextEditingController();
  final _districtController = TextEditingController();
  final _stateController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _gUrlController = TextEditingController();
  final _profileImgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Details',
          style: TextStyle(
            fontFamily: 'Futuristic',
            fontSize: 24,
            color: Colors.tealAccent,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.tealAccent,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.tealAccent),
            onPressed: () {},
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.grey[900]!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey[900]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTextField(_nameController, 'Name'),
              _buildTextField(_emailController, 'Email'),
              _buildTextField(_phoneController, 'Phone'),
              _buildTextField(_streetController, 'Street'),
              _buildTextField(_townController, 'Town'),
              _buildTextField(_districtController, 'District'),
              _buildTextField(_stateController, 'State'),
              _buildTextField(_pincodeController, 'Pincode'),
              _buildTextField(_gUrlController, 'Google URL'),
              _buildTextField(_profileImgController, 'Profile Image URL'),
              SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent,
                    foregroundColor: Colors.black,
                    textStyle:
                        TextStyle(fontSize: 18.0, fontFamily: 'Futuristic'),
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    shadowColor: Colors.tealAccent,
                    elevation: 10.0,
                  ),
                  onPressed: () => _saveUserDetails(context),
                  child: Text('Save Details'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white, fontFamily: 'Futuristic'),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle:
              TextStyle(color: Colors.tealAccent, fontFamily: 'Futuristic'),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.tealAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.tealAccent, width: 2.0),
          ),
          filled: true,
          fillColor: Colors.grey[850],
        ),
      ),
    );
  }

  void _saveUserDetails(BuildContext context) {
    ref.read(userDetailsNotifierProvider.notifier).saveUserDetails(
          name: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          street: _streetController.text,
          town: _townController.text,
          district: _districtController.text,
          state: _stateController.text,
          pincode: _pincodeController.text,
          gUrl: _gUrlController.text,
          profileImg: _profileImgController.text,
          context: context,
        );
  }
}
