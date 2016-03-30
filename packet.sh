#如果apk没有被签名，先使用sign.sh先对未签名的包进行签名，然后运行该sh即可。
#App名字，用于创建文件夹
AppName=APPNAME
echo -n "please input the version name:"
read Version
ROOT=$(cd "$(dirname "$0")"; pwd)
#创建总目录
FOLDER=${ROOT}/${AppName}_Release
#源APK
ApkName=MultiPacketShell

rm -rf META-INF
mkdir META-INF

rm -rf ${FOLDER}
mkdir ${FOLDER}

#这里需要删除Mac下的一个什么隐藏的毛线文件
rm -r META-INF/.DS_Store

for codeAndSource in `cat source_data.txt`; do
	echo "-----$codeAndSource-----";
	CODE=`echo $codeAndSource | cut -d = -f 1`
	SOURCE=`echo $codeAndSource | cut -d = -f 2`
	mkdir ${FOLDER}/${CODE}_${SOURCE}

	#创建渠道文件，以packetcode打头
	touch ${ROOT}/META-INF/packetcode_${CODE}

	cp ${ApkName}.apk ${FOLDER}/${CODE}_${SOURCE}/${AppName}_${Version}.apk

	#将渠道包塞到apk里面
	zip -r ${FOLDER}/${CODE}_${SOURCE}/${AppName}_${Version}.apk META-INF

	rm ${ROOT}/META-INF/packetcode_${CODE}

done

rm -rf META-INF

#read -p "enter to exit"
exit
