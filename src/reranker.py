from pygaggle.rerank.transformer import MonoT5
from pygaggle.rerank.base import Query, Text
import re
import spacy
from pysbd.utils import PySBDFactory
import sys

nlp = spacy.blank('pt')
model = MonoT5.get_model('unicamp-dl/ptt5-base-pt-msmarco-100k-v2')
tokenizer = MonoT5.get_tokenizer('unicamp-dl/ptt5-base-pt-msmarco-100k-v2')

def create_passages(documents_l):
    pipes = [i[0] for i in nlp.pipleline]
    if 'PsySBDFactory' not in pipes:
        nlp.add_pipe(PySBDFactory)
    passages_l =  [passage for document in documents_l for passage in list(nlp(document[1]).sents)]

    return passages_l

def rerank(query, documents):

    reranker = MonoT5(model, tokenizer)
    reranked = reranker.rerank(Query(query), ([Text(' '.join([t.documents for t in i])) for i in documents]))

    return rerank