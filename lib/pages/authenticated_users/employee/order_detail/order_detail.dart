import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/models/company/company.dart';
import 'package:office_supply_mobile_master/models/order_detail_history/order_detail_history.dart';
import 'package:office_supply_mobile_master/models/order_history/order_history.dart';
import 'package:office_supply_mobile_master/models/product_in_menu/product_in_menu.dart';
import 'package:office_supply_mobile_master/models/user/user.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/order_detail/widgets/order_item.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/order_detail/widgets/order_status.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/order_detail/widgets/top_navigation_bar.dart';

class OrderDetail extends StatefulWidget {
  final OrderHistory orderHistory;
  final List<OrderDetailHistory> orderdetailHistory;
  final User userOrder;
  final Company company;

  const OrderDetail({
    Key? key,
    required this.orderHistory,
    required this.orderdetailHistory,
    required this.userOrder,
    required this.company,
  }) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  var totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    for (var e in widget.orderdetailHistory) {
      totalPrice += e.price * e.quantity;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              child: TopNavigationBar(onTapBack: () {
                setState(() {});
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 0, left: 15),
              child: Text(
                'Chi tiết đơn hàng',
                style: h5.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Công ty: ',
                        style: h6.copyWith(
                          color: Colors.black,
                          height: 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.company.name,
                        style: h6.copyWith(
                          color: Colors.black,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Phòng ban: ',
                        style: h6.copyWith(
                          color: Colors.black,
                          height: 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Quản lý',
                        style: h6.copyWith(
                          color: Colors.black,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Mã đơn hàng: ',
                        style: h6.copyWith(
                          color: Colors.black,
                          height: 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '#' + widget.orderHistory.id.toString(),
                        style: h6.copyWith(
                          color: Colors.black,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Người đặt hàng: ',
                        style: h6.copyWith(
                          color: Colors.black,
                          height: 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.userOrder.firstname +
                            ' ' +
                            widget.userOrder.lastname,
                        style: h6.copyWith(
                          color: Colors.black,
                          height: 1.5,
                        ),
                      ),
                      Text(
                        ' (nhân viên)',
                        style: h6.copyWith(
                          color: lightGrey,
                          height: 1.5,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
              child: Text(
                'Trạng thái đơn hàng',
                style: h5.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            OrderStatus(
              doneStep: widget.orderHistory.orderStatusID == 3
                  ? 4
                  : widget.orderHistory.orderStatusID,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 15),
              child: Text(
                'Sản phẩm',
                style: h5.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            //!Have to update
            Expanded(
              flex: 3,
              child: ListView(
                children: widget.orderdetailHistory
                    .asMap()
                    .entries
                    .map((e) => OrderItem(
                          orderDetailHistory: e.value,
                        ))
                    .toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Thời gian đặt hàng: ',
                  style: h6.copyWith(
                    color: Colors.black,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat('kk:mm - dd/MM/yyyy').format(
                    widget.orderHistory.createTime.add(
                      const Duration(hours: 7),
                    ),
                  ),
                  style: h6.copyWith(
                    color: Colors.black,
                    height: 1.5,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Số tiền thanh toán:',
                  style: h6.copyWith(
                    color: Colors.black,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  ProductInMenu.format(price: totalPrice),
                  style: h4.copyWith(
                    height: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      );
}
