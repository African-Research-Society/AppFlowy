import 'package:flutter/material.dart';

import 'package:appflowy_editor/appflowy_editor.dart';

enum EditorNotificationType {
  none,
  undo,
  redo,
  exitEditing,
  paste,
  dragStart,
  dragEnd,
  turnInto,
}

class EditorNotification {
  const EditorNotification({required this.type});

  EditorNotification.undo() : type = EditorNotificationType.undo;
  EditorNotification.redo() : type = EditorNotificationType.redo;
  EditorNotification.exitEditing() : type = EditorNotificationType.exitEditing;
  EditorNotification.paste() : type = EditorNotificationType.paste;
  EditorNotification.dragStart() : type = EditorNotificationType.dragStart;
  EditorNotification.dragEnd() : type = EditorNotificationType.dragEnd;
  EditorNotification.turnInto() : type = EditorNotificationType.turnInto;

  static final PropertyValueNotifier<EditorNotificationType> _notifier =
      PropertyValueNotifier(EditorNotificationType.none);

  final EditorNotificationType type;

  void post() => _notifier.value = type;

  static final Map<ValueChanged<EditorNotificationType>, VoidCallback>
      _listeners = {};

  static void addListener(ValueChanged<EditorNotificationType> listener) {
    removeListener(listener);
    void callback() => listener(_notifier.value);
    _listeners[listener] = callback;
    _notifier.addListener(callback);
  }

  static void removeListener(ValueChanged<EditorNotificationType> listener) {
    final callback = _listeners.remove(listener);
    if (callback != null) {
      _notifier.removeListener(callback);
    }
  }

  static void dispose() => _notifier.dispose();
}
