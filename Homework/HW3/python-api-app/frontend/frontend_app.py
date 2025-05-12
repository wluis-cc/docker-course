from flask import Flask, render_template_string
import requests

app = Flask(__name__)

TEMPLATE = """
<!DOCTYPE html>
<html>
<head><title>Container Info</title></head>
<body>
    <h1>Container Info</h1>
    <p><strong>Hostname:</strong> {{ hostname }}</p>
    <p><strong>IP Address:</strong> {{ ip }}</p>
</body>
</html>
"""

@app.route('/')
def index():
    try:
        response = requests.get('http://backend:5000/info')  # 'backend' is the hostname of the other container in Docker network
        data = response.json()
        hostname = data.get('hostname', 'N/A')
        ip = data.get('ip_address', 'N/A')
    except Exception as e:
        hostname = 'Error'
        ip = str(e)
    return render_template_string(TEMPLATE, hostname=hostname, ip=ip)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
