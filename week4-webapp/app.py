from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
	return "<h1>Week 6: Automated pipeline check.</h1><p>The robot did my job for me!</p>"

if __name__ == '__main__':
	# Bind to 0.0.0.0 so it is accessible outside the container
	app.run(host='0.0.0.0', port=5000)
