#Install Jellyfish
apt-get -y update
apt-get install -y wget curl g++ build-essential &&\ 
mkdir jellyfish 
cd jellyfish 
wget https://github.com/gmarcais/Jellyfish/releases/download/v2.2.3/jellyfish-2.2.3.tar.gz
tar -xzf jellyfish-2.2.3.tar.gz
cd /jellyfish/jellyfish-2.2.3/ 
./configure 
make

#Install Julia
apt-get install -y software-properties-common python-software-properties 
add-apt-repository -y ppa:staticfloat/juliareleases 
add-apt-repository -y ppa:staticfloat/julia-deps
apt-get -y update  
apt-get install -y julia hdf5-tools
julia -e 'Pkg.add("HDF5"); Pkg.add("ArgParse");'

#Get the CommonKmers code, Install query per sequence and count_in_file
apt-get install -y git
git clone https://github.com/dkoslicki/CommonKmers.git
cd /CommonKmers/src/QueryPerSeq/
g++ -I /jellyfish/jellyfish-2.2.3/include -std=c++0x -Wall -O3 -L /jellyfish/jellyfish-2.2.3/.libs -l jellyfish-2.0 -l pthread -Wl,--rpath=/jellyfish/jellyfish-2.2.3/.libs query_per_sequence.cc sequence_mers.hpp -o query_per_sequence
cp /CommonKmers/src/QueryPerSeq/query_per_sequence /usr/local/bin
cp /CommonKmers/src/Julia/Classify.jl /usr/local/sbin/Classify.jl
cp /CommonKmers/src/Julia/Train.jl /usr/local/sbin/Train.jl
cd /CommonKmers/src/CountInFile/
g++ -I /jellyfish/jellyfish-2.2.3/include -std=c++0x -Wall -O3 -L /jellyfish/jellyfish-2.2.3/.libs -l jellyfish-2.0 -l pthread -Wl,--rpath=/jellyfish/jellyfish-2.2.3/.libs count_in_file.cc -o count_in_file
cp /CommonKmers/src/CountInFile/count_in_file /usr/local/bin
 
#Install Bcalm
wget https://github.com/Malfoy/bcalm/archive/1.tar.gz
tar -zxf 1.tar.gz
cd BCALM-1
make
cp bcalm /usr/local/bin
 
#Install gzip
apt-get install -y gzip
