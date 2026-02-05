import 'package:dio/dio.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/infrastructure/models/yes_no_model.dart';

class GetYesNOAnswer {
  final _dio = Dio(BaseOptions(baseUrl: 'https://yes-no-wtf.vercel.app/api'));

  Future<Message> call() async {
    final response = await _dio.get('/');
    final yesNoModel = YesNoModel.fromJsonMap(response.data);

    return yesNoModel.toMessageEntity();
  }
}
