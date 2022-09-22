%%%-------------------------------------------------------------------
%%% @author seanlee
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. Sep 2022 00:01
%%%-------------------------------------------------------------------
-module(server).

%% API
-export([start_server/3,start_handle_server/1, start_worker/2, handle_server/1, get_hash/3,max/2]).

start_server(String,K,Size)->
  erlang:statistics(runtime),
  erlang:statistics(wall_clock),
  start_handle_server(String),
  start_worker(K,Size).

start_handle_server(String) ->
  Pid = spawn(?MODULE,handle_server,[{String,0}]),
  register(server,Pid).

start_worker(K,Size) ->
  Zeros = string:chars($0,K),
  %% ??????????????
  spawn(?MODULE,get_hash,[K,Size,Zeros]).

%%  register(worker,Pid).

lookup(0,L) ->
  L;
lookup(Size,L) ->

  {Origin,N} = rpc(lookup),
  L1 = [lists:concat([Origin,N])|L],
  lookup(Size-1,L1).

finished(String,Res) -> rpc({finished,String,Res}).
rpc(Q) ->
  server ! {self(),Q},
  receive
    {server,Reply} ->
      Reply
  end.
handle_server() ->
  receive
  {From,_any} ->
      From ! {server,{job,down}}
  end.
handle_server(Tuple) ->
  receive
    {From,lookup} ->
      {String,N} = Tuple,
      Tuple2 = {String,N+1},
      From ! {server,{String,N+1}},
      handle_server(Tuple2);
    {From,{finished,String,Res}} ->
      From ! {server,{job,down}},
      %% print out, ~s means print as string, \t => tab
      io:format("~s~s~s~n",[String,"    ",Res]),

      {_,Time1} = erlang:statistics(runtime),
      {_,Time2} = erlang:statistics(wall_clock),
      U1 = Time1 / 1000,
      U2 = Time2 / 1000,
      U3 = U1 / U2,
      %% 4.2f, f mean type of number is float,
      %% 4 means the total length is 4,
      %% 2 means the length of decimal number is 2
      io:format("runtime: ~p (seconds)~n"
                "real time: ~p (seconds)~n"
                "the ratio CPU time to real time: ~4.2f ~n",[U1,U2,U3]),
      Max = erlang:system_info(process_count),
      io:format("the max number of process is: ~w~n",[Max]),
      handle_server()
  end.

%% K means the number of 0’s in the hash notation
%% Size means the size of work unit
get_hash(K,Size,Zeros) ->

  L = lookup(Size,[]),
  handle_hash(L,K,Size,Zeros).

handle_hash([],K,Size,Zeros) ->
  try
    get_hash(K,Size,Zeros)
  catch
    error:badarg -> exit(self(),kill)
  end;
%%    get_hash(K,Size,Zeros);

handle_hash(L,K,Size,Zeros) ->
  [H|T] = L,
  %% 64 bit, 16 =Hexadecimal,fill 0, b mean number
  %% the output of io_lib:format is "string", the output of io:format is string.
  Res = io_lib:format("~64.16.0b",[binary:decode_unsigned(crypto:hash(sha256,H))]),
  %%   the start index in list is 1
  Sub_Res = lists:sublist(Res,1,K),
  case Sub_Res of
    Zeros ->
      Finish = finished(H,Res),
      case Finish of
        %% kill this process
        {job,down} ->
          exit(self(),kill)
      end;

    _any ->
      handle_hash(T,K,Size,Zeros)
  end.

max(K,Size) ->
%%    Limit = erlang:system_info(process_limit),
    Limit = 10,
    for(1,Limit,fun() -> start_worker(K,Size) end),
    Max = erlang:system_info(process_count),
    io:format("the default number of process is: ~w~n"
              "the max number of process is: ~w~n",[Limit,Max]).



for(N,N,F) ->[F()];
for(I,N,F) ->
  [F()|for(I+1,N,F)].



