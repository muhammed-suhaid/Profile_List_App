import 'package:flutter/material.dart';
import 'package:profile_list/component.dart';
import 'package:profile_list/update_profile.dart';

import 'add_profile.dart';

class ProfileList extends StatefulWidget {
  const ProfileList({super.key});

  @override
  State<ProfileList> createState() => _ProfileListState();
}

Color _generateAvatarColor(int index) {
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
  ];

  return colors[index % colors.length];
}

class _ProfileListState extends State<ProfileList> {
  @override
  void initState() {
    setState(() {
      searchProfile = profile;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile Manager"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: 130,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    hintText: "search",
                    contentPadding: const EdgeInsets.only(
                      left: 15,
                      top: 0,
                      bottom: 0,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchProfile = profile
                          .where((profile) => profile.name
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                ),
              ),
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person_2_sharp)),
              Tab(icon: Icon(Icons.favorite)),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addprofile');
          },
          backgroundColor: Colors.black54,
          child: const Icon(Icons.person_add_alt_sharp),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: searchProfile.length,
              itemBuilder: (context, index) {
                if (profile.isEmpty) {
                  return const Center(
                    child: Text("No Profiles Yet"),
                  );
                }
                return Dismissible(
                  key: Key(searchProfile[index].name),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (DismissDirection direction) async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirm Delete'),
                          content: const Text(
                            'Are you sure you want to delete this item?',
                            textAlign: TextAlign.center,
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 8,
                        );
                      },
                    );
                  },
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      int profileIndex = profile.indexWhere(
                          (profile) => profile.id == searchProfile[index].id);
                      setState(() {
                        profile.removeAt(profileIndex);
                        searchProfile.removeAt(index);
                        favprofile.removeAt(index);
                      });
                    }
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          'Swipe to Delete',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: _generateAvatarColor(index),
                        child: Text(
                          searchProfile[index].name[0].toUpperCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text(
                        searchProfile[index].name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "${searchProfile[index].address}, ${searchProfile[index].city} - ${searchProfile[index].pin}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                profile[index].isFav = true;
                              });

                              if (!favprofile.any((favprofile) =>
                                  favprofile.id == profile[index].id)) {
                                setState(() {
                                  favprofile.add(profile[index]);
                                });
                              }
                            },
                            icon: !profile[index].isFav
                                ? const Icon(Icons.favorite_border)
                                : const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                          ),
                          IconButton(
                            onPressed: () async {
                              final confirmEdit = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirm Edit'),
                                    content: const Text(
                                      'Do you want to edit this profile?',
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: const Text(
                                          'Yes',
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 8,
                                  );
                                },
                              );

                              if (confirmEdit == true) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateProfile(
                                      updateprofile: profile[index],
                                    ),
                                  ),
                                );
                              }
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            //////// fav tab ////////
            ListView.builder(
              itemCount: favprofile.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: _generateAvatarColor(index),
                      child: Text(
                        favprofile[index].name[0].toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(
                      favprofile[index].name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "${favprofile[index].address}, ${favprofile[index].city} - ${favprofile[index].pin}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            int profileIndex = profile.indexWhere((profile) =>
                                profile.id == favprofile[index].id);
                            setState(() {
                              favprofile.remove(favprofile[index]);
                              profile[profileIndex].isFav = false;
                            });
                          },
                          icon: const Icon(Icons.favorite),
                          color: Colors.red,
                        ),
                        IconButton(
                          onPressed: () async {
                            final confirmEdit = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirm Edit'),
                                  content: const Text(
                                    'Do you want to edit this profile?',
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text(
                                        'Yes',
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 8,
                                );
                              },
                            );

                            if (confirmEdit == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateProfile(
                                    updateprofile: profile[index],
                                  ),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
