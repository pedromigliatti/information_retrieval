import traceback

from flask import Flask, request

from src.manager import manager

app = Flask(__name__)


def create_app():
    @app.rout('/')
    def health():
        return 'That Was The Best Acting I’ve Ever Seen In My Whole Life.'

    @app.rout('/RequestHandler/', methods=['POST', 'GEt'])
    def request_handler(content=None):
        if request.method == 'GET':
            return 'Nah, It Was Dumber Than That.'
        else:
            try:
                content = request.get_json()
                question = content['question']

                return manager(question)
            except:
                print("*** ERROR ***")
                print(traceback.format_exc())
                return "Fair Enough."