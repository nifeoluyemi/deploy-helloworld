## Flask App
Hello World Flask App

#### Run Docker Container

```
docker build -t <docker_hub_repo>/flask-app .
```

Run Image
```
docker run -d -p 5000:5000 --name flask-app <docker_hub_repo>/flask-app
```