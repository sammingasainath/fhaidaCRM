import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anucivil_client/notifiers/user_details_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Assuming you're using Firebase for authentication

class UserDetailsScreen extends ConsumerStatefulWidget {
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends ConsumerState<UserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
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
  void initState() {
    super.initState();
    _setPhoneNumber();
  }

  void _setPhoneNumber() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.phoneNumber != null) {
      _phoneController.text = user.phoneNumber!;
    }
  }

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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTextFormField(_nameController, 'Name', validateNotEmpty),
                _buildTextFormField(_emailController, 'Email', validateEmail),
                _buildTextFormField(_phoneController, 'Phone', validatePhone),
                _buildAddressFields(),
                _buildTextFormField(
                    _gUrlController, 'Google URL', validateNotEmpty),
                _buildTextFormField(_profileImgController, 'Profile Image URL',
                    validateNotEmpty),
                SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent,
                      foregroundColor: Colors.black,
                      textStyle:
                          TextStyle(fontSize: 18.0, fontFamily: 'Futuristic'),
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
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
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String labelText,
      String? Function(String?)? validator) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
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
        validator: validator,
      ),
    );
  }

  Widget _buildAddressFields() {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.tealAccent),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Address',
            style: TextStyle(
                color: Colors.tealAccent,
                fontFamily: 'Futuristic',
                fontSize: 16),
          ),
          _buildTextFormField(_streetController, 'Street', validateNotEmpty),
          _buildTextFormField(_townController, 'Town', validateNotEmpty),
          _buildTextFormField(
              _districtController, 'District', validateNotEmpty),
          _buildTextFormField(_stateController, 'State', validateNotEmpty),
          _buildTextFormField(_pincodeController, 'Pincode', validatePincode),
        ],
      ),
    );
  }

  var userDetailsNotifierProvider;

  void _saveUserDetails(BuildContext context) {
    if (_formKey.currentState!.validate()) {
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

  String? validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? validatePincode(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (value.length != 6) {
      return 'Enter a valid pincode';
    }
    return null;
  }
}
