import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:route_task/app/extenstions.dart';
import 'package:route_task/products/cubit/products_cubit.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductsCubit>().getproducts();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final cubit = context.read<ProductsCubit>();
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            toolbarHeight: height * .15,
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  SvgPicture.asset(
                    'assets/images/route.svg',
                    height: height * .05,
                    width: width * .1,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.teal),
                                borderRadius: BorderRadius.circular(50)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.teal),
                                borderRadius: BorderRadius.circular(50)),
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.teal),
                                borderRadius: BorderRadius.circular(50)),
                            border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.teal),
                                borderRadius: BorderRadius.circular(50)),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.teal,
                            ),
                            hintText: "What do you search for?"),
                      )),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.teal,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
          body: state is LoadGetProductsState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : cubit.products.isEmpty
                  ? const Center(
                      child: Text("No Date"),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: GridView.builder(
                          itemCount: cubit.products.length,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 10,
                                  crossAxisCount: 2,
                                  mainAxisExtent: 265),
                          itemBuilder: (contex, index) => Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.blue.shade300)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: height * .15,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(cubit
                                                  .products[index]
                                                  .thumbnail!))),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Stack(
                                          children: [
                                            PositionedDirectional(
                                              end: 10,
                                              top: 10,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(.5),
                                                          offset: const Offset(
                                                              -1, 2)),
                                                      BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(.5),
                                                          offset: const Offset(
                                                              -2, 1)),
                                                    ]),
                                                child: const Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.teal,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cubit.products[index].title
                                                .orEmpty(),
                                            style: const TextStyle(
                                                color: Colors.teal,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400),
                                            maxLines: 1,
                                          ),
                                          Text(
                                            cubit.products[index].description
                                                .orEmpty(),
                                            style: const TextStyle(
                                                color: Colors.teal,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "EGP ${cubit.products[index].price ?? 0}",
                                                style: const TextStyle(
                                                    color: Colors.teal,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              if (cubit.products[index]
                                                          .discountPercentage !=
                                                      null &&
                                                  cubit.products[index]
                                                          .discountPercentage !=
                                                      0)
                                                Text(
                                                  "EGP ${cubit.products[index].discountPercentage}",
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Review (${cubit.products[index].rating}})",
                                                style: const TextStyle(
                                                    color: Colors.teal,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 20,
                                              ),
                                              const Spacer(),
                                              CircleAvatar(
                                                backgroundColor:
                                                    Colors.blue.shade900,
                                                radius: 15,
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  weight: 500,
                                                  size: 25,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )),
                    ),
        );
      },
    );
  }
}
