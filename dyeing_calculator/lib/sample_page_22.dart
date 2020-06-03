import 'package:dyeingcalculator/material_picker.dart';
import 'package:dyeingcalculator/variable_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class SamplePage22 extends StatefulWidget {
  @override
  _SamplePage22State createState() => _SamplePage22State();
}

class _SamplePage22State extends State<SamplePage22> {
  Color currentColor = Colors.limeAccent;

  void changeColor(Color color) => setState(() => currentColor = color);

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RaisedButton(
              child: Text('이전'),
              onPressed: (){},
            ),
            RaisedButton(
              child: Text('다음'),
              onPressed: (){
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
        children: <Widget>[
          Container(
            child: Column(
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
          ),
          )
        ],
      ),
    );
  }
}
