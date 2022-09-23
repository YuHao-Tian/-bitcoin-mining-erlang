# Bitcoin Mining using Erlang
COP5615 - Distributed Operating Systems Principles Project 1

The goal of this project is to use Erlang and the actor model to get a good solution to the bitcoin mining problem that runs well on multi-core machines.
## 1. Size of the work unit 
### Size of the work unit that you determined results in the best performance for your implementation and an explanation of how you determined it. The size of the work unit refers to the number of sub-problems that a worker gets in a single request from the boss.
The worker asks the server for the corresponding number of String according to the input Size, and when these strings are calculated, the worker will continue to ask the server for the string. Server and workers stop working until the first coin is found. In this program, the worker receives a request for mining without an upper limit on the number of coins to be mined. However, unlimited size is not necessarily the most efficient one.  
In our project, runtime is the sum of all cpu runtimes, and realtime is the time from the start of the server to the time when the coin is found.  
We use the control variates method to control the value of the input String and K, and only change the value of each worker processing sub-problems each time.
Suppose there are 2 workers in this case, one is the server doing the computation itself and the other is the worker.  
From the following results, we can see that the best performance can be achieved with one worker dealing with 410 subproblems.  
 ```erlang
(server@YHT)1> server:start_server("42162604:Xin Li",5,500).
<0.88.0>
(server@YHT)2> 42162604:Xin Li571001    00000261141442d95c3a83606bfd6edddaf25bc238fd7ca31889b7dd006f6569
(server@YHT)2> runtime: 2.438 (seconds)
real time: 1.395 (seconds)
the ratio CPU time to real time: 1.75 
(server@YHT)2> the max number of process is: 48
(server@YHT)2> server:start_server("42162604:Xin Li",5,450). 
<0.97.0>
(server@YHT)3> 42162604:Xin Li571001    00000261141442d95c3a83606bfd6edddaf25bc238fd7ca31889b7dd006f6569
(server@YHT)3> runtime: 2.531 (seconds)
real time: 1.388 (seconds)
the ratio CPU time to real time: 1.82
(server@YHT)3> the max number of process is: 48
(server@YHT)3> server:start_server("42162604:Xin Li",5,430). 
<0.102.0>
(server@YHT)4> 42162604:Xin Li571001    00000261141442d95c3a83606bfd6edddaf25bc238fd7ca31889b7dd006f6569
(server@YHT)4> runtime: 2.485 (seconds)
real time: 1.334 (seconds)
the ratio CPU time to real time: 1.86
(server@YHT)4> the max number of process is: 48
(server@YHT)4> server:start_server("42162604:Xin Li",5,440). 
<0.107.0>
(server@YHT)5> 42162604:Xin Li571001    00000261141442d95c3a83606bfd6edddaf25bc238fd7ca31889b7dd006f6569
(server@YHT)5> runtime: 2.484 (seconds)
real time: 1.323 (seconds)
the ratio CPU time to real time: 1.88
(server@YHT)5> the max number of process is: 48
(server@YHT)5> server:start_server("42162604:Xin Li",5,445). 
<0.112.0>
(server@YHT)6> 42162604:Xin Li571001    00000261141442d95c3a83606bfd6edddaf25bc238fd7ca31889b7dd006f6569
(server@YHT)6> runtime: 2.516 (seconds)
real time: 1.324 (seconds)
the ratio CPU time to real time: 1.90
(server@YHT)6> the max number of process is: 48
```

## 2. The result of running your program for input 4
 ```erlang
42162604qwer43433    0000c042fa25420993d4165c9a150719340a69841a5e994c27f493a60ea3b592
```
## 3. Cores used in the computation
### The running time for the above is reported by time for the above and report the time.  The ratio of CPU time to REAL TIME tells you how many cores were effectively used in the computation.  If you are close to 1 you have almost no parallelism (points will be subtracted).
For this question, we defined the workers numbers as 3 and each worker takes 10 sub-problems.
The results are presented as follows:   
 ```erlang
%%Server
(server@YHT)1> server:start_server("42162604!wio?dopam",5,10).                         
<0.88.0>
(server@YHT)2> 42162604!wio?dopam1825441    00000d75422a00fc2120f95e18a2f8920e982600caecd46efbed0abfab39b2de
(server@YHT)2> runtime: 12.531 (seconds)
real time: 4.719 (seconds)
the ratio CPU time to real time: 2.66
(server@YHT)2> the max number of process is: 54

%%Client1
(client1@YHT)2> client:start('server@YHT',5,10).  
  
%%Client2
(client2@YHT)2> client:start('server@YHT',5,10).  
  
%%Client3
(client3@YHT)2> client:start('server@YHT',5,10).
```
## 4. Coin with most zeroes(7):
 ```erlang
abcdef406679004    000000079ec6de3069a7920126139ea70a8199f8673f3e8dd5fc4e61894c59ea
```
## 5. The largest number of working machines you were able to run your code with.
The largest number of working machines we are able to run are roughly 800,000.



