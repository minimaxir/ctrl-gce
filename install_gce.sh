# Gather CTRL and copy to working directory
git clone https://github.com/salesforce/ctrl.git
mv ctrl/* .

# Cython is needed to compile fastBPE
sudo pip install Cython

# Patch the TensorFlow estimator package
FILE="/usr/local/lib/python2.7/dist-packages/tensorflow_estimator/python/estimator/keras.py"
sudo patch -b "$FILE" estimator.patch
sudo awk 'NR==24{print "import tensorflow as tf"}7' "$FILE" > /tmp/out && sudo mv /tmp/out "$FILE"

# Install fastBPE
git clone https://github.com/glample/fastBPE.git
cd fastBPE
sudo python setup.py install
cd ..

URL=""
if [ "$1" == "512" ]; then
    URL="gs://sf-ctrl/seqlen512_v1.ckpt/"
else
    URL="gs://sf-ctrl/seqlen256_v1.ckpt/"
fi

# Copy model
gsutil -m cp -r $URL .
