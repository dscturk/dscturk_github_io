import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;

void main() async {
  var assetManifest = "";
  if (await File('build/web/assets/AssetManifest.json').exists()) {
    var _assetManifest = jsonDecode(
        await File('build/web/assets/AssetManifest.json').readAsString());

    for (var key in _assetManifest.keys) {
      var index = 0;
      for (var value in _assetManifest[key]) {
        _assetManifest[key][index] = '../../../../../../assets/' + value;
        index++;
      }
    }

    assetManifest = jsonEncode(_assetManifest);
  }

  var fontManifest = "";
  if (await File('build/web/assets/FontManifest.json').exists()) {
    var _fontManifest =
        await File('build/web/assets/FontManifest.json').readAsString();

    fontManifest = _fontManifest.replaceAll(
        '"asset":"', '"asset":"../../../../../../assets/');
  }

  if (await File('build/web/index_post.html').exists()) {
    await File('build/web/index_post.html').delete();
  }

  if (await Directory('build/web/blog').exists()) {
    var files = await Directory('build/web/blog').list(recursive: true);
    await for (var file in files) {
      if (file.path.endsWith('.html')) {
        if (assetManifest.length > 0) {
          if (await File(p.join(
                  file.parent.uri.toString(), 'assets', 'AssetManifest.json'))
              .exists()) {
            await File(p.join(
                    file.parent.uri.toString(), 'assets', 'AssetManifest.json'))
                .delete();
          }
          var assetManifestJson = await File(p.join(
                  file.parent.uri.toString(), 'assets', 'AssetManifest.json'))
              .create(recursive: true);
          await assetManifestJson.writeAsString(assetManifest);
        }

        if (fontManifest.length > 0) {
          if (await File(p.join(
                  file.parent.uri.toString(), 'assets', 'FontManifest.json'))
              .exists()) {
            await File(p.join(
                    file.parent.uri.toString(), 'assets', 'FontManifest.json'))
                .delete();
          }
          var fontManifestJson = await File(p.join(
                  file.parent.uri.toString(), 'assets', 'FontManifest.json'))
              .create(recursive: true);
          await fontManifestJson.writeAsString(fontManifest);
        }
      }
    }
  }
}