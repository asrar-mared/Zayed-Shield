#ifndef SHORTCUTS_H
#define SHORTCUTS_H

// تهيئة نظام الاختصارات
void init_shortcuts();

// معالجة أي مفتاح لمعرفة هل هو اختصار
// يرجع 1 إذا تم تنفيذ اختصار
// يرجع 0 إذا كان مفتاح عادي
int handle_shortcut(int key);

#endif
