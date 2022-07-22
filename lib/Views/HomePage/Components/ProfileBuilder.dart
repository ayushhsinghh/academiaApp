import 'package:flutter/material.dart';

import '../../../models/Details.dart';
import '../../Profile/ProfilePage.dart';

ProfileBuilder(AsyncSnapshot<Details> snapshot) {
  return ProfilePage(
    studentInfo: snapshot.data!,
  );
}
