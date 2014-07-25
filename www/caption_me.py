#!/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Flask
from flask import make_response
from flask import render_template

import cymysql # layer
from db.mysql import MySQL

app = Flask(__name__)
app.debug = True #reload changes

mysql = MySQL()

@app.route('/')
def hello_world():
    return 'Hello World!'

@app.route('/main')
def main():
    results = mysql.getData("videos")
    return render_template('video_main.j2', results=results)

@app.route('/caption/view/<int:video_id>')
def caption(video_id):
    caption_text = mysql.getCaption(video_id)
    return render_template('video_caption_view.j2', caption_text=caption_text)

@app.route('/caption/dlo/<int:video_id>')
def dlo_caption(video_id):
    caption_text = mysql.getCaption(video_id)
    response = make_response(caption_text)
    response.headers["Content-Disposition"] = "attachment; filename=caption.txt"
    return response

#def request_has_connection():
#    return hasattr(flask.g, 'dbconn')

#def get_request_connection():
#    if not request_has_connection():
#        flask.g.dbconn = sqlite3.connect(DATABASE)
        # Do something to make this connection transactional. I'm not familiar with SQLite to know what that is.
#    return flask.g.dbconn

#@app.teardown_request
#def close_db_connection(ex):
#    if request_has_connection():
#        conn = get_request_connection()
#        if None is ex:
            # Commit
#        else:
            # Rollback
#        conn.close()

#@app.teardown_appcontext
#def close_db_connection(exception):
#    """Closes the database again at the end of the request."""
#    mysql.close_connection()

# Programming fonts
# "font_face": "Akkurat-Mono",
# "font_face": "Source Code Pro",
# "font_face": "Fira Mono OT",
# "font_face": "DejaVu Sans Mono",
# "font_face": "Anonymous Pro",
# "font_face": "Envy Code R",
# "font_face": "Mako",
# "font_face": "ProFontWindows",

if __name__ == '__main__':
    print("Started CaptionMe")

    #app.run(host='0.0.0.0') # port 5000 by default
    #app.run() #run only locally

    app.run(
        host="0.0.0.0",
        port=80,
        debug=True
    )