# Bitcoin Mining using Erlang
COP5615 - Distributed Operating Systems Principles Project 1

The goal of this project is to use Erlang and the actor model to get a good solution to the bitcoin mining problem that runs well on multi-core machines.
## 1. Size of the work unit 
### Size of the work unit that you determined results in the best performance for your implementation and an explanation of how you determined it. The size of the work unit refers to the number of sub-problems that a worker gets in a single request from the boss.
The worker asks the server for the corresponding number of String according to the input Size, and when these strings are calculated, the worker will continue to ask the server for the string. Server and workers stop working until the first coin is found. In this program, the worker receives a request for mining without an upper limit on the number of coins to be mined. However, unlimited size is not necessarily the most efficient one.  
In our project, runtime is the sum of all cpu runtimes, and realtime is the time from the start of the server to the time when the coin is found.  
We use the control variates method to control the value of the input String and K, and only change the value of each worker processing sub-problems each time.
Suppose there are 2 workers in this case, one is the server doing the computation itself and the other is the worker.  
From the following results, we can see that the best performance can be achieved with one worker dealing with 410 subproblems。
 ```erlag
(server@YHT)7> server:start_server("Xin Li:42162604",5,500). 
<0.122.0>
(server@YHT)8> Xin Li:421626042308670    000003bf446c378e14c64d7dc25f73353a01fcd2e4bf8434efa9c27ac6bda27d
(server@YHT)8> runtime: 12.031 (seconds)
real time: 6.517 (seconds)
the ratio CPU time to real time: 1.85
(server@YHT)8> the max number of process is: 48
(server@YHT)8> server:start_server("Xin Li:42162604",5,450). 
<0.127.0>
(server@YHT)9> Xin Li:421626042308670    000003bf446c378e14c64d7dc25f73353a01fcd2e4bf8434efa9c27ac6bda27d
(server@YHT)9> runtime: 11.672 (seconds)
real time: 6.217 (seconds)
the ratio CPU time to real time: 1.88
(server@YHT)9> the max number of process is: 48
(server@YHT)9> server:start_server("Xin Li:42162604",5,430). 
<0.132.0>
(server@YHT)10> Xin Li:421626042308670    000003bf446c378e14c64d7dc25f73353a01fcd2e4bf8434efa9c27ac6bda27d
(server@YHT)10> runtime: 11.984 (seconds)
real time: 6.459 (seconds)
the ratio CPU time to real time: 1.86
(server@YHT)10> the max number of process is: 48
(server@YHT)10> server:start_server("Xin Li:42162604",5,440). 
<0.137.0>
(server@YHT)11> Xin Li:421626042308670    000003bf446c378e14c64d7dc25f73353a01fcd2e4bf8434efa9c27ac6bda27d
(server@YHT)11> runtime: 11.844 (seconds)
real time: 6.212 (seconds)
the ratio CPU time to real time: 1.91
(server@YHT)11> the max number of process is: 48
(server@YHT)11> server:start_server("Xin Li:42162604",5,445). 
<0.142.0>
(server@YHT)12> Xin Li:421626042308670    000003bf446c378e14c64d7dc25f73353a01fcd2e4bf8434efa9c27ac6bda27d
(server@YHT)12> runtime: 11.797 (seconds)
real time: 6.338 (seconds)
the ratio CPU time to real time: 1.86
(server@YHT)12> the max number of process is: 48
```

## 2. The result of running your program for input 4
 ```erlang
abcdefg46276    00007f1c9a6a3566518da3f695b5b59c7564ba9cb1e20625a74e81fa2eedba1e
```
## 3. Cores used in the computation
### The running time for the above is reported by time for the above and report the time.  The ratio of CPU time to REAL TIME tells you how many cores were effectively used in the computation.  If you are close to 1 you have almost no parallelism (points will be subtracted).
For this question, we defined the workers numbers as 3 and each worker takes 10 sub-problems.
The results are presented as follows:   
 ```erlang
%%Server
(server@YHT)1> server:start_server("abcdef",5,10).  
<0.88.0>
(server@YHT)2> abcdef3595115    0000089d8a0162df31956d2106c395ca580dd8a8e8fefdacb5cdb6196ce44484  
(server@YHT)2> runtime: 28.906 (seconds)  
real time: 9.942 (seconds)  
the ratio CPU time to real time: 2.91  
(server@YHT)2> the max number of process is: 52  
  
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



