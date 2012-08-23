-module(binary2_tests).

-import(binary2, [trim/1, trim/2, ltrim/2, rtrim/2,
                  reverse/1, inverse/1, join/2, suffix/2, prefix/2,
                  union/2, intersection/2, subtract/2]).

-include_lib("eunit/include/eunit.hrl").

-ifdef(TEST).

trim1_test_() ->
    [ ?_assertEqual(trim(<<>>), <<>>)
    , ?_assertEqual(trim(<<0,1,2>>), <<1,2>>)
    , ?_assertEqual(trim(<<0,0,1,2>>), <<1,2>>)
    , ?_assertEqual(trim(<<1,2,0,0>>), <<1,2>>)
    , ?_assertEqual(trim(<<0,1,2,0>>), <<1,2>>)
    , ?_assertEqual(trim(<<0,0,0,1,2,0,0,0>>), <<1,2>>)
    ].

trim2_test_() ->
    [ ?_assertEqual(trim(<<5>>, 5), <<>>)
    , ?_assertEqual(trim(<<5,1,2,5>>, 5), <<1,2>>)
    , ?_assertEqual(trim(<<5,5,5,1,2,0,0,0>>, 5), <<1,2,0,0,0>>)
    ].

ltrim2_test_() ->
    [ ?_assertEqual(ltrim(<<5>>, 5), <<>>)
    , ?_assertEqual(ltrim(<<5,1,2,5>>, 5), <<1,2,5>>)
    , ?_assertEqual(ltrim(<<5,5,5,1,2,0,0,0>>, 5), <<1,2,0,0,0>>)
    ].

rtrim2_test_() ->
    [ ?_assertEqual(rtrim(<<5>>, 5), <<>>)
    , ?_assertEqual(rtrim(<<5,1,2,5>>, 5), <<5,1,2>>)
    , ?_assertEqual(rtrim(<<5,5,5,1,2,0,0,0>>, 5), <<5,5,5,1,2,0,0,0>>)
    ].

reverse_test_() ->
    [ ?_assertEqual(reverse(<<0,1,2>>), <<2,1,0>>)
    ].


join_test_() ->
    [ ?_assertEqual(join([<<1,2>>, <<3,4>>, <<5,6>>], <<0>>), <<1,2,0,3,4,0,5,6>>)
    , ?_assertEqual(join([<<"abc">>, <<"def">>, <<"xyz">>], <<"|">>),
                    <<"abc|def|xyz">>)
    , ?_assertEqual(join([<<>>, <<"|">>, <<"x|z">>], <<"|">>),
                    <<"|||x|z">>)
    ].

suffix_test_() ->
    [ ?_assertEqual(suffix(<<1,2,3,4,5>>, 2), <<4,5>>)
    , ?_assertError(badarg, prefix(<<1,2,3,4,5>>, 25))
    ].

prefix_test_() ->
    [ ?_assertEqual(prefix(<<1,2,3,4,5>>, 2), <<1,2>>)
    , ?_assertError(badarg, prefix(<<1,2,3,4,5>>, 25))
    ].

union_test_() ->
    [ ?_assertEqual(union(<<2#0011011:7>>, 
                          <<2#1011110:7>>), 
                          <<2#1011111:7>>)
    ].

inverse_test_() ->
    [ ?_assertEqual(inverse(inverse(<<0,1,2>>)), <<0,1,2>>)
    , ?_assertEqual(inverse(<<0>>), <<255>>)
    , ?_assertEqual(inverse(<<2#1:1>>), <<2#0:1>>)
    , ?_assertEqual(inverse(<<2#0:1>>), <<2#1:1>>)
    , ?_assertEqual(inverse(<<2#01:2>>), 
                            <<2#10:2>>)
    , ?_assertEqual(inverse(<<2#0011011:7>>), 
                            <<2#1100100:7>>)
    ].

intersection_test_() ->
    [ ?_assertEqual(intersection(<<2#0011011>>, 
                                 <<2#1011110>>), 
                                 <<2#0011010>>)
    ].

subtract_test_() ->
    [ ?_assertEqual(subtract(<<2#0011011>>, 
                             <<2#1011110>>), 
                             <<2#0000001>>)
    ].

-endif.
