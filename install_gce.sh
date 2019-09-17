#!/bin/bash

# Gather CTRL and copy to working directory
git clone https://github.com/salesforce/ctrl.git
mv ctrl/* .

# Cython is needed to compile fastBPE
sudo pip install Cython

# Patch the TensorFlow estimator package
FILE="/usr/local/lib/python2.7/dist-packages/tensorflow_estimator/python/estimator/keras.py"
sudo patch -b "$FILE" estimator.patch

# Install fastBPE
git clone https://github.com/glample/fastBPE.git
cd fastBPE
sudo python setup.py install
cd ..

# Download the 512-length model if specified, 256-length otherwise
if [ "$1" = "512" ]
then
    URL="gs://sf-ctrl/seqlen512_v1.ckpt/"
else
    URL="gs://sf-ctrl/seqlen256_v1.ckpt/"
fi

# Copy model
gsutil -m cp -r "$URL" .
