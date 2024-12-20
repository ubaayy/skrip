import 'dart:convert';
import 'package:flutter/material.dart';
import 'ResepModel.dart';
import 'package:http/http.dart' as http;

class ResepController extends ChangeNotifier {
  final String apiUrl = 'https://6762e91917ec5852cae78740.mockapi.io/Resep';
  final List<Resep> _resepList = [];

  List<Resep> get resepList => _resepList;

  // Mengambil data dari MockAPI
  Future<void> fetchPoli() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        _resepList.clear();
        _resepList.addAll(data.map((json) => Resep(
              id: json['id'],
              titleResep: json['namaResep'],
              ingredientsResep: json['ingredientsResep'],
              stepsResep: json['stepsResep'],
            )));
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  // Menambah data ke MockAPI
  Future<void> addResep(String titleResep, String ingredientsResep, String stepsResep) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'titleResep': titleResep,
          'ingredientsResep': ingredientsResep,
          'stepsResep' : stepsResep,
        }),
      );
      if (response.statusCode == 201) {
        final newResep = Resep(
          id: jsonDecode(response.body)['id'],
          titleResep: titleResep,
          ingredientsResep: ingredientsResep,
          stepsResep: stepsResep,
        );
        _resepList.add(newResep);
        notifyListeners();
      } else {
        throw Exception('Failed to add data');
      }
    } catch (e) {
      throw Exception('Error adding data: $e');
    }
  }

  // Menambah data ke MockAPI
  Future<void> updateResep(
      String id, String titleResep, String ingredientsResep, String stepsResep) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'titleResep': titleResep,
          'ingredientsResep': ingredientsResep,
          'stepsResep' : stepsResep,
        }),
      );
      if (response.statusCode == 200) {
        final index = _resepList.indexWhere((poli) => poli.id == id);
        if (index != -1) {
          _resepList[index].titleResep = titleResep;
          _resepList[index].ingredientsResep = ingredientsResep;
          _resepList[index].stepsResep = stepsResep;
          notifyListeners();
        }
      } else {
        throw Exception('Failed to update data');
      }
    } catch (e) {
      throw Exception('Error updating data: $e');
    }
  }

  //Menghapus data dari MockAPI
  Future<void> deleteResep(String id) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/$id'));
      if (response.statusCode == 200) {
        _resepList.removeWhere((resep) => resep.id == id);
        notifyListeners();
      } else {
        throw Exception('Failed to delete data');
      }
    } catch (e) {
      throw Exception('Error deleting data: $e');
    }
  }
}
