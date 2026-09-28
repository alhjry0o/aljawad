# شركة الجواد الدولية العربية — AL-Gawad Group
## التطبيق الرسمي للخدمات والتشغيل والصيانة (Flutter Mobile & Web)

تطبيق رسمي متكامل وعالي الاحترافية مصمم ومطور خصيصاً لـ **شركة الجواد الدولية العربية (AL-Gawad Group)**، لتقديم وإدارة خدمات التشغيل والصيانة، النظافة الشاملة، تنظيف الواجهات المرتفعة، مكافحة الآفات، العزل، توفير الكوادر، تأجير المعدات، وإدارة المرافق الكبرى.

الموقع الرسمي للشركة: [aljawadservices.com](https://aljawadservices.com)

---

## Developer / Credits — معلومات وحقوق المطور

* **Developed by:** Abdullah AL-Hjry
* **Arabic Name:** عبدالله الحجري
* **Role:** Senior Flutter Developer & Mobile Architect
* **Contact Phone / WhatsApp:** [+967779966185](tel:+967779966185)
* **Copyright:** © 2026 Abdullah AL-Hjry. All Rights Reserved.

تم بناء هذا المشروع بأعلى معايير جودة الكود (Clean Architecture)، وإدارة الحالة الاحترافية عبر **Riverpod**، وتوجيه المسارات المتقدم عبر **GoRouter**، ودعم كامل للغة العربية والاتجاه من اليمين لليسار (RTL).

---

## 📱 متطلبات التشغيل (Requirements)

* **Flutter SDK:** `>= 3.0.0 < 4.0.0`
* **Dart SDK:** `>= 3.0.0`
* **Android Target:** Android 8.0 (API 26) أو أعلى
* **Flutter Web Support:** مدعوم بالكامل وجاهز للإنتاج والاستضافة الثابتة.

---

## 🚀 أوامر التشغيل والبناء (Build & Run Instructions)

### 1. تثبيت الحزم والمكتبات
```bash
flutter pub get
```

### 2. تشغيل التطبيق في وضع التطوير
```bash
# تشغيل على محاكي أو جهاز أندرويد متصل
flutter run

# تشغيل على متصفح الويب (Chrome)
flutter run -d chrome
```

### 3. بناء نسخة الأندرويد (Release APK)
لإنشاء ملف APK جاهز للتثبيت المباشر على أجهزة أندرويد للمعاينة والعرض على إدارة الشركة:
```bash
flutter build apk --release
```
يتم إنشاء الملف في المسار:
`build/app/outputs/flutter-apk/app-release.apk`

### 4. بناء حزمة النشر لمتجر جوجل بلاي (Android App Bundle - AAB)
عند اعتماد التطبيق من قبل إدارة الشركة والرغبة في النشر على Google Play Console:
```bash
flutter build appbundle --release
```
يتم إنشاء ملف الحزمة في:
`build/app/outputs/bundle/release/app-release.aab`

> **ملاحظة بخصوص معرف التطبيق (Application ID):**
> تم ضبط المعرف الافتراضي في `android/app/build.gradle` كالتالي:
> `applicationId "com.aljawad.services"`
> يمكنك تعديله إلى المعرف النهائي الذي تعتمده إدارة الشركة قبل النشر على Google Play دون التأثير على معمارية الكود.

### 5. بناء نسخة الويب (Flutter Web Release)
لبناء نسخة الويب الجاهزة للعرض عبر المتصفح ورفعها على أي استضافة ثابتة:
```bash
flutter build web --release
```
الملفات الناتجة تقع في:
`build/web/`
يمكنك ضغط هذا المجلد أو رفعه مباشرة على أي خادم ويب (Nginx, Apache, Firebase Hosting, Cloudflare Pages, GitHub Pages) لتشغيل التطبيق والوصول إليه من أي هاتف أو حاسوب عبر الرابط المباشر.

---

## 🎨 دليل تخصيص واستبدال الوسائط والصور (Customizing Assets)

تم تنظيم كافة الصور والوسائط داخل هيكل مجلدات مركزي وموحد، وتم ربطها بملف ثوابت واحد (`AppAssets` في `lib/core/constants/app_assets.dart`).
جميع الصور المستخدمة في التطبيق والمعاينة هي **صور حقيقية كاملة موجودة فعلياً داخل مجلد `assets` في ملف الـ ZIP** وليست روابط خارجية أو Base64.
استبدال هذه الصور لاحقاً بصور حقيقية لا يتطلب أي تعديل في كود Dart إطلاقاً؛ فقط ضع صورتك الجديدة بنفس الاسم والامتداد في المجلد المخصص.

---

### 1. صورة الواجهة الرئيسية (Home Hero Image)
* **المسار داخل المشروع:** `assets/images/hero/home_hero.jpg`
* **اسم الملف:** `home_hero.jpg`
* **الأبعاد الفعلية:** `1376 × 768` بكسل (1376x768 px)
* **نسبة الأبعاد (Aspect Ratio):** `16:9` (1.79:1)
* **الصيغة:** `JPEG / JPG` (8-bit sRGB)
* **الحجم الفعلي على القرص:** `978,623` بايت (~956 KB)
* **الوصف والمواصفات:** لقطة بانورامية عريضة لمبنى ومركز أعمال تجاري حديث يعكس بيئة تشغيل وصيانة المرافق الكبرى. الصورة خالية تماماً من النصوص والشعارات والعلامات المائية، ومدمجة مع طبقة التعتيم الكحلي التلقائية في التطبيق لضمان وضوح نصوص العناوين وشريط البحث وأزرار الطلب.
* **إرشادات الاستبدال:** اختر أي صورة أفقية بنسبة `16:9` (يفضل بدقة 1376×768 أو 1920×1080) وقم بتسميتها `home_hero.jpg` واستبدل الملف داخل مجلد `assets/images/hero/`.

---

### 2. صور المشاريع الأربعة (Projects Images)
* **المسار الموحد داخل المشروع:** `assets/images/projects/`
* **الصيغة لجميع صور المشاريع:** `JPEG / JPG` (8-bit sRGB)
* **نسبة الأبعاد المعتمدة:** `16:9` (متناسقة تماماً مع أبعاد وحجم بطاقات العرض في شاشتي الجوال والويب).

#### جدول المواصفات الفعلية الدقيقة لصور المشاريع:

| المشروع | اسم الملف | المسار الكامل | الأبعاد الفعلية (بكسل) | نسبة الأبعاد | الحجم الفعلي |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **1. برج الأعمال التجاري (واجهات)** | `project_tower_facade.jpg` | `assets/images/projects/project_tower_facade.jpg` | **1376 × 768** | 16:9 | 975,118 بايت (~952 KB) |
| **2. مجمع المستودعات (أرضيات صناعية)** | `project_industrial_floors.jpg` | `assets/images/projects/project_industrial_floors.jpg` | **1376 × 768** | 16:9 | 926,047 بايت (~904 KB) |
| **3. مقر مجموعة استثمارية (مقرات)** | `project_corporate_hq.jpg` | `assets/images/projects/project_corporate_hq.jpg` | **1376 × 768** | 16:9 | 1,078,937 بايت (~1.03 MB) |
| **4. المجمع الطبي التخصصي (طبي)** | `project_medical_center.jpg` | `assets/images/projects/project_medical_center.jpg` | **1376 × 768** | 16:9 | 907,015 بايت (~885 KB) |

#### وصف محتوى الصور التجريبية:
1. **`project_tower_facade.jpg`:** لقطة معمارية تصاعدية لبرج شاهق بواجهات زجاجية وكلادينج عاكسة ونظيفة تحت ضوء النهار بدون أي شعارات أو نصوص.
2. **`project_industrial_floors.jpg`:** لقطة داخلية لصالة صناعية ومستودع لوجستي فسيح بأرضيات إيبوكسي رمادية مصقولة ولامعة تعكس الإضاءة النظيفة.
3. **`project_corporate_hq.jpg`:** واجهة مقر إداري فاخر وحديث بهندسة معمارية زجاجية وساحة مدخل حجرية منسقة تعكس الاحترافية المؤسسية.
4. **`project_medical_center.jpg`:** مبنى مجمع طبي ومستشفى حديث بتصميم معماري ناصع ومساحات مدخل فسيحة ونظيفة.

* **طريقة الاستبدال:** لاستبدال أي صورة، قم بحفظ صورتك بنفس الاسم والامتداد داخل `assets/images/projects/`. ستظهر الصورة الجديدة فوراً في بطاقة المشروع المقابلة دون لمس كود Dart.

---

### 3. شعار الشركة وأيقونة التطبيق (Logo & App Icons)
* **الشعار الأصلي:** `assets/images/logo.png` بدقة `1024 × 1024` بكسل وخلفية شفافة.
* **أيقونة التطبيق (Android Launcher Icons):** متوفرة بجميع المقاسات القياسية داخل `android/app/src/main/res/mipmap-*/`.
* **الأيقونة التكيفية (Adaptive Foreground):** `assets/logo/app_icon_foreground.png`.
* **لون خلفية الأيقونة التكيفية:** `#0B1B3D`.

### 4. صور الخدمات (Service Images)
* **المسار:** `assets/images/services/`
* `cleaning.jpg` — النظافة الشاملة
* `facade_cleaning.jpg` — تنظيف الواجهات المرتفعة
* `industrial_cleaning.jpg` — تنظيف المواقف والمنشآت الصناعية
* `pools.jpg` — تنظيف وصيانة المسابح
* `pest_control.jpg` — مكافحة الآفات
* `insulation.jpg` — العزل المائي والحراري وعزل الخزانات
* `mep.jpg` — السباكة والكهرباء والتكييف
* `manpower.jpg` — توفير العمالة
* `facility_management.jpg` — إدارة وتشغيل وصيانة المرافق
* `equipment_rental.jpg` — تأجير المعدات
* `contracting.jpg` — الإنشاءات والمقاولات

### 5. صور المشاريع (Project Images)
* **المسار:** `assets/images/projects/`
* لإضافة مشروع جديد، ضع الصورة في المجلد وأضف البند في `LocalServiceRepository` داخل `lib/data/repositories/service_repository.dart`.

---

## 🔌 معمارية البيانات والربط المستقبلي مع الخادم (Backend Integration)

يعمل التطبيق حالياً في **النسخة التجريبية (Demo Mode)** باستخدام مستودع محلي `LocalRequestRepository` يحفظ الطلبات في ذاكرة الجهاز المحلية عبر `SharedPreferences`.

تم تصميم المعمارية وفق نمط الواجهة والمستودع (`Repository Pattern`):
```
UI (Widgets & Screens)
        ↓
State Management (Riverpod Providers)
        ↓
IRequestRepository / IServiceRepository (Abstractions)
        ↓
LocalRequestRepository  →  (يمكن استبداله بـ RemoteRequestRepository)
```

عند ربط التطبيق بخادم حقيقي (REST API / GraphQL / Firebase):
1. قم بإنشاء فئة `RemoteRequestRepository implements IRequestRepository`.
2. استبدل مزود المستودع في `lib/core/providers/app_providers.dart`:
```dart
final requestRepositoryProvider = Provider<IRequestRepository>((ref) {
  return RemoteRequestRepository(apiClient);
});
```
دون الحاجة لتعديل أي سطر برمجي داخل شاشات واجهة المستخدم!

---

## 🧪 الاختبارات الآلية (Testing)

لتشغيل الاختبارات البرمجية:
```bash
flutter test
```

---

## 🏢 معلومات التواصل الرسمية لشركة الجواد الدولية العربية

* **المركز الرئيسي:** الرياض، العليا، أمام الرياض جاليري
* **الرقم الموحد:** 920013406
* **الجوال:** 0535091378 | 0561116199
* **واتساب:** 05542471982
* **البريد الإلكتروني:** info@aljawadservices.com
* **الموقع الإلكتروني:** [aljawadservices.com](https://aljawadservices.com)
