class GeneralResponseModel {
  late var status;
  late var data;
  late var message;

  GeneralResponseModel();


  GeneralResponseModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = json['data'];
    message = json['message'];
  }


  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data,
    'message': message,
  };
}