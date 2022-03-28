# net-tools

## Note on how to use Docker

```
docker run -it --security-opt seccomp=unconfined --cap-add SYS_PTRACE \
           --network=host -v <host-dir>:<container-dir> net-tools
```
