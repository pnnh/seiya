import 'package:seiya/models/tool.dart';

List<ToolModel> selectTools() {
  List<ToolModel> list = List.empty(growable: true);
  var fileTool = ToolModel(
    urn: 'f1b1b3b4-1b1b-3b1b-4b1b-5b1b6b1b7b1b8',
    name: 'File Tool',
  );
  fileTool.cover = "static/images/common/tools/files.png";
  fileTool.route = "/files";
  list.add(fileTool);

  var noteTool = ToolModel(
    urn: 'f1b1b3b4-1b1b-3b1b-4b1b-5b1b6b1b7b1b8',
    name: 'Note Tool',
  );
  noteTool.cover = "static/images/common/tools/notes.png";
  noteTool.route = "/notes";
  list.add(noteTool);

  var imageTool = ToolModel(
    urn: 'f1b1b3b4-1b1b-3b1b-4b1b-5b1b6b1b7b1b8',
    name: 'Image Tool',
  );
  imageTool.cover = "static/images/common/tools/images.png";
  imageTool.route = "/images";
  list.add(imageTool);

  return list;
}
