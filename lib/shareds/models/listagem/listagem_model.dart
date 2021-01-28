import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ListagemModel {
  String date;
  int temperatureC;
  int temperatureF;
  String summary;

  ListagemModel();

  ListagemModel.fromJson(Map<String, dynamic> json) {
    this.date = json['date'];
    this.temperatureC = json['temperatureC'];
    this.temperatureF = json['temperatureF'];
    this.summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map();
    data['date'] = this.date;
    data['temperatureC'] = this.temperatureC;
    data['temperatureF'] = this.temperatureF;
    data['summary'] = this.summary;
    return data;
  }
  
  String datePtBr(){
    initializeDateFormatting();
    return DateFormat("dd/MM/yyyy", "PT_BR").format(DateTime.parse(this.date));
  }
}
