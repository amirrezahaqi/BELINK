import 'package:flutter/material.dart';
import 'package:html/parser.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';
import 'package:new_started/core/constants/texts/text_constant.dart';

class Applink {
  static String mohammadWbSite =
      "https://dehghanifard.ir/%d8%a2%d9%85%d9%88%d8%b2%d8%b4-%d8%b1%d8%a7%db%8c%da%af%d8%a7%d9%86-%d8%b4%db%8c%d8%a1%da%af%d8%b1%d8%a7-%db%8c%db%8c-%d8%af%d8%b1-%d8%b2%d8%a8%d8%a7%d9%86-%d8%a8%d8%b1%d9%86%d8%a7%d9%85%d9%87-2/";
  static String codYad = "https://codeyad.com/";
}

String title = 'در حال بارگذاری...';
String data = '';

class WebView extends StatefulWidget {
  const WebView({Key? key}) : super(key: key);

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  @override
  void initState() {
    sendRequest(AppTextConstants.mohammadWbSite);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
        ),
      ),
    );
  }

  sendRequest(String url) async {
    // ایجاد یک شیء Client برای ارسال درخواست به آدرس مورد نظر
    Client httpClient = Client();
    final response = await httpClient.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var doc = parse(response.body);
      data = doc.getElementsByTagName("html").toList()[0].outerHtml;
    }
  }
}
