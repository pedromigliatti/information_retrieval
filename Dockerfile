FROM ppc64le/python
# FROM ibmcom/pytorch-ppc64le

LABEL "maintaner"="Pedro Henrique Migliatti"

ENV PATH /opt/conda/bin:$PATH
RUN apt-get -y update

RUN curl -o /tmp/Anaconda3.sh https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-ppc64le.sh
RUN chmod +x /tmp/Anaconda3.sh
RUN /tmp/Anaconda3.sh -b -p /opt/conda
RUN ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh
RUN echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc
RUN echo "conda activate base" >> ~/.bashrc
RUN conda install -c anaconda pytorch

RUN python -m pip install --upgrade pip --user

RUN apt-get -y install rustc

ADD . /information_retrieval/

WORKDIR	/information_retrieval/

RUN pip install -r /information_retrieval/requirements.txt --user
RUN pip uninstall numpy -y
RUN pip install numpy --user

EXPOSE 5050

ENTRYPOINT ["python", "main.py"]
