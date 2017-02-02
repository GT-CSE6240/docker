FROM ubuntu:16.04
MAINTAINER Hang Su <hangsu@gatech.edu>

RUN apt-get update > /dev/null && \
    apt-get install -y -q apt-utils wget bzip2 gcc build-essential git > /dev/null

WORKDIR /root
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh > /dev/null && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -f > /dev/null && \
    rm -f Miniconda3-latest-Linux-x86_64.sh
ENV PATH "/root/miniconda3/bin:$PATH"

# Install scikit-learn, numpy and scipy through conda
# Get pip to download and install other requirements (duplicated with py/requirements.txt for build cache purpose):
RUN conda install -y openblas scikit-learn pandas jupyter gensim nltk murmurhash > /dev/null 
RUN conda install -y matplotlib > /dev/null
# pip install https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.11.0rc0-cp27-none-linux_x86_64.whl > /dev/null && \

RUN pip -q install beautifulsoup4
# for nltk
RUN python -c "import nltk; nltk.download(['stopwords'])"