from src.document_reader import DocumentReader

def qa(question, context):
    reader = DocumentReader("pierreguillou/bert-large-cased-squad-v1.1-portuguese")
    reader.tokenize(question, context)

    return reader.get_answer()