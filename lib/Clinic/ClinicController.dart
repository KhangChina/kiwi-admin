import 'package:get/get.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class ClinicController extends GetxController {
  static ClinicController get instance => Get.find();

  final MultiSelectController<String> multiSelectController = MultiSelectController<String>();

  RxList<DropdownItem<String>> itemsProducts = [
    DropdownItem(label: 'Item 1', value: "1"),
    DropdownItem(label: 'Item 2', value: "2"),
    DropdownItem(label: 'Item 3', value: "32"),
  ].obs;

  RxList<String> selectedItems = <String>[].obs;
}
