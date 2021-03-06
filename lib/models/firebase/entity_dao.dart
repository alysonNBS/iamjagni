import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iamjagni/models/firebase/firestore_dao.dart';
import 'package:iamjagni/models/firebase/entity.dart';
import 'package:rxdart/subjects.dart';

class FirebaseEntityDAO<T extends FirebaseEntity> {
  Stream<List<DocumentSnapshot>> _docStream;
  StreamSubscription _docSubscription;

  final StreamController<List<T>> _streamController =
      BehaviorSubject<List<T>>();

  FirebaseEntityDAO(
      String collectionPath, T Function(DocumentSnapshot doc) entityConstructor,
      {bool Function(T) filter, Query Function(CollectionReference) query}) {
    _docStream = FirestoreDAO.queryDocuments(collectionPath, buildQuery: query);

    _docSubscription = _docStream.listen((documents) {
      var modelList = documents.map((doc) => entityConstructor(doc)).toList();
      if (filter != null) {
        modelList = modelList.where(filter).toList();
      }
      modelList.sort();
      _streamController.add(modelList);
    });
  }

  Stream<List<T>> get stream {
    return _streamController.stream;
  }

  void dispose() {
    _streamController.close();
    _docSubscription.cancel();
  }
}

class SingleFirebaseEntityDAO<T extends FirebaseEntity> {
  Stream<DocumentSnapshot> _docStream;
  StreamSubscription _docSubscription;

  final StreamController<T> _streamController = BehaviorSubject<T>();

  SingleFirebaseEntityDAO(
      String documentPath, T Function(DocumentSnapshot doc) entityConstructor,
      {bool Function(T) filter}) {
    _docStream = FirestoreDAO.trackDocumentByPath(documentPath);

    _docSubscription = _docStream.listen((doc) {
      _streamController.add(entityConstructor(doc));
    });
  }

  Stream<T> get stream {
    return _streamController.stream;
  }

  void dispose() {
    _streamController.close();
    _docSubscription.cancel();
  }
}
