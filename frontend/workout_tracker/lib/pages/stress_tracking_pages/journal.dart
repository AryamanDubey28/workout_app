import 'package:flutter/material.dart';

class JournalCard extends StatelessWidget {
  const JournalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Journal',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'Record your thoughts and feelings in your journal.',
            ),
            const SizedBox(height: 10),
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.95,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: const AddJournalEntryPage(),
                      );
                    },
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const ViewAllJournalEntriesPage()),
                  );
                },
                child: const Text('See All'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddJournalEntryPage extends StatelessWidget {
  const AddJournalEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                // Add save logic here
                Navigator.pop(context);
              },
              child: const Text('Done'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                      hintText: 'Write your thoughts here...',
                      border: InputBorder.none,
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
}

class ViewAllJournalEntriesPage extends StatelessWidget {
  const ViewAllJournalEntriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Journal Entries'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: 10, // Replace with actual count of journal entries
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Journal Entry ${index + 1}'),
                subtitle: Text('Sample text for journal entry ${index + 1}...'),
              );
            },
          ),
        ),
      ),
    );
  }
}
