class Failure {
   int code;
   String message;

  Failure( this.code,  this.message);
   factory Failure.fromJson(Map<String, dynamic> apiResponse) {
    return Failure(apiResponse['statusCode'], apiResponse['message']);
  }
}