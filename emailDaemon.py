#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# REQUERIMIENTOS################################################################################
# * Instalar psycopg2: sudo apt install python-psycopg2
# * Instalar pip en caso de no tenerlo: sudo apt install python-pip
# * Instalar python-dotenv: pip install python-dotenv
# * Completar un archivo .env con la siguiente estructura:
# DB_NAME=nombrebase
# DB_HOST=localhost
# DB_USER=nombreusuario
# DB_PASSWORD=password
# * Iniciar el server local SMTP de testeo: python -m smtpd -c DebuggingServer -n localhost:1025
################################################################################################

import os
import select
import psycopg2
import psycopg2.extensions
from dotenv import load_dotenv
import smtplib, ssl

load_dotenv()
PORT=1025
DB_NAME=os.getenv("DB_NAME")
DB_HOST=os.getenv("DB_HOST")
DB_USER=os.getenv("DB_USER")
DB_PASSWORD=os.getenv("DB_PASSWORD")
EMAIL_SENDER="sender@gmail.com"
EMAIL_RECEIVER="receiver@hotmail.com"

dbc = psycopg2.connect(database=DB_NAME, host=DB_HOST, user=DB_USER, password=DB_PASSWORD)
dbc.set_isolation_level(psycopg2.extensions.ISOLATION_LEVEL_AUTOCOMMIT)
cur = dbc.cursor()
cur.execute('LISTEN perdida_elemento')
 
while 1:
  if not select.select([dbc], [], [], 5) == ([], [], []):
    dbc.poll()
    while dbc.notifies:
      notify = dbc.notifies.pop()
      msg = "Se perdio un especimen de la siguiente especie: %s" % (notify.payload)
      print(msg)
      server = smtplib.SMTP("localhost", PORT)
      server.sendmail(EMAIL_SENDER, EMAIL_RECEIVER, "\n" + msg)
      server.quit()