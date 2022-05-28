FROM python:3.7-stretch

LABEL "maintaner"="Pedro Henrique Migliatti"

RUN python -m pip install --upgrade pip

ADD . /information_retrieval/

WORKDIR	/information_retrieval/

RUN pip install -r /information_retrieval/requirements.txt

EXPOSE 5050

ENTRYPOINT ["python", "main.py"]
