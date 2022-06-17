

import 'package:assengnmentproject/textfieldmodel.dart';
import 'package:flutter/material.dart';

class TodoLists extends StatefulWidget {
  TodoLists({Key? key}) : super(key: key);

  @override
  State<TodoLists> createState() => _TodoListsState();
}

class _TodoListsState extends State<TodoLists> {
  final _formkey = GlobalKey<FormState>();
  List<TextFieldModel> listdata = [];
  TextEditingController _emailTextfield = TextEditingController();
  TextEditingController _numberTextfield = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "TodoListApp",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: Container(
          child: Column(children: [
            emailTextfield(),
            phonenoTextfield(),
            submitButton(context),
            ListviewItems()
          ]),
        ),
      ),
    );
  }

  Expanded ListviewItems() {
    return Expanded(
            child: ListView.builder(
                itemCount: listdata.length,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                    child: Card(
                      color: Colors.grey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                          listdata[index].email,
                          style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              listdata[index].phoneno,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
  }

  Padding submitButton(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: ElevatedButton(
                onPressed: () {
                  final _validate = _formkey.currentState!.validate();
                  if (!_validate) {
                    return;
                  }
                  _formkey.currentState!.save();
                  setState(() {
                    listdata.add(TextFieldModel(
                        _emailTextfield.text, _numberTextfield.text));
                  });
                  _emailTextfield.text = "";
                  _numberTextfield.text = "";
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.black,fontSize: 20),
                    ),
                  ),
                )),
          );
  }

  Padding phonenoTextfield() {
    return Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: TextFormField(
              controller: _numberTextfield,
              validator: (value) {
                if (value!.isEmpty) {
                  return "please enter mobile number";
                } else if (!phonenovalid(value)) {
                  return "please enter valid mobile number";
                } else if (value.length > 10) {
                  return "please enter must be 10 digits mobile number";
                } else {
                  final phoneItems = listdata
                      .where((element) => element.phoneno == value);
                  if (phoneItems.length != 0) {
                    return "This phone number is already exits";
                  }
                  return null;
                }
              },
              decoration: InputDecoration(
                hintText: "EnterNumber",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          );
  }

  Padding emailTextfield() {
    return Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: TextFormField(
              controller: _emailTextfield,
              validator: (email) {
                if (email!.isEmpty) {
                  return "please enter emailid";
                } else if (!emailvalidation(email)) {
                  return "Please enter valid emailid";
                } else {
                  final emailitem = listdata
                      .where((element) => element.email == email);
                  if (emailitem.length != 0) {
                    return "This email is already exits";
                  }
                  return null;
                }
              },
              decoration: InputDecoration(
                hintText: "EnterEmail",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          );
  }

  bool emailvalidation(String email) {
    return RegExp(
            "^[a-zA-Z0-9.a-zA-Z0-9.!#%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool phonenovalid(String value) {
    return RegExp("^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}\$")
        .hasMatch(value);
  }
} 
