import 'package:flutter/material.dart';
import 'package:frontend_project/screens/prompt_template.dart';
import 'package:frontend_project/screens/template_photo.dart';
import 'package:frontend_project/widget/backButton.dart';
import 'package:frontend_project/widget/cornerButton.dart';

import '../widget/size_widget.dart';

class TemplateThinking extends StatefulWidget {
  const TemplateThinking({super.key});

  @override
  State<TemplateThinking> createState() => _TemplateThinkingState();
}

class _TemplateThinkingState extends State<TemplateThinking> {
  bool status = false;
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                BackButtonWidget(),
                const Spacer(),
                CornerButtonWidget(
                    onPressed: () {
                      setState(() {
                        textController.text =
                            "this is the prompt filled by the chosen template";
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PromptTemplates()));
                    },
                    text: 'TEMPLATES')
              ],
            ),
          ),
          const SizedBox(
            height: 175,
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
          Expanded(child: Container()),
          const SizeWidget(),
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18.0),
              border: Border.all(
                color: Colors.blue,
                width: 3.0,
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 180, // Match the parent width
                  height: 10, // Desired height of the divider
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0), // Adjust margin as needed
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(
                        5.0), // Adjust radius for rounded corners
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textController,
                        decoration: const InputDecoration(
                          hintText: 'New Conversation...',
                          border: InputBorder.none,
                          // No border
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          // No border on error
                          disabledBorder: InputBorder.none,
                          // No border when disabled
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16.0),
                        ),
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.black),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.attach_file,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TemplatePhoto()));
                      },
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: Color(0xff4381BE),
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
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    ));
  }
}
