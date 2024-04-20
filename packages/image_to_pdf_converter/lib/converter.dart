part of image_to_pdf_converter;



class ImageToPdf {
  static Future<dynamic> imageList({required List<File?> listOfFiles,String? prefix}) async {
    if (listOfFiles.isEmpty) {
      throw "Your List is Empty";
    } else {
      final pdf = pw.Document();
      for (var image in listOfFiles) {
        var pdfImage = pw.MemoryImage(
          image!.readAsBytesSync(),
        );
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Image(pdfImage,fit:pw.BoxFit.fitWidth); // Center
            },
          ),
        );
      }
      Directory appDocDir = await getApplicationDocumentsDirectory();
      final file = File("${appDocDir.path}/${prefix??""}${DateTime.now().toIso8601String()}.pdf");
      final bytes = await pdf.save();
       return await file.writeAsBytes(bytes,flush: true);
    }
  }
}
