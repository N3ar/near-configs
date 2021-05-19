#!/bin/bash
INST=$(pwd)/external-installers
TGT_DIR=/usr/local
# TODO Find a way to grab the current version of Linux x86_64 installer every time
# Probably doable with cURL
#wget https://javadl.oracle.com/webapps/download/AutoDL?BundleId=244575_d7fc238d0cb4b0dac67be84580cfb4b -P ${INST}
# TODO for some unknown reason, I can't download the bundle through wget or curl for some reason. I could
# probably spend more time to get the exact request I need but it doesn't seem productive.
ls /usr/local | grep jre
if [ $? -eq 0 ]; then
  echo "JRE already installed. To update JRE, remove and run installer again."
  exit 0
fi

pushd ${INST}
ls | grep jre
if [ $? -eq 1 ]; then

  pushd ~/Downloads
  ls | grep jre
  if [ $? -eq 1 ]; then
    echo "I didn't want to deal with a bunch of cURLs back and forth for an install"
    echo "script so... you have 90 seconds to download the right file before the"
    echo "script continues execution."
    firefox https://java.com/en/download/
    sleep 90
  else
    echo "JRE install tar ball already downloaded, continuing"
  fi

  # mv file to external-installers
  mv $(ls ~/Downloads/jre*) ${INST}
  popd # ~/Downloads

else
  echo "Tar ball already in staging directory: ${INST}"
fi
popd # ${INST}

pushd ${TGT_DIR}
sudo tar zxvf $(ls ${INST}/jre*)
popd

rm ${INST}/jre*
