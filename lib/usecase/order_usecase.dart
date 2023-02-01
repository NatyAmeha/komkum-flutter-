import 'package:komkum/model/repo/repository.dart';
import 'package:komkum/viewmodel/order_viewmodel.dart';

class OrderUsecase {
  IRepository orderRepo;

  OrderUsecase({required this.orderRepo});

  Future<OrderViewmodel?> getOrderDetails(String orderId) async {
    var orderResult = await orderRepo.get<OrderViewmodel>("/order/$orderId");
    return orderResult;
  }
}
