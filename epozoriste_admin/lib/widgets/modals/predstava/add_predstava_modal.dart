import 'dart:convert';
import 'dart:io';
import 'package:epozoriste_admin/models/models.dart';
import 'package:epozoriste_admin/providers/vrsta_predstave_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

class AddPredstavaModal extends StatefulWidget {
  final Function handleAdd;
  const AddPredstavaModal({
    super.key,
    required this.handleAdd,
  });

  @override
  State<AddPredstavaModal> createState() => _AddPredstavaModalState();
}

class _AddPredstavaModalState extends State<AddPredstavaModal> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? naziv;
  String? sadrzaj;
  String? vrijemeTrajanja;
  String? rezija;
  String? scenografija;
  String? kostimografija;
  VrstaPredstaveProvider? _vrstaPredstaveProvider;
  bool slikaError = false;
  VrstaPredstave? _selectedVrstaPredstave;
  List<VrstaPredstave> _vrstePredstava = [];
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _vrstaPredstaveProvider = context.read<VrstaPredstaveProvider>();
    loadKategorije();
  }

  void loadKategorije() async {
    var data = await _vrstaPredstaveProvider!.get();
    setState(() {
      _vrstePredstava = data;
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
      title: const Text('Dodaj predstavu'),
      content: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Row(
              children: [
                SizedBox(
                  width: 220,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Naziv',
                          hintText: 'Unesite naziv predstave',
                        ),
                        onChanged: (value) {
                          naziv = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ovo polje je obavezno';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        maxLines: 6,
                        decoration: const InputDecoration(
                            labelText: 'Sadrzaj',
                            hintText: 'Unesite sadrzaj predstave'),
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
                      const SizedBox(height: 16),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Vrijeme trajanja(min)',
                          hintText: '45',
                        ),
                        onChanged: (value) {
                          vrijemeTrajanja = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ovo polje je obavezno';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Režija',
                          hintText: 'Unesite režisera',
                        ),
                        onChanged: (value) {
                          rezija = value;
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
                SizedBox(
                  width: 220,
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
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Scenografija',
                          hintText: 'Unesite scenografa',
                        ),
                        onChanged: (value) {
                          scenografija = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ovo polje je obavezno';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Kostimografija',
                          hintText: 'Unesite kostimografa',
                        ),
                        onChanged: (value) {
                          kostimografija = value;
                        },
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
                        child: DropdownButtonFormField<VrstaPredstave>(
                          decoration: InputDecoration(
                            labelText: 'Vrsta predstave',
                            labelStyle: TextStyle(
                                color: Theme.of(context).primaryColor),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          value: _selectedVrstaPredstave,
                          onChanged: (VrstaPredstave? vp) {
                            setState(() {
                              _selectedVrstaPredstave = vp!;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Ovo polje je obavezno';
                            }
                            return null;
                          },
                          items: _vrstePredstava
                              .map<DropdownMenuItem<VrstaPredstave>>(
                                  (VrstaPredstave vp) {
                            return DropdownMenuItem<VrstaPredstave>(
                              value: vp,
                              child: Text(vp.naziv),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
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
            if (formKey.currentState!.validate()) {
              if (_selectedImage == null) {
                setState(() {
                  slikaError = true;
                });
                return;
              }
              final bytes = await _selectedImage!.readAsBytes();
              final image = base64Encode(bytes);
              dynamic request = {
                'naziv': naziv,
                'sadrzaj': sadrzaj,
                'slika': image,
                'vrijemeTrajanje': int.parse(vrijemeTrajanja!),
                'rezija': rezija,
                'scenografija': scenografija,
                'kostimografija': kostimografija,
                'vrstaPredstaveId': _selectedVrstaPredstave!.vrstaPredstaveId,
              };
              widget.handleAdd(request);
            }
          },
          child: const Text('Dodaj'),
        ),
      ],
    );
  }
}
