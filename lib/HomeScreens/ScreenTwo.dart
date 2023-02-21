import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:ui' as ui;
import '../Services/apiService.dart';
import '../model/InstallmentConfiguration.dart';
import '../model/viewCarModel.dart';

class screenTwo extends StatefulWidget {
  final String monthlyInstallment;
  final Dataa vehicles;

  const screenTwo({super.key, required this.monthlyInstallment,  required this.vehicles});

  @override
  State<screenTwo> createState() => _screenTwoState(
      monthlyInstallment_: monthlyInstallment, vehicles_: vehicles);
}

final images = [
  "assets/image 4.png",
  "assets/image 4.png",
  "assets/image 4.png",
  "assets/image 4.png"
];

int activeindex = 2;
double _value = 0;
double sliderMin = 0, sliderMax = 100;
ui.Image? overlayimage;

Future<ui.Image> load(String asset) async {
  ByteData data = await rootBundle.load(asset);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
  ui.FrameInfo frameInfo = await codec.getNextFrame();
  return frameInfo.image;
}

class _screenTwoState extends State<screenTwo> {
  bool value = false;

  // List values = [
  //   "interest",
  //   "insurance",
  //   "downpayment",
  //   "lastpayment",
  //   "NoofMonths"
  // ];
  @override
  void initState() {
    load("assets/triangle.png").then((image) {
      setState(() {
        overlayimage = image;
      });
    });
    super.initState();
    initialize();
  }

  final monthlyInstallment_;
  final Dataa vehicles_;

  _screenTwoState({required this.monthlyInstallment_, required this.vehicles_});

  late InstallmentConfig data_;
  late List<Data> dataa = [];
  double installment = 0.0;
  double total = 0.0;
  double no_of_months = 0.0;
  double interest = 0.0;
  double insurence = 0.0;
  double down_payment_percentage = 0.0;
  double last_payment = 0.0;
  double car_price = 0.0;
  List<double> abc = [0.0, 0.0, 0.0, 0.0, 0.0];

  void initialize() async {
    ApiServices.InstallmentConfiguration().then((value) {
      data_ = value;
      dataa = data_.data;
      interest = double.parse(dataa[0].defaultValue);
      insurence = double.parse(dataa[1].defaultValue);
      down_payment_percentage = double.parse(dataa[2].defaultValue);
      last_payment = double.parse(dataa[3].defaultValue);
      no_of_months = double.parse(dataa[4].defaultValue);
      for (int i = 0; i < dataa.length; i++) {
        abc[i] = double.parse(dataa[i].defaultValue);
      }
      car_price = double.parse(monthlyInstallment_);
      calculate(no_of_months, interest, down_payment_percentage, insurence,
          last_payment, car_price);
    });
  }

  void calculate(
    double noOfMonths,
    double interest,
    double downPaymentPercentage,
    double insurance,
    double lastPayment,
    double carPrice,
  ) {
    double monthlyInstallment = ((carPrice -
                (carPrice * (downPaymentPercentage / 100))) +
            (((carPrice - (carPrice * (downPaymentPercentage / 100))) *
                    (interest / 100)) *
                (noOfMonths / 12)) +
            ((carPrice * (insurance / 100)) * (noOfMonths / 12)) -
            (carPrice - (carPrice - (carPrice * (lastPayment / 100))))) /
        (noOfMonths - 1);
    total = (monthlyInstallment * (noOfMonths - 1)) +
        (carPrice - (carPrice - (carPrice * (lastPayment / 100)))) +
        (carPrice * (downPaymentPercentage / 100));
    setState(() {
      total = (monthlyInstallment * (noOfMonths - 1)) +
          (carPrice - (carPrice - (carPrice * (lastPayment / 100)))) +
          (carPrice * (downPaymentPercentage / 100));
      installment = monthlyInstallment;
    });
  }

  Future<void> send() async {
    final Email email = Email(
      body: "",
      subject: "",
      recipients: [""],
      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

  Future<void> _createPDF() async {
    DateTime now = DateTime.now();
    String convertedDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";
    PdfDocument document = PdfDocument();
    document.pageSettings.orientation = PdfPageOrientation.landscape;
    document.pageSettings.margins.all = 50;
    PdfPage page = document.pages.add();
    PdfGraphics graphics = page.graphics;
    ByteData bytes_ = await rootBundle.load('assets/tamweeli_logo-1.png');
    var buffer = bytes_.buffer;
    var m = base64.encode(Uint8List.view(buffer));
    PdfImage image = PdfBitmap.fromBase64String(m);
    graphics.drawImage(image, const Rect.fromLTWH(10, 10, 150, 100));
    PdfBrush solidBrush = PdfSolidBrush(PdfColor(126, 151, 173));
    Rect bounds = Rect.fromLTWH(0, 160, graphics.clientSize.width, 30);
    graphics.drawRectangle(brush: solidBrush, bounds: bounds);
    PdfFont subHeadingFont = PdfStandardFont(PdfFontFamily.timesRoman, 14);
    PdfTextElement element =
        PdfTextElement(text: 'QUOTATION NO 1', font: subHeadingFont);
    element.brush = PdfBrushes.white;
    PdfLayoutResult result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, bounds.top + 8, 0, 0))!;
    String currentDate = 'DATE: $convertedDateTime';
    Size textSize = subHeadingFont.measureString(currentDate);
    Offset textPosition = Offset(
        graphics.clientSize.width - textSize.width - 10, result.bounds.top);
    graphics.drawString(currentDate, subHeadingFont,
        brush: element.brush,
        bounds: Offset(graphics.clientSize.width - textSize.width - 10,
                result.bounds.top) &
            Size(textSize.width + 2, 20));
    element.brush = PdfSolidBrush(PdfColor(126, 155, 203));
    result = element.draw(
        page: page,
        bounds: Rect.fromLTWH(10, result.bounds.bottom + 25, 0, 0))!;
    PdfFont timesRoman = PdfStandardFont(PdfFontFamily.timesRoman, 10);
    element = PdfTextElement(
        text:
            '${vehicles_.year} | ${vehicles_.engineTypeName} | ${vehicles_.bodyTypeName}',
        font: timesRoman);
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page,
        bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0))!;
    element = PdfTextElement(text: '${vehicles_.makeName}', font: timesRoman);
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page,
        bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0))!;
    graphics.drawLine(
        PdfPen(PdfColor(126, 151, 173), width: 0.7),
        Offset(0, result.bounds.bottom + 3),
        Offset(graphics.clientSize.width, result.bounds.bottom + 3));

    PdfGrid grid = PdfGrid();
    grid.columns.add(count: 5);
    grid.headers.add(1);
    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Interest';
    header.cells[1].value = 'Insurance';
    header.cells[2].value = 'Down Payment';
    header.cells[3].value = 'No of Months';
    header.cells[4].value = 'Last Payment';
    PdfGridCellStyle headerStyle = PdfGridCellStyle();
    headerStyle.borders.all = PdfPen(PdfColor(126, 151, 173));
    headerStyle.backgroundBrush = PdfSolidBrush(PdfColor(126, 151, 173));
    headerStyle.textBrush = PdfBrushes.white;
    headerStyle.font = PdfStandardFont(PdfFontFamily.timesRoman, 14,
        style: PdfFontStyle.regular);
    for (int i = 0; i < header.cells.count; i++) {
      if (i == 0 || i == 1) {
        header.cells[i].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.middle);
      } else {
        header.cells[i].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.right,
            lineAlignment: PdfVerticalAlignment.middle);
      }
      header.cells[i].style = headerStyle;
    }
    PdfGridRow row = grid.rows.add();
    row.cells[0].value = interest.toStringAsFixed(2);
    row.cells[1].value = insurence.toStringAsFixed(2);
    row.cells[2].value = down_payment_percentage.toStringAsFixed(2);
    row.cells[3].value = '${no_of_months.toInt()}';
    row.cells[4].value = last_payment.toStringAsFixed(2);
    grid.style.cellPadding = PdfPaddings(left: 2, right: 2, top: 2, bottom: 2);
    PdfGridCellStyle cellStyle = PdfGridCellStyle();
    cellStyle.borders.all = PdfPens.white;
    cellStyle.borders.bottom = PdfPen(PdfColor(217, 217, 217), width: 0.70);
    cellStyle.font = PdfStandardFont(PdfFontFamily.timesRoman, 12);
    cellStyle.textBrush = PdfSolidBrush(PdfColor(131, 130, 136));
    for (int i = 0; i < grid.rows.count; i++) {
      PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        row.cells[j].style = cellStyle;
        if (j == 0 || j == 1) {
          row.cells[j].stringFormat = PdfStringFormat(
              alignment: PdfTextAlignment.left,
              lineAlignment: PdfVerticalAlignment.middle);
        } else {
          row.cells[j].stringFormat = PdfStringFormat(
              alignment: PdfTextAlignment.right,
              lineAlignment: PdfVerticalAlignment.middle);
        }
      }
    }
    PdfLayoutFormat layoutFormat =
        PdfLayoutFormat(layoutType: PdfLayoutType.paginate);
    PdfLayoutResult gridResult = grid.draw(
        page: page,
        bounds: Rect.fromLTWH(0, result.bounds.bottom + 20,
            graphics.clientSize.width, graphics.clientSize.height - 100),
        format: layoutFormat)!;
    gridResult.page.graphics.drawString(
        'Car Value :                             $monthlyInstallment_',
        subHeadingFont,
        brush: PdfSolidBrush(PdfColor(126, 155, 203)),
        bounds: Rect.fromLTWH(520, gridResult.bounds.bottom + 10, 0, 0));
    gridResult.page.graphics.drawString(
        'Total Price :                             ${total.toStringAsFixed(2)}',
        subHeadingFont,
        brush: PdfSolidBrush(PdfColor(126, 155, 203)),
        bounds: Rect.fromLTWH(520, gridResult.bounds.bottom + 30, 0, 0));
    gridResult.page.graphics.drawString('Issued By: Ali Mohd', subHeadingFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(520, gridResult.bounds.bottom + 60, 0, 0));
    gridResult.page.graphics.drawString('Mobile: +966434232', subHeadingFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(520, gridResult.bounds.bottom + 80, 0, 0));
    gridResult.page.graphics.drawString('Tamweelcar.com', subHeadingFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(520, gridResult.bounds.bottom + 100, 0, 0));
    gridResult.page.graphics.drawString(
        'For more Details Download', subHeadingFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(60, gridResult.bounds.bottom + 30, 0, 0));
    gridResult.page.graphics.drawString('Tamweelcar from: ', subHeadingFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(60, gridResult.bounds.bottom + 50, 0, 0));

    Future<List<int>> bytes = document.save();
    List<int> list = await bytes;
    document.dispose();
    bytes.then((result) {
      //saveAndLaunchFile(result, 'car.pdf');
    });
  }

  List controller = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  List<bool?> checkBox = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  bool interestValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: dataa == null
                ? const SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  //Navigator.pushNamed(context, "routeName");
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Transform.translate(
                          offset: const Offset(0, -15),
                          child: Center(
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${vehicles_.makeName}",
                                  style: const TextStyle(
                                      color: Color(0xff4263eb),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("${vehicles_.year}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                        )),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: 11,
                                      width: 1.5,
                                      color: Colors.black54,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text("${vehicles_.bodyTypeName}",
                                        style: const TextStyle(fontSize: 12)),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: 11,
                                      width: 1.5,
                                      color: Colors.black54,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${vehicles_.engineTypeName}",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                CarouselSlider.builder(
                                  itemCount: vehicles_.vehicleImages!.length,
                                  itemBuilder: (BuildContext context, int index,
                                      int realIndex) {
                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            "http://backend.tamweelcar.com/vehicleImages/${vehicles_.vehicleImages![index].fileName}",
                                      ),
                                    );
                                  },
                                  options: CarouselOptions(
                                      onPageChanged: (index, reason) =>
                                          setState(() {
                                            activeindex = index;
                                          }),
                                      viewportFraction: 1,
                                      autoPlay: true,
                                      height: 150
                                  )                                 ,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                AnimatedSmoothIndicator(
                                  activeIndex: activeindex,
                                  count: vehicles_.vehicleImages!.length,
                                  effect: const ScaleEffect(
                                      activeDotColor: Color(0xff4263eb),
                                      dotHeight: 7,
                                      dotWidth: 7),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              color: Color(0xffD2DAFF),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Car Value",
                                  style: TextStyle(
                                      fontSize: 13, color: Color(0xff4263eb)),
                                ),
                                Text(
                                  "Installment",
                                  style: TextStyle(
                                      fontSize: 13, color: Color(0xff4263eb)),
                                ),
                                Text(
                                  "Total Price",
                                  style: TextStyle(
                                      fontSize: 13, color: Color(0xff4263eb)),
                                )
                              ],
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0.0, -6),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Color(0xff4263eb),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        "SAR",
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.white),
                                      ),
                                      Text(
                                        " $monthlyInstallment_",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    installment.toStringAsFixed(2),
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "SAR",
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.white),
                                      ),
                                      Text(
                                        " ${total.toStringAsFixed(2)}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: dataa.length,
                            itemBuilder: (BuildContext context, int index) {
                              _value = double.parse(dataa[index].defaultValue);
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical:15 ),
                                child: SingleChildScrollView(
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    height: 50,
                                    child: Row(
                                      children: [
                                        Column(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  dataa[index].description,
                                                  style: const TextStyle(fontSize: 10,color: Colors.black),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
                                                  return Align(
                                                    alignment: Alignment.topRight,
                                                    child: SizedBox(
                                                      width: 45,
                                                      height: 22,
                                                      child: Transform.scale(
                                                        scale: 1.0,
                                                        child: Switch(
                                                            activeColor: const Color(0xff4263eb),
                                                            value: checkBox[index]!,
                                                            onChanged: (check) {
                                                              setState(() {
                                                                print(checkBox[index].toString());
                                                                checkBox[index] = !checkBox[index]!;
                                                              });
                                                            }),
                                                      ),
                                                    ),
                                                  );
                                                },)

                                              ],
                                            ),
                                            Container(
                                              width: 100,
                                              height: 28,
                                              decoration: const BoxDecoration(
                                                  color: Colors.black12,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(5))),
                                              child: TextField(
                                                enabled: !checkBox[index]!,
                                                controller: controller[index],
                                                onChanged: (value) {
                                                  setState(() {
                                                    abc[index] =
                                                        double.parse(value);
                                                    if (index == 0) {
                                                      controller[index].text =
                                                          abc[index]
                                                              .toStringAsFixed(2);
                                                      interest = abc[index];
                                                    } else if (index == 1) {
                                                      controller[index].text =
                                                          abc[index]
                                                              .toStringAsFixed(2);
                                                      insurence = abc[index];
                                                    } else if (index == 2) {
                                                      controller[index].text =
                                                          abc[index]
                                                              .toStringAsFixed(2);
                                                      down_payment_percentage =
                                                          abc[index];
                                                    } else if (index == 3) {
                                                      controller[index].text =
                                                          abc[index]
                                                              .toStringAsFixed(2);
                                                      last_payment = abc[index];
                                                    } else if (index == 4) {
                                                      controller[index].text =
                                                          abc[index]
                                                              .toStringAsFixed(0);
                                                      no_of_months = abc[index];
                                                    }
                                                  });
                                                  calculate(
                                                      no_of_months,
                                                      interest,
                                                      down_payment_percentage,
                                                      insurence,
                                                      last_payment,
                                                      car_price);
                                                  setState(() {});
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  enabled: false,hintStyle: const TextStyle(      color: Colors.black54,  fontWeight: FontWeight.bold,fontSize: 18), contentPadding: const EdgeInsets.only(
                                                          bottom: 11, left: 20),
                                                  border: InputBorder.none,
                                                  hintText:
                                                      dataa[index].defaultValue,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            overlayimage != null
                                                ? StatefulBuilder(
                                                    builder: (BuildContext
                                                            context,
                                                        void Function(
                                                                void Function())
                                                            setState) {
                                                      return SizedBox(
                                                        height: 30,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            140,
                                                        child: SliderTheme(
                                                          data: SliderThemeData(
                                                            trackHeight: 12,
                                                            inactiveTrackColor:
                                                                Colors.black12,
                                                            activeTickMarkColor:
                                                                const Color(
                                                                    0xff4263eb),
                                                            thumbColor:
                                                                Colors.black,
                                                            thumbShape:
                                                                SliderThumbImage(
                                                                    overlayimage!),
                                                          ),
                                                          child: Slider(
                                                            min: double.parse(
                                                                dataa[index].minValue),
                                                            max: double.parse(
                                                                dataa[index].maxValue),
                                                            value: abc[index],
                                                            onChanged: (val) {
                                                              setState(() {
                                                                abc[index] =
                                                                    val;
                                                                if (index ==
                                                                    0) {
                                                                  controller[
                                                                          index]
                                                                      .text = double
                                                                          .parse(val
                                                                              .toString())
                                                                      .toStringAsFixed(
                                                                          2)
                                                                      .toString();
                                                                  interest =
                                                                      abc[index];
                                                                } else if (index ==
                                                                    1) {
                                                                  controller[
                                                                          index]
                                                                      .text = double
                                                                          .parse(val
                                                                              .toString())
                                                                      .toStringAsFixed(
                                                                          2)
                                                                      .toString();
                                                                  insurence =
                                                                      abc[index];
                                                                } else if (index ==
                                                                    2) {
                                                                  controller[
                                                                          index]
                                                                      .text = double
                                                                          .parse(val
                                                                              .toString())
                                                                      .toStringAsFixed(
                                                                          2)
                                                                      .toString();
                                                                  down_payment_percentage =
                                                                      abc[index];
                                                                } else if (index ==
                                                                    3) {
                                                                  controller[
                                                                          index]
                                                                      .text = double
                                                                          .parse(val
                                                                              .toString())
                                                                      .toStringAsFixed(
                                                                          2)
                                                                      .toString();
                                                                  last_payment =
                                                                      abc[index];
                                                                } else if (index ==
                                                                    4) {
                                                                  controller[
                                                                          index]
                                                                      .text = double
                                                                          .parse(val
                                                                              .toString())
                                                                      .toStringAsFixed(
                                                                          0)
                                                                      .toString();
                                                                  no_of_months =
                                                                      abc[index];
                                                                }
                                                                calculate(
                                                                    no_of_months,
                                                                    interest,
                                                                    down_payment_percentage,
                                                                    insurence,
                                                                    last_payment,
                                                                    car_price);
                                                              });
                                                              controller[index]
                                                                      .text =
                                                                  val.toString();
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : Container(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                    dataa[index].minValue),
                                                const SizedBox(
                                                  width: 100,
                                                ),
                                                Text(
                                                    dataa[index].maxValue),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(0xff4263eb))),
                                onPressed: () async {
                                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => filtersPage()));

                                  //await _createPDF();
                                },
                                child: const Text(
                                  "PDF Download",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(0xff4263eb))),
                                onPressed: () async {
                                  send();
                                },
                                child: const Text(
                                  "Email",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
        ));
  }

  Widget TheBar(thenew) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        //color: Colors.blueGrey,
        height: 50,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dataa[0].description,
                      style: const TextStyle(fontSize: 10, color: Colors.black),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                        width: 10,
                        height: 10,
                        child: Transform.scale(
                          scale: 0.9,
                          child: Switch(
                              //inactiveThumbColor: Colors.black,
                              activeColor: const Color(0xff4263eb),
                              value: thenew,
                              onChanged: (check) {
                                setState(() {
                                  thenew = check;
                                  // print(checkBox[index]);
                                });
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: 100,
                  height: 28,
                  decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: TextField(
                    controller: controller[0],
                    onChanged: (value) {
                      setState(() {
                        // abc[index] = double.parse(value);
                        // if (index == 0) {
                        //   controller[index].text = abc[index].toStringAsFixed(2);
                        //   interest = abc[index];
                        // } else if (index == 1) {
                        //   controller[index].text = abc[index].toStringAsFixed(2);
                        //   insurence = abc[index];
                        // } else if (index == 2) {
                        //   controller[index].text = abc[index].toStringAsFixed(2);
                        //   down_payment_percentage = abc[index];
                        // } else if (index == 3) {
                        //   controller[index].text = abc[index].toStringAsFixed(2);
                        //   last_payment = abc[index];
                        // } else if (index == 4) {
                        //   controller[index].text = abc[index].toStringAsFixed(0);
                        //   no_of_months = abc[index];
                        // }
                      });
                      // calculate(no_of_months, interest, down_payment_percentage, insurence, last_payment, car_price);
                      // setState(() {});
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      enabled: false,
                      hintStyle: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      contentPadding:
                          const EdgeInsets.only(bottom: 11, left: 20),
                      border: InputBorder.none,
                      hintText: dataa[0].defaultValue,
                    ),
                  ),
                ),
              ],
            ),
            Transform.translate(
              offset: const Offset(0, 13),
              child: Column(
                children: [
                  overlayimage != null
                      ? StatefulBuilder(
                          builder: (BuildContext context,
                              void Function(void Function()) setState) {
                            return SizedBox(
                              height: 30,
                              width: MediaQuery.of(context).size.width - 140,
                              child: SliderTheme(
                                data: SliderThemeData(
                                  trackHeight: 12,
                                  inactiveTrackColor: Colors.black12,
                                  activeTickMarkColor: const Color(0xff4263eb),
                                  thumbColor: Colors.black,
                                  thumbShape: SliderThumbImage(overlayimage!),
                                ),
                                child: Slider(
                                  min: double.parse(dataa[0].minValue),
                                  max: double.parse(dataa[0].maxValue),
                                  value: abc[0],
                                  onChanged: (val) {
                                    // setState(() {
                                    //   abc[index] = val;
                                    //   if(index==0){
                                    //     controller[index].text=double.parse(val.toString()).toStringAsFixed(2).toString();
                                    //     interest=abc[index];
                                    //   }else if(index==1){
                                    //     controller[index].text=double.parse(val.toString()).toStringAsFixed(2).toString();
                                    //     insurence=abc[index];
                                    //   }
                                    //   else if(index==2){
                                    //     controller[index].text=double.parse(val.toString()).toStringAsFixed(2).toString();
                                    //     down_payment_percentage=abc[index];
                                    //   }
                                    //   else if(index==3){
                                    //     controller[index].text=double.parse(val.toString()).toStringAsFixed(2).toString();
                                    //     last_payment=abc[index];
                                    //   }
                                    //   else if(index==4){
                                    //     controller[index].text=double.parse(val.toString()).toStringAsFixed(0).toString();
                                    //     no_of_months=abc[index];
                                    //   }
                                    //   calculate(no_of_months, interest, down_payment_percentage, insurence, last_payment, car_price);
                                    // });
                                    controller[0].text = val.toString();
                                  },
                                ),
                              ),
                            );
                          },
                        )
                      : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(dataa[0].minValue),
                      const SizedBox(
                        width: 100,
                      ),
                      Text(dataa[0].maxValue),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget CheckBox(bool) {
    return Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        width: 10,
        height: 10,
        child: Transform.scale(
          scale: 0.9,
          child: Switch(
              //inactiveThumbColor: Colors.black,
              activeColor: const Color(0xff4263eb),
              value: bool,
              onChanged: (check) {
                setState(() {
                  bool = check;
                  print(bool);
                });
              }),
        ),
      ),
    );
  }
}

class SliderThumbImage extends SliderComponentShape {
  final ui.Image image;

  SliderThumbImage(this.image);

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    // TODO: implement getPreferredSize
    return const Size(0, 0);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final canvas = context.canvas;
    final imageWidth = image.width ?? 10;
    final imageHeight = image.height ?? 10;

    Offset imageOffset = Offset(
      center.dx - (imageWidth / 2),
      center.dy - (imageHeight / 2),
    );

    Paint paint = Paint()..filterQuality = FilterQuality.high;

    canvas.drawImage(image, imageOffset, paint);
    // TODO: implement paint
  }
}

// Future<void> createPdftaa() async {
//   PdfDocument document = PdfDocument();
//   final page = document.pages.add();
//   PdfGrid grid = PdfGrid();
//   grid.style = PdfGridStyle(
//       font: PdfStandardFont(PdfFontFamily.helvetica, 30),
//       cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));
//
//   grid.columns.add(count: 4);
//   grid.headers.add(1);
//
//   PdfGridRow header = grid.headers[0];
//   header.cells[0].value = 'Roll No';
//   header.cells[1].value = 'Name';
//   header.cells[2].value = 'Class';
//
//   PdfGridRow row = grid.rows.add();
//   row.cells[0].value = '1';
//   row.cells[1].value = 'Arya';
//   row.cells[2].value = '6';
//
//   row = grid.rows.add();
//   row.cells[0].value = '2';
//   row.cells[1].value = 'John';
//   row.cells[2].value = '9';
//
//   row = grid.rows.add();
//   row.cells[0].value = '3';
//   row.cells[1].value = 'Tony';
//   row.cells[2].value = '8';
//
//   grid.draw(
//       page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));
//   Future<List<int>> bytes = document.save();
//   List<int> list = await bytes;
//   document.dispose();
//   bytes.then((result) {
//     saveAndLaunchFile(result, 'car.pdf');
//   });
// }
Future<Uint8List> _readImageData(String name) async {
  final data = await rootBundle.load('images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
