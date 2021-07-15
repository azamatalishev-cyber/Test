FROM python:3.9.6

RUN mkdir /app

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt
RUN chmod +x entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
