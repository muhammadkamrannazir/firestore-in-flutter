import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Audio {
  final String topicName;
  final String audioUrl;

  Audio({required this.topicName, required this.audioUrl});
}

class AzharNazir extends StatelessWidget {
  final CollectionReference audioCollection =
      FirebaseFirestore.instance.collection('audio');

  AzharNazir({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: audioCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          final audioList = snapshot.data!.docs
              .map((doc) => Audio(
                    topicName: doc['topicName'],
                    audioUrl: doc['audioUrl'],
                  ))
              .toList();

          return ListView.builder(
            itemCount: audioList.length,
            itemBuilder: (context, index) {
              final audio = audioList[index];
              return ListTile(
                title: Text(audio.topicName),
                subtitle: Text(audio.audioUrl),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UploadPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final CollectionReference audioCollection =
      FirebaseFirestore.instance.collection('audio');

  final TextEditingController topicNameController = TextEditingController();
   FilePickerResult? audioFileResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: topicNameController,
              decoration: const InputDecoration(labelText: 'Topic Name'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _pickAudio,
              child: const Text('Pick Audio'),
            ),
            const SizedBox(height: 16.0),
            if (audioFileResult != null)
              Text('Audio Selected: ${audioFileResult!.files.single.path}'),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _uploadAudio,
              child: const Text('Upload Audio'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _uploadAudio() async {
    if (audioFileResult != null) {
      File file = File(audioFileResult!.files.single.path!);
      Reference ref = FirebaseStorage.instance.ref().child('audios').child(
          '${DateTime.now().millisecondsSinceEpoch}.${file.path.split('.').last}');
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      String audioUrl = await taskSnapshot.ref.getDownloadURL();

      await audioCollection.add({
        'topicName': topicNameController.text,
        'audioUrl': audioUrl,
      });

      Navigator.pop(context);
    }
  }

  Future<void> _pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav'], // Add more extensions if needed
    );

    if (result != null) {
      setState(() {
        audioFileResult = result;
      });
    }
  }
}
