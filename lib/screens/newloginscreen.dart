import 'package:flutter/material.dart';
import 'package:mellimeter/components/components.dart';
import 'package:mellimeter/services/auth.dart';
import 'package:mellimeter/widgets/adminButton.dart';
import '../widgets/customLogo.dart';

class NewLoginScreen extends StatefulWidget {
  static const routeName = "/newloginscreen";

  @override
  _NewLoginScreenState createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends State<NewLoginScreen> {
  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final myscaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedRadio;
  bool _isLoading;

  @override
  void initState() {
    _selectedRadio = 1;
    _isLoading = false;
    super.initState();
  }

  bool trySubmut() {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    void setSelectedRadio(val) {
      setState(() {
        _selectedRadio = val;
      });
    }

    String _userEmail = "";
    String _userPassword = "";
    String _userAddress = "";
    String _userName = "";
    int _userNumber = 0;

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: myscaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[100],
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomLogo(),
              SizedBox(
                height: 30,
              ),
              adminSelectButton(
                  title: "تسجيل دخول",
                  fun: setSelectedRadio,
                  radioValue: 1,
                  radioGroupValue: _selectedRadio),
              adminSelectButton(
                  title: "إنشاء حساب",
                  fun: setSelectedRadio,
                  radioValue: 2,
                  radioGroupValue: _selectedRadio),
              adminSelectButton(
                  title: "اشتري بدون إنشاء حساب",
                  fun: setSelectedRadio,
                  radioValue: 3,
                  radioGroupValue: _selectedRadio),
              if (!(_selectedRadio == 3))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      key: Key("email"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (!value.contains("@") || value.length < 8) {
                          return "برجاء إدخال ايميل صحيح";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _userEmail = newValue;
                      },
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          alignLabelWithHint: true,
                          labelText: "الإيميل"),
                    ),
                  ),
                ),
              if (!(_selectedRadio == 3))
                SizedBox(
                  height: size.height * 0.07,
                ),
              if (!(_selectedRadio == 3))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      key: Key("password"),
                      obscureText: true,
                      validator: (value) {
                        if (value.length < 8) {
                          return "كلمة السر التي ادخلتها ضعيفه";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _userPassword = newValue;
                      },
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          alignLabelWithHint: true,
                          labelText: "كلمة السر"),
                    ),
                  ),
                ),
              if (!(_selectedRadio == 3))
                SizedBox(
                  height: size.height * 0.07,
                ),
              if (!(_selectedRadio == 1))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      key: Key("name"),
                      validator: (value) {
                        if (value.length < 4) {
                          return "برجاء إدخال اسم صحيح";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _userName = newValue;
                      },
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          alignLabelWithHint: true,
                          labelText: "الإسم"),
                    ),
                  ),
                ),
              if (!(_selectedRadio == 1))
                SizedBox(
                  height: size.height * 0.07,
                ),
              if (!(_selectedRadio == 1))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      key: Key("mobile"),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value.length < 10 && !value.contains(".")) {
                          return "برجاء إدخال رقم موبيل صحيح";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _userNumber = int.parse(newValue);
                      },
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          alignLabelWithHint: true,
                          labelText: "رقم الموبيل"),
                    ),
                  ),
                ),
              if (!(_selectedRadio == 1))
                SizedBox(
                  height: size.height * 0.07,
                ),
              if (!(_selectedRadio == 1))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      key: Key("address"),
                      keyboardType: TextInputType.streetAddress,
                      validator: (value) {
                        if (value.length < 15) {
                          return "برجاء إدخال عنوان صحيح";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _userAddress = newValue;
                      },
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          alignLabelWithHint: true,
                          labelText: "العنوان"),
                    ),
                  ),
                ),
              if (!(_selectedRadio == 1))
                SizedBox(
                  height: size.height * 0.10,
                ),
              FlatButton(
                height: size.height * 0.07,
                minWidth: size.width * 0.66,
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  trySubmut();
                  if (trySubmut() == true && _selectedRadio == 1) {
                    await FBAuth().signIn(
                        _userEmail, _userPassword, context, myscaffoldKey);
                  } else if (trySubmut() == true && _selectedRadio == 2) {
                    await FBAuth().signUp(
                        _userEmail,
                        _userPassword,
                        _userAddress,
                        _userNumber,
                        _userName,
                        context,
                        myscaffoldKey);
                  } else if (trySubmut() == true && _selectedRadio == 3) {
                    await FBAuth().signInAnonymously(
                        _userName, _userAddress, _userNumber, context);
                  }
                  setState(() {
                    _isLoading = false;
                  });
                },
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        _selectedRadio == 1
                            ? "تسجيل الدخول"
                            : _selectedRadio == 2
                                ? "إنشاء حساب"
                                : "اشتري الآن",
                        style: TextStyle(color: Colors.white),
                      ),
                color: Colors.blue[900],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              AdminButton(),
              SizedBox(
                height: size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
