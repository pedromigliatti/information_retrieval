from config.constants import THRESHOLD_DOCS, THRESHOLD_PASSAGES
from src.question_answer import qa
from src.file_indexer import search_document
from src.reranker import create_passages, rerank


def manager(question=None):
    docs = search_document(question, threshold=THRESHOLD_DOCS)
    passages_l = create_passages(docs)
    reranked_passages = rerank(question, passages_l)
    reranked_passages.sort(key=lambda x: x.score, reverse=True)

    context = []
    for order, passage in enumerate(reranked_passages):
        if order <= THRESHOLD_PASSAGES:
            context += [passage.text]
        else:
            break
    context = ' '.join(context)

    answer = qa(question, context)