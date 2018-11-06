## Benchmark of reading files (line by line) with bash script

#### Data 

dummy file is generated with `/dev/urandom` :

`for i in {1..40000}; do base64 /dev/urandom | head -c 40 >> dummy.txt; echo -e "" >> dummy.txt; done`

in this example, information of `dummy.txt` :

- #rows = 40000

- #columns = 41 (EOL:End of Line is counted)

- size =  1.6M

information of my current running system :

- #cpus = 20

- memory = 251G

#### Testing scripts

1. things should notice in different methods :

- loop : while v.s. **for**

- pipe v.s. redirection v.s. **file descriptor**

- read v.s **line**

2. in split method, beginning `split` and the final `cat` are not time-consuming, parallel part is the important part
    (parallel has 250 ms startup time, for larger file it's better)

3. awk(and sed) are good for homogeneous processing, do the same thing for every line, and they are a little bit tricky, for complex processing commands, they are very slow
