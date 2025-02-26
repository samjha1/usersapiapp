import 'package:flutter/material.dart';
import 'package:users/domain/entities/user.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserDetailCard(
              title: 'Contact Information',
              content: [
                DetailItem(
                    icon: Icons.person,
                    label: 'Username',
                    value: user.username),
                DetailItem(
                    icon: Icons.email, label: 'Email', value: user.email),
                DetailItem(
                    icon: Icons.phone, label: 'Phone', value: user.phone),
                DetailItem(
                    icon: Icons.web, label: 'Website', value: user.website),
              ],
            ),
            const SizedBox(height: 16),
            UserDetailCard(
              title: 'Address',
              content: [
                DetailItem(
                    icon: Icons.location_on,
                    label: 'Street',
                    value: user.address.street),
                DetailItem(
                    icon: Icons.home,
                    label: 'Suite',
                    value: user.address.suite),
                DetailItem(
                    icon: Icons.location_city,
                    label: 'City',
                    value: user.address.city),
                DetailItem(
                    icon: Icons.pin_drop,
                    label: 'Zipcode',
                    value: user.address.zipcode),
                DetailItem(
                    icon: Icons.map,
                    label: 'Coordinates',
                    value:
                        'Lat: ${user.address.geo.lat}, Lng: ${user.address.geo.lng}'),
              ],
            ),
            const SizedBox(height: 16),
            UserDetailCard(
              title: 'Company',
              content: [
                DetailItem(
                    icon: Icons.business,
                    label: 'Name',
                    value: user.company.name),
                DetailItem(
                    icon: Icons.comment,
                    label: 'Catch Phrase',
                    value: user.company.catchPhrase),
                DetailItem(
                    icon: Icons.work, label: 'BS', value: user.company.bs),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserDetailCard extends StatelessWidget {
  final String title;
  final List<Widget> content;

  const UserDetailCard({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(),
            ...content,
          ],
        ),
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const DetailItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
