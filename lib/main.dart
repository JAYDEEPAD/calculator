
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest Calculator App",
    home: SiForm(),
  ));
}

class SiForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SiFormState();
  }
}

class SiFormState extends State<SiForm> {

  final _formKey=GlobalKey<FormState>();
  var currencies = ['Rupees', 'Pound', 'Dollar'];
  final minimumPadding = 5.0;
  var currentItemSelected='Rupees';

  TextEditingController principalController=TextEditingController();
  TextEditingController roiController=TextEditingController();
  TextEditingController termController=TextEditingController();

  var displayResult="";
  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle=Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Simple Interest Calculator'),
      ),
      body: Form(
        key: _formKey,
        child:Padding(padding: EdgeInsets.all(minimumPadding*2),
        // margin: EdgeInsets.all(minimumPadding * 2),
        child: ListView(
          children: [
            getImageAsset(),
            Padding(
                padding: EdgeInsets.only(
                    top: minimumPadding, bottom: minimumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: principalController,
                  validator: (value){
                        if(value!.isEmpty){
                          return 'Please enter principal Amount';
                        }
                        return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Principal",
                      hintText: "Enter Principal e.g 12000",
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: minimumPadding, bottom: minimumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: roiController,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please Enter Rate Of Interest';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Rate of Interest",
                      hintText: "In Percent",
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),
            Padding(padding: EdgeInsets.only(top: minimumPadding,bottom: minimumPadding),child:Row(
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: termController,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter Terms In Years';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Terms",
                        hintText: "Time In Years",
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Container(width: minimumPadding* 5.0,),
                Expanded(
                    child: DropdownButton<String>(
                  items: currencies.map((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                  value: currentItemSelected,
                  onChanged: (newValue) {
                        dropDown(newValue!);
                  },
                ))
              ],
            )),
            Padding(padding: EdgeInsets.only(top: minimumPadding,bottom: minimumPadding),
              child:Row(children: [
              Expanded(child: OutlinedButton(child: Text("Calculate",style:textStyle,textScaleFactor: 1.2,),
              onPressed: (){
                setState((){
                  if(_formKey.currentState!.validate()) {
                    displayResult = calculateTotal();
                  }
                  });

              }),),
              Expanded(child: ElevatedButton(child: Text("Reset",style: textStyle,textScaleFactor: 1.2,),
                  onPressed: (){
                      setState((){
                        resetAmount();
                      });
                  }),)
            ],),),
            Padding(padding: EdgeInsets.all(minimumPadding*2),
            child: Text(displayResult,style: textStyle,),)

            
          ],
        ),
      )),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = const AssetImage("images/bank.png");
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      margin: EdgeInsets.all(minimumPadding * 10),
      child: image,
    );
  }

  void dropDown(String newValue)
  {
    setState((){
      currentItemSelected=newValue;
    });
  }

  String calculateTotal(){
    double principal=double.parse(principalController.text);
    double roi=double.parse(roiController.text);
    double term=double.parse(termController.text);

    double totalAmountPay=principal+(principal*roi*term)/100;
    String result='After $term years,your investment will be worth $totalAmountPay $currentItemSelected';
    return result;
  }

  void resetAmount(){
    principalController.text="";
    roiController.text="";
    termController.text="";
    displayResult="";

    currentItemSelected=currencies[0];
  }
}
