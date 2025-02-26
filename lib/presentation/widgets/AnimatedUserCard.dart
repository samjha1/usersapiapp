import 'package:flutter/material.dart';

class AnimatedUserCard extends StatelessWidget {
  final dynamic user;
  final Color avatarColor;
  final int index;
  final VoidCallback onTap;

  const AnimatedUserCard({
    Key? key,
    required this.user,
    required this.avatarColor,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AlwaysStoppedAnimation(1.0),
      builder: (context, child) {
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 300 + (index * 50)),
          curve: Curves.easeOutQuint,
          builder: (context, double value, child) {
            return Transform.translate(
              offset: Offset(0, (1 - value) * 50),
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.only(bottom: 12.0),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Hero(
                      tag: 'avatar-${user.id}',
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: avatarColor,
                        child: Text(
                          user.name.isNotEmpty
                              ? user.name[0].toUpperCase()
                              : '?',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: 'name-${user.id}',
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                user.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.email_outlined,
                                size: 14,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  user.email,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.7),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.business_outlined,
                                size: 14,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  user.company.name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.7),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
