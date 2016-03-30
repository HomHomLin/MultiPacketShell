#!/bin/bash
${JAVA_HOME}/bin/jarsigner -digestalg SHA1 -sigalg MD5withRSA -tsa https://timestamp.geotrust.com/tsa -verbose -storepass 你的签名密码 -keystore 签名文件.keystore -signedjar temp.apk release-unsigned.apk “keyAlias”
echo "sign keystore complete"

zipAlign=$(cd "$(dirname "$0")"; pwd)/zipAlign
${zipAlign} -v 4  temp.apk real.apk

echo "ZipAlign complete"
read -p "Press enter to exit"
exit
