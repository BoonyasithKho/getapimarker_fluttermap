import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:getapimarker_fluttermap/models/floodwarning_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  MapController flutterMapController = MapController();
  Map<String, String> requestHeaders = {'Content-type': 'application/json', 'Accept': 'application/json', 'x-api-key': 'ADTISG_4202'};
  final List<Marker> markers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlutterMap(
      mapController: flutterMapController,
      options: MapOptions(
        initialZoom: 6,
        initialCameraFit: CameraFit.bounds(
            bounds: LatLngBounds.fromPoints([
          const LatLng(22.9, 97.0),
          const LatLng(4.9, 106.0),
        ])),
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
        ),
        crs: const Epsg3857(),
        backgroundColor: Colors.transparent,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        PopupMarkerLayer(
          options: PopupMarkerLayerOptions(
            markers: markers,
            popupDisplayOptions: PopupDisplayOptions(
              builder: (context, marker) => Text(
                marker.point.toString(),
              ),
            ),
            // selectedMarkerBuilder: (context, marker) => Text(
            //   marker.toString(),
            // ),
          ),
        ),
        // const MarkerLayer(markers: [Marker(point: LatLng(13, 100), child: Icon(Icons.abc)), Marker(point: LatLng(15, 100), child: Icon(Icons.abc))]),
        // MarkerLayer(markers: markers),
      ],
    ));
  }

  Future getData() async {
    var response = await http.get(Uri.parse('http://103.156.151.144/waterlevel'), headers: requestHeaders);
    var jsonData = FloodwarningModel.fromJson(jsonDecode(response.body));

    var classifyColor = [];
    var pointLocation = [];
    var stationID = [];
    var percentage = [];

    for (var d in jsonData.data) {
      pointLocation.add(LatLng(d.latitude, d.longitude));
      classifyColor.add(d.classify);
      stationID.add(d.stationOldCode);
      percentage.add(d.percentage);
    }

    for (var i = 0; i < pointLocation.length; i++) {
      markers.add(Marker(
          point: pointLocation[i],
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Center(
                      child: Column(
                        children: [
                          Text('รหัสสถานี : ${stationID[i]}'),
                          const Divider(
                            height: 1,
                            color: Colors.black,
                          ),
                          Text('ระดับน้ำ : ${percentage[i]}'),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Icon(
              Icons.pin_drop,
              size: 14,
              color: (classifyColor[i] == 1 || classifyColor[i] == 2 || classifyColor[i] == 3)
                  ? Colors.green
                  : (classifyColor[i] == 5 || classifyColor[i] == 6 || classifyColor[i] == 7 || classifyColor[i] == 8 || classifyColor[i] == 9)
                      ? Colors.red
                      : (classifyColor[i] == 4)
                          ? Colors.amber
                          : Colors.transparent,
            ),
          )));
    }
    setState(() {});
    return markers;
  }
}
