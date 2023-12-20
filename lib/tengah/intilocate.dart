import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'dart:math' as Math;
import '/consts.dart';
import 'package:url_launcher/url_launcher.dart';

class HalamanLocate extends StatefulWidget {
  const HalamanLocate({Key? key});

  @override
  State<HalamanLocate> createState() => _HalamanLocateState();
}

class _HalamanLocateState extends State<HalamanLocate> {
  Location _locationController = Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _pMcDonaldPlex = LatLng(1.121306, 104.049888);
  static const LatLng _pPoltekPlex = LatLng(1.118646, 104.048462);
  LatLng? _currentP;
  List<LatLng> _polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  List<Marker> _markers = [];
  String _selectedPlaceType = 'Rumah Sakit'; // Default selection
  List<Map<String, dynamic>> _RumahSakitList = [];
  List<Map<String, dynamic>> _clinicList = [];
  List<Map<String, dynamic>> _healthCenterList = [];

  @override
  void initState() {
    super.initState();
    getLocationUpdates().then(
      (_) {
        getPolylinePoints().then((coordinates) {
          setState(() {
            _polylineCoordinates = coordinates;
          });
          generatePolylineFromPoints();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;

    final bodyHeight = mediaQueryHeight;
    return Scaffold(
      body: Column(
        children: [
          /////////////////////////////////////////////////////////  Header  //////////////////////////////////////////////////////////
          Container(
            padding: const EdgeInsets.only(top: 70, left: 20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(64, 158, 158, 158),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(4, 4))
                ]),
            height: bodyHeight * 0.14,
            width: double.infinity,
            child: const Text(
              'Cari Fasilitas Kesehatan',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                  color: Colors.black),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(15),
            height: bodyHeight * 0.2,
            child: _currentP == null
                ? const Center(
                    child: Text("Loading..."),
                  )
                : GoogleMap(
                    onMapCreated: ((GoogleMapController controller) =>
                        _mapController.complete(controller)),
                    initialCameraPosition: const CameraPosition(
                      target: _pMcDonaldPlex,
                      zoom: 10,
                    ),
                    markers: Set<Marker>.of(_markers),
                    polylines: Set<Polyline>.of(polylines.values),
                  ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
            decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: _selectedPlaceType,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPlaceType = newValue!;
                    updateMarkers();
                  });
                },
                items: ['Rumah Sakit', 'Klinik', 'Puskesmas']
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 15),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 0),
              itemCount: _selectedPlaceType == 'Rumah Sakit'
                  ? _RumahSakitList.length
                  : (_selectedPlaceType == 'Klinik'
                      ? _clinicList.length
                      : _healthCenterList.length),
              itemBuilder: (context, index) {
                final List<Map<String, dynamic>> selectedList =
                    _selectedPlaceType == 'Rumah Sakit'
                        ? _RumahSakitList
                        : (_selectedPlaceType == 'Klinik'
                            ? _clinicList
                            : _healthCenterList);
                return ListTile(
                  title: Container(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(10)),
                            color: Color.fromARGB(255, 2, 128, 144),
                          ),
                          child: Text(
                            selectedList[index]['name'],
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins',
                                color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 2, 128, 144)),
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(10))),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(
                                    10), // Use padding instead of margin
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Color.fromARGB(255, 2, 128, 144),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                          selectedList[index]['address'] ?? '',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 5, 20, 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${selectedList[index]['distance']} KM',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                    Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 2, 128, 144),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Color.fromARGB(33, 0, 0, 0),
                                              blurRadius: 2,
                                              spreadRadius: 1,
                                              offset: Offset(1, 1))
                                        ],
                                      ),
                                      child: MaterialButton(
                                        onPressed: () {
                                          _onFollowButtonPressed(
                                              selectedList[index]);
                                        },
                                        child: Text(
                                          'Ikuti',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _navigateToSelectedPlace(LatLng selectedPlacePosition) async {
    final GoogleMapController controller = await _mapController.future;

    CameraPosition _newCameraPosition = CameraPosition(
      target: selectedPlacePosition,
      zoom: 10,
    );

    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );

    // Tambahkan ini untuk membuka Google Maps dengan rute
    await _launchGoogleMaps(selectedPlacePosition);
  }

  void _cameraToPosition(LatLng target) async {
    final GoogleMapController controller = await _mapController.future;

    CameraPosition newPosition = CameraPosition(target: target, zoom: 10);

    controller.animateCamera(CameraUpdate.newCameraPosition(newPosition));
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentP!);
          updateMarkers();
        });
      }
    });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY,
      PointLatLng(_pMcDonaldPlex.latitude, _pMcDonaldPlex.longitude),
      PointLatLng(_pPoltekPlex.latitude, _pPoltekPlex.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void generatePolylineFromPoints() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.black,
      points: _polylineCoordinates,
      width: 8,
    );

    setState(() {
      polylines[id] = polyline;
    });
  }

  void updateMarkers() async {
    _markers.clear();

    if (_currentP != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId("_currentLocation"),
          icon: BitmapDescriptor.defaultMarker,
          position: _currentP!,
        ),
      );
    }

    //RumahSakit
    if (_selectedPlaceType == 'Rumah Sakit') {
      final bitmapDescriptor = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(devicePixelRatio: 2.5),
          'img/icon/hijau.png');
      _markers.addAll([
        Marker(
          markerId: const MarkerId("Rumah Sakit Awal Bros Botania"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1069512, 104.0891856),
          infoWindow: const InfoWindow(
            title: "Rumah Sakit Awal Bros Botania",
            snippet:
                "Jl. Raja Ali Kelana, Desa/Kelurahan Belian, Kec. Batam Kota, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Rumah Sakit Badan Pengusahaan Batam"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1298738, 103.9289702),
          infoWindow: const InfoWindow(
            title: "Rumah Sakit Badan Pengusahaan Batam",
            snippet:
                "Jl. Dr. Ciptomangunkusumo No.1, Tj. Pinggir, Kec. Sekupang, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Rumah Sakit Bhayangkara Polda Kepri"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1438439, 104.1158414),
          infoWindow: const InfoWindow(
            title: "Rumah Sakit Bhayangkara Polda Kepri",
            snippet:
                "Jl. Dang Merdu No.KM. 2, Batu Besar, Kecamatan Nongsa, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Rumah Sakit Hj. Bunda Halimah"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1069272, 104.0805531),
          infoWindow: const InfoWindow(
            title: "Rumah Sakit Hj. Bunda Halimah",
            snippet:
                "Jl.Uniba no.A09, Kawasan Uniba Batam Center, Belian, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Rumah Sakit Ibu dan Anak Griya Medika"),
          icon: bitmapDescriptor,
          position: const LatLng(1.124857, 104.026869),
          infoWindow: const InfoWindow(
            title: "Rumah Sakit Ibu dan Anak Griya Medika",
            snippet:
                "Komplek Mega Indah Blok A 3-4 & B 1-4, Jl. Laksamana Bintan, Sungai Panas, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Rumah Sakit Ibu dan Anak Frisdhy Angel"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1371884, 104.0160629),
          infoWindow: const InfoWindow(
            title: "Rumah Sakit Ibu dan Anak Frisdhy Angel",
            snippet:
                "B, Jl. Raden Patah No.1-3, Lubuk Baja Kota, Kec. Lubuk Baja, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Rumah Sakit Ibu dan Anak Kasih Sayang Ibu"),
          icon: bitmapDescriptor,
          position: const LatLng(1.0470197, 103.9667163),
          infoWindow: const InfoWindow(
            title: "Rumah Sakit Ibu dan Anak Kasih Sayang Ibu",
            snippet: "Blk. B1 No.11, Buliang, Kec. Batu Aji, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Rumah Sakit Ibu dan Anak Mutiara Aini"),
          icon: bitmapDescriptor,
          position: const LatLng(1.0521388, 103.9751502),
          infoWindow: const InfoWindow(
            title: "Rumah Sakit Ibu dan Anak Mutiara Aini",
            snippet:
                "Jalan Batu Aji 2 Blok A No.1, Buliang, Kec. Batu Aji, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Rumah Sakit Jasmin Batam"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1151554, 104.0939007),
          infoWindow: const InfoWindow(
            title: "Rumah Sakit Jasmin Batam",
            snippet:
                "no.5_11, Jl. Raja M. Saleh komplek duta raya, Belian, Kec. Batam Kota, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Rumah Sakit Keluarga Husada"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1281658, 104.0989972),
          infoWindow: const InfoWindow(
            title: "Rumah Sakit Keluarga Husada",
            snippet:
                "Komplek rukomas Odessa, Jl. Tengku Sulung, Belian, Kec. Batam Kota, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Rumah Sakit St. Elisabeth Sei Lekop"),
          icon: bitmapDescriptor,
          position: const LatLng(1.0236441, 103.9434391),
          infoWindow: const InfoWindow(
            title: "Rumah Sakit St. Elisabeth Sei Lekop",
            snippet:
                "Jl. Utama Sei Binti, Sungai Lekop, Kec. Sagulung, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Rumah Sakit Awal Bros Batam"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1236007, 104.013993),
          infoWindow: const InfoWindow(
            title: "Rumah Sakit Awal Bros Batam",
            snippet:
                "Jl. Gajah Mada No.Kav. 1, Baloi Indah, Kec. Lubuk Baja, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Rumah Sakit Budi Kemuliaan"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1477964, 104.0162367),
          infoWindow: const InfoWindow(
            title: "Rumah Sakit Budi Kemuliaan",
            snippet:
                "Jl. Budi Kemuliaan No.1, Kp. Seraya, Kec. Lubuk Baja, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Rumah Sakit Camatha Sahidya"),
          icon: bitmapDescriptor,
          position: const LatLng(1.0737913, 104.0148928),
          infoWindow: const InfoWindow(
            title: "Rumah Sakit Camatha Sahidya",
            snippet:
                "Jalan Jendral Ahmad Yani No. 8 Kelurahan Muka Kuning, Kec. Sei Beduk, Kota Batam,",
          ),
        ),
        Marker(
          markerId: const MarkerId("Rumah Sakit Charis Medika Batam"),
          icon: bitmapDescriptor,
          position: const LatLng(1.056253, 103.9614347),
          infoWindow: const InfoWindow(
            title: "Rumah Sakit Charis Medika Batam",
            snippet:
                "Komp, Blk. D, Jl. Muka Kuning Paradise No.1, Bukit Tempayan, Kec. Batu Aji, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Rumah Sakit Umum Daerah Embung Fatimah"),
          icon: bitmapDescriptor,
          position: const LatLng(1.050374, 103.9650712),
          infoWindow: const InfoWindow(
            title: "Rumah Sakit Umum Daerah Embung Fatimah",
            snippet:
                "Blk. D1, Jalan Letjen R. Suprapto No.9, Bukit Tempayan, Kec. Batu Aji, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Rumah Sakit Graha Hermine"),
          icon: bitmapDescriptor,
          position: const LatLng(1.0455771, 103.9708592),
          infoWindow: const InfoWindow(
            title: "Rumah Sakit Graha Hermine",
            snippet:
                "Komp. Ruko Asih Raya, Blok B Jl. Letjend Suprapto No.6 - 15, Buliang, Kec. Batu Aji, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Rumah Sakit Umum Harapan Bunda"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1477646, 104.0136497),
          infoWindow: const InfoWindow(
            title: "Rumah Sakit Umum Harapan Bunda",
            snippet:
                "Jalan Seraya No.1, Kp. Seraya, Kec. Batu Ampar, Kota Batam",
          ),
        ),
        Marker(
          markerId:
              const MarkerId("Rumah Sakit Umum Santa Elisabeth Lubuk Baja"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1357372, 104.0126974),
          infoWindow: const InfoWindow(
            title: "Rumah Sakit Umum Santa Elisabeth Lubuk Baja",
            snippet:
                "Jl. Anggrek, Lubuk Baja Kota, Kec. Lubuk Baja, Kota Batam",
          ),
        ),
        Marker(
          markerId:
              const MarkerId("Rumah Sakit Umum Santa Elisabeth Batam Kota"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1071979, 104.077278),
          infoWindow: const InfoWindow(
            title: "Rumah Sakit Umum Santa Elisabeth Batam Kota",
            snippet: "Jl. Raja Alikelana, Belian, Kec. Batam Kota, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Rumah Sakit Umum Soedarsono Darmosoewito"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1204674, 104.1381889),
          infoWindow: const InfoWindow(
            title: "Rumah Sakit Umum Soedarsono Darmosoewito",
            snippet:
                "Jalan Hang Kasturi II KM 4.5 Kabil, Batu Besar, Kecamatan Nongsa, Kota Batam",
          ),
        ),
      ]);

      //Clinic
    } else if (_selectedPlaceType == 'Klinik') {
      final bitmapDescriptor = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(devicePixelRatio: 2.5), 'img/icon/biru.png');
      _markers.addAll([
        Marker(
          markerId:
              const MarkerId("Politeknik Negeri Batam - Unit Kesehatan Kampus"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1186351, 104.045887),
          infoWindow: const InfoWindow(
            title: "Politeknik Negeri Batam - Unit Kesehatan Kampus",
            snippet:
                "Batam Centre, Jl. Ahmad Yani, Tlk. Tering, Kec. Batam Kota, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Klinik & Apotek Utama Panacea"),
          icon: bitmapDescriptor,
          position: const LatLng(1.109136, 103.9596002),
          infoWindow: const InfoWindow(
            title: "Klinik & Apotek Utama Panacea",
            snippet:
                "Tiban Bukit Asri Blok A No 1, RW.4, Tiban Baru, Kec. Sekupang, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Klinik Ad Medicine"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1210988, 103.9788122),
          infoWindow: const InfoWindow(
            title: "Klinik Ad Medicine",
            snippet:
                "Komplek Tiban Mas Indah Blok A1 No.3a&5 Tiban Indah Kec. Sekupang, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId(
              "Klinik Utama dan Laboratorium Batam Sentra Diagnostika"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1110292, 103.9731136),
          infoWindow: const InfoWindow(
            title: "Klinik Utama dan Laboratorium Batam Sentra Diagnostika",
            snippet:
                "Ruko Tiban Sakura Blok A, Tiban Lama, Kec. Sekupang, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("JiRa Dental Care"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1125343, 103.9719933),
          infoWindow: const InfoWindow(
            title: "JiRa Dental Care",
            snippet: "Patam Lestari, Kec. Sekupang, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Klinik Batam Medical Centre"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1388776, 104.0128016),
          infoWindow: const InfoWindow(
            title: "Klinik Batam Medical Centre",
            snippet:
                "Komp. Libra Centre, Jl. Raden Patah, Lubuk Baja Kota, Lubuk Baja, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Klinik Utama Promed"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1372084, 104.0135043),
          infoWindow: const InfoWindow(
            title: "Klinik Utama Promed",
            snippet:
                "Jl. Raden Patah No.1, RW.3, Lubuk Baja Kota, Kec. Lubuk Baja, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Klinik Oto Medika"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1350603, 103.9996706),
          infoWindow: const InfoWindow(
            title: "Klinik Oto Medika",
            snippet:
                "Ujung, Jl. Bunga Raya No.86, Baloi Indah, Lubuk Baja, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Zio Clinic Occupational Helath & Medicine"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1605435, 104.0155023),
          infoWindow: const InfoWindow(
            title: "Zio Clinic Occupational Helath & Medicine",
            snippet:
                "Komplek Ruko Garama Citra Hill blok R No. Soedarso, Jl. Yos Sudarso No.17, Sei Panas , Batu Ampar, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Klinik Utama Anakita@NSD"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1246085, 104.0212419),
          infoWindow: const InfoWindow(
            title: "Klinik Utama Anakita@NSD",
            snippet:
                "Business Center, Ruko Jl. Orchid Park, Taman Baloi, Kec. Batam Kota, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Klinik Utama Gatsu Medika"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1281281, 104.0318322),
          infoWindow: const InfoWindow(
            title: "Klinik Utama Gatsu Medika",
            snippet:
                "Komplek Trikarsa Ekualita, Blk. B No.22-23, Sungai Panas, Kec. Batam Kota, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Klinik Gigi Orthodentistika"),
          icon: bitmapDescriptor,
          position: const LatLng(1.107493, 104.0251031),
          infoWindow: const InfoWindow(
            title: "Klinik Gigi Orthodentistika",
            snippet:
                "Ruko Permata Niaga, Jl. Sudirman, Sukajadi, Kec. Batam Kota, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Batam Eye Clinic"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1071916, 104.0255653),
          infoWindow: const InfoWindow(
            title: "Batam Eye Clinic",
            snippet:
                "Permata Niaga Blok B No.01 Bukit Indah Sukajadi, Sukajadi, Kec. Batam Kota, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("MedeNS Medical Centre"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1124011, 104.0299993),
          infoWindow: const InfoWindow(
            title: "MedeNS Medical Centre",
            snippet:
                "Permata Niaga Blok B No.01 Bukit Indah Sukajadi, Sukajadi, Kec. Batam Kota, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Batam Eye Care"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1254068, 104.0389641),
          infoWindow: const InfoWindow(
            title: "Batam Eye Care",
            snippet:
                "Komplek Mitra Junction Blok B1 no. 21, Tlk. Tering, Kec. Batam Kota, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Klinik Utama Husada Citra Medika"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1254068, 104.0389641),
          infoWindow: const InfoWindow(
            title: "Klinik Utama Husada Citra Medika",
            snippet:
                "Ruko Green Land Batam Center Blok B. 10-12, Tlk. Tering, Kec. Batam Kota, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Klinik Utama Gading Batam Center"),
          icon: bitmapDescriptor,
          position: const LatLng(1.131744, 104.040016),
          infoWindow: const InfoWindow(
            title: "Klinik Utama Gading Batam Center",
            snippet:
                "Komplek Ruko Mahkota Raya blok G no 3a-5, Tlk. Tering, Kec. Batam Kota, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Aeskulap Health Centre"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1070366, 104.0267254),
          infoWindow: const InfoWindow(
            title: "Aeskulap Health Centrer",
            snippet:
                "Ruko Dermaga Blok RF No. 7, Baloi Permai, Kec. Batam Kota, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("PT. Erha Clinic Indonesia"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1264405, 104.0281979),
          infoWindow: const InfoWindow(
            title: "PT. Erha Clinic Indonesia",
            snippet:
                "Jl. Gajah Mada Ruko Rafflesia, Blk. H1 No.2, Tlk. Tering, Kec. Batam Kota, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Klinik 3 Putri Medika"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1088046, 104.0864454),
          infoWindow: const InfoWindow(
            title: "Klinik 3 Putri Medika",
            snippet:
                "Plaza mall botania 2, blok b23 no 10, Belian, Kec. Batam Kota, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Klinik Tridi Medical Centre"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1023825, 104.0329216),
          infoWindow: const InfoWindow(
            title: "Klinik Tridi Medical Centre",
            snippet: "Kepri Mall, Sukajadi, Batam Kota, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Klinik Utama Prodia"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1311106, 104.0367723),
          infoWindow: const InfoWindow(
            title: "Klinik Utama Prodia",
            snippet:
                "Ruko Mahkota Raya, Jl. Raja H. Fisabilillah No.12, Tlk. Tering, Kec. Batam Kota, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Klinik Kasih Bunda"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1454036, 104.0097651),
          infoWindow: const InfoWindow(
            title: "Klinik Kasih Bunda",
            snippet: "Batam, Lubuk Baja Kota, Kec. Lubuk Baja, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Klinik Utama RISIO"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1026897, 104.0736579),
          infoWindow: const InfoWindow(
            title: "Klinik Utama RISIO",
            snippet: "Ruko KDA Junction Blok E no 7 - 9, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Klinik Medilab"),
          icon: bitmapDescriptor,
          position: const LatLng(1.0930251, 104.0319775),
          infoWindow: const InfoWindow(
            title: "Klinik Medilab",
            snippet:
                "Jl. Ahmad Yani Ruko Taman Niaga Suka Jadi Blok: J, No.: 1 - 6, Sukajadi, Kec. Batam Kota, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Klinik Utama Kimia Farm Sagulung Baru"),
          icon: bitmapDescriptor,
          position: const LatLng(1.0411868, 103.939379),
          infoWindow: const InfoWindow(
            title: "Klinik Utama Kimia Farm Sagulung Baru",
            snippet:
                "Jl. Raya Sagulung Baru No.167, Sungai Binti, Kec. Sagulung, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Klinik SANO MEDIKA"),
          icon: bitmapDescriptor,
          position: const LatLng(1.0361869, 103.973019),
          infoWindow: const InfoWindow(
            title: "Klinik SANO MEDIKA",
            snippet:
                "Komp Ruko Putri Hijau Blok A No.15-20, Sungai Langkai, Kec. Sagulung, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Klinik Utama Dunia Medical Centre"),
          icon: bitmapDescriptor,
          position: const LatLng(1.0361869, 103.973019),
          infoWindow: const InfoWindow(
            title: "Klinik Utama Dunia Medical Centre",
            snippet: "Ruko Fanindo Blok B No 07-10 Tanjung Uncang, Kota Batam ",
          ),
        ),
        Marker(
          markerId: const MarkerId("Klinik Utama Saffira Sentra Medika"),
          icon: bitmapDescriptor,
          position: const LatLng(1.0361869, 103.973019),
          infoWindow: const InfoWindow(
            title: "Klinik Utama Saffira Sentra Medika",
            snippet:
                "Buana Central Park, Blok Monroe No 53 & 53A, Jl LetJen S. Parman, Kel. Kibing, Kec. Batuaji, Kota Batam",
          ),
        ),
      ]);

      //HealthCenter
    } else if (_selectedPlaceType == 'Puskesmas') {
      final bitmapDescriptor = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(devicePixelRatio: 2.5),
          'img/icon/kuning.png');
      _markers.addAll([
        Marker(
          markerId: const MarkerId("Puskesmas Sei Panas"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1452023, 104.0256336),
          infoWindow: const InfoWindow(
            title: "Puskesmas Sei Panas",
            snippet: "Bengkong Indah, Kec. Bengkong, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Puskesmas Tanjung Sengkuang"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1831229, 104.0099633),
          infoWindow: const InfoWindow(
            title: "Puskesmas Tanjung Sengkuang",
            snippet:
                "Jl. Tenggiri Kel. Tanjung Sengkuang Kec. Batu Ampar, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Puskesmas Mentarau"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1330133, 103.9770416),
          infoWindow: const InfoWindow(
            title: "Puskesmas Mentarau",
            snippet:
                "Komplek Ciptaland Mentarau, Kel. Tiban Indah, Kec. Sekupang, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Puskesmas Kabil"),
          icon: bitmapDescriptor,
          position: const LatLng(1.0777412, 104.1165218),
          infoWindow: const InfoWindow(
            title: "Puskesmas Kabil",
            snippet: "Jl. Hasanuddin No. 1 Kel Kabil Kec. Nongsa, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Puskesmas Tanjung Uncang"),
          icon: bitmapDescriptor,
          position: const LatLng(1.0838844, 103.900873),
          infoWindow: const InfoWindow(
            title: "Puskesmas Tanjung Uncang",
            snippet:
                "Jl. Brigjen Katamso, Kel. Tanjung Uncang Kec.Batu Aji, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Puskesmas Galang"),
          icon: bitmapDescriptor,
          position: const LatLng(0.8457238, 104.2567744),
          infoWindow: const InfoWindow(
            title: "Puskesmas Galang",
            snippet:
                "Jl.Batin Limat No 15 Kel. Sembulang Kec. Galang, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Puskesmas Belakang Padang"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1560745, 103.8864872),
          infoWindow: const InfoWindow(
            title: "Puskesmas Belakang Padang",
            snippet:
                "Jl. Hang Tuah, Kp. Tanjung, Kec. Belakang Padang, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Puskesmas Rempang Cate"),
          icon: bitmapDescriptor,
          position: const LatLng(0.912162, 104.1182291),
          infoWindow: const InfoWindow(
            title: "Puskesmas Rempang Cate",
            snippet: "Rempang Cate, Galang, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Puskesmas Bulang"),
          icon: bitmapDescriptor,
          position: const LatLng(1.0152126, 103.9269673),
          infoWindow: const InfoWindow(
            title: "Puskesmas Bulang",
            snippet:
                "Jl. Zakaria Ahmad, Kel. Pulau Buluh, Kec. Bulang, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Puskesmas Tanjung Buntung"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1676265, 104.0268999),
          infoWindow: const InfoWindow(
            title: "Puskesmas Tanjung Buntung",
            snippet: "Tj. Buntung, Bengkong Laut, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Puskesmas Tiban Baru"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1027912, 103.9674191),
          infoWindow: const InfoWindow(
            title: "Puskesmas Tiban Baru",
            snippet: "Jl. Tiban Koperasi, Tiban Baru, Sekupang, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Puskesmas Sei Pancur"),
          icon: bitmapDescriptor,
          position: const LatLng(1.0275763, 104.0617519),
          infoWindow: const InfoWindow(
            title: "Puskesmas Sei Pancur",
            snippet:
                "Kav. Sei Pancur Blok I No. 1 Tj. Piayu Batam,, Kabil, Nongsa, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Puskesmas Sei Lekop"),
          icon: bitmapDescriptor,
          position: const LatLng(1.0363094, 103.9513932),
          infoWindow: const InfoWindow(
            title: "Puskesmas Sei Pancur",
            snippet:
                "Kavling Pelopor. Kelurahan Sungai Lekop, Sungai Lekop, Sagulung, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Puskesmas Lubuk Baja"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1441958, 103.999092),
          infoWindow: const InfoWindow(
            title: "Puskesmas Lubuk Baja",
            snippet: "Jl. Duyung, Tj. Uma, Kec. Lubuk Baja, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Puskesmas Sambau"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1545632, 104.0979866),
          infoWindow: const InfoWindow(
            title: "Puskesmas Sambau",
            snippet:
                "Jl. Hang Lekir No.1, Sambau, Nongsa, Sambau, Kecamatan Nongsa, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Puskesmas Baloi Permai"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1044314, 104.05076),
          infoWindow: const InfoWindow(
            title: "Puskesmas Baloi Permai",
            snippet:
                "Perum. Legenda Malaka Komplek Graha Legenda, Baloi Permai, Kec. Batam Kota, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Puskesmas Sekupang"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1094698, 103.9500157),
          infoWindow: const InfoWindow(
            title: "Puskesmas Sekupang",
            snippet:
                "Jl. Raya H. No.6, Kel. Sungai Harapan, Kec. Sekupang, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Puskesmas Sei Langkai"),
          icon: bitmapDescriptor,
          position: const LatLng(1.0369249, 103.9621976),
          infoWindow: const InfoWindow(
            title: "Puskesmas Sei Langkai",
            snippet:
                "Jalan Raya Jl. Batu Aji Baru, Sungai Langkai, Kec. Sagulung, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Puskesmas Botania"),
          icon: bitmapDescriptor,
          position: const LatLng(1.1304969, 104.0947191),
          infoWindow: const InfoWindow(
            title: "Puskesmas Botania",
            snippet: "Belian, Kec. Batam Kota, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Puskesmas Batu Aji"),
          icon: bitmapDescriptor,
          position: const LatLng(1.0547393, 103.975604),
          infoWindow: const InfoWindow(
            title: "Puskesmas Batu Aji",
            snippet:
                "Jalan Rindang Garden Batu Aji, Kel. Buliang, Kec. Batu Aji, Kota Batam",
          ),
        ),
        Marker(
          markerId: const MarkerId("Puskesmas Kampung Jabi"),
          icon: bitmapDescriptor,
          position: const LatLng(1.136062, 104.1382518),
          infoWindow: const InfoWindow(
            title: "Puskesmas Kampung Jabi",
            snippet: "Batu Besar, Kecamatan Nongsa, Kota Batam",
          ),
        ),
      ]);
    }

    updateLists();
    setState(() {});
  }

  void updateLists() {
    _RumahSakitList = [];
    _clinicList = [];
    _healthCenterList = [];

    _markers.sort((a, b) => _calculateDistance(_currentP!, a.position)
        .compareTo(_calculateDistance(_currentP!, b.position)));

    for (Marker marker in _markers) {
      Map<String, dynamic> place = {
        'name': marker.markerId.value,
        'distance': _calculateDistance(_currentP!, marker.position),
        'address': marker.infoWindow.snippet,
      };

      if (marker.markerId.value.contains('Rumah Sakit')) {
        _RumahSakitList.add(place);
      } else if (marker.markerId.value.contains('Klinik') ||
          marker.markerId.value.contains('Klinik') ||
          marker.markerId.value.contains('Dental')) {
        _clinicList.add(place);
      } else if (marker.markerId.value.contains('Puskesmas')) {
        _healthCenterList.add(place);
      }
    }

    _RumahSakitList.sort((a, b) => a['distance'].compareTo(b['distance']));
    _clinicList.sort((a, b) => a['distance'].compareTo(b['distance']));
    _healthCenterList.sort((a, b) => a['distance'].compareTo(b['distance']));
  }

  double _calculateDistance(LatLng start, LatLng end) {
    const double radius = 6371.0;
    double dLat = _toRadians(end.latitude - start.latitude);
    double dLon = _toRadians(end.longitude - start.longitude);

    double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(_toRadians(start.latitude)) *
            Math.cos(_toRadians(end.latitude)) *
            Math.sin(dLon / 2) *
            Math.sin(dLon / 2);
    double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

    double distance = radius * c;

    // Round the distance to two decimal places
    distance = double.parse(distance.toStringAsFixed(2));

    return distance;
  }

  double _toRadians(double degree) {
    return degree * Math.pi / 180;
  }

  Future<void> _launchGoogleMaps(LatLng destination) async {
    final String googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&destination=${destination.latitude},${destination.longitude}';

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch Google Maps';
    }
  }

  void _onMarkerTapped(String markerId) {
    LatLng selectedPlacePosition = _markers
        .firstWhere((marker) => marker.markerId.value == markerId)
        .position;
    _navigateToSelectedPlace(selectedPlacePosition);
  }

  void _onFollowButtonPressed(Map<String, dynamic> selectedPlace) {
    LatLng selectedPlacePosition = _markers
        .firstWhere((marker) => marker.markerId.value == selectedPlace['name'])
        .position;
    _navigateToSelectedPlace(selectedPlacePosition);
  }
}
