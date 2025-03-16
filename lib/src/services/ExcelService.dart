import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../model/KidModelII.dart';

class ExcelService {
  Future<void> saveKidCollectionToExcel(List<KidModelII> kidCollection, String date) async {
    // Request storage permissions
    var status = await Permission.storage.request();
    if (status.isGranted) {
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

      // Format the date to a valid file name format
      String formattedDate = date.replaceAll(RegExp(r'[^\w\s-]'), '_');

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

      String filePath = "${directory.path}/$formattedDate.xlsx";
      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.encode()!);
    } else {
      // Handle the case when permission is not granted
      print("Permission not granted");
    }
  }
}