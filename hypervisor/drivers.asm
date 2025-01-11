 asm ( assembler template  
   : output operands                  /* optional */  
   : input operands                   /* optional */  
   : list of registers used      /* optional */  
           ); 
int a=10, b; 
        asm ( 
    "movl %1, %%eax;  
     movl %%eax, %0;" 
   :"=r"(b)        /* output */ 
   :"r"(a)         /* input */  
   :"%eax"         /* clobbered register */  
             ); 
do {                                                                                            
        register long __gu_r8 asm ("r8") = 0;                                                   
        register long __gu_r9 asm ("r9");                                                       
        asm ("\n[1:]\tld"#n" %0=%2%P2\t// %0 and %1 get overwritten by exception handler\n"     
             "\t.xdata4 \"__ex_table\", 1b-., 1f-.+4\n"                                         
             "[1:]"                                                                             
             : "=r"(__gu_r9), "=r"(__gu_r8) : "m"(__m(addr)), "1"(__gu_r8));                    
        (err) = __gu_r8;                                                                        
        (val) = __gu_r9;                                                                        
} while (0); 
LD C,2   ; Load 2 into register C
LD E,65  ; Load the ASCII code for 'A' into register E
CALL 5   ; Call CP/M's routine for getting things done
