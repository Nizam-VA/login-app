import 'package:flutter/material.dart';
import 'package:login_demo/Screens/login_page.dart';
import 'package:login_demo/Screens/personal_page.dart';
import 'package:login_demo/Screens/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<String> names = [
    'Nizam',
    'Hashir',
    'Vappa',
    'Sayyid Jaseel',
    'C Usthad',
    'Niyas Suraiji',
    'Kattippara Usthad',
    'Sheikh Sageer',
    'Hazrath Usthad',
    'Baqavi Usthad',
  ];
  final List<String> descriptions = [
    'Meeting',
    'I love madeeena',
    'Live to learn',
    'Text message only',
    'Iam busy',
    'Iam using whatsapp',
    'Typing....',
    'Making kithab',
    'Teacher',
    'New world',
  ];
  List<AssetImage> images = [
    AssetImage('assets/images/nizam.jpg'),
    AssetImage('assets/images/hashir.jpg'),
    AssetImage('assets/images/vappa.jpg'),
    AssetImage('assets/images/thangal.jpg'),
    AssetImage('assets/images/custhad.jpg'),
    AssetImage('assets/images/niyas.jpg'),
    AssetImage('assets/images/kattipparausthad.jpg'),
    AssetImage('assets/images/apusthad.jpg'),
    AssetImage('assets/images/hazrath.jpg'),
    AssetImage('assets/images/aliusthad.jpg')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maxino'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                showAlertDialog(context);
              },
              icon: Icon(Icons.logout))
        ],
        backgroundColor: Colors.green[900],
        toolbarHeight: 70,
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(
        //   bottom: Radius.circular(20),
        // )),
      ),
      body: ListView.builder(
          itemBuilder: (context, index) {
            // return index%2==0 ?   :
            return index % 2 == 0
                ? ListTile(
                    leading: CircleAvatar(
                      child: GestureDetector(
                        onTap: () async {
                          Future.delayed(Duration(seconds: 1));
                          await showDialog(
                              context: context,
                              builder: (_) => ImageDialog(
                                    image: images[index],
                                  ));
                        },
                      ),
                      backgroundImage: images[index],
                    ),
                    title: Text(
                      names[index],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(descriptions[index]),
                    trailing: Text('0${index + 1}:00 pm'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => ScreenPersonal(
                              name: names[index], image: images[index]),
                        ),
                      );
                    },
                  )
                : ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      child: Image(
                        image: images[index],
                      ),
                    ),
                    title: Text(
                      names[index],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(descriptions[index]),
                    trailing: Text('0${index + 1}:00 pm'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => ScreenPersonal(
                              name: names[index], image: images[index]),
                        ),
                      );
                    },
                  );
          },
          itemCount: names.length),
    );
  }

  signOut(BuildContext ctx) async {
    final _pref = await SharedPreferences.getInstance();
    await _pref.clear();
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => ScreenLogin()), (route) => false);
  }

  showAlertDialog(BuildContext context) {
    Widget yesButton = ElevatedButton(
      onPressed: () {
        signOut(context);
      },
      child: Text('YES'),
    );

    Widget noButton = ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text('No'),
    );

    AlertDialog alert = AlertDialog(
      title: Text('LOGOUT'),
      content: Text('Do you want to logout'),
      actions: [
        yesButton,
        noButton,
      ],
    );

    showDialog(context: context, builder: (BuildContext contaxt) => alert);
  }
}

class ImageDialog extends StatelessWidget {
  final AssetImage image;
  ImageDialog({required this.image});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 250,
        height: 300,
        decoration: BoxDecoration(
            image: DecorationImage(image: image, fit: BoxFit.cover)),
      ),
    );
  }
}
