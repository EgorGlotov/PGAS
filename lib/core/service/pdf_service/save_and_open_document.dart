export 'save_and_open_document_stub.dart'
    if (dart.library.html) 'save_and_open_document_web.dart'
    if (dart.library.io) 'save_and_open_document_mobile.dart';