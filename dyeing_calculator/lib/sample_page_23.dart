import 'package:dyeingcalculator/material_picker.dart';
import 'package:dyeingcalculator/variable_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SamplePage23 extends StatefulWidget {
  @override
  _SamplePage23State createState() => _SamplePage23State();
}

class _SamplePage23State extends State<SamplePage23> {
  var _currentLevel = 1;
  var _wantedLevel = 1;
  var _wantedColor;
  var _currentColor;
  String CurrentColor = '레드';
  String WantedColor = '레드';
  bool lightTheme = true;
  Color currentColor = Colors.limeAccent;
  Color _current_Color = Colors.white;
  Color _wanted_Color = Colors.white;
  Map<String, Color> currentColorMap = {
    '레드' : Colors.red,
    '옐로우' : Colors.yellow,
    '애쉬' : Colors.blueGrey,
    '블루' : Colors.blue,
    '오렌지' : Colors.orange,
    '퍼플' : Colors.purple,
    '카키' : Colors.lightGreen
  };

  void changeColor(Color color) => setState(() => currentColor = color);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('색 정하기'),
      ),
      body: _buildBody(),
      floatingActionButton:
      Container(
        width: 320,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RaisedButton(
              child: Text('이전'),
              onPressed: (){},
            ),
            RaisedButton(
              child: Text('다음'),
              onPressed: (){
                _saveColor();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>VariablePage())
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 242,
            decoration: BoxDecoration(border: Border.all()),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: Text('현재 색'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 100,
                      decoration: BoxDecoration(border: Border.all()),
                      width: 80,
                      child: CircleAvatar(
                        backgroundColor: _current_Color,
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 160,
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 48,
                            width:160,
                            child: RaisedButton(
                              child: Text('Lv $_currentLevel'),
                              onPressed: _showCurrentLevelDialog,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: _current_Color
                            ),
                            alignment: Alignment.center,
                            height: 48,
                            width:160,
                            child: DropdownButton<String>(
                              value: CurrentColor,
                              style: TextStyle(
                                  color: Colors.black
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  CurrentColor = newValue;
                                  if(newValue == '레드'){
                                    _current_Color = Colors.red;
                                    _currentColor = 10;
                                  }
                                  if(newValue == '옐로우'){
                                    _current_Color = Colors.yellow;
                                  }
                                  if(newValue == '애쉬'){
                                    _current_Color = Colors.grey;
                                    _currentColor = 5;
                                  }
                                  if(newValue == '블루'){
                                    _current_Color = Colors.blue;
                                  }
                                  if(newValue == '오렌지'){
                                    _current_Color = Colors.orange;
                                    _currentColor = 7;
                                  }
                                  if(newValue == '퍼플'){
                                    _current_Color = Colors.purple;
                                  }
                                  if(newValue == '브라운'){
                                    _current_Color = Colors.brown;
                                  }
                                });
                              },
                              items: <String>['레드', '옐로우', '애쉬', '블루', '오렌지', '퍼플', '브라운']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }
                              ).toList(),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            child: Icon(Icons.arrow_downward, size: 40,),
          ),
          Container(
            width: 242,
            decoration: BoxDecoration(border: Border.all()),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: Text('타겟 색'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 100,
                      decoration: BoxDecoration(border: Border.all()),
                      width: 80,
                      child: CircleAvatar(
                        backgroundColor: _wanted_Color,
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 160,
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 48,
                            width:160,
                            child: RaisedButton(
                              child: Text('Lv $_wantedLevel'),
                              onPressed: _showWantedLevelDialog,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: _wanted_Color
                            ),
                            alignment: Alignment.center,
                            height: 48,
                            width:160,
                            child: DropdownButton<String>(
                              value: WantedColor,
                              style: TextStyle(
                                  color: Colors.black
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  WantedColor = newValue;
                                  if(newValue == '레드'){
                                    _wanted_Color = Colors.red;
                                    _wantedColor = 10;
                                  }
                                  if(newValue == '옐로우'){
                                    _wanted_Color = Colors.yellow;
                                  }
                                  if(newValue == '애쉬'){
                                    _wanted_Color = Colors.grey;
                                    _currentColor = 5;
                                  }
                                  if(newValue == '블루'){
                                    _wanted_Color = Colors.blue;
                                  }
                                  if(newValue == '오렌지'){
                                    _wanted_Color = Colors.orange;
                                    _wantedColor = 7;
                                  }
                                  if(newValue == '퍼플'){
                                    _wanted_Color = Colors.purple;
                                  }
                                  if(newValue == '브라운'){
                                    _wanted_Color = Colors.brown;
                                  }
                                });
                              },
                              items: <String>['레드', '옐로우', '애쉬', '블루', '오렌지', '퍼플', '브라운']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }
                              ).toList(),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          /*Column(
            children: <Widget>[
              Container(
                width : 242,
                height: 140,
                child: RaisedButton(
                  elevation: 3.0,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          titlePadding: const EdgeInsets.all(0.0),
                          contentPadding: const EdgeInsets.all(0.0),
                          content: SingleChildScrollView(
                            child: CurrentPicker(
                              pickerColor: currentColor,
                              onColorChanged: changeColor,
                              enableLabel: true,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('타겟 컬러'),
                  color: currentColor,
                  textColor: useWhiteForeground(currentColor)
                      ? const Color(0xffffffff)
                      : const Color(0xff000000),
                ),
              )
            ],
          ),*/
          ]
      ),
    );
  }
  void _showCurrentLevelDialog() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return NumberPickerDialog.integer(
            minValue: 1,
            maxValue: 20,
            title: Text("현재 색"),
            initialIntegerValue: _currentLevel,
          );
        }
    ).then((onValue) {
      if (onValue != null) {
        setState(() => _currentLevel = onValue,
        );
      }
    });
  }

  void _showWantedLevelDialog() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return NumberPickerDialog.integer(
            minValue: 1,
            maxValue: 20,
            title: Text("현재 색"),
            initialIntegerValue: _wantedLevel,
          );
        }
    ).then((onValue) {
      if (onValue != null) {
        setState(() => _wantedLevel = onValue,
        );
      }
    });
  }

  void _saveColor() async{
   final prefs = await SharedPreferences.getInstance();
   prefs.setInt('Current_Color', _currentColor);
   prefs.setInt('Wanted_Color', _wantedColor);
   prefs.setInt('Current_Level', _currentLevel);
   prefs.setInt('Wanted_Level', _wantedLevel);
  }




}
