# from __future__ import absolute_import, unicode_literals
from celery import shared_task
from celery.utils.log import get_task_logger

import threading
import json

logger = get_task_logger(__name__)

results = []
import geopy
from geopy import distance

class myThread(threading.Thread):
    def __init__(self, ind, lock):
        threading.Thread.__init__(self)
        self.ind = ind
        self.lock = lock

    def run(self):
        global results
        with open('data_{0}.json'.format(self.ind)) as data_file:
            data = json.load(data_file)

        with self.lock:
            results.extend(data.get(str(self.ind)))


@shared_task(bind=True)
def test_task(self):
    global results
    logger.info("Start task")
    lock = threading.Lock()
    threads = [myThread(x, lock) for x in range(1, 4)]
    for t in threads:
        t.start()
    for t in threads:
        t.join()
    results = sorted(results, key=lambda k: k['id'])
    return results


from flask import Flask, render_template, url_for,request, redirect
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from datetime import datetime
app = Flask(__name__)
@app.route('/')
@app.route('/home')
def hello_world():
    test_task.delay()
    return render_template("test.html")