# Bitcoin Mining using Erlang
COP5615 - Distributed Operating Systems Principles Project 1

The goal of this project is to use Erlang and the actor model to build a good solution to the bitcoin mining problem that runs well on multi-core machines.
## 1. Size of the work unit 
### Size of the work unit that you determined results in the best performance for your implementation and an explanation of how you determined it. The size of the work unit refers to the number of sub-problems that a worker gets in a single request from the boss.
In this program, the worker receives a request for mining without an upper limit on the number of coins to be mined. We spawn 2*logproc worker processes / node for mining bitcoins, where logproc is the number of logical processors available on a machine. To ensure that all worker processes stay functional, we also supervise each worker process and restart them in case of failure.
## 2. The result of running your program for input 4
abcdefg46276    00007f1c9a6a3566518da3f695b5b59c7564ba9cb1e20625a74e81fa2eedba1e
## 3. Ratio
### The running time for the above is reported by time for the above and report the time.  The ratio of CPU time to REAL TIME tells you how many cores were effectively used in the computation.  If you are close to 1 you have almost no parallelism (points will be subtracted).
