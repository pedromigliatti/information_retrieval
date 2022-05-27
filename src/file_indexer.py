import spacy
from src.wikiload import wikiload

nlp = spacy.load("pt_core_news_sm")

def search_document(query_string, threshold):
    doc = nlp(query_string)
    key_word = ''
    for ent in doc.ents:
        key_word += ent.text.replace('', '?')

    results = wikiload(key_word, threshold)

    return results