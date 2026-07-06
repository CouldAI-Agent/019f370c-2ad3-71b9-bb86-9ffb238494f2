import 'package:flutter/material.dart';

void main() {
  runApp(const CaseReferencesApp());
}

class CaseReferencesApp extends StatelessWidget {
  const CaseReferencesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Murder Case References',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const CaseListScreen(),
      },
    );
  }
}

class MurderCase {
  final String title;
  final String citation;
  final String year;
  final String location;
  final String summary;
  final String verdict;

  const MurderCase({
    required this.title,
    required this.citation,
    required this.year,
    required this.location,
    required this.summary,
    required this.verdict,
  });
}

const List<MurderCase> cases = [
  MurderCase(
    title: 'Nusrat Jahan Rafi Murder Case',
    citation: 'State vs Siraj Ud Doula and others',
    year: '2019',
    location: 'Feni, Bangladesh',
    summary: 'Nusrat Jahan Rafi, a 19-year-old madrasa student, was set on fire on the roof of her institution after refusing to withdraw a sexual harassment complaint against the principal. Her death sparked nationwide protests and a demand for swift justice.',
    verdict: 'In October 2019, 16 people, including the principal, were sentenced to death for their involvement in the murder.',
  ),
  MurderCase(
    title: 'Abrar Fahad Murder Case',
    citation: 'State vs Mehedi Hasan Rasel and others',
    year: '2019',
    location: 'BUET, Dhaka, Bangladesh',
    summary: 'Abrar Fahad, a second-year student of Bangladesh University of Engineering and Technology (BUET), was beaten to death in his dormitory (Sher-e-Bangla Hall) by leaders and activists of the university\'s Chhatra League unit over his Facebook post.',
    verdict: 'In December 2021, a Speedy Trial Tribunal sentenced 20 people to death and 5 others to life imprisonment.',
  ),
  MurderCase(
    title: 'Sagar-Runi Murder Case',
    citation: 'Unsolved (Investigation ongoing)',
    year: '2012',
    location: 'Dhaka, Bangladesh',
    summary: 'Sagar Sarowar, a broadcast journalist, and Meherun Runi, a senior reporter, were brutally stabbed to death in their apartment in Dhaka. Despite immense public outcry and multiple investigative bodies taking over, the motive remains unknown.',
    verdict: 'The case remains unsolved as investigators have repeatedly failed to submit the probe report, seeking extensions over 100 times.',
  ),
  MurderCase(
    title: 'Biswajit Das Murder Case',
    citation: 'State vs Rafiqul Islam Shakil and others',
    year: '2012',
    location: 'Old Dhaka, Bangladesh',
    summary: 'Biswajit Das, a 24-year-old tailor, was hacked to death in broad daylight during a nationwide strike. The attackers were identified as members of the Chhatra League. The brutal attack was captured on camera and broadcast on television.',
    verdict: 'In 2013, a speedy trial tribunal sentenced eight people to death and 13 to life in prison. The High Court later upheld two death sentences and commuted others.',
  ),
  MurderCase(
    title: 'Avijit Roy Murder Case',
    citation: 'State vs Syed Mohammad Ziaul Haque and others',
    year: '2015',
    location: 'Dhaka, Bangladesh',
    summary: 'Avijit Roy, a prominent Bangladeshi-American secular activist, blogger, and author, was hacked to death by Islamic extremists wielding machetes near the Ekushey Book Fair at Dhaka University. His wife was also severely injured.',
    verdict: 'In February 2021, an Anti-Terrorism Special Tribunal sentenced five members of the banned militant outfit Ansar al-Islam to death and one to life imprisonment.',
  ),
];

class CaseListScreen extends StatefulWidget {
  const CaseListScreen({super.key});

  @override
  State<CaseListScreen> createState() => _CaseListScreenState();
}

class _CaseListScreenState extends State<CaseListScreen> {
  MurderCase? _selectedCase;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Murder Case References'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 350,
                  child: _buildList(context, isWide: true),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: _selectedCase == null
                      ? const Center(
                          child: Text('Select a case to view details', style: TextStyle(fontSize: 18, color: Colors.grey)),
                        )
                      : CaseDetailView(murderCase: _selectedCase!),
                ),
              ],
            );
          }
          return _buildList(context, isWide: false);
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, {required bool isWide}) {
    return ListView.separated(
      itemCount: cases.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final c = cases[index];
        final isSelected = isWide && _selectedCase == c;
        
        return ListTile(
          title: Text(c.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(c.year),
          selected: isSelected,
          onTap: () {
            if (isWide) {
              setState(() {
                _selectedCase = c;
              });
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CaseDetailScreen(murderCase: c),
                ),
              );
            }
          },
        );
      },
    );
  }
}

class CaseDetailScreen extends StatelessWidget {
  final MurderCase murderCase;

  const CaseDetailScreen({super.key, required this.murderCase});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(murderCase.title),
      ),
      body: CaseDetailView(murderCase: murderCase),
    );
  }
}

class CaseDetailView extends StatelessWidget {
  final MurderCase murderCase;

  const CaseDetailView({super.key, required this.murderCase});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            murderCase.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            murderCase.citation,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontStyle: FontStyle.italic, color: Colors.grey[700]),
          ),
          const SizedBox(height: 24),
          _buildInfoRow(context, Icons.calendar_today, 'Year', murderCase.year),
          const SizedBox(height: 12),
          _buildInfoRow(context, Icons.location_on, 'Location', murderCase.location),
          const SizedBox(height: 32),
          Text(
            'Summary',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            murderCase.summary,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
          ),
          const SizedBox(height: 32),
          Text(
            'Verdict',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              murderCase.verdict,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
