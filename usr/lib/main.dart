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
    title: 'O.J. Simpson Murder Case',
    citation: 'People of the State of California v. Orenthal James Simpson',
    year: '1995',
    location: 'Los Angeles, California, USA',
    summary: 'A criminal trial held in Los Angeles County Superior Court in which former American football star and actor O. J. Simpson was tried on two counts of murder for the June 12, 1994, slashing deaths of his ex-wife, Nicole Brown Simpson, and her friend Ron Goldman.',
    verdict: 'Not guilty of both murders.',
  ),
  MurderCase(
    title: 'Ted Bundy Trials',
    citation: 'State of Florida v. Theodore Robert Bundy',
    year: '1979',
    location: 'Miami, Florida, USA',
    summary: 'Theodore Robert Bundy was an American serial killer who kidnapped, raped, and murdered numerous young women and girls during the 1970s and possibly earlier. His trial in Florida was the first to be nationally televised in the United States.',
    verdict: 'Guilty of two counts of first-degree murder, three counts of attempted first-degree murder, and two counts of burglary. Sentenced to death.',
  ),
  MurderCase(
    title: 'Charles Manson Trial',
    citation: 'People of the State of California v. Charles Manson et al.',
    year: '1970-1971',
    location: 'Los Angeles, California, USA',
    summary: 'The trial of Charles Manson and members of his "Family" for the Tate-LaBianca murders, a series of killings carried out in August 1969. The prosecution argued that Manson directed his followers to commit the murders to incite a race war.',
    verdict: 'Guilty of first-degree murder and conspiracy to commit murder. Sentenced to death (later commuted to life imprisonment).',
  ),
  MurderCase(
    title: 'Casey Anthony Trial',
    citation: 'State of Florida v. Casey Marie Anthony',
    year: '2011',
    location: 'Orlando, Florida, USA',
    summary: 'Casey Anthony was tried for the first-degree murder of her two-year-old daughter, Caylee. The case garnered massive media attention and was characterized by controversial forensic evidence and changing timelines.',
    verdict: 'Not guilty of first-degree murder, aggravated child abuse, and aggravated manslaughter of a child. Guilty of four misdemeanor counts of providing false information to a law enforcement officer.',
  ),
  MurderCase(
    title: 'Lizzie Borden Trial',
    citation: 'Commonwealth of Massachusetts v. Lizzie Andrew Borden',
    year: '1893',
    location: 'New Bedford, Massachusetts, USA',
    summary: 'Lizzie Borden was tried for the August 4, 1892, axe murders of her father and stepmother in Fall River, Massachusetts. The case was a cause célèbre throughout the United States.',
    verdict: 'Not guilty.',
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
