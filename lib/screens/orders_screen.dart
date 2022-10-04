import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  // const OrdersScreen({ Key? key }) : super(key: key);
  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;
  @override
  // void initState() {
  //   // Future.delayed(Duration.zero).then((_) async {
  //   //   setState(() {
  //   //     _isLoading = true;
  //   //   });
  //   // _isLoading = true;
  //   // Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  //   // setState(() {
  //   //   _isLoading = false;
  //   // });
  //   // });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot == null) {
              return Center(
                child: Text('An error occurred'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, ordersData, child) => ListView.builder(
                  itemBuilder: (ctx, i) => OrderItem(ordersData.orders[i]),
                  itemCount: ordersData.orders.length,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
