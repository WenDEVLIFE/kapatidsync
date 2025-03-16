import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import '../model/KidModelII.dart';

class ExcelService {
  Future<void> saveKidCollectionToExcel(List<KidModelII> kidCollection) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Kid Collection'];

    // Add header row
    sheetObject.appendRow([
      'Kid Name',
      'Age',
      'Gender',
      'Purok',
      'Attendance Status',
      'Time In'
    ]);

    // Add data rows
    for (var kid in kidCollection) {
      sheetObject.appendRow([
        kid.kidName,
        kid.kidAge,
        kid.kidGender,
        kid.kidPurok,
        kid.isPresent,
        kid.isPresent == 'Present' ? kid.kidTimeIn : 'No Time In'
      ]);
    }

    // Save the file to the downloads folder
    Directory? directory = await getExternalStorageDirectory();
    String newPath = "";
    List<String> paths = directory!.path.split("/");
    for (int x = 1; x < paths.length; x++) {
      String folder = paths[x];
      if (folder != "Android") {
        newPath += "/" + folder;
      } else {
        break;
      }
    }
    newPath = newPath + "/Download";
    directory = Directory(newPath);

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    String filePath = "${directory.path}/KidCollection.xlsx";
    File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.encode()!);
  }
}