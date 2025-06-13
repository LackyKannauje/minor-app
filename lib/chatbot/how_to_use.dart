import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:animal_rescue_application/chatbot/chatweb.dart';

class HowToUseChatbotPage extends StatelessWidget {
  const HowToUseChatbotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("How to Use Chatbot"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖼 Image with Shadow
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/bot.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Center(
              child: Icon(
                LucideIcons.bot,
                size: 72,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                "Animal Rescue Assistant",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Our chatbot helps with animal rescues. Here's how to use it effectively:",
              style: TextStyle(fontSize: 16, color: Colors.black87),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            Divider(color: Colors.deepPurple.shade100, thickness: 1.2),
            const SizedBox(height: 16),

            _stepTile(
              icon: LucideIcons.messageCircle,
              title: "Start a Conversation",
              description:
                  "Say 'Hi' or 'Hello' to begin chatting with the bot.",
            ),
            _stepTile(
              icon: LucideIcons.helpCircle,
              title: "Ask for Help",
              description:
                  "Type questions like 'What do you do?' or 'How can I report an injured animal?'",
            ),
            _stepTile(
              icon: LucideIcons.alertTriangle,
              title: "Report a Rescue",
              description:
                  "Use phrases like 'I found a lost dog' or 'There's an injured cat' to report issues.",
            ),
            _stepTile(
              icon: LucideIcons.info,
              title: "Get Information",
              description:
                  "Ask about shelters, care guides, or local help centers.",
            ),

            const SizedBox(height: 28),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 3,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatBotWebView()));
                },
                icon: const Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.white,
                ),
                label: const Text(
                  "Start Chatting",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stepTile(
      {required IconData icon,
      required String title,
      required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: Colors.deepPurple),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14.5, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
