APP_NAME=KakikataShogun.Bot
PROJECT_DIR=KakikataShogun.Bot
PUBLISH_DIR=/var/kakikatabot/
RUNTIME=linux-x64
SERVICE_NAME=kakikatabot
SERVICE_FILE=/etc/systemd/system/$(SERVICE_NAME).service

build:
	dotnet build

run:
	dotnet run --project $(PROJECT_DIR)

publish:
	dotnet publish $(PROJECT_DIR) -c Release -r $(RUNTIME) --self-contained true -o $(PUBLISH_DIR)

deploy: publish
	sudo cp $(SERVICE_NAME).service $(SERVICE_FILE)
	sudo systemctl daemon-reload
	sudo systemctl enable $(SERVICE_NAME)
	sudo systemctl restart $(SERVICE_NAME)

logs:
	sudo journalctl -u $(SERVICE_NAME) -f

status:
	sudo systemctl status $(SERVICE_NAME)

restart:
	sudo systemctl restart $(SERVICE_NAME)

stop:
	sudo systemctl stop $(SERVICE_NAME)

start:
	sudo systemctl start $(SERVICE_NAME)
