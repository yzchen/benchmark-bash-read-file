## Benchmark of reading files with bash script

#### Data 

dummy file is generated with `/dev/urandom` :

`for i in {1..20000}; do base64 /dev/urandom | head -c 40 >> dummy.txt; echo -e "" >> dummy.txt; done`

in this example, information of `dummy.txt` :

- #rows = 40000

- #columns = 41 (EOL:End of Line is counted)

- size =  1.6M

#### Testing scripts

things should notice in different methods :

- loop : while v.s. **for**

- pipe v.s. redirection v.s. **file descriptor**
