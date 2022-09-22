%%%-------------------------------------------------------------------
%%%
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. Sep 2022 15:48
%%%-------------------------------------------------------------------
-module(client).

%% API
-export([start/3]).


start(Server_node,K,Size) ->


  rpc:call(Server_node,server,start_worker,[K,Size]).
