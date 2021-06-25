import 'package:baztami_app_flutter/config/config.dart';
import 'package:baztami_app_flutter/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/services/authservice.dart';

class Configuration2 extends StatefulWidget {
  const Configuration2({Key? key}) : super(key: key);

  @override
  _Configuration2State createState() => _Configuration2State();
}

class _Configuration2State extends State<Configuration2> {
  final String cuurentUserID = FirebaseAuth.instance.currentUser!.uid;
  String username = "";
  String myPhoneNumber = "";
  String firstname = "";
  String lastname = "";

  void getdata() async {
    DocumentSnapshot variable = await FirebaseFirestore.instance
        .collection("Users")
        .doc(cuurentUserID)
        .get();
    setState(() {
      username = variable["username"];
      myPhoneNumber = variable["phoneNumber"];
      firstname = variable["firstname"];
      lastname = variable["lastname"];
      print(username);
    });
  }

  @override
  void initState() {
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => {
            /*Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()))*/
            Navigator.pop(context)
          },
          icon: Icon(Icons.arrow_back),
          color: Palette.primaryDark2Color,
        ),
        title: Text("Configuration",
            style: TextStyle(
                color: Palette.primaryHeadingColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 5.0),
        child: ListView(children: <Widget>[
          Container(
            margin: EdgeInsets.all(4.0),
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Palette.primaryColor, Palette.primaryHeadingColor]),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(cuurentUserID)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: new CircularProgressIndicator());
                  return ListTile(
                      leading: Icon(Icons.phone_in_talk),
                      title: Text(
                        "Mon numéro de téléphone",
                        style: TextStyle(color: Colors.lightBlue[200]),
                      ),
                      subtitle: Text(
                        (snapshot.data!)["phoneNumber"].toString(),
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ));
                }),
          ),
          Container(
            margin: EdgeInsets.all(4.0),
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Palette.primaryColor, Palette.primaryHeadingColor]),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(cuurentUserID)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: new CircularProgressIndicator());
                  return ListTile(
                    leading: Icon(Icons.phone_in_talk),
                    title: Text(
                      "Mon nom d'utilisateur",
                      style: TextStyle(color: Colors.lightBlue[200]),
                    ),
                    subtitle: Text(
                      (snapshot.data!)["username"].toString(),
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    trailing: Icon(
                      Icons.edit,
                      color: Colors.lightBlueAccent,
                    ),
                  );
                }),
          ),
          Container(
            margin: EdgeInsets.all(4.0),
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Palette.primaryColor, Palette.primaryHeadingColor]),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(cuurentUserID)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: new CircularProgressIndicator());
                  return ListTile(
                    leading: Icon(Icons.phone_in_talk),
                    title: Text(
                      "Mon Prénom",
                      style: TextStyle(color: Colors.lightBlue[200]),
                    ),
                    subtitle: Text(
                      (snapshot.data!)["firstname"].toString(),
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    trailing: Icon(
                      Icons.edit,
                      color: Colors.lightBlueAccent,
                    ),
                  );
                }),
          ),
          Container(
            margin: EdgeInsets.all(4.0),
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Palette.primaryColor, Palette.primaryHeadingColor]),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(cuurentUserID)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: new CircularProgressIndicator());
                  return ListTile(
                    leading: Icon(Icons.phone_in_talk),
                    title: Text(
                      "Mon Nom",
                      style: TextStyle(color: Colors.lightBlue[200]),
                    ),
                    subtitle: Text(
                      (snapshot.data!)["lastname"].toString(),
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    trailing: Icon(
                      Icons.edit,
                      color: Colors.lightBlueAccent,
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  // background color
                  primary: Colors.redAccent,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(fontSize: 20),
                ),
                onPressed: () => {_showMyDialog()},
                icon: Icon(Icons.delete_forever),
                label: Text(
                  "Supprimer mon compte",
                )),
          ),
        ]),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          true, //the user can dispose of the alert box either by pressing a cancel button or by pressing anywhere other the alert itself

      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmez votre action.'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Etes vous sûres de vouloir Supprimer votre compte?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirmer'),
              onPressed: () {
                Navigator.of(context).pop();
                FirebaseFirestore.instance
                    .collection("Users")
                    .doc(cuurentUserID)
                    .delete();
                AuthService().signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
        
      //using containers for data is better for the state
              
      /*Column(children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(cuurentUserID)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData)
                return Center(child: new CircularProgressIndicator());
              return ListTile(
                  title: Text((snapshot.data!)["username"].toString()));
            }),
      ]),*/
  