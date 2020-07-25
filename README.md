# NifGoBoom

To observe the failure to load a nif during runtime configuration perform the following:

```
$ mix deps.get
 ...
$ mix deps.compile
 ...
$ mix release
$ mix release
* assembling nif_go_boom-0.1.0 on MIX_ENV=dev
* using config/releases.exs to configure the release at runtime
_build/dev/rel/nif_go_boom/bin/nif_go_boom start
...
```

You should observe something like :

```
$ _build/dev/rel/nif_go_boom/bin/nif_go_boom start_iex
Erlang/OTP 23 [erts-11.0.2] [source] [64-bit] [smp:16:16] [ds:16:16:10] [async-threads:1] [hipe] [dtrace]

Erlang/OTP 23 [erts-11.0.2] [source] [64-bit] [smp:16:16] [ds:16:16:10] [async-threads:1] [hipe] [dtrace]

2020-07-25 14:52:54.840953 supervisor_report   #{label=>{supervisor,start_error},report=>[{supervisor,{local,kernel_sup}},{errorContext,start_error},{reason,{on_load_function_failed,enacl_nif}},{offender,[{pid,undefined},{id,kernel_safe_sup},{mfargs,{supervisor,start_link,[{local,kernel_safe_sup},kernel,safe]}},{restart_type,permanent},{shutdown,infinity},{child_type,supervisor}]}]}
2020-07-25 14:52:54.842139 crash_report        #{label=>{proc_lib,crash},report=>[[{initial_call,{supervisor,kernel,['Argument__1']}},{pid,<0.1209.0>},{registered_name,[]},{error_info,{exit,{on_load_function_failed,enacl_nif},[{init,run_on_load_handlers,0,[]},{kernel,init,1,[{file,"kernel.erl"},{line,189}]},{supervisor,init,1,[{file,"supervisor.erl"},{line,301}]},{gen_server,init_it,2,[{file,"gen_server.erl"},{line,417}]},{gen_server,init_it,6,[{file,"gen_server.erl"},{line,385}]},{proc_lib,init_p_do_apply,3,[{file,"proc_lib.erl"},{line,226}]}]}},{ancestors,[kernel_sup,<0.1183.0>]},{message_queue_len,0},{messages,[]},{links,[<0.1185.0>]},{dictionary,[]},{trap_exit,true},{status,running},{heap_size,610},{stack_size,28},{reductions,262}],[]]}
2020-07-25 14:52:55.844214 crash_report        #{label=>{proc_lib,crash},report=>[[{initial_call,{application_master,init,['Argument__1','Argument__2','Argument__3','Argument__4']}},{pid,<0.1182.0>},{registered_name,[]},{error_info,{exit,{{shutdown,{failed_to_start_child,kernel_safe_sup,{on_load_function_failed,enacl_nif}}},{kernel,start,[normal,[]]}},[{application_master,init,4,[{file,"application_master.erl"},{line,138}]},{proc_lib,init_p_do_apply,3,[{file,"proc_lib.erl"},{line,226}]}]}},{ancestors,[<0.1181.0>]},{message_queue_len,1},{messages,[{'EXIT',<0.1183.0>,normal}]},{links,[<0.1181.0>,<0.1180.0>]},{dictionary,[]},{trap_exit,true},{status,running},{heap_size,376},{stack_size,28},{reductions,192}],[]]}
2020-07-25 14:52:55.845721 std_info            #{label=>{application_controller,exit},report=>[{application,kernel},{exited,{{shutdown,{failed_to_start_child,kernel_safe_sup,{on_load_function_failed,enacl_nif}}},{kernel,start,[normal,[]]}}},{type,permanent}]}
{"Kernel pid terminated",application_controller,"{application_start_failure,kernel,{{shutdown,{failed_to_start_child,kernel_safe_sup,{on_load_function_failed,enacl_nif}}},{kernel,start,[normal,[]]}}}"}
Kernel pid terminated (application_controller) ({application_start_failure,kernel,{{shutdown,{failed_to_start_child,kernel_safe_sup,{on_load_function_failed,enacl_nif}}},{kernel,start,[normal,[]]}}})

Crash dump is being written to: erl_crash.dump...done
```

To work around this, set `reboot_system_after_config: true` in the releases section of `mix.exs` and rebuild the release


```
$ mix release
Compiling 1 file (.ex)
Generated nif_go_boom app
Release nif_go_boom-0.1.0 already exists. Overwrite? [Yn] y
* assembling nif_go_boom-0.1.0 on MIX_ENV=dev
* using config/releases.exs to configure the release at runtime
 _build/dev/rel/nif_go_boom/bin/nif_go_boom start_iex
...

$ _build/dev/rel/nif_go_boom/bin/nif_go_boom start_iex
Erlang/OTP 23 [erts-11.0.2] [source] [64-bit] [smp:16:16] [ds:16:16:10] [async-threads:1] [hipe] [dtrace]

Interactive Elixir (1.10.4) - press Ctrl+C to exit (type h() ENTER for help)
iex(nif_go_boom@Bryans-MacBook-Pro)1> :enacl.verify
:ok
iex(nif_go_boom@Bryans-MacBook-Pro)2>
