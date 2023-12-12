import 'dart:convert';
import 'dart:io';
import 'package:epozoriste_admin/models/models.dart';
import 'package:epozoriste_admin/providers/kategorija_obavijest.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

class AddObavijestModal extends StatefulWidget {
  final Function handleAdd;
  const AddObavijestModal({
    super.key,
    required this.handleAdd,
  });

  @override
  State<AddObavijestModal> createState() => _AddObavijestModalState();
}

class _AddObavijestModalState extends State<AddObavijestModal> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? naslov;
  String? podnaslov;
  String? sadrzaj;
  KategorijaObavijestProvider? _kategorijaObavijestProvider;
  bool slikaError = false;
  KategorijaObavijest? _selectedKategorijaObavijest;
  List<KategorijaObavijest> _kategorije = [];
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _kategorijaObavijestProvider = context.read<KategorijaObavijestProvider>();
    loadKategorije();
  }

  void loadKategorije() async {
    var data = await _kategorijaObavijestProvider!.get();
    setState(() {
      _kategorije = data;
    });
  }

  void selectImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        _selectedImage = File(result.files.single.path!);
        slikaError = false;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Dodaj obavijest'),
      content: Form(
          key: formKey,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Naslov',
                        hintText: 'Unesite naslov obavijesti',
                      ),
                      onChanged: (value) {
                        naslov = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ovo polje je obavezno';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Podnaslov',
                        hintText: 'Unesite podnaslov obavijesti',
                      ),
                      onChanged: (value) {
                        podnaslov = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ovo polje je obavezno';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      maxLines: 5,
                      decoration: const InputDecoration(
                          labelText: 'Sadrzaj',
                          hintText: 'Unesite sadrzaj obavijesti'),
                      onChanged: (value) {
                        sadrzaj = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ovo polje je obavezno';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 40),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButtonFormField<KategorijaObavijest>(
                        decoration: InputDecoration(
                          labelText: 'Kategorija',
                          labelStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        value: _selectedKategorijaObavijest,
                        onChanged: (KategorijaObavijest? k) {
                          setState(() {
                            _selectedKategorijaObavijest = k!;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Ovo polje je obavezno';
                          }
                          return null;
                        },
                        items: _kategorije
                            .map<DropdownMenuItem<KategorijaObavijest>>(
                                (KategorijaObavijest d) {
                          return DropdownMenuItem<KategorijaObavijest>(
                            value: d,
                            child: Text(d.naziv),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                style: _selectedImage == null
                                    ? BorderStyle.solid
                                    : BorderStyle.none,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: InkWell(
                              onTap: selectImage,
                              child: _selectedImage == null
                                  ? SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.cloud_upload,
                                            size: 48,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Odaberite sliku',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Image.file(
                                      _selectedImage!,
                                      height: 200,
                                      width: 200,
                                      fit: BoxFit.contain,
                                    ),
                            )),
                        if (slikaError)
                          const Text(
                            'Slika je obavezna!',
                            style: TextStyle(color: Colors.red),
                          )
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Poništi'),
        ),
        ElevatedButton(
          onPressed: () async {
            setState(() {
              slikaError = false;
            });

            if (_selectedImage == null) {
              setState(() {
                slikaError = true;
              });
              return;
            }
            if (formKey.currentState!.validate()) {
              final bytes = await _selectedImage!.readAsBytes();
              final image = base64Encode(bytes);
              widget.handleAdd(
                naslov,
                podnaslov,
                sadrzaj,
                _selectedKategorijaObavijest!.obavijestKategorijaId,
                image,
              );
            }
          },
          child: const Text('Dodaj'),
        ),
      ],
    );
  }
}
