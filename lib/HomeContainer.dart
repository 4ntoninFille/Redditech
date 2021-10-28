import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/PostDisplayController.dart';
import 'package:flutter_application_1/globals.dart';
import 'package:draw/draw.dart';

import 'FeedWidget.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        CommunitiesWidget(),
        FeedWidget(),
      ],
    );
  }
}

class CommunitiesWidget extends StatelessWidget {
  const CommunitiesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // redditor!.
    return Container(
      height: 170,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary,
            spreadRadius: 2,
            blurRadius: 3,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0),
            child: Text(
              "Communities",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.0,
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: ComunitiIconeName(),
          )
        ],
      ),
    );
  }
}

class ComunitiIconeName extends StatelessWidget {
  const ComunitiIconeName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fillCommunities(),
      builder: (BuildContext context, AsyncSnapshot<List<SubredditRef>> list) {
        if (list.connectionState == ConnectionState.done) {
          if (!list.hasData) {
            return Center(child: Text("null"));
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.data!.length,
            itemBuilder: (context, index) {
              Subreddit subred = list.data![index] as Subreddit;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/postSubreddit',
                        arguments: PostArguments(subred));
                  },
                  child: Container(
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.8),
                                  spreadRadius: 2,
                                  blurRadius: 6,
                                  offset: Offset(0, 7),
                                )
                              ],
                            ),
                            child: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              radius: 30,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.transparent,
                                foregroundImage:
                                    NetworkImage(subred.iconImage.toString()),
                                onForegroundImageError: (test, err) {},
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            'r/' + subred.displayName,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

Future<List<SubredditRef>> fillCommunities() async {
  List<Widget> commu = [];
  final data = redditech!.user.subreddits(limit: 20);
  final result = await data.toList();

  return result;
}

 // Column(
    //   children: [
    //     Text("Communities"),
    //     Container(
    //       margin: const EdgeInsets.symmetric(vertical: 20.0),
    //       height: 100,
    //       child: ListView.builder(itemBuilder: (context, index),),
          // child: ListView(
          //   scrollDirection: Axis.horizontal,
          //   children: <Widget>[
          //     Container(
          //       width: 160.0,
          //       color: Colors.red,
          //     ),
          //     Container(
          //       width: 160.0,
          //       color: Colors.blue,
          //     ),
          //     Container(
          //       width: 160.0,
          //       color: Colors.green,
          //     ),
          //     Container(
          //       width: 160.0,
          //       color: Colors.yellow,
          //     ),
          //     Container(
          //       width: 160.0,
          //       color: Colors.orange,
          //     ),
          //   ],
          // ),