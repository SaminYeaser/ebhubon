import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter/material.dart';

import '../my_theme.dart';

class UnderMaintainencePage extends StatelessWidget {
  const UnderMaintainencePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState.openDrawer();
          },
          child: Builder(
            builder: (context) => IconButton(
                icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
                onPressed: () {
                  // if (!widget.go_back) {
                  //   return;
                  // }
                  return Navigator.of(context).pop();
                }),
          )
        ),
        title: Container(
          height: 20,
          //MediaQuery.of(context).viewPadding.top is the statusbar height, with a notch phone it results almost 50, without a notch it shows 24.0.For safety we have checked if its greater than thirty
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Padding(
                  padding: app_language_rtl.$
                      ? const EdgeInsets.only(top: 14.0, bottom: 14, left: 12)
                      : const EdgeInsets.only(top: 14.0, bottom: 14, right: 12),
                  child: Image.asset('assets/ebhubon.png'),
                ),
              ),
            ],
          ),
        ),
        elevation: 0.0,
        titleSpacing: 0,
        actions: <Widget>[

        ],
      ),
      body: Center(
        child: Text('Under Maintenance!!', style: TextStyle(fontSize: 24),),
      ),
    );
  }
}
