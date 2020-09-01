import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Database {}

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  void createJob(Map<String, dynamic> jobData) {
    final path = '/user/$uid/jobs/job_abc';
    final documentReference = FirebaseFirestore.instance.doc(path);
  }
}
