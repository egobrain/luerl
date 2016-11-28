-module(luerl_lib_js).

-include("luerl.hrl").

-export([install/1]).

-export([object/2, array/2]).

%% -import(luerl_lib, [lua_error/2,badarg_error/3]).	%Shorten this

install(St) ->
    luerl_emul:alloc_table(table(), St).

table() ->
    [{<<"object">>,{function,fun object/2}},
     {<<"array">>,{function,fun array/2}}].

object([#tref{}=T|_], St) ->
    set_type(T, <<"object">>, St).

array([#tref{}=T|_], St) ->
    set_type(T, <<"array">>, St).

set_type(T, Type, St0) ->
    {#tref{}=M, St1} = luerl_emul:alloc_table([
        {<<"__jsontype">>, Type}
    ], St0),
    luerl_lib_basic:setmetatable([T, M], St1).
