import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kmstore_mobile/widgets/sidebar.dart';
import 'package:kmstore_mobile/screens/menu.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

enum DPI {
  dpi800(800),
  dpi1600(1600),
  dpi3200(3200),
  dpi6400(6400);

  final int value;
  const DPI(this.value);
}

class MouseFormPage extends StatefulWidget {
  const MouseFormPage({super.key});

  @override
  State<MouseFormPage> createState() => _MouseFormPageState();
}

class _MouseFormPageState extends State<MouseFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _description = "";
  DPI _selectedDPI = DPI.dpi800;
  int _stock = 0;
  int _price = 0;
  int _weight = 0;
  String _brand = "";
  String _image = "";



  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Tambah Mood Kamu Hari ini',
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Name",
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _name = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong!";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Deskripsi",
                  labelText: "Deskripsi",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _description = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Deskripsi tidak boleh kosong!";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<DPI>(
                value: _selectedDPI,
                onChanged: (DPI? newValue) {
                  setState(() {
                    _selectedDPI = newValue!;
                  });
                },
                items: DPI.values.map<DropdownMenuItem<DPI>>((DPI dpi) {
                  return DropdownMenuItem<DPI>(
                    value: dpi,
                    child:
                        Text('${dpi.value} DPI'), // Display the numeric value
                  );
                }).toList(),
                decoration: InputDecoration(
                  hintText: "DPI",
                  labelText: "DPI",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Brand",
                  labelText: "Brand",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _brand = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Brand tidak boleh kosong!";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Image URL",
                  labelText: "Image URL",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _image = value!;
                  });
                },
                validator: (String? value) {
                  if (value != null && value.isNotEmpty) {
                    // Basic URL validation
                    return Uri.tryParse(value)?.hasAbsolutePath ?? false
                        ? null
                        : 'Mohon Masukan valid URL!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Price",
                  labelText: "Price",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _price = int.tryParse(value!) ?? 0;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Price tidak boleh kosong!";
                  } else if (int.tryParse(value) == null) {
                    return "Price harus berupa angka!";
                  } else if (int.tryParse(value)! < 0) {
                    return "Price tidak boleh kurang dari 0!";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Stock",
                  labelText: "Stock",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _stock = int.tryParse(value!) ?? 0;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Stock tidak boleh kosong!";
                  } else if (int.tryParse(value) == null) {
                    return "Stock harus berupa angka!";
                  } else if (int.tryParse(value)! < 0) {
                    return "Stock tidak boleh kurang dari 0!";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Weight",
                  labelText: "Weight",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _weight = int.tryParse(value!) ?? 0;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Weight tidak boleh kosong!";
                  } else if (int.tryParse(value) == null) {
                    return "Weight harus berupa angka!";
                  } else if (int.tryParse(value)! < 0) {
                    return "Weight tidak boleh kurang dari 0!";
                  }
                  return null;
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.primary),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await request.postJson(
                        "http://tristan-agra-kmstore.pbp.cs.ui.ac.id/create-mouse/",
                        jsonEncode(<String, String>
                          {
                            "name": _name,
                            "description": _description,
                            "dpi": _selectedDPI.value.toString(),
                            "stock": _stock.toString(),
                            "price": _price.toString(),
                            "weight": _weight.toString(),
                            "brand": _brand,
                            "image": _image,
                          },
                        ),
                      );
                      if (context.mounted) {
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Mouse baru berhasil disimpan!"),
                          ));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                                Text("Terdapat kesalahan, silakan coba lagi."),
                          ));
                        }
                      }
                    }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
