## Flask App
Hello World Flask App

#### Run Docker Container

```
docker build --platform=linux/arm64 -t <docker_hub_repo>/flask-app .
```

Run Image
```
docker run -d -p 5000:5000 --name flask-app <docker_hub_repo>/flask-app
```

Access the dashboard
```
http://127.0.0.1:5000/
```