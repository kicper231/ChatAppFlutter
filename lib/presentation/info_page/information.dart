import 'package:chatapp/presentation/gaps.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key, required this.email, required this.image});
  final String? email;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color.fromARGB(255, 251, 251, 251),
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              gapH4,
              Padding(
                padding: const EdgeInsets.only(top: 0, right: 0, bottom: 0),
                child: Hero(
                    tag: 'avatar',
                    child: CircleAvatar(
                      radius: 50,
                      child: ClipOval(
                        child: image != null
                            ? Image.network(image!)
                            : const Icon(Icons.person,
                                size: 90, color: Colors.white),
                      ),
                    )),
              ),
              gapH8,
              Text(email!,
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onSurfaceVariant)),
              gapH12,
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      boxShadow: [
                        BoxShadow(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3))
                      ]),
                  child: GestureDetector(
                    onTap: () {
                      context.pushNamed('friend_list');
                    },
                    child: const Row(
                      children: [
                        gapW12,
                        gapW16,
                        Icon(Icons.person, size: 25),
                        gapW12,
                        gapW8,
                        Text("Edit Friends List",
                            style: TextStyle(fontSize: 16))
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      boxShadow: [
                        BoxShadow(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3))
                      ]),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Row(
                      children: [
                        gapW12,
                        gapW16,
                        Icon(Icons.person, size: 25),
                        gapW12,
                        gapW8,
                        Text("Edit Password", style: TextStyle(fontSize: 16))
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      boxShadow: [
                        BoxShadow(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3))
                      ]),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Row(
                      children: [
                        gapW12,
                        gapW16,
                        Icon(Icons.person, size: 25),
                        gapW12,
                        gapW8,
                        Text("Delete Account", style: TextStyle(fontSize: 16))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}






// Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Container(
//                   height: 100,
//                   decoration: BoxDecoration(
//                       color: Theme.of(context).colorScheme.secondaryContainer,
//                       boxShadow: [
//                         BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: 5,
//                             blurRadius: 7,
//                             offset: const Offset(0, 3))
//                       ]),
//                 ),
//               ),