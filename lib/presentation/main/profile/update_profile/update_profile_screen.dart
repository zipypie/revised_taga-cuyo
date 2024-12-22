import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/common_widgets/button.dart';
import 'package:taga_cuyo/core/common_widgets/textfield_editable.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
// import 'package:taga_cuyo/core/models/user_model.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({
    super.key,
  });

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController fnController =
      TextEditingController(text: "Juan");
  final TextEditingController lnController =
      TextEditingController(text: "Dela Cruz");
  final TextEditingController emailController =
      TextEditingController(text: "juanDelaCruz@example.com");
  final TextEditingController genderController =
      TextEditingController(text: "Male");
  final TextEditingController ageController = TextEditingController(text: "30");

  // @override
  // void initState() {
  //   super.initState();

  //   // Initialize controllers with existing user data
  //   fnController = TextEditingController(text: widget.user.firstName);
  //   lnController = TextEditingController(text: widget.user.lastName);
  //   emailController = TextEditingController(text: widget.user.email);
  //   genderController = TextEditingController(text: widget.user.gender);
  //   ageController = TextEditingController(text: widget.user.age.toString());
  // }

  @override
  void dispose() {
    // Dispose controllers when no longer needed
    fnController.dispose();
    lnController.dispose();
    emailController.dispose();
    genderController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: CustomColors.userAvatar,
                ),
              ),
              SizedBox(height: 20),
              TextfieldWithEditIcon(
                label: 'First Name',
                controller: fnController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20),
              TextfieldWithEditIcon(
                label: 'Last Name',
                controller: lnController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20),
              TextfieldWithEditIcon(
                label: 'Email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              TextfieldWithEditIcon(
                label: 'Gender',
                controller: genderController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20),
              TextfieldWithEditIcon(
                label: 'Age',
                controller: ageController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              CustomButton(
                  onTab: () {
                    // User updatedUser = User(
                    //   uid: widget.user.uid,
                    //   firstName: fnController.text,
                    //   lastName: lnController.text,
                    //   email: emailController.text,
                    //   gender: genderController.text,
                    //   age: int.parse(ageController.text),
                    //   profileImage: widget.user.profileImage,
                    // );
                  },
                  text: 'Update Profile')
            ],
          ),
        ),
      ),
    );
  }
}
