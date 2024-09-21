import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../constants.dart';

class AttachmentsList extends StatefulWidget {
  final List<Widget> attachments;
  final List<File> images;
  final List<TextEditingController> observationsControllers;

  const AttachmentsList({
    Key? key,
    required this.attachments,
    required this.images,
    required this.observationsControllers,
  }) : super(key: key);

  @override
  _AttachmentsListState createState() => _AttachmentsListState();
}

class _AttachmentsListState extends State<AttachmentsList> {
  late List<TextEditingController> _observationsControllers;
  late List<Widget> _attachments;
  late List<File> _images;

  @override
  void initState() {
    super.initState();
    _observationsControllers = widget.observationsControllers;
    _attachments = widget.attachments;
    _images = widget.images;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    void addAttachment(File image, TextEditingController controller) {
      _attachments.add(
        Container(
          padding: EdgeInsets.only(bottom: screenHeight * 0.01),
          color: mainColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Anexo " + (_attachments.length + 1).toString(),
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 5),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.18,
                    width: MediaQuery.of(context).size.width * 0.18,
                    decoration: BoxDecoration(
                      color: mainColor,
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: FileImage(image),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.025),
              SizedBox(
                width: MediaQuery.of(context).size.width - 0.3 * 5,
                height: 50,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(180),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: controller,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.start,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Descrição',
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                      ),
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        fontSize: screenHeight * 0.025,
                        color: Colors.grey[900],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_images.isNotEmpty && _attachments.isEmpty) {
      for (int i = 0; i < _images.length; i++) {
        addAttachment(_images[i], _observationsControllers[i]);
      }
    }

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ..._attachments,
            if (_attachments.isNotEmpty) SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (_attachments.isNotEmpty)
                  IconButtonContainer(
                    color: Colors.green,
                    icon: Icons.add,
                    onPressed: () async {
                      final result = await _openFilePicker();
                      if (result != null) {
                        setState(() {
                          final newController = TextEditingController();
                          _observationsControllers.add(newController);
                          final newImage = File(result);
                          _images.add(newImage);
                          addAttachment(newImage, newController);
                        });
                      }
                    },
                  ),
                if (_attachments.isNotEmpty)
                  IconButtonContainer(
                    color: Colors.red,
                    icon: Icons.remove,
                    onPressed: () {
                      setState(() {
                        _images.removeLast();
                        _attachments.removeLast();
                        _observationsControllers.removeLast();
                      });
                    },
                  ),
              ],
            ),
            if (_attachments.isEmpty)
              Column(
                children: [
                  Text(
                    "Nenhum anexo adicionado",
                    style: TextStyle(fontSize: screenHeight * 0.02),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  IconButtonContainer(
                    color: Colors.green,
                    icon: Icons.add,
                    onPressed: () async {
                      final result = await _openFilePicker();
                      if (result != null) {
                        setState(() {
                          final newController = TextEditingController();
                          _observationsControllers.add(newController);
                          final newImage = File(result);
                          _images.add(newImage);
                          addAttachment(newImage, newController);
                        });
                      }
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Future<String?> _openFilePicker() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );

      return pickedFile?.path;
    } catch (e) {
      print('Erro ao selecionar a imagem: $e');
      return null;
    }
  }
}

class IconButtonContainer extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  const IconButtonContainer({
    Key? key,
    required this.color,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: screenHeight * 0.02,
          color: Colors.white,
        ),
      ),
    );
  }
}
