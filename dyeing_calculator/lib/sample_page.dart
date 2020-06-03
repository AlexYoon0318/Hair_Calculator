import 'package:dyeingcalculator/color_table.dart';
import 'package:dyeingcalculator/variable_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';

class SamplePage extends StatefulWidget {
  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  Color currentColor = Colors.grey;
  Color wantedColor = Colors.grey;
  int currentLevel = 14;
  int currentActualLevel = 1;
  int wantedLevel = 14;
  int wantedActualLevel = 1;
  int currentColorLevel = 1;
  int wantedColorLevel = 1;
  int currentValue = 0;
  int wantedValue = 0;
  String currentColorName = '색을 골라주십시오.';
  String wantedColorName = '색을 골라주십시오.';

  void changeColor(Color color) => setState(() => currentColor = color);
  void changeWantedColor(Color color) => setState(() => wantedColor = color);

  void changeLevel(int int) => setState(()=> currentLevel = int);
  void changeWantedLevel(int int) => setState(()=> wantedLevel = int);

  void changeCurrentActualLevel(int int) => setState(()=> currentActualLevel = int);
  void changeWantedActualLevel(int int) => setState(()=> wantedActualLevel = int);

  void changeColorLevel(int int) => setState(()=> currentColorLevel = int);
  void changeWantedColorLevel(int int) => setState(()=> wantedColorLevel = int);

  void changeCurrentColorName(String String) => setState(()=> currentColorName = String);
  void changeWantedColorName(String String) => setState(()=> wantedColorName = String);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('샘플'),
      ),
      body: _buildBody(),
      floatingActionButton:
      Container(
        width: 320,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            /*RaisedButton(
              child: Text('이전'),
              onPressed: (){},
            ),*/
            RaisedButton(
              child: Text('다음'),
              onPressed: (){
                setState(() {
                  _saveColor();
                });
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ThemeConsumer(child: VariablePage()))
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
            child: Column(
              children: <Widget>[
                ///현재색
                Container(
                  width : 242,
                  height: 100,
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
                              child: ColorTable(
                                pickerColor: currentColor,
                                pickerLevel: currentActualLevel,
                                onColorChanged: changeColor,
                                onActualLevelChanged: changeCurrentActualLevel,
                                onColorLevelChanged: changeColorLevel,
                                onColorNameChanged: changeCurrentColorName,
                                onLevelChanged: changeLevel,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('현재색',style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Lv ' + currentActualLevel.toString(),style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            SizedBox(width: 15,),
                            Text(currentColorName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                          ],
                        )
                      ],
                    ),
                    color: currentColor,
                    textColor: useWhiteForeground(currentColor)
                        ? const Color(0xffffffff)
                        : const Color(0xff000000),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Icon(Icons.arrow_downward, size: 40,),
          ),
          ///타겟색
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  width : 242,
                  height: 100,
                  child: RaisedButton(
                    elevation: 3.0,
                    onPressed: () {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              titlePadding: const EdgeInsets.all(0.0),
                              contentPadding: const EdgeInsets.all(0.0),
                              content: SingleChildScrollView(
                                child: ColorTable(
                                  pickerColor: wantedColor,
                                  pickerLevel: wantedActualLevel,
                                  onColorChanged: changeWantedColor,
                                  onActualLevelChanged: changeWantedActualLevel,
                                  onColorLevelChanged: changeWantedColorLevel,
                                  onColorNameChanged: changeWantedColorName,
                                  onLevelChanged: changeWantedLevel,
                                ),
                              ),
                            );
                          },
                        );
                      });
                    },
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('타겟색',style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Lv ' + wantedActualLevel.toString(),style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          SizedBox(width: 15,),
                          Text(wantedColorName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                        ],
                      )
                    ],
                  ),
                    color: wantedColor,
                    textColor: useWhiteForeground(wantedColor)
                        ? const Color(0xffffffff)
                        : const Color(0xff000000),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  void _saveColor() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('Current_ColorName', currentColorName);
    prefs.setString('Wanted_ColorName', wantedColorName);
    prefs.setInt('Current_Color', currentColorLevel);
    prefs.setInt('Wanted_Color', wantedColorLevel);
    prefs.setInt('Current_Level', currentLevel);
    prefs.setInt('Wanted_Level', wantedLevel);
    prefs.setInt('Current_Value', currentValue);
    prefs.setInt('Wanted_Value', wantedValue);
  }

}
