import wikipedia


def wikiload(key_word, limit):
    result = wikipedia.search(key_word, results=limit, suggestion=True)

    return result