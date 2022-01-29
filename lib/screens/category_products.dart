import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/screens/under_maintainence_page.dart';
import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/ui_elements/product_card.dart';
import 'package:active_ecommerce_flutter/repositories/product_repository.dart';
import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toast/toast.dart';

import 'filter.dart';
import 'main.dart';

class CategoryProducts extends StatefulWidget {
  CategoryProducts({Key key, this.category_name, this.category_id, this.show_back_button = true, go_back = false})
      : super(key: key);

  bool show_back_button;
  bool go_back;
  final String category_name;
  final int category_id;

  @override
  _CategoryProductsState createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController _scrollController = ScrollController();
  ScrollController _xcrollController = ScrollController();
  TextEditingController _searchController = TextEditingController();

  List<dynamic> _productList = [];
  bool _isInitial = true;
  int _page = 1;
  String _searchKey = "";
  int _totalData = 0;
  bool _showLoadingContainer = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();

    _xcrollController.addListener(() {
      //print("position: " + _xcrollController.position.pixels.toString());
      //print("max: " + _xcrollController.position.maxScrollExtent.toString());

      if (_xcrollController.position.pixels ==
          _xcrollController.position.maxScrollExtent) {
        setState(() {
          _page++;
        });
        _showLoadingContainer = true;
        fetchData();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    _xcrollController.dispose();
    super.dispose();
  }

  fetchData() async {
    var productResponse = await ProductRepository().getCategoryProducts(
        id: widget.category_id, page: _page, name: _searchKey);
    _productList.addAll(productResponse.products);
    _isInitial = false;
    _totalData = productResponse.meta.total;
    _showLoadingContainer = false;
    setState(() {});
  }

  reset() {
    _productList.clear();
    _isInitial = true;
    _totalData = 0;
    _page = 1;
    _showLoadingContainer = false;
    setState(() {});
  }

  Future<void> _onRefresh() async {
    reset();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = 10;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(statusBarHeight, context),
        body: Stack(
          children: [
            buildProductList(),
            Align(
                alignment: Alignment.bottomCenter,
                child: buildLoadingContainer())
          ],
        ));
  }

  Container buildLoadingContainer() {
    return Container(
      height: _showLoadingContainer ? 36 : 0,
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Text(_totalData == _productList.length
            ? AppLocalizations.of(context).common_no_more_products
            : AppLocalizations.of(context).common_loading_more_products),
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
        child: widget.show_back_button
            ? Builder(
          builder: (context) => IconButton(
              icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
              onPressed: () {
                // if (!widget.go_back) {
                //   return;
                // }
                return Navigator.of(context).pop();
              }),
        )
            : Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 5.0, horizontal: 5.0),
            child: Container(
              child: Image.asset(
                'assets/hamburger.png',
                height: 16,
                //color: MyTheme.dark_grey,
                color: MyTheme.dark_grey,
              ),
            ),
          ),
        ),
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
  buildProductList() {
    if (_isInitial && _productList.length == 0) {
      return SingleChildScrollView(
          child: ShimmerHelper()
              .buildProductGridShimmer(scontroller: _scrollController));
    } else if (_productList.length > 0) {
      return RefreshIndicator(
        color: MyTheme.accent_color,
        backgroundColor: Colors.white,
        displacement: 0,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          controller: _xcrollController,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: GridView.builder(
            // 2
            //addAutomaticKeepAlives: true,
            itemCount: _productList.length,
            controller: _scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                childAspectRatio: 0.618),
            padding: EdgeInsets.all(16),
            //physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              // 3
              return ProductCard(
                  id: _productList[index].id,
                  image: _productList[index].thumbnail_image,
                  name: _productList[index].name,
                  main_price: _productList[index].main_price,
                  stroked_price: _productList[index].stroked_price,
                  has_discount: _productList[index].has_discount);
            },
          ),
        ),
      );
    } else if (_totalData == 0) {
      return Center(
          child: Text(AppLocalizations.of(context).common_no_data_available));
    } else {
      return Container(); // should never be happening
    }
  }
}
