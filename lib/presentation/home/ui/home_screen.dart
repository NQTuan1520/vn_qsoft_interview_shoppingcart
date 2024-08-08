import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vn_qsoft_interview_shoppingcart/managers/routes/route_name.dart';
import 'package:vn_qsoft_interview_shoppingcart/presentation/cart/bloc/cart_bloc.dart';
import 'package:vn_qsoft_interview_shoppingcart/presentation/home/widgets/app_bar_custom_clipper.dart';
import 'package:vn_qsoft_interview_shoppingcart/presentation/home/widgets/item_list_widget.dart';
import 'package:vn_qsoft_interview_shoppingcart/presentation/home/widgets/shimmer_list_widget.dart';

import '../../../managers/utils/enum.dart';
import '../bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
          context.read<HomeBloc>().add(LoadMoreItemsEvent());
        }
      });
    context.read<HomeBloc>().add(LoadItemsEvent());
    context.read<CartBloc>().add(LoadCartEvent());
  }

  Future<void> _onRefresh() async {
    context.read<HomeBloc>().add(RefreshItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 150.h,
        onShoppingPressed: () {
          Navigator.pushNamed(context, RouteName.cart);
        },
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const ShimmerListWidget();
          } else if (state.status == Status.failure) {
            return const Text("Error");
          } else if (state.status == Status.success) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    ItemListWidget(
                      items: state.itemEntity,
                      onAddToCart: (itemQuantityMap) {
                        itemQuantityMap.forEach((item, quantity) {
                          BlocProvider.of<CartBloc>(context).add(AddItemToCartEvent(item: item, quantity));
                        });
                      },
                    ),
                    if (state.hasMoreItems)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
