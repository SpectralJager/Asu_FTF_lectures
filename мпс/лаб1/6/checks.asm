public check_spd_btns, check_mod_btns
extrn code (next_mod, prev_mod, incr_spd, decr_spd)

checks segment code

rseg checks
check_spd_btns:
    jnb p3.4, check_incr
    jnb p3.5, check_decr
    sjmp check_exit
check_incr:
    call incr_spd
    sjmp check_exit
check_decr:
    call decr_spd
    sjmp check_exit

check_mod_btns:
    jnb p3.2, check_next
    jnb p3.3, check_prev
    sjmp check_exit 
check_next:
    call next_mod
    sjmp check_exit
check_prev:
    call prev_mod
    sjmp check_exit

check_exit:
    ret
end















