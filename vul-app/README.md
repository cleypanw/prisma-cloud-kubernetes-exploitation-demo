## Build image

#### Docker 
```bash
docker build -t vul-app:x.y.z .
```
#### Build Image in x86
```bash
docker buildx build --platform linux/amd64,linux/arm64 --push -t chrisley75/vul-app:1.0.0 .
```

## Node Page Server-side Template Injection

> Uses nunjucks as the templating engine for the attack

### Genuine request

```bash
http GET http://<host>:5000/
```

> returns the bookstore page.

### Attack request

```bash
http GET http://<host>:5000/page?name=something
```

```bash
http GET http://<host>:5000/page?name={{7*7}}
```

> this is injectable. use tplmap for exploit