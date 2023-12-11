import 'dart:convert';
import 'dart:io';
import 'package:epozoriste_admin/models/models.dart';
import 'package:epozoriste_admin/providers/kategorija_obavijest.dart';
import 'package:epozoriste_admin/utils/util.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditObavijestModal extends StatefulWidget {
  final Obavijest obavijest;
  final Function handleEdit;
  const EditObavijestModal({
    Key? key,
    required this.obavijest,
    required this.handleEdit,
  }) : super(key: key);

  @override
  State<EditObavijestModal> createState() => _EditObavijestModalState();
}

class _EditObavijestModalState extends State<EditObavijestModal> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController _naslovController;
  late TextEditingController _podnaslovController;
  late TextEditingController _sadrzajController;
  KategorijaObavijestProvider? _kategorijaObavijestProvider;
  bool slikaError = false;
  KategorijaObavijest? _selectedKategorijaObavijest;
  List<KategorijaObavijest> _kategorije = [];
  String? _selectedImage;
  @override
  void initState() {
    super.initState();
    _naslovController = TextEditingController(text: widget.obavijest.naslov);
    _podnaslovController =
        TextEditingController(text: widget.obavijest.podnaslov);
    _sadrzajController = TextEditingController(text: widget.obavijest.sadrzaj);
    _kategorijaObavijestProvider = context.read<KategorijaObavijestProvider>();
    loadKategorije();
    _selectedImage = widget.obavijest.slika;
  }

  void loadKategorije() async {
    var data = await _kategorijaObavijestProvider!.get();

    _kategorije = data;
    int index = data.indexWhere((element) =>
        element.obavijestKategorijaId ==
        widget.obavijest.obavijestKategorija!.obavijestKategorijaId);

    setState(() {
      _kategorije = data;
      _selectedKategorijaObavijest = data[index];
    });
  }

  void selectImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      final file = File(result.files.single.path!);
      final bytes = await file!.readAsBytes();
      final image = base64Encode(bytes);
      setState(() {
        _selectedImage = image;
        slikaError = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Izmjeni obavijest'),
      content: Form(
          key: formKey,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _naslovController,
                      decoration: const InputDecoration(
                        labelText: 'Naslov',
                        hintText: 'Unesite naslov obavijesti',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ovo polje je obavezno';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _podnaslovController,
                      decoration: const InputDecoration(
                        labelText: 'Podnaslov',
                        hintText: 'Unesite podnaslov obavijesti',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ovo polje je obavezno';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _sadrzajController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                          labelText: 'Sadrzaj',
                          hintText: 'Unesite sadrzaj obavijesti'),
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
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Odaberite sliku',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : imageFromBase64String(
                                    _selectedImage!,
                                    200,
                                    200,
                                  ),
                          ),
                        ),
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
              String image = _selectedImage!;
              widget.handleEdit(
                widget.obavijest.obavijestId,
                _naslovController.text,
                _podnaslovController.text,
                _sadrzajController.text,
                _selectedKategorijaObavijest!.obavijestKategorijaId,
                image,
                widget.obavijest.datumKreiranja,
              );
            }
          },
          child: const Text('Dodaj'),
        ),
      ],
    );
  }
}
