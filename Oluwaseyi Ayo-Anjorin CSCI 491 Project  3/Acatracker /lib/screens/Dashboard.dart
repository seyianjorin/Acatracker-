// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors

import 'package:acatracker_homepage/utils/api.dart';
import 'package:acatracker_homepage/widgets/Dashboard_Navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class MyClassApp extends StatefulWidget {
  final String user;
  const MyClassApp(this.user);
  @override
  _MyClassAppState createState() => _MyClassAppState();
}

class _MyClassAppState extends State<MyClassApp> {
  String? selectedClass;

  late Future<List<ClassItem>> myClassItems;
  late Future<List<Class>> myClass;
  int selectedValue = 0;
  TextEditingController? controller;
  TextEditingController? nameController;
  TextEditingController? collabController;
  TextEditingController? roomController;
  TextEditingController? scoreController;
  TextEditingController? statusController;
  TextEditingController? editingController;
  String? startDate = DateTime.now().toString();
  String? endDate = DateTime.now().toString();
  ScrollController? scrollController;
  int average = 0;
  String sortedWith = '';

  @override
  void initState() {
    super.initState();
    myClassItems = getClassItems('');
    myClass = getClass(widget.user);
    controller = TextEditingController();
    nameController = TextEditingController();
    scoreController = TextEditingController();
    collabController = TextEditingController();
    roomController = TextEditingController();
    statusController = TextEditingController();
    editingController = TextEditingController();
    scrollController = ScrollController();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//Open drawer
  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      title: 'Dashboard',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Dashboard_Navbar(
            isFunctional: false,
          ),
        ),

        //Class Drawer starts here
        drawer: Drawer(
          key: _scaffoldKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  children: [
                    Flexible(
                      child: SizedBox(
                        height: 100.0,
                        width: 300.0,
                        child: DrawerHeader(
                          padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
                          margin: EdgeInsets.zero,
                          child: Center(child: Text('My Class')),
                        ),
                      ),
                    ),
                    Flexible(
                      child: FutureBuilder<List<Class>>(
                          future: myClass,
                          builder: (context, snap) {
                            if (snap.hasData) {
                              return ListView.builder(
                                itemCount: snap.data!.length,
                                itemBuilder: (context, index) {
                                  return Material(
                                    key: ValueKey(index),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          myClassItems = getClassItems(snap
                                              .data!
                                              .elementAt(index)
                                              .className);
                                          selectedClass = snap.data!
                                              .elementAt(index)
                                              .className;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Icon(
                                            Icons.book_rounded,
                                            color: Colors.amber[300],
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          SizedBox(
                                            height: 40.0,
                                            child: Center(
                                              child: Text(
                                                snap.data!
                                                    .elementAt(index)
                                                    .className
                                                    .split('_')[1],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (snap.hasError) {
                              return Text('No Class Created Yet');
                            }
                            return CircularProgressIndicator();
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60.0,
                width: 300.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.amber[300],
                  ),
                  child: Text('Add Class'),
                  onPressed: () {
                    setState(() {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Enter the Class name'),
                            content: TextField(
                              controller: controller,
                            ),
                            actions: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.red[300],
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.blue[300],
                                ),
                                onPressed: () async {
                                  await createTable(controller!.text +
                                      "_" +
                                      FirebaseAuth
                                          .instance.currentUser!.email!);
                                  await putClass(
                                      widget.user,
                                      controller!.text +
                                          "_" +
                                          FirebaseAuth
                                              .instance.currentUser!.email!);
                                  Navigator.pop(context);
                                  setState(() {
                                    myClass = getClass(widget.user);
                                  });
                                },
                                child: Text('Create'),
                              ),
                            ],
                          );
                        },
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),

        //Main body section
        body: FutureBuilder<List<ClassItem>>(
            future: myClassItems,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                average = 0;
                for (int i = 0; i < snapshot.data!.length; i++) {
                  average =
                      average + int.parse(snapshot.data!.elementAt(i).score);
                }
                average = (snapshot.data!.isEmpty)
                    ? 0
                    : average ~/ snapshot.data!.length;
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 50.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                Text(
                                  selectedClass!.split('_')[1],
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Average: ' + average.toString(),
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Spacer(),
                            TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.amber[300],
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                              ),
                              onPressed: () {
                                setState(() {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          contentPadding: EdgeInsets.all(20.0),
                                          actionsPadding: EdgeInsets.all(10.0),
                                          title: Text(
                                            'Enter the Class Item Details',
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextField(
                                                  controller: nameController,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'Enter Class item e.g quiz 1',
                                                    focusColor:
                                                        Colors.amber[300],
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                      color: Color(0xffffd54f),
                                                    )),
                                                  ),
                                                  cursorColor:
                                                      Colors.amber[300],
                                                ),
                                                SizedBox(height: 5.0),
                                                TextField(
                                                  controller: collabController,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'Enter Collaborator Name',
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                      color: Color(0xffffd54f),
                                                    )),
                                                  ),
                                                  cursorColor:
                                                      Colors.amber[300],
                                                ),
                                                SizedBox(height: 5.0),
                                                TextField(
                                                  controller: roomController,
                                                  decoration: InputDecoration(
                                                    hintText: 'Enter Room Name',
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                      color: Color(0xffffd54f),
                                                    )),
                                                  ),
                                                  cursorColor:
                                                      Colors.amber[300],
                                                ),
                                                SizedBox(height: 10.0),
                                                Row(
                                                  children: [
                                                    TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        primary:
                                                            Colors.amber[300],
                                                      ),
                                                      onPressed: () async {
                                                        startDate =
                                                            (await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime.now(),
                                                          lastDate:
                                                              DateTime(2096),
                                                        ))
                                                                .toString();
                                                      },
                                                      child: Text(
                                                          'Select Start Date'),
                                                    ),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        primary:
                                                            Colors.amber[300],
                                                      ),
                                                      onPressed: () async {
                                                        endDate =
                                                            (await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime.now(),
                                                          lastDate:
                                                              DateTime(2096),
                                                        ))
                                                                .toString();
                                                      },
                                                      child: Text(
                                                          'Select End Date'),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5.0),
                                                TextField(
                                                  controller: scoreController,
                                                  decoration: InputDecoration(
                                                    hintText: 'Enter Score',
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                      color: Color(0xffffd54f),
                                                    )),
                                                  ),
                                                  cursorColor:
                                                      Colors.amber[300],
                                                ),
                                                SizedBox(height: 5.0),
                                                TextField(
                                                  controller: statusController,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'Enter Current Status',
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                      color: Color(0xffffd54f),
                                                    )),
                                                  ),
                                                  cursorColor:
                                                      Colors.amber[300],
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                primary: Colors.white,
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('Cancel'),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                primary: Colors.amber[300],
                                              ),
                                              onPressed: () async {
                                                print('score controller:' +
                                                    scoreController!.text +
                                                    "0");
                                                await putClassItem(
                                                  selectedClass!,
                                                  name: nameController!.text,
                                                  room: roomController!.text,
                                                  collab:
                                                      collabController!.text,
                                                  startDate: startDate,
                                                  endDate: endDate,
                                                  score: scoreController!
                                                              .text ==
                                                          ''
                                                      ? '0'
                                                      : scoreController!.text,
                                                  status:
                                                      statusController!.text,
                                                );
                                                Navigator.pop(context);
                                                setState(() {
                                                  nameController!.clear();
                                                  collabController!.clear();
                                                  scoreController!.clear();
                                                  statusController!.clear();
                                                  roomController!.clear();
                                                  startDate =
                                                      DateTime.now().toString();
                                                  endDate =
                                                      DateTime.now().toString();
                                                  myClassItems = getClassItems(
                                                      selectedClass!);
                                                });
                                              },
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        );
                                      });
                                });
                              },
                              child: Text('Add Class Record'),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.red,
                              ),
                              onPressed: () async {
                                await deleteTable(selectedClass!);
                                await deleteClass(
                                    't_${FirebaseAuth.instance.currentUser!.email!}',
                                    selectedClass!);
                                setState(() {
                                  selectedClass = '';
                                  myClassItems = getClassItems(selectedClass!);
                                  myClass = getClass(widget.user);
                                });
                              },
                              child: Text('Delete Class'),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Table UI starts here
                    Flexible(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ClassColumn(
                                    text: snapshot.data!
                                        .elementAt(index)
                                        .id
                                        .toString(),
                                    show: index == 0,
                                    columnName: 'ID',
                                    width: 60,
                                    onEditPressed: () {},
                                    isSortedWithThis: sortedWith == 'id',
                                    onColumnTap: (isAsec) {
                                      variable = isAsec ? 'id' : 'id.desc';
                                      setState(() {
                                        sortedWith = 'id';
                                        myClassItems =
                                            getClassItems(selectedClass!);
                                      });
                                    },
                                  ),
                                  ClassColumn(
                                    text: snapshot.data!
                                        .elementAt(index)
                                        .className,
                                    show: index == 0,
                                    columnName: 'Class Item',
                                    width: 150,
                                    isSortedWithThis: sortedWith == 'classitem',
                                    onColumnTap: (isAsec) {
                                      variable = isAsec
                                          ? 'classitem'
                                          : 'classitem.desc';
                                      setState(() {
                                        sortedWith = 'classitem';
                                        myClassItems =
                                            getClassItems(selectedClass!);
                                      });
                                    },
                                    onEditPressed: () {
                                      editField(
                                          context,
                                          snapshot,
                                          index,
                                          'classitem',
                                          snapshot.data!
                                              .elementAt(index)
                                              .className);
                                    },
                                  ),
                                  ClassColumn(
                                    text: snapshot.data!
                                        .elementAt(index)
                                        .collaborators,
                                    show: index == 0,
                                    columnName: 'Collaborators',
                                    width: 170,
                                    isSortedWithThis:
                                        sortedWith == 'collaborators',
                                    onColumnTap: (isAsec) {
                                      variable = isAsec
                                          ? 'collaborators'
                                          : 'collaborators.desc';
                                      setState(() {
                                        sortedWith = 'collaborators';
                                        myClassItems =
                                            getClassItems(selectedClass!);
                                      });
                                    },
                                    onEditPressed: () {
                                      editField(
                                          context,
                                          snapshot,
                                          index,
                                          'collaborators',
                                          snapshot.data!
                                              .elementAt(index)
                                              .collaborators);
                                    },
                                  ),
                                  ClassColumn(
                                    text: snapshot.data!
                                        .elementAt(index)
                                        .classRoom,
                                    show: index == 0,
                                    columnName: 'ClassRoom',
                                    width: 150,
                                    isSortedWithThis: sortedWith == 'classroom',
                                    onColumnTap: (isAsec) {
                                      variable = isAsec
                                          ? 'classroom'
                                          : 'classroom.desc';
                                      setState(() {
                                        sortedWith = 'classroom';
                                        myClassItems =
                                            getClassItems(selectedClass!);
                                      });
                                    },
                                    onEditPressed: () {
                                      editField(
                                          context,
                                          snapshot,
                                          index,
                                          'classroom',
                                          snapshot.data!
                                              .elementAt(index)
                                              .classRoom);
                                    },
                                  ),
                                  ClassColumn(
                                    text: snapshot.data!
                                        .elementAt(index)
                                        .startDate,
                                    show: index == 0,
                                    columnName: 'Start Date',
                                    width: 110,
                                    isSortedWithThis: sortedWith == 'startdate',
                                    onColumnTap: (isAsec) {
                                      variable = isAsec
                                          ? 'startdate'
                                          : 'startdate.desc';
                                      setState(() {
                                        sortedWith = 'startdate';
                                        myClassItems =
                                            getClassItems(selectedClass!);
                                      });
                                    },
                                    onEditPressed: () async {
                                      startDate = (await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2096),
                                      ))
                                          .toString();
                                      await updateClassItem(
                                          selectedClass!,
                                          'startdate',
                                          startDate!,
                                          snapshot.data!.elementAt(index).id);
                                      setState(() {
                                        myClassItems =
                                            getClassItems(selectedClass!);
                                      });
                                    },
                                  ),
                                  ClassColumn(
                                    text:
                                        snapshot.data!.elementAt(index).endDate,
                                    show: index == 0,
                                    columnName: 'End Date',
                                    width: 110,
                                    isSortedWithThis: sortedWith == 'enddate',
                                    onColumnTap: (isAsec) {
                                      variable =
                                          isAsec ? 'enddate' : 'enddate.desc';
                                      setState(() {
                                        sortedWith = 'enddate';
                                        myClassItems =
                                            getClassItems(selectedClass!);
                                      });
                                    },
                                    onEditPressed: () async {
                                      endDate = (await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2096),
                                      ))
                                          .toString();
                                      await updateClassItem(
                                          selectedClass!,
                                          'enddate',
                                          endDate!,
                                          snapshot.data!.elementAt(index).id);
                                      setState(() {
                                        myClassItems =
                                            getClassItems(selectedClass!);
                                      });
                                    },
                                  ),
                                  ClassColumn(
                                    text: snapshot.data!.elementAt(index).score,
                                    show: index == 0,
                                    columnName: 'Score',
                                    width: 80,
                                    isSortedWithThis: sortedWith == 'score',
                                    onColumnTap: (isAsec) {
                                      variable =
                                          isAsec ? 'score' : 'score.desc';
                                      setState(() {
                                        sortedWith = 'score';
                                        myClassItems =
                                            getClassItems(selectedClass!);
                                      });
                                    },
                                    onEditPressed: () {
                                      editField(
                                          context,
                                          snapshot,
                                          index,
                                          'score',
                                          snapshot.data!
                                              .elementAt(index)
                                              .score);
                                    },
                                  ),
                                  ClassColumn(
                                    text:
                                        snapshot.data!.elementAt(index).status,
                                    show: index == 0,
                                    columnName: 'Status',
                                    width: 110,
                                    isSortedWithThis: sortedWith == 'status',
                                    onColumnTap: (isAsec) {
                                      variable =
                                          isAsec ? 'status' : 'status.desc';
                                      setState(() {
                                        sortedWith = 'status';
                                        myClassItems =
                                            getClassItems(selectedClass!);
                                      });
                                    },
                                    onEditPressed: () {
                                      editField(
                                          context,
                                          snapshot,
                                          index,
                                          'status',
                                          snapshot.data!
                                              .elementAt(index)
                                              .status);
                                    },
                                  ),

                                  // Delete Button UI
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: 80,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              color: Colors.white, width: 1.0),
                                          bottom: BorderSide(
                                              color: Colors.white, width: 1.0),
                                          left: BorderSide(
                                              color: Colors.white, width: 0.5),
                                          right: BorderSide(
                                              color: Colors.white, width: 0.5),
                                        ),
                                      ),
                                      height: 50.0,
                                      child: Material(
                                        color: Colors
                                            .transparent, // color of the delete button background
                                        child: InkWell(
                                          onTap: () async {
                                            await deleteClassItem(
                                                selectedClass!,
                                                snapshot.data!
                                                    .elementAt(index)
                                                    .id);
                                            setState(() {
                                              myClassItems =
                                                  getClassItems(selectedClass!);
                                            });
                                          },
                                          child: Icon(Icons.delete_forever),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                      'Welcome! Please select a class to display your class content.',
                      style: TextStyle(fontSize: 25.0)),
                );
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }

//Editing table
  Future<dynamic> editField(
      BuildContext context,
      AsyncSnapshot<List<ClassItem>> snapshot,
      int index,
      String columnName,
      String initialValue) {
    editingController!.text = initialValue;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter the Updated Class Item'),
          content: TextFormField(
            // initialValue: initialValue,
            controller: editingController,
            decoration: InputDecoration(
              hintText: 'Enter update value',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffffd54f),
                ),
              ),
            ),
            cursorColor: Colors.amber[300],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.amber[300],
              ),
              onPressed: () async {
                await updateClassItem(
                    selectedClass!,
                    columnName,
                    editingController!.text,
                    snapshot.data!.elementAt(index).id);

                Navigator.pop(context);
                setState(() {
                  myClassItems = getClassItems(selectedClass!);
                });
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}

//Table UI
class ClassColumn extends StatefulWidget {
  final String text;
  final String columnName;
  final bool show;
  final double width;
  final Function onEditPressed;
  final Function onColumnTap;
  final bool isSortedWithThis;
  const ClassColumn({
    required this.text,
    required this.columnName,
    required this.show,
    required this.width,
    required this.onEditPressed,
    required this.onColumnTap(bool isAsec),
    required this.isSortedWithThis,
  });

  @override
  State<ClassColumn> createState() => _ClassColumnState();
}

class _ClassColumnState extends State<ClassColumn> {
  double opacity = 0.0;
  bool isAsec = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.show
            ? Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    isAsec = !isAsec;
                    widget.onColumnTap(isAsec);
                  },
                  child: Container(
                    width: widget.width,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.white, width: 1.0),
                        bottom: BorderSide(color: Colors.white, width: 1.0),
                        left: BorderSide(color: Colors.white, width: 0.5),
                        right: BorderSide(color: Colors.white, width: 0.5),
                      ),
                    ),
                    height: 50.0,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.columnName,
                          ),
                          widget.isSortedWithThis
                              ? SizedBox(
                                  width: 2.0,
                                )
                              : SizedBox(),
                          widget.isSortedWithThis
                              ? Icon(
                                  isAsec
                                      ? Icons.arrow_upward_rounded
                                      : Icons.arrow_downward_rounded,
                                  size: 16.0,
                                  color: Colors.amber[300],
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox(),

        // Table border Feild UI
        Container(
          width: widget.width,
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              top: BorderSide(color: Colors.white, width: 1.0),
              bottom: BorderSide(color: Colors.white, width: 1.0),
              left: BorderSide(color: Colors.white, width: 0.5),
              right: BorderSide(color: Colors.white, width: 0.5),
            ),
          ),
          height: 50.0,
          child: Stack(
            children: [
              Center(
                child: Text(
                  widget.text,
                ),
              ),
              widget.columnName != 'ID'
                  ? Align(
                      alignment: Alignment(1.0, 0.0),
                      child: MouseRegion(
                        onEnter: (value) {
                          setState(() {
                            opacity = 1.0;
                          });
                        },
                        onExit: (value) {
                          setState(() {
                            opacity = 0.0;
                          });
                        },
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 200),
                          opacity: opacity,
                          child: Container(
                            width: widget.width,
                            color: Colors.amber[300],
                            child: IconButton(
                              onPressed: () {
                                widget.onEditPressed();
                              },
                              icon: Icon(
                                Icons.edit_rounded,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
