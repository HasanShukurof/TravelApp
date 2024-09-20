import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:san_travel/screens/payment_method_screen.dart';

class DetailBookingScreen extends StatefulWidget {
  const DetailBookingScreen({super.key});

  @override
  State<DetailBookingScreen> createState() => _DetailBookingScreenState();
}

class _DetailBookingScreenState extends State<DetailBookingScreen> {
  final TextEditingController _guestNameController = TextEditingController();
  final TextEditingController _guestCountController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  String? dropDownValue;
  List<String> listAutoType = ["Sedan", "Minivan"];

  DateTime? startDate;
  DateTime? endDate;

  Future<void> _startDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != startDate)
      setState(() {
        startDate = picked;
      });
  }

  Future<void> _endDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != endDate)
      setState(() {
        endDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Detail Booking",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                            ),
                          ),
                          const Text(
                              "Get the best out of derleng by creating an account"),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            "Guest name",
                            style: TextStyle(fontSize: 13),
                          ),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(17))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 18,
                                top: 8,
                                right: 8,
                                bottom: 8,
                              ),
                              child: TextField(
                                controller: _guestNameController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none, hintText: "John"),
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Guest number",
                            style: TextStyle(fontSize: 13),
                          ),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(17))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 18,
                                top: 8,
                                right: 8,
                                bottom: 8,
                              ),
                              child: TextField(
                                controller: _guestCountController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none, hintText: "3"),
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(17))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                underline: const SizedBox(),
                                isExpanded: true,
                                hint: const Text("Choose auto type"),
                                value: dropDownValue,
                                onChanged: (value) {
                                  setState(() {
                                    if (value != null) {
                                      dropDownValue = value;
                                    }
                                  });
                                },
                                items: listAutoType.map(
                                  (valueItem) {
                                    return DropdownMenuItem<String>(
                                      value: valueItem,
                                      child: Text(
                                        valueItem,
                                        style: TextStyle(),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Phone",
                            style: TextStyle(fontSize: 13),
                          ),
                          Row(
                            children: [
                              Container(
                                height: 60,
                                width: 100,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(17))),
                                child: const Padding(
                                  padding: EdgeInsets.all(18.0),
                                  child: Text(
                                    "+855",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(17))),
                                  child: const Padding(
                                    padding: EdgeInsets.all(18.0),
                                    child: Text(
                                      "123 456 789",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Date (start)",
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Date (end)",
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => _startDate(context),
                                  child: Container(
                                    height: 60, // Yüksekliği ayarladım
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(17)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Text(
                                        startDate != null
                                            ? startDate!
                                                .toLocal()
                                                .toString()
                                                .split(' ')[0]
                                            : DateTime.now()
                                                .toLocal()
                                                .toString()
                                                .split(
                                                    ' ')[0], // Bugünün tarihi
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: startDate == null
                                              ? Colors.grey
                                              : Colors.black, // Hint rengi
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => _endDate(context),
                                  child: Container(
                                    height: 60, // Yüksekliği ayarladım
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(17)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Text(
                                        endDate != null
                                            ? endDate!
                                                .toLocal()
                                                .toString()
                                                .split(' ')[0]
                                            : DateTime.now()
                                                .toLocal()
                                                .toString()
                                                .split(
                                                    ' ')[0], // Bugünün tarihi
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: endDate == null
                                              ? Colors.grey
                                              : Colors.black, // Hint rengi
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: SizedBox(
              height: 100,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 20, top: 20, left: 26, right: 26),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Row(
                          children: [
                            Text(
                              "\$600",
                              style: TextStyle(
                                  color: Color(0XFFF0A7BAB),
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "/Person",
                              style: TextStyle(color: Color(0XFFF0A7BAB)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (dropDownValue != null &&
                                _guestNameController.text.isNotEmpty &&
                                _guestCountController.text.isNotEmpty) {
                              // Tüm gerekli alanlar doldurulmuş, diğer sayfaya geçiş yap
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentMethodScreen(
                                    guestName: _guestNameController.text,
                                    guestCount: _guestCountController.text,
                                    carType: dropDownValue!,
                                    startDate: startDate,
                                    endDate: endDate,
                                  ),
                                ),
                              );
                            } else {
                              // Eksik bilgi var, AlertDialog göster
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Warning'),
                                    content: Text(
                                        'Please fill in all empty fields.'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: const Card(
                            elevation: 2.2,
                            color: Color(0XFFF0FA3E2),
                            child: SizedBox(
                              height: 60,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Next",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
