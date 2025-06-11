import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapSCreen extends StatefulWidget {
  const MapSCreen({super.key});

  @override
  State<MapSCreen> createState() => _MapSCreenState();
}

class _MapSCreenState extends State<MapSCreen> {
  static const _london = LatLng(51.509364, -0.128928);
  static const _paris = LatLng(52.509364, -0.138928);
  static const _dublin = LatLng(53.509364, -0.138928);

  static const _markers = [
    Marker(
      width: 30,
      height: 30,
      point: _london,
      child: FlutterLogo(key: ValueKey('blue')),
    ),
    Marker(
      width: 30,
      height: 30,
      point: _dublin,
      child: FlutterLogo(key: ValueKey('green')),
    ),
    Marker(
      width: 30,
      height: 30,
      point: _paris,
      child: FlutterLogo(key: ValueKey('purple')),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 32, 32),
        title: const Text('Flutter MapBox'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              minZoom: 5,
              maxZoom: 18,
              initialZoom: 13,
              initialCenter: LatLng(51.509364, -0.128928),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/roam2024/clpjir0v000oy01pa6e481tmu/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoicm9hbTIwMjQiLCJhIjoiY2xwamk3eG9uMDBhbTJybXJqdTB1bTlsNCJ9.IDYDegcj9tn_O6ihimg7XA",
                additionalOptions: const {
                  'mapStyleId':
                      "mapbox://styles/roam2024/clpjir0v000oy01pa6e481tmu",
                  'accessToken':
                      "pk.eyJ1Ijoicm9hbTIwMjQiLCJhIjoiY2xwamk3eG9uMDBhbTJybXJqdTB1bTlsNCJ9.IDYDegcj9tn_O6ihimg7XA",
                },
              ),
              MarkerLayer(markers: _markers)
            ],
          ),
        ],
      ),
    );
  }
}
