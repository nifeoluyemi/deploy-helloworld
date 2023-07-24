from flask import Flask, render_template
import os

app = Flask(__name__, template_folder='template')

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/health')
def health():
    return '', 200

port = int(os.getenv('FLASK_PORT', 5000))

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=port, debug=True)