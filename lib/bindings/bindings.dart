import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:messenger/controller/msg_controller.dart';

class ChatScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(MsgController());
  }
}
