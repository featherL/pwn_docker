# pwn_docker
docker for pwn

reference: https://github.com/skysider/pwndocker

## Usage
```bash
$ docker run -it \
        -p 23946:23946 \
        --cap-add=SYS_PTRACE \
        fe4ther/pwn_docker 
```


## software

+ [pwntools](https://github.com/Gallopsled/pwntools)
+ [pwndbg](https://github.com/pwndbg/pwndbg)
+ [pwngdb](https://github.com/scwuaptx/Pwngdb)
+ [one_gadget](https://github.com/david942j/one_gadget)
+ [seccomp-tools](https://github.com/david942j/seccomp-tools)
+ [tmux](https://tmux.github.io/)
+ [ltrace](https://linux.die.net/man/1/ltrace)
+ [strace](https://linux.die.net/man/1/strace)
+ linux_server32/64 -- ida7.6
+ [Oh My Zsh](https://ohmyz.sh/)
+ [patchelf](https://github.com/NixOS/patchelf)
+ [libc-database](https://github.com/niklasb/libc-database)
+ [qemu](https://www.qemu.org/)
+ [glibc-all-in-one](https://github.com/matrix1001/glibc-all-in-one.git)

