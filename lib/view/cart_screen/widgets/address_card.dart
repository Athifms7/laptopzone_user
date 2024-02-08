import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laptopzone_user/constants/constants.dart';
import 'package:laptopzone_user/controller/address_controller.dart';
import 'package:laptopzone_user/model/address_model.dart';
import 'package:laptopzone_user/services/address_service.dart';
import 'package:laptopzone_user/view/cart_screen/widgets/address_detail.dart';

class AddressCard extends StatelessWidget {
  final AddressModel address;
  int index;
  int? tappedIndex;

  AddressCard(
      {super.key,
      required this.address,
      required this.index,
      required this.tappedIndex});

  AddressController ad = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          kheight30,
          SizedBox(
            height: 170,
            width: double.infinity,
            child: GetBuilder<AddressController>(
                init: ad,
                builder: (controller) {
                  return Card(
                    color: (index == controller.selectedIdx)
                        ? Colors.grey
                        : kwhite,
                    shadowColor: kblack,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AddAdressWidget(
                                detail:
                                    '${address.name}\n${address.area}\n${address.district}\n${address.state}\n${address.pincode}',
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () async {
                                await AddressServices()
                                    .removeAddress(address: address);
                              },
                              icon: const Icon(
                                Icons.delete,
                               
                              ))
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
