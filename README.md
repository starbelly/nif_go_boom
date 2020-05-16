# NifGoBoom

To observe the failure to load a nif during runtime configuration perform the following:

## Set the HELLO env var

```shell
export HELLO="starbelly"
```

or (depending on your shell)

```shell
set -x HELLO "starbelly"
```

## Get the deps

```shell
$ mix deps.get --only prod
Resolving Hex dependencies...
Dependency resolution completed:
Unchanged:
  enacl 1.0.0
* Getting enacl (Hex package)
```
## Compile the release

```shell
$ env MIX_ENV=prod mix release
env MIX_ENV=prod mix release
===> Fetching pc ({pkg,<<"pc">>,<<"1.10.0">>})
===> Version cached at /Users/starbelly/.cache/rebar3/hex/default/packages/pc-1.10.0.tar is up to date, reusing it
===> Compiling pc
===> Fetching rebar3_hex ({pkg,<<"rebar3_hex">>,<<"6.9.3">>})
===> Version cached at /Users/starbelly/.cache/rebar3/hex/default/packages/rebar3_hex-6.9.3.tar is up to date, reusing it
===> Fetching hex_core ({pkg,<<"hex_core">>,<<"0.6.8">>})
===> Version cached at /Users/starbelly/.cache/rebar3/hex/default/packages/hex_core-0.6.8.tar is up to date, reusing it
===> Fetching verl ({pkg,<<"verl">>,<<"1.0.2">>})
===> Version cached at /Users/starbelly/.cache/rebar3/hex/default/packages/verl-1.0.2.tar is up to date, reusing it
===> Compiling verl
===> Compiling hex_core
===> Compiling rebar3_hex
===> Compiling enacl
===> Compiling /Users/starbelly/devel/elixir/nif_go_boom/deps/enacl/c_src/aead.c
===> Compiling /Users/starbelly/devel/elixir/nif_go_boom/deps/enacl/c_src/enacl.c
===> Compiling /Users/starbelly/devel/elixir/nif_go_boom/deps/enacl/c_src/enacl_ext.c
===> Compiling /Users/starbelly/devel/elixir/nif_go_boom/deps/enacl/c_src/enacl_nif.c
===> Compiling /Users/starbelly/devel/elixir/nif_go_boom/deps/enacl/c_src/generichash.c
===> Compiling /Users/starbelly/devel/elixir/nif_go_boom/deps/enacl/c_src/hash.c
===> Compiling /Users/starbelly/devel/elixir/nif_go_boom/deps/enacl/c_src/kx.c
===> Compiling /Users/starbelly/devel/elixir/nif_go_boom/deps/enacl/c_src/public.c
===> Compiling /Users/starbelly/devel/elixir/nif_go_boom/deps/enacl/c_src/pwhash.c
===> Compiling /Users/starbelly/devel/elixir/nif_go_boom/deps/enacl/c_src/randombytes.c
===> Compiling /Users/starbelly/devel/elixir/nif_go_boom/deps/enacl/c_src/secret.c
===> Compiling /Users/starbelly/devel/elixir/nif_go_boom/deps/enacl/c_src/sign.c
===> Linking /Users/starbelly/devel/elixir/nif_go_boom/deps/enacl/priv/enacl_nif.so
Compiling 1 file (.ex)
Generated nif_go_boom app
* assembling nif_go_boom-0.1.0 on MIX_ENV=prod
* using config/releases.exs to configure the release at runtime
* creating _build/prod/rel/nif_go_boom/releases/0.1.0/vm.args
* creating _build/prod/rel/nif_go_boom/releases/0.1.0/env.sh
* creating _build/prod/rel/nif_go_boom/releases/0.1.0/env.bat
* skipping elixir.bat for windows (bin/elixir.bat not found in the Elixir installation)
* skipping iex.bat for windows (bin/iex.bat not found in the Elixir installation)

Release created at _build/prod/rel/nif_go_boom!

    # To start your system
    _build/prod/rel/nif_go_boom/bin/nif_go_boom start

Once the release is running:

    # To connect to it remotely
    _build/prod/rel/nif_go_boom/bin/nif_go_boom remote

    # To stop it gracefully (you may also send SIGINT/SIGTERM)
    _build/prod/rel/nif_go_boom/bin/nif_go_boom stop

To list all commands:

    _build/prod/rel/nif_go_boom/bin/nif_go_boom

```

## Ensure the enacl ebin is not symlinked and the enacl shared object is not symlinked

```shell
$ ls -l _build/prod/rel/nif_go_boom/lib/enacl-1.0.0/ebin/
-rw-r--r--  1 starbelly  starbelly   434 May 16 15:07 enacl.app
-rw-r--r--  1 starbelly  starbelly  5341 May 16 15:07 enacl.beam
-rw-r--r--  1 starbelly  starbelly   658 May 16 15:07 enacl_ext.beam
-rw-r--r--  1 starbelly  starbelly  3415 May 16 15:07 enacl_nif.beam

$ ls -l _build/prod/rel/nif_go_boom/lib/enacl-1.0.0/priv/
-rwxr-xr-x  1 starbelly  starbelly  67920 May 16 15:07 enacl_nif.so
```

## Attempt to start up the release in iex mode

```
$  _build/prod/rel/nif_go_boom/bin/nif_go_boom start_iex
Erlang/OTP 22 [erts-10.7.1] [source] [64-bit] [smp:16:16] [ds:16:16:10] [async-threads:1] [hipe] [dtrace]

The shell log file has mysteriousy closed. Ignoring currently unread history.
Erlang/OTP 22 [erts-10.7.1] [source] [64-bit] [smp:16:16] [ds:16:16:10] [async-threads:1] [hipe] [dtrace]

2020-05-16 15:10:44.264556 supervisor_report   #{label=>{supervisor,start_error},report=>[{supervisor,{local,kernel_sup}},{errorContext,start_error},{reason,{on_load_function_failed,enacl_nif}},{offender,[{pid,undefined},{id,kernel_safe_sup},{mfargs,{supervisor,start_link,[{local,kernel_safe_sup},kernel,safe]}},{restart_type,permanent},{shutdown,infinity},{child_type,supervisor}]}]}
2020-05-16 15:10:44.264596 crash_report        #{label=>{proc_lib,crash},report=>[[{initial_call,{supervisor,kernel,['Argument__1']}},{pid,<0.1175.0>},{registered_name,[]},{error_info,{exit,{on_load_function_failed,enacl_nif},[{init,run_on_load_handlers,0,[]},{kernel,init,1,[{file,"kernel.erl"},{line,189}]},{supervisor,init,1,[{file,"supervisor.erl"},{line,295}]},{gen_server,init_it,2,[{file,"gen_server.erl"},{line,374}]},{gen_server,init_it,6,[{file,"gen_server.erl"},{line,342}]},{proc_lib,init_p_do_apply,3,[{file,"proc_lib.erl"},{line,249}]}]}},{ancestors,[kernel_sup,<0.1148.0>]},{message_queue_len,0},{messages,[]},{links,[<0.1150.0>]},{dictionary,[]},{trap_exit,true},{status,running},{heap_size,610},{stack_size,27},{reductions,265}],[]]}
2020-05-16 15:10:45.267593 crash_report        #{label=>{proc_lib,crash},report=>[[{initial_call,{application_master,init,['Argument__1','Argument__2','Argument__3','Argument__4']}},{pid,<0.1147.0>},{registered_name,[]},{error_info,{exit,{{shutdown,{failed_to_start_child,kernel_safe_sup,{on_load_function_failed,enacl_nif}}},{kernel,start,[normal,[]]}},[{application_master,init,4,[{file,"application_master.erl"},{line,138}]},{proc_lib,init_p_do_apply,3,[{file,"proc_lib.erl"},{line,249}]}]}},{ancestors,[<0.1146.0>]},{message_queue_len,1},{messages,[{'EXIT',<0.1148.0>,normal}]},{links,[<0.1146.0>,<0.1145.0>]},{dictionary,[]},{trap_exit,true},{status,running},{heap_size,610},{stack_size,27},{reductions,193}],[]]}
2020-05-16 15:10:45.269176 std_info            #{label=>{application_controller,exit},report=>[{application,kernel},{exited,{{shutdown,{failed_to_start_child,kernel_safe_sup,{on_load_function_failed,enacl_nif}}},{kernel,start,[normal,[]]}}},{type,permanent}]}
{"Kernel pid terminated",application_controller,"{application_start_failure,kernel,{{shutdown,{failed_to_start_child,kernel_safe_sup,{on_load_function_failed,enacl_nif}}},{kernel,start,[normal,[]]}}}"}
Kernel pid terminated (application_controller) ({application_start_failure,kernel,{{shutdown,{failed_to_start_child,kernel_safe_sup,{on_load_function_failed,enacl_nif}}},{kernel,start,[normal,[]]}}})
```

## Relish in failure

![Go to Jail!](https://i.stack.imgur.com/6OFAa.jpg)

