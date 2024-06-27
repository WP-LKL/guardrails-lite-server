install:
	pip install -r requirements.txt

lock:
	pip freeze > requirements-lock.txt

install-lock:
	pip install -r requirements-lock.txt

env:
	python3 -m venv ./.venv

make build:
	make install-lock
	echo "\n\nDownloading NLTK punkt tokenizer; this may take a while...\n\n"
	python3 -m nltk.downloader punkt --exit-on-error
	guardrails hub install hub://guardrails/regex_match --quiet


start:
	gunicorn --bind 0.0.0.0:8000 --timeout=5 --workers=10 --worker-class=gthread 'guardrails_api.app:create_app("example.env", "config.py")'