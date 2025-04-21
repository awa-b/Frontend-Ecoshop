import 'package:http/http.dart' as http;
import '../api/api.dart';

class OrderService {
  Future<http.Response> getHistoriqueCommandes(String tokenAcces) async {
    final response = await http.get(
      Uri.parse(Api.commandes),
      headers: {
        'Authorization': 'Bearer $tokenAcces',
      },
    );
    return response;
  }
}