import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:san_travel/screens/payment_method_screen.dart';

class DetailBookingScreen extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String tourName;
  final dynamic sedanPrice;
  final dynamic minivanPrice;
  final dynamic airportPickUpPrice;

  const DetailBookingScreen({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.tourName,
    required this.sedanPrice,
    required this.minivanPrice,
    required this.airportPickUpPrice,
  });

  @override
  State<DetailBookingScreen> createState() => _DetailBookingScreenState();
}

class _DetailBookingScreenState extends State<DetailBookingScreen> {
  final TextEditingController _guestNameController = TextEditingController();
  final TextEditingController _guestCountController = TextEditingController();
  String? dropDownValue;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  List<String> listAutoType = ["Sedan", "Minivan"];
  bool isCheckedAirportPickUp = false;
  final FocusNode _focusNode = FocusNode();
  final FocusNode _guestCountFocusNode = FocusNode();
  String? _completeNumber;
  TimeOfDay? pickUpTime;
  DateTime? pickUpDate;
  DateTime? startDate;
  DateTime? endDate;
  int? dayDifference;
  int resultAmount = 0;

  void calculate() {
    if (startDate != null && endDate != null) {
      setState(() {
        // Tarihler arasındaki farkı hesapla
        dayDifference = endDate!.difference(startDate!).inDays;

        // Eğer fark 0 ise, en az 1 gün olarak hesapla (isteğe bağlı)
        if (dayDifference == 0) {
          dayDifference = 1;
        }
      });
    }

    int autoTypeValue = 0;
    if (dropDownValue == 'Sedan') {
      autoTypeValue =
          int.tryParse(widget.sedanPrice.toString()) ?? 0; // Dönüşüm eklendi
    } else if (dropDownValue == 'Minivan') {
      autoTypeValue =
          int.tryParse(widget.minivanPrice.toString()) ?? 0; // Dönüşüm eklendi
    } else {
      autoTypeValue = 0;
    }

    // Gün farkı `null` ise hesaplama yapma
    if (dayDifference != null && dayDifference! > 0) {
      resultAmount = autoTypeValue + (dayDifference! * 100);
    } else {
      resultAmount = 0; // Hata durumunda varsayılan bir değer
    }

    setState(() {});
  }

  Future<void> _pickUpTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != pickUpTime) {
      setState(() {
        pickUpTime = picked;
      });
    }
  }

  Future<void> _pickUpDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: pickUpDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        pickUpDate = picked;
      });
    }
  }

  Future<void> _startDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        startDate = picked;
      });
    }
  }

  Future<void> _endDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        endDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // FocusNode'un odak değişikliklerini dinleyin
    _focusNode.addListener(() {
      setState(
          () {}); // Odak değiştiğinde yeniden oluşturma için setState kullanın
    });
    _guestCountFocusNode.addListener(() {
      setState(
          () {}); // Odak değiştiğinde yeniden oluşturma için setState kullanın
    });
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Bellek sızıntılarını önlemek için dispose
    _guestCountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          "Detail Booking",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
      ),
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
                                Radius.circular(17),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 18,
                                top: 8,
                                right: 8,
                                bottom: 8,
                              ),
                              child: TextField(
                                focusNode:
                                    _focusNode, // FocusNode'u TextField'a bağlayın
                                keyboardType: TextInputType.name,
                                controller: _guestNameController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: _focusNode.hasFocus ? '' : "Jone",
                                ),
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Auto type'),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(17))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                underline: const SizedBox(),
                                isExpanded: true,
                                hint: const Text("Choose"),
                                value: dropDownValue,
                                onChanged: (value) {
                                  setState(() {
                                    if (value != null) {
                                      dropDownValue = value;
                                      // Guest count değerini seçime göre güncelle
                                      if (value == 'Sedan') {
                                        _guestCountController.text = '1-3 pax';
                                      } else if (value == 'Minivan') {
                                        _guestCountController.text = '1-7 pax';
                                      }
                                    }
                                  });
                                },
                                items: listAutoType.map((valueItem) {
                                  return DropdownMenuItem<String>(
                                    value: valueItem,
                                    child: Text(
                                      valueItem,
                                      style: const TextStyle(),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Guest count",
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
                                readOnly:
                                    true, // TextField düzenlenemez hale getirildi
                                controller: _guestCountController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "0 pax",
                                ),
                                style: const TextStyle(fontSize: 15),
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
                          IntlPhoneField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Colors.blue), // Focus edildiğinde renk
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .grey.shade300), // Normal durumda renk
                              ),
                            ),
                            style: const TextStyle(fontSize: 15),
                            onChanged: (phoneNumber) {
                              setState(() {
                                _completeNumber = phoneNumber.completeNumber;
                              });
                            },
                          ),
                          Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Color(0XFFF0FA3E2),
                                value: isCheckedAirportPickUp,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isCheckedAirportPickUp = value!;
                                  });
                                },
                              ),
                              const Text("Airport pick-up"),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AnimatedSwitcher(
                            duration: const Duration(
                                milliseconds: 300), // Animasyonun süresi
                            child: isCheckedAirportPickUp
                                ? Column(
                                    key: const ValueKey(
                                        1), // Unique key, animasyon için gerekli
                                    children: [
                                      const Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Date (pick up)",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Time (pick up)",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () => _pickUpDate(context),
                                              child: Container(
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(17)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      18.0),
                                                  child: Text(
                                                    pickUpDate != null
                                                        ? pickUpDate!
                                                            .toLocal()
                                                            .toString()
                                                            .split(' ')[0]
                                                        : DateTime.now()
                                                            .toLocal()
                                                            .toString()
                                                            .split(' ')[0],
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: pickUpDate == null
                                                          ? Colors.grey
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () => _pickUpTime(context),
                                              child: Container(
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(17)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      18.0),
                                                  child: Text(
                                                    pickUpTime != null
                                                        ? pickUpTime!
                                                            .format(context)
                                                        : TimeOfDay.now()
                                                            .format(context),
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: pickUpTime == null
                                                          ? Colors.grey
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(), // Boş görünüm
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Start Date (tour)",
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "End Date (tour)",
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
                          const SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () => calculate(),
                            child: const Card(
                              elevation: 2.2,
                              color: Color(0XFFF0FA3E2),
                              child: SizedBox(
                                height: 60,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Calculate",
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
                          const SizedBox(
                            height: 30,
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
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 10, top: 10, left: 16, right: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          resultAmount != null ? '$resultAmount' : 'N/A',
                          style: const TextStyle(
                              color: Color(0XFFF0A7BAB),
                              fontSize: 21,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "  AZN",
                          style: TextStyle(color: Color(0XFFF0A7BAB)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (_guestNameController.text.isNotEmpty &&
                            _guestCountController.text.isNotEmpty &&
                            dropDownValue != null &&
                            _completeNumber != null &&
                            startDate != null &&
                            endDate != null &&
                            (!isCheckedAirportPickUp ||
                                (pickUpDate != null && pickUpTime != null))) {
                          // Tüm gerekli alanlar doldurulmuş, diğer sayfaya geçiş yap
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentMethodScreen(
                                  guestName: _guestNameController.text,
                                  guestCount: _guestCountController.text,
                                  carType: dropDownValue!,
                                  phoneNumber: _completeNumber!,
                                  isCheckedAirportPickUp:
                                      isCheckedAirportPickUp,
                                  startDate: startDate,
                                  endDate: endDate,
                                  userName: widget.userName,
                                  userEmail: widget.userEmail,
                                  tourName: widget.tourName),
                            ),
                          );
                        } else {
                          // Eksik bilgi var, AlertDialog göster
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Warning'),
                                content: const Text(
                                    'Please fill in all empty fields.'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('OK'),
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
                          height: 50,
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
        ],
      ),
    );
  }
}
