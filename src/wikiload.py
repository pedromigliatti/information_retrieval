import wikipedia


def wikiload(key_word, limit):
    wikipedia.set_lang('pt')
    result_titles = wikipedia.search(key_word, results=limit, suggestion=True)[0]
    print(result_titles)
    result_pages = []
    for title in result_titles:
        result_pages += [wikipedia.page(title).content]

    return result_pages
