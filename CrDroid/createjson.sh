#!/bin/bash
# Put script in crDroid source folder, make executable (chmod +x createupdate.sh) and run it (./createupdate.sh)

#Leave blank if not used
maintainer="iTS_UDAY_404"
oem="xiaomi" #ex : OnePlus
device="miatoll" #ex: miatoll
devicename="Redmi Note 9 Pro Series" #ex: OnePlus 7 Pro
zip="crDroidAndroid-<android version>-<date>-<device codename>-v<crdroid version>.zip" 
#ex: crDroidAndroid-<android version>-<date>-<device codename>-v<crdroid version>.zip
buildtype="Monthly" #choose from Testing/Alpha/Beta/Weekly/Monthly
forum="" #https link (mandatory)
gapps="" 
firmware="" #https link (leave empty if unused)
modem="" #https link (leave empty if unused)
bootloader="" #https link (leave empty if unused)
recovery="" #https link (leave empty if unused)
paypal="" #https link (leave empty if unused)
telegram="https://t.me/itz_miatoll_zone404" #https link (leave empty if unused)
dt="" #https://github.com/crdroidandroid/android_device_<oem>_<device_codename>
commondt="" #https://github.com/crdroidandroid/android_device_<orm>_<SOC>-common
kernel="" #https://github.com/crdroidandroid/android_kernel_<oem>_<SOC>


#don't modify from here
script_path="`dirname \"$0\"`"
zip_name=$script_path/out/target/product/$device/$zip
buildprop=$script_path/out/target/product/$device/system/build.prop

if [ -f $script_path/$device.json ]; then
  rm $script_path/$device.json
fi

linenr=`grep -n "ro.system.build.date.utc" $buildprop | cut -d':' -f1`
timestamp=`sed -n $linenr'p' < $buildprop | cut -d'=' -f2`
zip_only=`basename "$zip_name"`
md5=`md5sum "$zip_name" | cut -d' ' -f1`
sha256=`sha256sum "$zip_name" | cut -d' ' -f1`
size=`stat -c "%s" "$zip_name"`
version=`echo "$zip_only" | cut -d'-' -f5`
v_max=`echo "$version" | cut -d'.' -f1 | cut -d'v' -f2`
v_min=`echo "$version" | cut -d'.' -f2`
version=`echo $v_max.$v_min`

echo '{
  "response": [
    {
        "maintainer": "'$maintainer'",
        "oem": "'$oem'",
        "device": "'$devicename'",
        "filename": "'$zip_only'",
        "download": "https://sourceforge.net/projects/crdroid/files/'$device'/'$v_max'.x/'$zip_only'/download",
        "timestamp": '$timestamp',
        "md5": "'$md5'",
        "sha256": "'$sha256'",
        "size": '$size',
        "version": "'$version'",
        "buildtype": "'$buildtype'",
        "forum": "'$forum'",
        "gapps": "'$gapps'",
        "firmware": "'$firmware'",
        "modem": "'$modem'",
        "bootloader": "'$bootloader'",
        "recovery": "'$recovery'",
        "paypal": "'$paypal'",
        "telegram": "'$telegram'",
        "dt": "'$dt'",
        "common-dt": "'$commondt'",
        "kernel": "'$kernel'"
    }
  ]
}' >> $device.json