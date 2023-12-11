import 'dart:convert';
import 'dart:io';
import 'package:epozoriste_admin/models/models.dart';
import 'package:epozoriste_admin/providers/kategorija_obavijest.dart';
import 'package:epozoriste_admin/providers/vrsta_predstave_provider.dart';
import 'package:epozoriste_admin/utils/util.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditPredstavaModal extends StatefulWidget {
  final Predstava predstava;
  final Function handleEdit;
  const EditPredstavaModal({
    Key? key,
    required this.predstava,
    required this.handleEdit,
  }) : super(key: key);

  @override
  State<EditPredstavaModal> createState() => _EditPredstavaModalState();
}

class _EditPredstavaModalState extends State<EditPredstavaModal> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController nazivController;
  late TextEditingController sadrzajController;
  late TextEditingController vrijemeTrajanjeController;
  late TextEditingController rezijaController;
  late TextEditingController scenografijaController;
  late TextEditingController kostimografijaController;
  VrstaPredstaveProvider? _vrstaPredstaveProvider;
  bool slikaError = false;
  VrstaPredstave? _selectedVrstaPredstave;
  List<VrstaPredstave> _vrstePredstava = [];
  String? _selectedImage;
  @override
  void initState() {
    super.initState();
    nazivController = TextEditingController(text: widget.predstava.naziv);
    sadrzajController = TextEditingController(text: widget.predstava.sadrzaj);
    vrijemeTrajanjeController = TextEditingController(
        text: widget.predstava.vrijemeTrajanje.toString());
    rezijaController = TextEditingController(text: widget.predstava.rezija);
    scenografijaController =
        TextEditingController(text: widget.predstava.scenografija);
    kostimografijaController =
        TextEditingController(text: widget.predstava.kostimografija);
    _vrstaPredstaveProvider = context.read<VrstaPredstaveProvider>();
    _selectedImage = widget.predstava.slika;
    loadKategorije();
  }

  void loadKategorije() async {
    var data = await _vrstaPredstaveProvider!.get();

    _vrstePredstava = data;
    int index = data.indexWhere((element) =>
        element.vrstaPredstaveId == widget.predstava.vrstaPredstaveId);

    setState(() {
      _vrstePredstava = data;
      _selectedVrstaPredstave = data[index];
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
      title: const Text('Dodaj obavijest'),
      content: Form(
          key: formKey,
          child: Row(
            children: [
              SizedBox(
                width: 220,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nazivController,
                      decoration: const InputDecoration(
                        labelText: 'Naziv',
                        hintText: 'Unesite naziv predstave',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ovo polje je obavezno';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: sadrzajController,
                      maxLines: 6,
                      decoration: const InputDecoration(
                          labelText: 'Sadrzaj',
                          hintText: 'Unesite sadrzaj predstave'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ovo polje je obavezno';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: vrijemeTrajanjeController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        labelText: 'Vrijeme trajanja(min)',
                        hintText: '45',
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
                      controller: rezijaController,
                      decoration: const InputDecoration(
                        labelText: 'Režija',
                        hintText: 'Unesite režisera',
                      ),
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
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: scenografijaController,
                      decoration: const InputDecoration(
                        labelText: 'Scenografija',
                        hintText: 'Unesite scenografa',
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
                      controller: kostimografijaController,
                      decoration: const InputDecoration(
                        labelText: 'Kostimografija',
                        hintText: 'Unesite kostimografa',
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
                      child: DropdownButtonFormField<VrstaPredstave>(
                        decoration: InputDecoration(
                          labelText: 'Vrsta predstave',
                          labelStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
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
              dynamic request = {
                'naziv': nazivController.text,
                'sadrzaj': sadrzajController.text,
                'slika': _selectedImage,
                'vrijemeTrajanje': int.parse(vrijemeTrajanjeController.text),
                'rezija': rezijaController.text,
                'scenografija': scenografijaController.text,
                'kostimografija': kostimografijaController.text,
                'vrstaPredstaveId': _selectedVrstaPredstave!.vrstaPredstaveId,
              };
              widget.handleEdit(widget.predstava.predstavaId, request);
            }
          },
          child: const Text('Dodaj'),
        ),
      ],
    );
  }
}
