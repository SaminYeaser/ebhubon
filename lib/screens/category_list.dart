import 'package:active_ecommerce_flutter/screens/under_maintainence_page.dart';
import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/ui_sections/drawer.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:toast/toast.dart';
import 'package:active_ecommerce_flutter/screens/category_products.dart';
import 'package:active_ecommerce_flutter/repositories/category_repository.dart';
import 'package:shimmer/shimmer.dart';
import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'filter.dart';
import 'main.dart';

class CategoryList extends StatefulWidget {
  CategoryList(
      {Key key,
      this.parent_category_id = 0,
      this.parent_category_name = "",
      this.is_base_category = false,
      this.is_top_category = false,
        this.show_back_button = true, go_back = false})
      : super(key: key);

  final int parent_category_id;
  final String parent_category_name;
  final bool is_base_category;
  final bool is_top_category;
  bool show_back_button;
  bool go_back;

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = 10;
     return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          key: _scaffoldKey,
          drawer: MainDrawer(),
          backgroundColor: Colors.white,
          appBar: buildAppBar(statusBarHeight, context),
          body: Stack(children: [
            CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildListDelegate([
                  buildCategoryList(),
                  Container(
                    height: widget.is_base_category ? 60 : 90,
                  )
                ]))
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: widget.is_base_category || widget.is_top_category
                  ? Container(
                      height: 0,
                    )
                  : buildBottomContainer(),
            )
          ])),
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

      leading: !widget.is_base_category ? GestureDetector(
        onTap: () {
          _scaffoldKey.currentState.openDrawer();
        },
        child:Builder(
          builder: (context) => IconButton(
              icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
              onPressed: () {
                return Navigator.of(context).pop();
              }),
        )
      ) : Container(),
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

  String getAppBarTitle() {
    String name = widget.parent_category_name == ""
        ? (widget.is_top_category ? AppLocalizations.of(context).category_list_screen_top_categories : AppLocalizations.of(context).category_list_screen_categories)
        : widget.parent_category_name;

    return name;
  }

  buildCategoryList() {
    var future = widget.is_top_category
        ? CategoryRepository().getTopCategories()
        : CategoryRepository()
            .getCategories(parent_id: widget.parent_category_id);
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            //snapshot.hasError
            print("category list error");
            print(snapshot.error.toString());
            return Container(
              height: 10,
            );
          } else if (snapshot.hasData) {
            //snapshot.hasData
            var categoryResponse = snapshot.data;
            return SingleChildScrollView(
              child: ListView.builder(
                itemCount: categoryResponse.categories.length,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 4.0, left: 16.0, right: 16.0),
                    child: buildCategoryItemCard(categoryResponse, index),
                  );
                },
              ),
            );
          } else {
            return SingleChildScrollView(
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 4.0, left: 16.0, right: 16.0),
                    child: Row(
                      children: [
                        Shimmer.fromColors(
                          baseColor: MyTheme.shimmer_base,
                          highlightColor: MyTheme.shimmer_highlighted,
                          child: Container(
                            height: 60,
                            width: 60,
                            color: Colors.white,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, bottom: 8.0),
                              child: Shimmer.fromColors(
                                baseColor: MyTheme.shimmer_base,
                                highlightColor: MyTheme.shimmer_highlighted,
                                child: Container(
                                  height: 20,
                                  width: MediaQuery.of(context).size.width * .7,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Shimmer.fromColors(
                                baseColor: MyTheme.shimmer_base,
                                highlightColor: MyTheme.shimmer_highlighted,
                                child: Container(
                                  height: 20,
                                  width: MediaQuery.of(context).size.width * .5,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        });
  }

  Card buildCategoryItemCard(categoryResponse, index) {
    return Card(
      shape: RoundedRectangleBorder(
        side: new BorderSide(color: MyTheme.light_grey, width: 1.0),
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Container(
            width: 80,
            height: 80,
            child: ClipRRect(
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(16), right: Radius.zero),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/placeholder.png',
                  image: AppConfig.BASE_PATH +
                      categoryResponse.categories[index].banner,
                  fit: BoxFit.cover,
                ))),
        Container(
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 8, 0),
                child: Text(
                  categoryResponse.categories[index].name,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: MyTheme.font_grey,
                      fontSize: 14,
                      height: 1.6,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(32, 8, 8, 4),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (categoryResponse
                                .categories[index].number_of_children >
                            0) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CategoryList(
                              parent_category_id:
                                  categoryResponse.categories[index].id,
                              parent_category_name:
                                  categoryResponse.categories[index].name,
                            );
                          }));
                        } else {
                          ToastComponent.showDialog(
                              AppLocalizations.of(context).category_list_screen_no_subcategories, context,
                              gravity: Toast.CENTER,
                              duration: Toast.LENGTH_LONG);
                        }
                      },
                      child: Text(
                        AppLocalizations.of(context).category_list_screen_view_subcategories,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: categoryResponse
                                        .categories[index].number_of_children >
                                    0
                                ? MyTheme.medium_grey
                                : MyTheme.light_grey,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                    Text(
                      " | ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: MyTheme.medium_grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CategoryProducts(
                            category_id: categoryResponse.categories[index].id,
                            category_name:
                                categoryResponse.categories[index].name,
                          );
                        }));
                      },
                      child: Text(
                        AppLocalizations.of(context).category_list_screen_view_products,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: MyTheme.medium_grey,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Container buildBottomContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),

      height: widget.is_base_category ? 0 : 80,
      //color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: (MediaQuery.of(context).size.width - 32),
                height: 40,
                child: FlatButton(
                  minWidth: MediaQuery.of(context).size.width,
                  //height: 50,
                  color: MyTheme.accent_color,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0))),
                  child: Text(
                    AppLocalizations.of(context).category_list_screen_all_products_of + " " + widget.parent_category_name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CategoryProducts(
                        category_id: widget.parent_category_id,
                        category_name: widget.parent_category_name,
                      );
                    }));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
