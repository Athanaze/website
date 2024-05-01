import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:frontend_project/widget/send_message.dart';
import '../theme/colors.dart';
import '../widget/getmesage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<File> _pickedFiles = [];
  final List<PDFDocument?> _pdfDocuments = [];
  final List<bool> _isLoadingList = [];
  bool _isLoading = false;
  PDFDocument? _pdfDocument;
  File? _pickedFile;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColor.primaryColor,
                    child: Icon(
                      Icons.person,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            GetMessageWidget(
              message:
                  'Hello ! I am GPT-4. You received free credits for 5000 words. How can i help you ?',
            ),
            const SizedBox(
              height: 15,
            ),
            SendMessageWidget(message: 'This is some text the user just sent'),
            const SizedBox(
              height: 45,
            ),
            const Text(
              'Thinking about it...',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/Ellipse 3.png'),
                const SizedBox(
                  width: 10,
                ),
                Image.asset('images/Ellipse 4.png'),
                const SizedBox(
                  width: 10,
                ),
                Image.asset('images/Ellipse 5.png'),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                      bottomRight: Radius.circular(18))),
              child: Center(
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Here this is...',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Text(
                          'A very long responce...',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    HighlightView(
                      '''
              void main() {
              print('Hello, world!');
                            }
                         ''',
                      language: 'dart',
                      theme: myCustomTheme,
                      padding: const EdgeInsets.all(12),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: Container()),
            Expanded(
              child: ListView.builder(
                itemCount: _pickedFiles.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (_pdfDocuments[index] != null) {
                    return Stack(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColor.primaryColor,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.picture_as_pdf,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          top: -12,
                          right: 0,
                          left: 30,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              color: Colors.black,
                              iconSize: 25,
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _pdfDocuments.removeAt(index);
                                  _pickedFiles.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                _pickedFiles[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: -5,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: CloseButton(
                              color: Colors.black,
                              onPressed: () {
                                setState(() {
                                  _pickedFiles.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.0),
                border: Border.all(
                  color: AppColor.primaryColor,
                  width: 3.0,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 180,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                          ),
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            allowMultiple: true,
                            type: FileType.custom,
                            allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
                          );

                          if (result != null) {
                            for (var file in result.files) {
                              setState(() {
                                _pickedFiles.add(File(file.path!));
                                _isLoadingList.add(true);
                              });
                              _loadFile(File(file.path!));
                            }
                          } else {}
                        },
                        child: const Icon(
                          Icons.attach_file,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColor.primaryColor,
                          child: Icon(
                            Icons.send,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  final myCustomTheme = {
    'root': const TextStyle(backgroundColor: Colors.black, color: Colors.white),
    'comment': const TextStyle(color: Colors.green),
    'keyword': const TextStyle(color: Colors.blue),
    'number': const TextStyle(color: Colors.orange),
    'string': const TextStyle(color: Colors.red),
    'brackets': const TextStyle(color: Colors.orange),
  };

  void _loadPDF() async {
    _pdfDocument = await PDFDocument.fromFile(_pickedFile!);
    setState(() {
      _isLoading = false;
    });
  }

  void _loadFile(File file) async {
    setState(() {
      _isLoadingList.add(true);
    });

    try {
      if (file.path.endsWith('.pdf')) {
        PDFDocument? pdfDocument = await PDFDocument.fromFile(file);
        setState(() {
          _pdfDocuments.add(pdfDocument);
          _isLoadingList.add(false);
        });
      } else {
        setState(() {
          _pdfDocuments.add(null);
          _isLoadingList.add(false);
        });
      }
    } catch (e) {
      print("Error loading file: $e");
      setState(() {
        _pdfDocuments.add(null);
        _isLoadingList.add(false);
      });
    }
  }
}
