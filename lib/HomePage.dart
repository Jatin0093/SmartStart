import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartstart/file.dart';
import 'package:smartstart/style.dart';

import 'DrawerWidget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
void openHomeDrawer() {
  _HomeState()._openHomeDrawer();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedCategory = 0;
  List<dynamic> selectedCategoryList = chairs;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RawMaterialButton(
              elevation: 5,
              onPressed: () {
                _openHomeDrawer();
              },
              constraints: const BoxConstraints(
                minWidth: 10,
              ),
              child: SvgPicture.asset('assets/images/menu.svg',
                  width: 20, color: Colors.black),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              fillColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: height * 0.02),
          Padding(
            padding: standardPaddingX,
            child: PrimaryText(
                text: 'Discover your best furniture',
                fontWeight: FontWeight.w700,
                size: 36),
          ),
          SizedBox(height: height * 0.03),
          Padding(
            padding: standardPaddingX,
            child: TextField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  contentPadding: const EdgeInsets.all(15),
                  fillColor: Colors.grey[200],
                  filled: true,
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                      fontSize: 18),
                  prefixIcon:
                  const Icon(Icons.search, size: 30, color: Colors.black)),
            ),
          ),
          SizedBox(height: height * 0.03),
          SizedBox(
            height: height * 0.075,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.only(
                  left: index == 0 ? 25 : 0,
                  right: 20,
                ),
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedCategory = index;
                      selectedCategoryList = categories[index]['arrayMappedname'] as List;
                    });
                  },
                  child: PrimaryText(
                    text: categories[index]['label'].toString(),
                    color: selectedCategory == index
                        ? Colors.white
                        : Colors.grey,
                    fontWeight: FontWeight.w500,
                    size: 18,
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                    primary: selectedCategory == index
                        ? Colors.blue
                        : Colors.grey[200],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Padding(
            padding: standardPaddingX,
            child: Row(
              children: [
                PrimaryText(
                    text: 'Popular', fontWeight: FontWeight.w800, size: 28),
                const Spacer(),
                PrimaryText(
                    text: 'View all',
                    color: Colors.blue,
                    fontWeight: FontWeight.w800,
                    size: 20)
              ],
            ),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          Padding(
            padding: standardPaddingX,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                    selectedCategoryList.length,
                        (index) => productCard(
                        context,
                        height,
                        selectedCategoryList[index]["image"],
                        selectedCategoryList[index]["label"],
                        selectedCategoryList[index]["price"]))),
          ),
        ],
      ),
    );
  }

  Widget productCard(
      BuildContext context,var height, String image, String label, String price) {
    return GestureDetector(
      onTap: () {},
      child: Hero(
        tag: image,
        child: Container(
          padding: const EdgeInsets.all(10),
          width: (MediaQuery.of(context).size.width - 80) / 2,
          height: height * 0.3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PrimaryText(
                            text: label, color: Colors.grey, size: 16),
                        const SizedBox(height: 5),
                        PrimaryText(
                            text: price, size: 18, fontWeight: FontWeight.w700),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 0,
                    child: RawMaterialButton(
                        onPressed: () {},
                        elevation: 0,
                        constraints: const BoxConstraints(
                          minWidth: 0,
                        ),
                        shape: const CircleBorder(),
                        fillColor: Colors.blue,
                        padding: const EdgeInsets.all(5),
                        child: const Icon(Icons.add, size: 16, color: Colors.white)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openHomeDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }
}
