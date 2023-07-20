from flask import Flask

app = Flask(__name__, template_folder='template')

@app.route('/')
def hello():
    return 'Hello, World!'

@app.route('/health')
def hello():
    return '', 200