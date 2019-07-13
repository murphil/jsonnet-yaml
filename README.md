```bash
docker run -t --rm -v $(pwd):/w jsonnet-yaml sh -c "jsonnet /w/xxx.jsonnet | json-yaml"
```