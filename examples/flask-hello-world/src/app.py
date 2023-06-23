
from flask import Flask

body = '''
<html>
  <head>
    <title>Hello world!</title>
    <!--meta http-equiv="refresh" content="3" /-->
  </head>
  <body>
    Hello from flask!
  </body>
</html>
'''

app = Flask(__name__)

@app.route("/")
def hello_world():
    return body
