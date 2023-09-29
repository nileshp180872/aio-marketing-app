import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_strings.dart';
import '../../../infrastructure/db/clientdata.dart';

class ClientteleCotroller extends GetxController {
  /// screen title
  RxString screenTitle = AppStrings.clientele.obs;
  List<ClientData> clientList  = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   addClientData();

  }

  void addClientData() {

    ClientData clientMahindra = new ClientData();
    clientMahindra.name="mahindra";
    clientMahindra.logo=ClientAssets.client7;
    clientList.add(clientMahindra);

    ClientData clientTrianz = new ClientData();
    clientTrianz.name="trianz";
    clientTrianz.logo=ClientAssets.client2;
    clientList.add(clientTrianz);

    ClientData clientGacl = new ClientData();
    clientGacl.name="gacl";
    clientGacl.logo=ClientAssets.client3;
    clientList.add(clientGacl);

    ClientData clientKotak = new ClientData();
    clientKotak.name="kotak";
    clientKotak.logo=ClientAssets.client4;
    clientList.add(clientKotak);

    ClientData clientYaskava = new ClientData();
    clientYaskava.name="yaskava";
    clientYaskava.logo=ClientAssets.client5;
    clientList.add(clientYaskava);

    ClientData clientLT = new ClientData();
    clientLT.name="LT";
    clientLT.logo=ClientAssets.client6;
    clientList.add(clientLT);

    ClientData clientOrix = new ClientData();
    clientOrix.name="orix";
    clientOrix.logo=ClientAssets.client1;
    clientList.add(clientOrix);


    ClientData clientPetronas = new ClientData();
    clientPetronas.name="petronas";
    clientPetronas.logo=ClientAssets.client8;
    clientList.add(clientPetronas);

    ClientData clientPuma = new ClientData();
    clientPuma.name="puma";
    clientPuma.logo=ClientAssets.client9;
    clientList.add(clientPuma);

    ClientData clientBirla = new ClientData();
    clientBirla.name="birla";
    clientBirla.logo=ClientAssets.client10;
    clientList.add(clientBirla);

    ClientData clientPeugoet = new ClientData();
    clientPeugoet.name="peugoet";
    clientPeugoet.logo=ClientAssets.client11;
    clientList.add(clientPeugoet);

    ClientData clientTechMahindra = new ClientData();
    clientTechMahindra.name="techmahindra";
    clientTechMahindra.logo=ClientAssets.client12;
    clientList.add(clientTechMahindra);

  }
}