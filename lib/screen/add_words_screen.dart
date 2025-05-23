// ignore_for_file: prefer_final_fields
import 'package:vocab_master/models/words_model/word.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vocab_master/services/hive_helper/hive_names.dart';

class AddWordsScreen extends StatefulWidget {
  const AddWordsScreen({super.key});
  @override
  State<AddWordsScreen> createState() => _AddWordsScreenState();
}

class _AddWordsScreenState extends State<AddWordsScreen> {
  List<Words> wordsList = [];
  TextEditingController enController = TextEditingController();
  TextEditingController uzController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true
        ,
        title:  Text(
          'Translated words',
          style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 23),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: wordsList.length,
              itemBuilder: (context, index) => wordsWidget(
                  wordsList[index].nameEn ?? "",
                  wordsList[index].nameUz ?? "",
                  wordsList.length == index + 1),
            ),
            const SizedBox(
              height: 20,
            ),
            addWordField(),
            Card(
              color: Theme.of(context).primaryColor,
              child: IconButton(
                onPressed: () async {
                  if (uzController.text != "" && enController.text != "") {
                    Words wd = Words()
                      ..nameEn = enController.text
                      ..nameUz = uzController.text
                      ..isSelected = true;
                    await HiveBoxes.addwords.add(wd);

                    wordsList.add(wd);
                    enController.text = "";
                    uzController.text = "";
                    _focusNode.requestFocus();
                    setState(() {});
                  }
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addWordField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              key: _formKey,
              cursorColor: Colors.teal,
              controller: enController,
              decoration:  InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                labelStyle: const TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                      width: 1, color: Theme.of(context).primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1.0),
                ),
                hintText: 'Enter text',
                labelText: 'En',
                hintStyle: const TextStyle(fontSize: 12),
                prefixText: '',
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextField(
              cursorColor: Colors.teal,
              controller: uzController,
              decoration:  InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                labelStyle: const TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                      width: 1, color: Theme.of(context).primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1.0),
                ),
                hintText: 'Matn kiriting',
                labelText: 'Uz',
                hintStyle: const TextStyle(fontSize: 12),
                prefixText: '',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget wordsWidget(String en, String uz, bool isBottom) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: const BorderSide(),
                  left: const BorderSide(),
                  right: const BorderSide(),
                  bottom: BorderSide(
                    width: isBottom == true ? 1 : 0,
                  ),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                child: Text(
                  en,
                  style: GoogleFonts.comfortaa(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: const BorderSide(),
                  right: const BorderSide(),
                  bottom: BorderSide(
                    width: isBottom == true ? 1 : 0,
                  ),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                child: Text(
                  uz,
                  style: GoogleFonts.comfortaa(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
