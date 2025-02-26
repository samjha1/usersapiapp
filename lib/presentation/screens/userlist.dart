import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users/core/error.dart';
import 'package:users/presentation/providers/provider.dart';
import 'package:users/presentation/screens/userdetails.dart';
import 'package:users/presentation/widgets/AnimatedUserCard.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showSearchField = false;

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            floating: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            stretch: true,
            actions: [
              AnimatedOpacity(
                opacity: _showSearchField ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: IconButton(
                  icon: const Icon(Icons.search, size: 28),
                  onPressed: () {
                    setState(() {
                      _showSearchField = true;
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 20),
              title: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _showSearchField
                    ? Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.9,
                        margin: const EdgeInsets.only(bottom: 10, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search users...',
                            hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.6),
                              fontSize: 14,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Theme.of(context).colorScheme.primary,
                              size: 20,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 16.0,
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.close, size: 20),
                              onPressed: () {
                                _searchController.clear();
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .searchUsers('');
                                setState(() {
                                  _showSearchField = false;
                                });
                              },
                            ),
                          ),
                          onChanged: (value) {
                            Provider.of<UserProvider>(context, listen: false)
                                .searchUsers(value);
                          },
                        ),
                      )
                    : const Text(
                        'User Directory',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primary.withOpacity(0.8),
                      Theme.of(context).colorScheme.primaryContainer,
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -30,
                      top: -20,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      left: -40,
                      bottom: 0,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 60),
                        child: Row(
                          children: [
                            Consumer<UserProvider>(
                              builder: (context, provider, _) {
                                final userCount = provider.filteredUsers.length;
                                return Text(
                                  '$userCount ${userCount == 1 ? 'User' : 'Users'}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Users',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  if (!_showSearchField)
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: PopupMenuButton<String>(
                        icon: const Icon(Icons.filter_list),
                        onSelected: (value) {
                          // Implement filtering logic
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'name_asc',
                            child: Text('Name (A-Z)'),
                          ),
                          const PopupMenuItem(
                            value: 'name_desc',
                            child: Text('Name (Z-A)'),
                          ),
                          const PopupMenuItem(
                            value: 'id_asc',
                            child: Text('ID (Low-High)'),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              if (userProvider.isLoading) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (userProvider.error != null) {
                return SliverFillRemaining(
                  child: Center(
                    child: ErrorDisplay(
                      error: userProvider.error!,
                      onRetry: () => userProvider.fetchUsers(),
                    ),
                  ),
                );
              }

              if (userProvider.filteredUsers.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No users found',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.7),
                                  ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final user = userProvider.filteredUsers[index];
                      final avatarColor = _getAvatarColor(user.id);

                      return AnimatedUserCard(
                        user: user,
                        avatarColor: avatarColor,
                        index: index,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UserDetailScreen(user: user),
                            ),
                          );
                        },
                      );
                    },
                    childCount: userProvider.filteredUsers.length,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final userProvider =
              Provider.of<UserProvider>(context, listen: false);
          userProvider.fetchUsers();

          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Color _getAvatarColor(int id) {
    // Generate consistent colors based on user ID
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
      Colors.amber,
      Colors.deepPurple,
      Colors.lightBlue,
    ];

    return colors[id % colors.length];
  }
}
