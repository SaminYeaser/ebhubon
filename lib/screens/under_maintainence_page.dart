import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../my_theme.dart';
import 'filter.dart';
import 'main.dart';

class UnderMaintainencePage extends StatefulWidget {
   UnderMaintainencePage({Key key,this.show_back_button = true, this.go_back = false}) : super(key: key);
  bool show_back_button;
  bool go_back;
  @override
  State<UnderMaintainencePage> createState() => _UnderMaintainencePageState();
}

class _UnderMaintainencePageState extends State<UnderMaintainencePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = 10;
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      appBar: buildAppBar(statusBarHeight, context),
      body: Center(
        child: Text('Under Maintenance!!', style: TextStyle(fontSize: 24),),
      ),
    );
  }

  AppBar buildAppBar(double statusBarHeight, BuildContext context) {
    return AppBar(
      // flexibleSpace: FlexibleSpace(),
      toolbarHeight: 30,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(35),
        child: Padding(
          padding: EdgeInsets.only(bottom: 3, left: 30, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Main()));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.home,color: Colors.red,),
                      Text('Home',style: TextStyle(
                          fontSize: 16
                      ),)
                    ],
                  ),
                ),
              ),
              Container(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UnderMaintainencePage()));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.campaign,color: Colors.red,),
                      Text('Campaign',style: TextStyle(
                          fontSize: 16
                      ),)
                    ],
                  ),
                ),
              ),
              Container(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UnderMaintainencePage()));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.local_offer,color: Colors.red,),
                      Text('Offers',style: TextStyle(
                          fontSize: 16
                      ),)
                    ],
                  ),
                ),
              ),
              Container(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UnderMaintainencePage()));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.video_call,color: Colors.red,),
                      Text('Live',style: TextStyle(
                          fontSize: 16
                      ),)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),

      ),
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
        height: kToolbarHeight +
            statusBarHeight -
            (MediaQuery.of(context).viewPadding.top > 20 ? 10.0 : 10.0),
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

            Container(
              child: Padding(
                  padding: app_language_rtl.$
                      ? const EdgeInsets.only(top: 16.0, bottom: 20, left: 12)
                      : const EdgeInsets.only(top: 16.0, bottom: 20, right: 12),
                  // when notification bell will be shown , the right padding will cease to exist.
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return Filter();
                            }));
                      },
                      child: buildHomeSearchBox(context))),
            ),
          ],
        ),
      ),
      elevation: 0.0,
      titleSpacing: 0,
      actions: <Widget>[
        InkWell(
          onTap: () {
            ToastComponent.showDialog(
                AppLocalizations.of(context).common_coming_soon, context,
                gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
          },
          child: Visibility(
            visible: false,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
              child: Image.asset(
                'assets/bell.png',
                height: 16,
                color: MyTheme.dark_grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildHomeSearchBox(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Filter();
        }));
      },
      autofocus: false,
      // decoration: InputDecoration(
      //     hintText: AppLocalizations.of(context).home_screen_search,
      //     hintStyle: TextStyle(fontSize: 12.0, color: MyTheme.textfield_grey),
      //     enabledBorder: OutlineInputBorder(
      //       borderSide: BorderSide(color: MyTheme.textfield_grey, width: 0.5),
      //       borderRadius: const BorderRadius.all(
      //         const Radius.circular(16.0),
      //       ),
      //     ),
      //     focusedBorder: OutlineInputBorder(
      //       borderSide: BorderSide(color: MyTheme.textfield_grey, width: 1.0),
      //       borderRadius: const BorderRadius.all(
      //         const Radius.circular(16.0),
      //       ),
      //     ),
      //     prefixIcon: Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Icon(
      //         Icons.search,
      //         color: MyTheme.textfield_grey,
      //         size: 20,
      //       ),
      //     ),
      //
      //     icontentPadding: EdgeInsets.all(0.0)),
      icon: Icon(
        Icons.search,
        color: MyTheme.textfield_grey,
        size: 20,
      ),
    );
  }
}
