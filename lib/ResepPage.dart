import 'package:belajar_flutter/ResepModel.dart';
import 'package:flutter/material.dart';
import 'ResepController.dart';
import 'package:provider/provider.dart';
import 'ResepModel.dart';

class ResepPage extends StatelessWidget {
  const ResepPage({super.key});

  @override
  Widget build(BuildContext context) {
    final resepController = Provider.of<ResepController>(context);
    final TextEditingController titleResepController = TextEditingController();
    final TextEditingController ingredientsResepController = TextEditingController();
    final TextEditingController stepsResepController = TextEditingController();
    void _editResep(Resep resep) {
      titleResepController.text = resep.titleResep;
      ingredientsResepController.text = resep.ingredientsResep;
      stepsResepController.text = resep.stepsResep;

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Edit Resep'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: titleResepController,
                        decoration: InputDecoration(labelText: 'Nama Makanan'),
                      ),
                      TextField(
  controller: ingredientsResepController,
  decoration: InputDecoration(labelText: 'Ingredients (pisahkan dengan koma)'),
),
TextField(
  controller: stepsResepController,
  decoration: InputDecoration(labelText: 'Steps (pisahkan dengan koma)'),
),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (titleResepController.text.isEmpty ||
                          ingredientsResepController.text.isEmpty ||
                          stepsResepController.text.isEmpty) {
                        // Tampilkan pesan jika ada field kosong
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Nama Resep dan tidak boleh kosong')),
                        );
                        return;
                      }

                      resepController.updateResep(
                        resep.id,
                        titleResepController.text,
                        ingredientsResepController.text,
                        stepsResepController.text,
                      );
                      Navigator.of(context).pop();
                    },
                    child: Text('Simpan'),
                  )
                ],
              ));
    }

    void _showDeleteConfirmation(String id) {
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi Hapus'),
            content: Text('Apakah Anda yakin ingin menghapus data ini?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();// Tutup Dialog
                }, 
                child: Text('Batal'),
                ),
                TextButton(
                  onPressed: () {
                    resepController.deleteResep(id);
                    Navigator.of(context).pop();//Tutup dialog setelah hapus
                  }, child: Text('Hapus'),
                  )
            ],
          );
        });
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Resep Makanan'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: titleResepController,
                decoration: InputDecoration(labelText: 'Nama Makanan'),
              ),
              TextField(
                controller: ingredientsResepController,
                decoration: InputDecoration(labelText: 'Ingredients(pisahkan dengan koma)'),
              ),
              TextField(
                controller: stepsResepController,
                decoration: InputDecoration(labelText: 'Steps(pisahkan dengan koma)'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (titleResepController.text.isEmpty ||
                      ingredientsResepController.text.isEmpty ||
                      stepsResepController.text.isEmpty) {
                    //Tampilkan pesan jika input kosong
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Nama Resep tidak boleh kosong')),
                    );
                    return;
                  }
                  //tambah resep baru
                  resepController.addResep(
                    titleResepController.text,
                    ingredientsResepController.text,
                    stepsResepController.text,
                  );
                  titleResepController.clear();
                  ingredientsResepController.clear();
                  stepsResepController.clear();
                },
                child: Text('Tambah Resep'),
              ),
              SizedBox(height: 20),
              Expanded(
                  child: ListView.builder(
                itemCount: resepController.resepList.length,
                itemBuilder: (context, index) {
                  final resep = resepController.resepList[index];
                  return ListTile(
                      title: Text(resep.titleResep, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text("Ingredients:", style: TextStyle(fontWeight: FontWeight.bold)),
                          ...resep.ingredientsResep.split(',').map((ingredient) => Text("- ${ingredient.trim()}")).toList(),
                          SizedBox(height: 10),
                          Text("Steps:", style: TextStyle(fontWeight: FontWeight.bold)),
                          ...resep.stepsResep.split(',').map((step) => Text("• ${step.trim()}")).toList(),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _editResep(resep),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _showDeleteConfirmation(resep.id),
                          ),
                        ],
                      ),
                    );
                  },
                )
              )
            ],
          ),
        )
    );
  }
}
