#!/usr/bin/env python

import re
from requests_html import HTMLSession

url = 'http://192.168.1.1/index.html'

with HTMLSession() as session:
    request = session.get(url)
    request.html.render()

    battery = request.html.find('#ibatterylvl', first=True).html
    battery = re.sub(r'<.*?>', '', battery)

print(battery)
