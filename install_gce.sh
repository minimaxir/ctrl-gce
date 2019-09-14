# Gather CTRL and copy to working directory
git clone https://github.com/salesforce/ctrl.git
mv ctrl/* .

# Install TensorFlow into Python 2
# cython is needed to compile fastBPE
sudo pip2 install /opt/deeplearning/binaries/tensorflow/tensorflow_gpu-1.14.0-cp27-cp27mu-linux_x86_64.whl cython

# Patch the newly-installed TensorFlow
sudo patch -b -R /usr/local/lib/python2.7/dist-packages/tensorflow_estimator/python/estimator/keras.py estimator.patch

# Install fastBPE
git clone https://github.com/glample/fastBPE.git
cd fastBPE
sudo g++ -std=c++11 -pthread -O3 fastBPE/main.cc -IfastBPE -o fast
sudo python2.7 setup.py install
cd ..

# Copy model
gsutil -m cp -r gs://sf-ctrl/seqlen256_v1.ckpt/ .
