import 'package:flutter/material.dart';
import 'package:profile_list/add_profile.dart';
import 'package:profile_list/list_profiles.dart';
import 'component.dart';
import 'list.dart';

class UpdateProfile extends StatefulWidget {

  final updateprofile;

  const UpdateProfile({super.key, required this.updateprofile});

  @override
  State<UpdateProfile> createState() => _AddProfileState();
}

List<String> gender = ['Male', 'Female', 'Others'];

//List<Profiles> profile = List.empty(growable: true);
//
class _AddProfileState extends State<UpdateProfile> {
  String? selectedValue;
   String currentOption = '';
  //
  TextEditingController nametext = TextEditingController();
  TextEditingController emailtext = TextEditingController();
  TextEditingController phonetext = TextEditingController();
  TextEditingController agetext = TextEditingController();
  TextEditingController addresstext = TextEditingController();
  TextEditingController citytext = TextEditingController();
  TextEditingController pintext = TextEditingController();
  //
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Andhra Pradesh", child: Text("Andhra Pradesh")),
      const DropdownMenuItem(
          value: "Arunachal Pradesh", child: Text("Arunachal Pradesh")),
      const DropdownMenuItem(value: "Assam", child: Text("Assam")),
      const DropdownMenuItem(value: "Bihar", child: Text("Bihar")),
      const DropdownMenuItem(value: "Kerala", child: Text("Kerala")),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as Map;
 
    currentOption = widget.updateprofile.gender;
    selectedValue = widget.updateprofile.state;    
    nametext.text = widget.updateprofile.name;
    emailtext.text = widget.updateprofile.email;
    phonetext.text = widget.updateprofile.phone;
    agetext.text = widget.updateprofile.age;
    addresstext.text = widget.updateprofile.address;
    citytext.text = widget.updateprofile.city;
    pintext.text = widget.updateprofile.pin;
    
    //phonetext.text = args[phonetext].toString();
    //print(profile[0].name);
    //addresstext.text = args['address'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text(
          "Update Profile",
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CustomSizedTextform(
                  controllerr: nametext,
                  height: 66,
                  hinttext: 'Enter Name',
                  keyboardtype: TextInputType.text,
                  maxlenght: null,
                  text: 'Name',
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CustomSizedTextform(
                  controllerr: emailtext,
                  height: 66,
                  hinttext: 'Enter Email Address',
                  keyboardtype: TextInputType.emailAddress,
                  maxlenght: null,
                  text: 'Email Address',
                  validate: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CustomSizedTextform(
                  controllerr: phonetext,
                  height: 66,
                  hinttext: 'Enter Phone Number',
                  keyboardtype: TextInputType.number,
                  maxlenght: 10,
                  text: 'Phone Number',
                  validate: (value) {
                    if (!RegExp(r'^\d{10,}$').hasMatch(value!)) {
                      return 'Please enter a 10 digit Phone number';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CustomSizedTextform(
                  controllerr: agetext,
                  height: 66,
                  hinttext: 'Enter Age',
                  keyboardtype: TextInputType.number,
                  maxlenght: 3,
                  text: 'Age',
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter valid Age';
                    }
                    return null;
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Select Your Gender",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  RadioListTile(
                      value: gender[0],
                      groupValue: currentOption,
                      title: const Text("Male"),
                      onChanged: (value) {
                        setState(() {
                          currentOption = value.toString();
                        });
                      }),
                  RadioListTile(
                      value: gender[1],
                      groupValue: currentOption,
                      title: const Text("Female"),
                      onChanged: (value) {
                        setState(() {
                          currentOption = value.toString();
                        });
                      }),
                  RadioListTile(
                      value: gender[2],
                      groupValue: currentOption,
                      title: const Text("Others"),
                      onChanged: (value) {
                        setState(() {
                          currentOption = value.toString();
                        });
                      })
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CustomSizedTextform(
                  controllerr: addresstext,
                  height: 66,
                  hinttext: 'Enter Address',
                  keyboardtype: TextInputType.text,
                  maxlenght: null,
                  text: 'Address',
                  validate: (value) {
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CustomSizedTextform(
                  controllerr: citytext,
                  height: 66,
                  hinttext: 'Enter City',
                  keyboardtype: TextInputType.text,
                  maxlenght: null,
                  text: 'City',
                  validate: (value) {
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: DropdownButtonFormField(
                  value: selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  items: dropdownItems,
                 
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'State is required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    label: Text("Select Your State"),
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                  icon: const Icon(Icons.arrow_drop_down),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CustomSizedTextform(
                  controllerr: pintext,
                  height: 66,
                  hinttext: 'Enter PIN code',
                  keyboardtype: TextInputType.number,
                  maxlenght: 6,
                  text: 'PIN code',
                  validate: (value) {
                    if (!RegExp(r'^\d{6,}$').hasMatch(value!)) {
                      return 'Please enter a valid PinCode';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                  onPressed: () {
                    Profiles updatedProfile = Profiles(
                      name: nametext.text,
                      email: emailtext.text,
                      phone: phonetext.text,
                      address: addresstext.text,
                      age: agetext.text,
                      city: citytext.text,
                      gender: currentOption,
                      pin: pintext.text,
                      state: selectedValue,
                      id: widget.updateprofile.id,
                      isFav: widget.updateprofile.isFav,
                    );

                    int index = profile.indexWhere(
                        (profile) => profile.id == widget.updateprofile.id);

                    profile[index] = updatedProfile;

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileList()),
                      (route) => false,
                    );
                  },
                  style: const ButtonStyle(
                      minimumSize:
                          MaterialStatePropertyAll(Size(double.infinity, 45)),
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.black54)),
                  child: const Text("UPDATE"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
