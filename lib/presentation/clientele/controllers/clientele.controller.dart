import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_strings.dart';
import '../../../infrastructure/db/clientdata.dart';

class ClientteleCotroller extends GetxController {
  /// screen title
  RxString screenTitle = AppStrings.clientele.obs;
  List<ClientData> clientList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    addClientData();
  }

  void addClientData() {
    ClientData clientMahindra = new ClientData();
    clientMahindra.name = "mahindra";
    clientMahindra.logo = ClientAssets.client7;
    clientList.add(clientMahindra);

    ClientData clientTrianz = new ClientData();
    clientTrianz.name = "trianz";
    clientTrianz.logo = ClientAssets.client2;
    clientList.add(clientTrianz);

    ClientData clientGacl = new ClientData();
    clientGacl.name = "gacl";
    clientGacl.logo = ClientAssets.client3;
    clientList.add(clientGacl);

    ClientData clientKotak = new ClientData();
    clientKotak.name = "kotak";
    clientKotak.logo = ClientAssets.client4;
    clientList.add(clientKotak);

    ClientData clientYaskava = new ClientData();
    clientYaskava.name = "yaskava";
    clientYaskava.logo = ClientAssets.client5;
    clientList.add(clientYaskava);

    ClientData clientLT = new ClientData();
    clientLT.name = "LT";
    clientLT.logo = ClientAssets.client6;
    clientList.add(clientLT);

    ClientData clientOrix = new ClientData();
    clientOrix.name = "orix";
    clientOrix.logo = ClientAssets.client1;
    clientList.add(clientOrix);

    ClientData clientPetronas = new ClientData();
    clientPetronas.name = "petronas";
    clientPetronas.logo = ClientAssets.client8;
    clientList.add(clientPetronas);

    clientList.add(ClientData(logo: ClientAssets.client18, name: "adityabirla"));

    ClientData clientBirla = new ClientData();
    clientBirla.name = "birla";
    clientBirla.logo = ClientAssets.client10;
    clientList.add(clientBirla);

    ClientData clientPeugoet = new ClientData();
    clientPeugoet.name = "peugoet";
    clientPeugoet.logo = ClientAssets.client11;
    clientList.add(clientPeugoet);

    ClientData clientTechMahindra = new ClientData();
    clientTechMahindra.name = "techmahindra";
    clientTechMahindra.logo = ClientAssets.client12;
    clientList.add(clientTechMahindra);

    clientList.add(ClientData(logo: ClientAssets.client13, name: "maxlife"));
    clientList.add(ClientData(logo: ClientAssets.client14, name: "ey"));
    clientList.add(ClientData(logo: ClientAssets.client15, name: "magmaHDI"));
    clientList.add(ClientData(logo: ClientAssets.client16, name: "foreglimpse"));
    clientList.add(ClientData(logo: ClientAssets.client17, name: "light"));
    clientList.add(ClientData(logo: ClientAssets.client18, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client19, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client20, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client21, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client22, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client23, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client24, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client25, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client26, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client27, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client28, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client29, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client30, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client31, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client32, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client33, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client34, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client35, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client36, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client37, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client38, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client39, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client40, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client41, name: "puma"));
    clientList.add(ClientData(logo: ClientAssets.client42, name: "puma"));

  }
}
