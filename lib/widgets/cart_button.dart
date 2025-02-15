import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/shopping_cart/shopping_cart.dart';
import 'package:office_supply_mobile_master/providers/cart.dart';
import 'package:provider/provider.dart';

class CartButton extends StatelessWidget {
  const CartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context, listen: true);

    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.only(
        right: 15,
        bottom: 100,
      ),
      child: Stack(
        children: [
          FloatingActionButton(
            backgroundColor: primaryLightColor,
            child: const Icon(
              CupertinoIcons.shopping_cart,
              size: 20,
              color: primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ShoppingCart(),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.topRight,
            child: CircleAvatar(
              child: Text(
                cartProvider.cart.cartItems.length.toString(),
                style: h6.copyWith(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.red,
              radius: 9,
            ),
          )
        ],
      ),
    );
  }
}
