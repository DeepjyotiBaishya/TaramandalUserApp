# rashi_network

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

### Release Keystore

Variant: release
Config: release
Store: D:\Projects\Network\rashi_network\keystore.jks
Alias: upload
MD5: 18:36:0F:81:CC:C8:E2:AD:31:A0:3A:AC:B2:C4:9A:D3
SHA1: AC:0A:65:6C:9D:7C:0E:6D:88:08:4C:8E:C7:14:03:75:F8:BF:81:FC
SHA-256: D8:B0:13:CA:DA:A1:24:B2:64:FE:E0:8A:D7:35:8A:57:61:CE:B7:FD:B1:1C:7A:32:56:E6:C1:50:0D:D9:3A:E9
Valid until: Wednesday, 5 October, 2050


### Debug Keystore


Variant: debug
Config: debug
Store: C:\Users\Sam\.android\debug.keystore
Alias: AndroidDebugKey
MD5: 61:D4:8D:B9:EC:03:77:4D:0F:5D:B1:27:7F:5C:D5:18
SHA1: 35:BF:E5:C3:18:3E:11:33:E3:FF:BC:99:31:D6:50:79:9A:9D:4A:CC
SHA-256: 86:D2:B7:F1:1C:16:DD:D3:62:85:27:70:02:73:51:FB:99:AB:61:86:04:C3:34:C3:1A:0C:A5:F4:42:B8:60:25
Valid until: Tuesday, 10 October, 2051

---

keytool -list -v -alias androiddebugkey -keystore C:/Users/Sam/.android/debug.keystore android
gradle signingReport //deep

flutter build apk --split-per-abi --no-tree-shake-icons
