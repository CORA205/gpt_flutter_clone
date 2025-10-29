import 'package:flutter/material.dart';
import '../models/ChatMessage.dart';
import '../widgets/message_widget.dart';
import '../api/api.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  final List<ChatMessage> _messages = [];

  final TextEditingController _textController = TextEditingController();

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(message: text, isUser: true));
    });
    ApiService().sendMessage(text).then((response) {
      setState(() {
        _messages.add(ChatMessage(message: response, isUser: false));
      });
    });
    _textController.clear();
  }

  void _menu() {
    debugPrint("☰ Menu");
  }

  void _pickFile() {
    debugPrint("📎 Importer un fichier");
  }

  void _startVoiceInput() {
    debugPrint("🎙️ Démarrer l’enregistrement vocal");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _menu,
          icon: const Icon(Icons.menu, color: Colors.white70),
        ),
        title: const Text("Mon application GPT"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            // === Zone des messages ===
            Expanded(
              child: Container(
                color: Colors.black,
                child: Center(
                  child: _messages.isEmpty
                      ? const Center(
                          child: Text(
                            "Comment puis-je vous aider ?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: ListView.builder(
                            itemCount: _messages.length,
                            itemBuilder: (context, index) {
                              final massage = _messages[index];
                              return MessageWidget(
                                message: massage.message,
                                isUser: massage.isUser,
                              );
                            },
                          ),
                      ),
                ),
              ),
            ),

            // === Barre d’entrée ===
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.black,
              child: Row(
                children: [
                  // Champ de saisie + bouton envoyer
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF343541),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.grey[700]!),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.attach_file,
                              color: Colors.white70,
                            ),
                            onPressed: _pickFile,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _textController,
                              decoration: InputDecoration(
                                hintText: "Posez votre question...",
                                hintStyle: TextStyle(color: Colors.grey[500]),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: const TextStyle(color: Colors.white),
                              maxLines: null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.mic, color: Colors.white70),
                            onPressed: _startVoiceInput,
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                                size: 20,
                              ),
                              onPressed: () =>
                                  _sendMessage(_textController.text),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
