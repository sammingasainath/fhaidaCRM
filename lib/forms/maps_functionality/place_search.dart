import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

final dioProvider = Provider((ref) => Dio());

var searchResults1 = false;

final locationProvider = FutureProvider<Position?>((ref) async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied');
  }

  return await Geolocator.getCurrentPosition();
});

class PlaceSearchNotifier
    extends StateNotifier<AsyncValue<List<PlaceSearchResult>>> {
  final Dio _dio;

  PlaceSearchNotifier(this._dio) : super(AsyncValue.data([]));

  Future<void> searchPlaces(String input) async {
    if (input.isEmpty) {
      state = AsyncValue.data([]);
      return;
    }

    state = AsyncValue.loading();
    try {
      final response = await _dio.get(
        'https://api.olamaps.io/places/v1/autocomplete',
        queryParameters: {
          'input': input,
          'api_key': 'wsDdIDv12U09fVMmIMzyJJ47N8tvBpgin34xh7kH',
        },
      );

      if (response.statusCode == 200) {
        final List<PlaceSearchResult> results =
            (response.data['predictions'] as List)
                .map((prediction) => PlaceSearchResult.fromJson(prediction))
                .toList();
        state = AsyncValue.data(results);
      } else {
        state = AsyncValue.error('Failed to fetch results', StackTrace.current);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

class PlaceSearchResult {
  final String description;
  final double lat;
  final double lng;

  PlaceSearchResult(
      {required this.description, required this.lat, required this.lng});

  factory PlaceSearchResult.fromJson(Map<String, dynamic> json) {
    return PlaceSearchResult(
      description: json['description'],
      lat: json['geometry']['location']['lat'],
      lng: json['geometry']['location']['lng'],
    );
  }
}

class PlaceSearchField extends ConsumerStatefulWidget {
  final String label;
  final void Function(PlaceSearchResult) onSelected;
  final String uniqueKey;

  const PlaceSearchField({
    Key? key,
    required this.label,
    required this.onSelected,
    required this.uniqueKey,
  }) : super(key: key);

  @override
  _PlaceSearchFieldState createState() => _PlaceSearchFieldState();
}

class _PlaceSearchFieldState extends ConsumerState<PlaceSearchField> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  late StateNotifierProvider<PlaceSearchNotifier,
      AsyncValue<List<PlaceSearchResult>>> placeSearchProvider;

  @override
  void initState() {
    super.initState();
    placeSearchProvider = StateNotifierProvider<PlaceSearchNotifier,
        AsyncValue<List<PlaceSearchResult>>>((ref) {
      return PlaceSearchNotifier(ref.watch(dioProvider));
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(placeSearchProvider.notifier).searchPlaces(query);
    });
  }

  Future<void> _getCurrentLocation() async {
    final locationAsyncValue = ref.read(locationProvider);

    locationAsyncValue.when(
      data: (location) async {
        if (location != null) {
          final result =
              await _reverseGeocode(location.latitude, location.longitude);
          if (result != null) {
            _controller.text = result.description;
            widget.onSelected(result);
          }
        }
      },
      loading: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fetching location...')),
      ),
      error: (error, _) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      ),
    );
  }

  Future<PlaceSearchResult?> _reverseGeocode(double lat, double lng) async {
    try {
      final response = await ref.read(dioProvider).get(
        'https://api.olamaps.io/places/v1/reverse-geocode',
        queryParameters: {
          'latlng': '$lat,$lng',
          'api_key': 'wsDdIDv12U09fVMmIMzyJJ47N8tvBpgin34xh7kH',
        },
      );

      if (response.statusCode == 200 && response.data['results'].isNotEmpty) {
        final result = response.data['results'][0];
        return PlaceSearchResult(
          description: result['formatted_address'],
          lat: lat,
          lng: lng,
        );
      }
    } catch (e) {
      print('Error in reverse geocoding: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(placeSearchProvider);

    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: widget.label,
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 24,
                        ),
                        // if (searchResults1!)
                        IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            _controller.clear();
                            ref
                                .read(placeSearchProvider.notifier)
                                .searchPlaces('');
                          },
                        ),
                        // Icon(Icons.search, color: Colors.blueAccent),
                      ],
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onChanged: _onSearchChanged,
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.my_location, color: Colors.blueAccent),
                onPressed: _getCurrentLocation,
              ),
            ],
          ),
          const SizedBox(height: 10),
          searchResults.when(
            data: (results) {
              setState(() {
                searchResults1 = results.isEmpty;
              });
              return results.isEmpty
                  ? Center(
                      child: Text('Search Here...',
                          style: TextStyle(color: Colors.grey)))
                  : Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(results[index].description),
                            onTap: () {
                              _controller.text = results[index].description;
                              widget.onSelected(results[index]);
                              ref
                                  .read(placeSearchProvider.notifier)
                                  .searchPlaces('');
                            },
                          );
                        },
                      ),
                    );
            },
            loading: () => Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
                child:
                    Text('Error: $error', style: TextStyle(color: Colors.red))),
          ),
        ],
      ),
    );
  }
}
