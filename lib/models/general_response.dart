

class GeneralResponse{
  int code;
  String message;
  Map? data;

  GeneralResponse({required this.code, required this.message, this.data});

  factory GeneralResponse.wentWrong(){
    return GeneralResponse(code: 0, message: "Something went wrong");
  }
}