import 'package:flutter/material.dart';

class LeaderboardTile extends StatelessWidget {
  final int index;
  final Map<String, dynamic> leaderboard;
  const LeaderboardTile(
      {Key? key, required this.index, required this.leaderboard})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return Container(
        height: 130,
        width: 260,
        margin: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.yellow[400],
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    // shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  leaderboard.keys.toList()[index],
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                    "${leaderboard[leaderboard.keys.toList()[index]] ~/ 60} h ${leaderboard[leaderboard.keys.toList()[index]] % 60} min")

              ],
            ),
          ),
        ),
      );
    } else if (index == 1) {
      return Container(
        height: 120,
        width: 240,
        margin: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    // shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  leaderboard.keys.toList()[index],
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                    "${leaderboard[leaderboard.keys.toList()[index]] ~/ 60} h ${leaderboard[leaderboard.keys.toList()[index]] % 60} min")

              ],
            ),
          ),
        ),
      );
    } else if (index == 2) {
      return Container(
        height: 110,
        width: 220,
        margin: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.brown[400],
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    // shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  leaderboard.keys.toList()[index],
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                    "${leaderboard[leaderboard.keys.toList()[index]] ~/ 60} h ${leaderboard[leaderboard.keys.toList()[index]] % 60} min")
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        height: 80,
        width: 160,
        margin: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    // shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  leaderboard.keys.toList()[index],
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                    "${leaderboard[leaderboard.keys.toList()[index]] ~/ 60} h ${leaderboard[leaderboard.keys.toList()[index]] % 60} min")

              ],
            ),
          ),
        ),
      );
    }
  }
}
