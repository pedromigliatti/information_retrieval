from config.constants import THRESHOLD_DOCS, THRESHOLD_PASSAGES
from src.question_answer import qa
from src.file_indexer import search_document
from src.reranker import create_passages


def manager(question=None):
    docs = search_document(question, threshold=THRESHOLD_DOCS)
    #passages_l = create_passages(docs)
#    print(len(passages_l))
    #reranked_passages = rerank(question, passages_l)
    #reranked_passages.sort(key=lambda x: x.score, reverse=True)

    #context = []
    #for order, passage in enumerate(reranked_passages):
    #for passage in passages_l:
    #    if order <= THRESHOLD_PASSAGES:
    #        context += [passage.text]
    #    else:
    #        break
    #context = ' '.join(context)
    answer = []
    print(len(docs))
    for doc in docs:
        answer +=[qa(question, doc)]

    answer = '. '.join(answer)
    return answer
