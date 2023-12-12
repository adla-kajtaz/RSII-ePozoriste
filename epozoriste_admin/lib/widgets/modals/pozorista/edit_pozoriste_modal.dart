import 'dart:convert';
import 'dart:io';
import 'package:epozoriste_admin/models/models.dart';
import 'package:epozoriste_admin/providers/gradovi_provider.dart';
import 'package:epozoriste_admin/utils/util.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String patternUrl =
    r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$';
String patternEmail = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
String patternPhone = r'^\d{3}-\d{3}-\d{3}$';

class EditPozoristeModal extends StatefulWidget {
  final Pozoriste pozoriste;
  final Function handleEdit;
  const EditPozoristeModal({
    Key? key,
    required this.pozoriste,
    required this.handleEdit,
  }) : super(key: key);

  @override
  State<EditPozoristeModal> createState() => _EditPozoristeModalState();
}

class _EditPozoristeModalState extends State<EditPozoristeModal> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController nazivController;
  late TextEditingController adresaController;
  late TextEditingController webStranicaController;
  late TextEditingController emailController;
  late TextEditingController brojTelefonaController;
  GradoviProvider? _gradoviProvider;
  bool? isAktivan;
  Grad? _selectedGrad;
  List<Grad> _gradovi = [];
  String? _selectedImage;

  @override
  void initState() {
    super.initState();
    nazivController = TextEditingController(text: widget.pozoriste.naziv);
    adresaController = TextEditingController(text: widget.pozoriste.adresa);
    webStranicaController =
        TextEditingController(text: widget.pozoriste.webstranica);
    emailController = TextEditingController(text: widget.pozoriste.email);
    brojTelefonaController =
        TextEditingController(text: widget.pozoriste.brTelefona);
    _gradoviProvider = context.read<GradoviProvider>();
    loadGradovi();
    _selectedImage = widget.pozoriste.logo;
    isAktivan = widget.pozoriste.aktivan;
  }

  void selectImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      final imageFile = File(result.files.single.path!);
      final bytes = await imageFile!.readAsBytes();
      final image = base64Encode(bytes);
      setState(() {
        _selectedImage = image;
      });
    } else {
      // User canceled the picker
    }
  }

  loadGradovi() async {
    var data = await _gradoviProvider!.get();
    _gradovi = data;
    int index = data.indexWhere(
        (element) => element.gradId == widget.pozoriste.grad!.gradId);

    setState(() {
      _gradovi = data;
      _selectedGrad = data[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Izmjeni pozoriste'),
      content: Form(
          key: formKey,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      controller: nazivController,
                      decoration: const InputDecoration(
                        labelText: 'Naziv',
                        hintText: 'Unesite naziv pozorista',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ovo polje je obavezno';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: adresaController,
                      decoration: const InputDecoration(
                        labelText: 'Adresa',
                        hintText: 'Unesite adresu pozorista',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ovo polje je obavezno';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButtonFormField<Grad>(
                        decoration: InputDecoration(
                          labelText: 'Grad',
                          labelStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        value: _selectedGrad,
                        onChanged: (Grad? k) {
                          setState(() {
                            _selectedGrad = k!;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Ovo polje je obavezno';
                          }
                          return null;
                        },
                        items: _gradovi.map<DropdownMenuItem<Grad>>((Grad g) {
                          return DropdownMenuItem<Grad>(
                            value: g,
                            child: Text(g.naziv),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: webStranicaController,
                      decoration: const InputDecoration(
                          labelText: 'Web stranica',
                          hintText: 'Unesite web stranicu pozorista'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ovo polje je obavezno';
                        } else if (!RegExp(patternUrl).hasMatch(value)) {
                          return 'Unesite validan url(https://stranica.com)';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Unesite email pozorista'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ovo polje je obavezno';
                        } else if (!RegExp(patternEmail).hasMatch(value)) {
                          return 'Unesite validan email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: brojTelefonaController,
                      decoration: const InputDecoration(
                          labelText: 'Broj broj telefona pozoriste',
                          hintText: ''),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ovo polje je obavezno';
                        } else if (!RegExp(patternPhone).hasMatch(value)) {
                          return 'Format telefona mora biti XXX-XXX-XXX';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Checkbox(
                          value: isAktivan,
                          onChanged: (bool? s) {
                            setState(() {
                              isAktivan = s!;
                            });
                          },
                          activeColor: Theme.of(context).primaryColor,
                        ),
                        const Text('Aktivan')
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 40),
              Expanded(
                child: Column(
                  children: [
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
            if (formKey.currentState!.validate()) {
              dynamic request = {
                'naziv': nazivController.text,
                'adresa': adresaController.text,
                'webstranica': webStranicaController.text,
                'gradId': _selectedGrad!.gradId,
                'logo': _selectedImage,
                'email': emailController.text,
                'brTelefona': brojTelefonaController.text,
                'aktivan': isAktivan,
              };

              widget.handleEdit(widget.pozoriste.pozoristeId, request);
            }
          },
          child: const Text('Izmjeni'),
        ),
      ],
    );
  }
}
