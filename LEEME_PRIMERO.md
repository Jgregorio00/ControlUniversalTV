# Control Universal TV — NIKKEL (Android TV) + Samsung

**Versión 2.0 · Proyecto Android Studio · Java · Sin anuncios · Red local**

## Qué incluye

- Pantalla de control remoto en español, con botones de navegación, encendido, volumen, canales, entradas, números y reproducción.
- Selector de protocolo **NIKKEL / Android TV** o **Samsung Smart TV**.
- NIKKEL y otras marcas que ejecuten **Android TV o Google TV con Android TV Remote Service v2**: búsqueda mDNS, conexión por IP, vinculación con código de 6 caracteres en la pantalla, TLS y reconexión con certificado almacenado.
- Samsung Smart TV **Tizen**: WebSocket por IP, descubrimiento SSDP, autorización en pantalla, token local.
- Las teclas se envían directamente desde el celular al TV. No hay conexión con servicios web ni se necesitan credenciales.

**Compatibilidad importante:** que el TV tenga Play Store no garantiza que incluya Android TV Remote Service. No existe una implementación universal de Wi-Fi válida para todos los televisores NIKKEL. Tampoco se puede garantizar que todos los botones respondan. No está probado en un televisor físico.

## Para obtener el APK desde Windows

1. Instala [Android Studio](https://developer.android.com/studio) y el **Android SDK API 35 (Android 15)**, junto con SDK Build-Tools.
2. Extrae por completo el ZIP en una carpeta de Windows (no ejecutes los archivos dentro del ZIP).
3. Haz doble clic en **`COMPILAR_APK_WINDOWS.bat`**. La primera compilación necesita conexión a Internet para descargar Gradle y el complemento de Android.
4. Si finaliza correctamente, se creará `ControlUniversalTV_NIKKEL_Samsung.apk` en la misma carpeta.
5. Pasa el APK al Android y ábrelo para instalarlo. Autoriza la instalación desde esa fuente si Android te lo solicita.

En Android Studio también puedes abrir este proyecto y ejecutar **Build > Build APK(s)**.

## Cómo conectar el NIKKEL

1. Enciende el televisor NIKKEL y el celular. Ambos deben estar conectados a la misma red Wi-Fi o LAN.
2. Abre **Control Universal TV** y pulsa **NIKKEL / Android TV**.
3. Pulsa **Buscar televisores compatibles**. Si no aparece, consulta en tu NIKKEL **Ajustes > Red** y escribe su IP privada (ejemplo: `192.168.1.45`) en el control.
4. Pulsa **Conectar**.
5. Si tu TV es compatible, mostrará un **código de 6 caracteres**. Escríbelo en el campo de vinculación de *esta misma aplicación* y toca **Vincular**.
6. Cuando aparezca **NIKKEL / Android TV conectado**, prueba **INICIO**, flechas, OK y volumen.

Si no sale un código o hay un mensaje de conexión rechazada, el televisor podría usar otro sistema de control. En ese caso, se necesita la referencia exacta del modelo y versión del sistema para desarrollar un adaptador adicional.

## Cómo conectar Samsung

Selecciona **Samsung Smart TV** y pulsa **Buscar televisores compatibles** (o escribe la IP). Al conectar, acepta **Permitir** en la pantalla Samsung. Se conservan los controles y opciones de la versión anterior.

## Limitaciones / advertencias técnicas

- Se necesita **Android 8.0 o posterior** en el celular.
- Los Android TV deben disponer de **Android TV Remote Service v2** (normalmente puertos TLS 6466/6467), habilitado y accesible por la red local. La aplicación no intenta activar el servicio ni instalar software en el TV.
- El encendido desde reposo depende de opciones como Wake-on-LAN y del hardware; el botón de encendido puede servir solo para apagar.
- Algunas funciones como números, canales, botones de colores o cambio HDMI pueden no ser reconocidas por todos los Android TV.
- La identidad cliente de Android TV se mantiene en Android Keystore. El código mostrado en pantalla verifica criptográficamente el emparejamiento; el certificado del TV se registra por IP tras autorizarlo. No se envían datos a terceros.
- Si Android Studio está actualizado puede pedir actualizar gradle; esta carpeta usa AGP 8.7.3 y Gradle 8.9.
- **Este ZIP es el proyecto para compilar, NO un APK ya instalado.** Las pruebas realizadas aquí comprueban sintaxis y lógica del protocolo, no el funcionamiento en el TV físico. El entorno donde se desarrolló no tiene Android SDK disponible para generar directamente el `.apk`.

## Archivos destacados

- `app/src/main/assets/index.html`: interfaz del control.
- `app/src/main/java/com/controluniversal/samsung/AndroidTvRemote.java`: protocolo Android TV v2 sin librerías externas.
- `app/src/main/java/com/controluniversal/samsung/AndroidTvIdentity.java`: identidad TLS con Android Keystore.
- `app/src/main/java/com/controluniversal/samsung/MainActivity.java`: selector, búsqueda, Samsung y vinculación NIKKEL.
- `COMPILAR_APK_WINDOWS.bat`: compilación automatizada en Windows.
- `tests/AndroidTvProtoTest.java`: tests de protobuf y enmarcado de mensajes.

## Fuentes para compatibilidad técnica

- [Protocolo Android TV Remote v2 (referencia)](https://github.com/tronikos/androidtvremote2).
- [Protocolo de emparejamiento](https://android.googlesource.com/platform/external/google-tv-pairing-protocol/).

Código escrito para este proyecto; la implementación del protocolo se basa en documentación pública y esquemas de mensajes abiertos.
