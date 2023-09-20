from flask import Flask
app = Flask(__name__)


@app.route('/')
def hello_world():
    return 'Working on local testing of app'


if __name__ == '__main__':
    app.run()
