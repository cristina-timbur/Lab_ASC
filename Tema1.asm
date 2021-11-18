.data 
  p : .space 4				        #prim
  g : .space 4 					#generator
  str1 : .space 100 				#mesajul care trebuie criptat
  str2 : .space 100 				#mesajul criptat
  tablou: .space 100 				#tablou pentru stocarea puterilor la generare
  tablou_invers: .space 100 #tablou pentru decriptare
  alfabet: .asciiz "ABCDEFGHIJKLMNOPRSTUVXZ"
  not_prime: .asciiz "Numarul p nu este prim\n"
  prime: .asciiz "Numarul p este prim\n"
  found_generator: .asciiz "Am gasit un generator: "
  spatiu: .asciiz " "
  newline: .asciiz "\n"
  
.text
main:

  li $v0,5                            #Inputul numarului p
  syscall
  move $t0,$v0
  sw $t0,p                            #Stocam in memorie numarul p introdus pentru pastrare
  
  li $t1,2                            #Verificam daca este prim
  div $t2,$t0,2                       #Limita for-ului
  addi $t2,$t2,1          	      #[p/2]+1
  
  prime_check:                        #Verificam daca este prim sau nu
    ble $t0,1,exit_not_prime
    beq $t1,$t2,leave_prime_check
    rem $t3,$t0,$t1
    beqz $t3,exit_not_prime
    addi $t1,$t1,1
    j prime_check
    
  exit_not_prime:                     #Daca nu este prim, iesi din program
    la $a0,not_prime
    li $v0,4
    syscall
    j exit
  
leave_prime_check:		      #Daca este prim, continua programul
  la $a0,prime
  li $v0,4
  syscall
  
  #Cum am determinat ca p este prim, citim acum mesajele, sa le avem stocate in memorie
  la $a0,str1 #Citim mesajul care trebuie criptat
  li $a1,100
  li $v0,8
  syscall
  
  la $a0,str2 #Citim mesajul criptat care trebuie decriptat
  li $a1,100
  li $v0,8
  syscall
  
  #Numarul p este prim si satisface conditia. Incercam sa gasim acum generatorul pentru Zp*
  #Incarcam intr-un registru ($t1) valoarea 1. Daca la o ridicare la putere obtinem
  #valoarea 1, putem sa intrerupem ciclul si sa trecem la urmatorul generator
  #Vom utiliza teorema ca g divide cardinalul lui Zp* (card Zp* = p-1)
  #Incepem de la g=2 (g=1 nu are sens de calculat, pentru ca nu este un generator)
  #Vom declara si o variabila $t4, pentru a itera cu datele din tabel
  
  li $t1,1 			# g^0, pt. orice g din Zp*
  sw $t1,tablou($zero)          # tablou[0] = 1 (pentru orice generator)
  li $t2,2 			# g=2										 
  sub $t3,$t0,1 		# p=p-1 (cardinalul Zp*,utilizam alt registru pentru ca avem nevoie de p la mod)
  for_g:
  	beq $t2,$t0,strange_error # if g = p, s-a produs o eroare (am introdus-o ca pe o limit? pentru for, in realitate nu da nici o eroare :) )				        # punem limita forului pana la p
        rem $t5,$t3,$t2           # Cu $t5 verificam daca este sau nu divizor al lui p-1							# Calculam (p-1)%g 	 
  	beqz $t5, verf_gen 	  # Dac? este egal cu 0, s?rim la verificare				# daca (p-1)%g == 0, incepem sa verificam daca e generator
  	increment:		   				# daca nu este egal, atunci:
  	addi $t2,$t2,1     					# marim cu 1 generatorul
  	j for_g
  	
        verf_gen: 						# Facem un for (j = 1, j < p-1, j++)
        	li $t4,4                      			# $t4 - iterator pentru tablou
        	sw $t2,tablou($t4)				# Nu vom modifica regi?trii $t0(p), $t1 (1), $t2 (gener.),$t3(p-1) sau $t4(iteratorul tabloului)
        	li $t5,2       				# j = 2
        	addi $t6,$t2,0 	#g (prec) (cum g < p, nu e nevoie de mod p)
        	for_j:
                	beq $t5, $t3, exit_generator_check  	# if (j = p-1)
                	addi $t4,$t4,4				# increment index of array
                	mul $t6,$t6,$t2				# g(now) = g (prec) * g
                	rem $t6,$t6,$t0 			# g(now) mod p
                	beq $t6,$t1,increment			# if g^j == 1, break and increment g
                	sw $t6, tablou($t4)			# else: adauga in tablou
                	addi $t5,$t5,1				#increment j
        		j for_j	
        	
  exit_generator_check:
  	sw $t2, g
  	
  	la $a0,found_generator
  	li $v0,4
  	syscall
  	
  	move $a0, $t2
  	li $v0,1
  	syscall
  	
  	la $a0,newline
 	li $v0,4
        syscall
  		
  
  
        #!!!Sectiune aditionala pentru a verifica daca tabloul este corect (P.S. E corect :) )!!!
  li $t4,0
  mul $t1,$t3,4				#(p-1)*4
  print_tablou:
  bge $t4,$t1,exit_print
  lw $t2,tablou($t4)
  move $a0,$t2
  li $v0,1
  syscall
  
  la $a0,spatiu
  li $v0,4
  syscall
  
  addi $t4,$t4,4	
  j print_tablou
  
  exit_print:	
  la $a0,newline
  li $v0,4
  syscall
  	        #SFARSIT PRINT TABEL
  	        
  		#CREARE TABEL INVERS (PENTRU CRIPTARE - DECRIPTARE)#		
  li $t4,0 		     			#iterator tablou_invers
  sw $zero,tablou_invers($t4) 			# ocupam indexul 0 cu valoarea 0 (pentru ca nu putem face inversul lui 0)         										
  
  tab_inv:  
  	 						#Trebuie sa cre?m tablou cu care vom decripta al doilea mesaj, care de fapt, este tabloul 0,1,...,p-2
  	bge $t4,$t1,finished_invers    
  	lw $t2,tablou($t4)
  	div $t4,$t4,4
  	mul $t2,$t2,4
  	sw $t4,tablou_invers($t2)
  	mul $t4,$t4,4
  	addi $t4,$t4,4 
	j tab_inv
  
  finished_invers:   
     			#PRINT TABLOU INVERS (PENTRU DECRIPTARE)
  li $t4,4 #reset iterator
  print_tablou_invers:
  bgt $t4,$t1,exit_print_invers
  lw $t2,tablou_invers($t4)
  move $a0,$t2
  li $v0,1
  syscall
  
  la $a0,spatiu
  li $v0,4
  syscall
  
  addi $t4,$t4,4	
  j print_tablou_invers     
        	
  exit_print_invers:
  la $a0,newline
  li $v0,4
  syscall
  
    			#CRIPTAREA MESAJULUI
  
  #li $t0,0 # introducem cate o litera din mesaj
  li $t2,0 # iterator pentru mesaj
  li $t3,1 # verificator pentru sfarsitul sirului
  
  criptare:
  lb $t0,str1($t2) 	# incarcam in $t0 litera de pe pozitia $t2 din stringul str1
  sub $t0,$t0,65	
  mul $t0,$t0,4
  lw $t1,tablou($t0)
  lb $t1,alfabet($t1)
  
  li $v0,11
  move $a0,$t1
  syscall
  
  addi $t2,$t2,1
  addi $t3,$t3,1
  lb $t0,str1($t3)
  beqz $t0,finish_criptare
  j criptare
  
  finish_criptare:
  
  la $a0,newline
  li $v0,4
  syscall
  
  
  li $t0,0
  li $t2,0 #iterator pentru mesaj
  #li $t3,1 #verificator pentru sfarsitul sirului
  
  decriptare:
  lb $t0,str2($t2) 
  beqz $t0,finish_decriptare
  sub $t0,$t0,65
  mul $t0,$t0,4
  lw $t1,tablou_invers($t0)
  lb $t1,alfabet($t1)
  
  li $v0,11
  move $a0,$t1
  syscall
  
  addi $t2,$t2,1
  #addi $t3,$t3,1
  #lb $t0,str2($t3)
  #beqz $t0,finish_decriptare
  j decriptare
  
  finish_decriptare:
  
exit:
  li $v0,10
  syscall  
  
  
strange_error:
  #An error has occured
  li $v0,10
  syscall
