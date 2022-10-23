import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'system_notifications.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

//import 'package:rampu_seminarski_rad/main.dart';

void main() async{

  //inicijalizacija awesome_notifications
  WidgetsFlutterBinding.ensureInitialized();

  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: "key1",
            channelName: "RAMPU",
            channelDescription: "Primjer RAMPU",
            defaultColor: Colors.red,
            playSound: true,
        ),
      ]
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RootPage(

      ),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  @override
  void initState() {
    super.initState();
    NotificationWidget.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Image.network(
            "https://www.foi.unizg.hr/sites/default/files/foi-logo-horiz-hrv-2.png"),
        backgroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 100,
      ),

      body:
      Container(
        //width: 450,
        //height: 300,

        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,

        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://www.srednja.hr/app/uploads/2020/07/foi_predstavljanje-6.jpg"),
                fit: BoxFit.cover
            )
        ),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 50)
              ),
              onPressed: () {
                Fluttertoast.showToast(msg: "Toast notifikacija!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  textColor: Colors.red[800],
                  backgroundColor: Colors.blue,
                  fontSize: 20,
                );
              },
              child: const Text("Toast"),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 50)
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                          "Ovo je snackbar obavijest. Možeš ju ugasiti pritiskom na gumb ili pričekati da se sama ugasi"),
                      action: SnackBarAction(
                        label: "Dismiss",
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    )
                );
              },
              child: const Text("SnackBar"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SystemNotifications()));
              },
              child: const Text("Sistemske notifikacije"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const UserDialogs()));
              },

              child: const Text("Korisnički dialozi"),
            ),
          ],
        ),
      ),

      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        child: const Icon(Icons.school_outlined),
        backgroundColor: Colors.red[900],
        overlayStyle: ExpandableFabOverlayStyle(
          blur: 5,
        ),

        children: [

          FloatingActionButton.small(
            heroTag: null,
            backgroundColor: Colors.red[900],
            child: const Icon(Icons.edit),
            onPressed: () {},
          ),
          FloatingActionButton.small(
            heroTag: null,
            backgroundColor: Colors.red[900],
            child: const Icon(Icons.my_library_add_rounded),
            onPressed: () {},
          ),
          FloatingActionButton.small(
            backgroundColor: Colors.red[900],
            onPressed: () {},
            child: const Icon(Icons.search),
          )
        ],
      ),
    );
  }
}



////////////////////////////////////////////////////////////////
/////////////////////////////PAGE2//////////////////////////////
////////////////////////////////////////////////////////////////

class SystemNotifications extends StatelessWidget {
  const SystemNotifications({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(

          centerTitle: true,
          toolbarHeight: 150,

          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("https://venturebeat.com/wp-content/uploads/2021/05/GettyImages-1291886933-e1624308433688.jpg?fit=2309%2C1154&strip=all"),
                    fit: BoxFit.cover
                ),
            ),
          ),
          title: const Text("Sistemske notifikacije",
            style: TextStyle(
                color: Colors.red,
                fontSize: 30,
            ),
          ),
        ),

      body: Center(
        child: Container(

          decoration:  const BoxDecoration(
            gradient:   LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.red,
                Colors.blue,
              ]
            )
          ),

          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,

          child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              ElevatedButton(
                onPressed: () {
                  NotificationWidget.showNotification(title: "RAMPU", body: "Dobrodošao na razvoj aplikacija za mobilne i pametne uređaje. Enjoy your stay!");
                },
                child: const Text("Jednostavna lokalna notifikacija"),
              ),

              ElevatedButton(
                onPressed: () async{
                  ComplexNotifications.NotifyMe();
                },
                child: const Text("Složena lokalna notifikacija"),
              ),

              ElevatedButton(
                onPressed: () async{
                  ComplexNotifications.NotifyMeScheduled();
                },
                child: const Text("Scheduled notifikacija"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


////////////////////////////////////////////////////////////////
/////////////////////////////PAGE3//////////////////////////////
////////////////////////////////////////////////////////////////


class UserDialogs extends StatelessWidget {
  const UserDialogs({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        centerTitle: true,
        toolbarHeight: 150,

        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage("https://static.prod01.ue1.p.pcomm.net/blackbaud/user_content/photos/000/006/6783/a6132a5cd55abcae190bc82567ca8a47-original-users.png"),
                  fit: BoxFit.cover
              )
          ),
        ),
        title: const Text("Korisnički dialozi",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
        ),
      ),

      body: Center(
        child: Container(

          decoration:  const BoxDecoration(
              gradient:   LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.greenAccent,
                  ]
              )
          ),

          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,

          child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              ElevatedButton(
                onPressed: () {
                  showAlertDialog(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.orange)
                ),

                child: const Text("Alert Dialog"),
              ),

              ElevatedButton(
                onPressed: () {
                  showSimpleDialog(context);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.orange)
                ),

                child: const Text("Simple Dialog"),
              ),

              ElevatedButton(
                onPressed: () async{
                  openDialogWithInput(context);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.orange)
                ),

                child: const Text("Dialog za unos podataka"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  Widget cancelButton = TextButton(
    child: const Text('Cancel'),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  Widget continueButton = TextButton(
    child: const Text('Continue'),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    title: const Text("Alert dialog"),
    content: const Text("Ovo je Alert dialog u Flutteru. Stisni jedan od gumba da vidiš kako radi :)"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showSimpleDialog(BuildContext context) async{
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Expanded(
        child: SimpleDialog(
          elevation: 10,
          title: const Text("Odaberi najdraži jezik"),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "C++");
              },
              child: const Text("C++"),
            ),

            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "Python");
              },
              child: const Text("Python"),
            ),

            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "JavaScript");
              },
              child: const Text("JavaScript"),
            ),

            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "C#");
              },
              child: const Text("C#"),
            ),

            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "Ruby");
              },
              child: const Text("Ruby"),
            ),
          ],
        ),
      );
    }
  );
}

openDialogWithInput(BuildContext context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Ime i prezime"),
      content: const TextField(
        decoration: InputDecoration(
          hintText: "Unesi svoje ime i prezime",
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Podnesi")
        )
      ],
    ),
);

