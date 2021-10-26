.macro print(%dir_memoria)
li $v0 4 
la $a0 %dir_memoria
syscall 
.end_macro 

.macro fin
li $v0 10
syscall 
.end_macro 

.macro num(%dir_memoria)
li $v0 1
move $a0 %dir_memoria
syscall 
.end_macro 

.data
mensaje1: .asciiz "Numero plis => "
mensaje2: .asciiz "El numero es el "
salto: .asciiz "\n"
dosciento: .asciiz "doscientos"
espacio: .asciiz " " 
tres: .asciiz "tres"

dies: .asciiz "dies"
veinte: .asciiz "veinte"
treinta: .asciiz "treinta"
cuarenta: .asciiz "cuarenta"
cincuenta: .asciiz "cincuenta"
sesenta: .asciiz "sesenta"
setenta: .asciiz "setenta"
ochenta: .asciiz "ochenta"
noventa: .asciiz "noventa"

cien: .asciiz "cien"
doscientos: .asciiz "doscientos"
trescientos: .asciiz "trescientos"
cuatrocientos: .asciiz "cuatrocientos"
quinientos: .asciiz "quinientos"
seiscientos: .asciiz "seiscientos"
sietecientos: .asciiz "sietecientos"
ochocientos: .asciiz "ochocientos"
novecientos: .asciiz "novecientos"

cadena: .space 10

.text 
print(mensaje1)

li $v0 8
li $a1 10
la $a0 cadena
syscall 

li $t0 0
loop:
	li $t1 0
	add $t1 $t1 $t0
	
	lb $t2 cadena($t0)
	blt $t2 0x30 finfin
	bgt $t2 0x39 finfin
	
	loopsig:
		lb $t3 cadena($t1)
	
		beq $t3 0x00 sigpaso
		beq $t3 0x0A sigpaso
		
		addi $t1 $t1 1
				
		b loopsig
		
	sigpaso:
		sub $t1 $t1 $t0
		
		subi $t2 $t2 0x30
		
		beq $t1 1 normal
		beq $t1 2 diez   
		beq $t1 3 cientos
		beq $t1 5 diezmiles
		beq $t1 6 cinetosmiles
		beq $t1 7 millones
		beq $t1 8 diezmillones 
		beq $t1 9 cientosmillones
		
		diez:
			beq $t2 1 Dies
			beq $t2 2 Veinte
			beq $t2 3 Treinta
			beq $t2 4 Cuarenta
			beq $t2 5 Cincuenta
			beq $t2 6 Sesenta
			beq $t2 7 Setenta
			beq $t2 8 Ochenta
			beq $t2 9 Noventa
			Dies:
				print(dies)
				print(espacio)
				b siguesigue
			Veinte:
				print(veinte)
				print(espacio)
				b siguesigue
			Treinta:
				print(treinta)
				print(espacio)
				b siguesigue
			Cuarenta:
				print(cuarenta)
				print(espacio)
				b siguesigue
			Cincuenta:
				print(cincuenta)
				print(espacio)
				b siguesigue
			Sesenta:
				print(sesenta)
				print(espacio)
				b siguesigue
			Setenta:
				print(setenta)
				print(espacio)
				b siguesigue
			Ochenta:
				print(ochenta)
				print(espacio)
				b siguesigue
			Noventa:
				print(noventa)
				print(espacio)
				b siguesigue
			
		cientos:
			beq $t2 1 Cien
			beq $t2 2 Doscientos
			beq $t2 3 Trescientos
			beq $t2 4 Cuatrocientos
			beq $t2 5 Quinientos
			beq $t2 6 Seiscientos
			beq $t2 7 Sietecientos
			beq $t2 8 Ochocientos
			beq $t2 9 Novecientos
			Cien:
				print(cien)
				print(espacio)
				b siguesigue
			Doscientos:
				print(dosciento)
				print(espacio)
				b siguesigue
			Trescientos:
				print(trescientos)
				print(espacio)
				b siguesigue
			Cuatrocientos:
				print(cuatrocientos)
				print(espacio)
				b siguesigue	
			Quinientos:
				print(quinientos)
				print(espacio)
				b siguesigue
			Seiscientos:
				print(seiscientos)
				print(espacio)
				b siguesigue
			Sietecientos:
				print(sietecientos)
				print(espacio)
				b siguesigue
			Ochocientos:
				print(ochocientos)
				print(espacio)
				b siguesigue
			Novecientos:
				print(novecientos)
				print(espacio)
				b siguesigue
		
		normal:
			beq $t2 1 Uno
			beq $t2 2 Dos
			beq $t2 3 Tres
			beq $t2 4 Cuatro
			beq $t2 5 Cinco
			beq $t2 6 Seis
			beq $t2 7 Siete
			beq $t2 8 Ocho
			beq $t2 9 Nueve
			
			Uno:
			   print(conector)
			   print(espacio)
			   print(uno)
			   b siguesigue
			
			Dos:
			   print(conector)
			   print(espacio)
			   print(dos)
			   b siguesigue
			   
			Tres:
			    print(conector)
			   print(espacio)
			   print(tres)
			   b siguesigue
			   
			Cuatro:
			   print(conector)
			   print(espacio)
			   print(cuatro)
			   b siguesigue
			   
			Cinco:
			   print(conector)
			   print(espacio)
			   print(cinco)
			   b siguesigue
			
			Seis:
			   print(conector)
			   print(espacio)
			   print(seis)
			   b siguesigue
			   
			Siete:
			   print(conector)
			   print(espacio)
			   print(siete)
			   b siguesigue
			
			Ocho:
			   print(conector)
			   print(espacio)
			   print(ocho)
			   b siguesigue
			
			Nueve:
			   print(conector)
			   print(espacio)
			   print(nueve)
			   b siguesigue
		diezmiles:
		cinetosmiles:
		millones:
		diezmillones:
		cientosmillones:
		
		siguesigue:
		
		#num($t1)
		#print(salto)
	
		#num($t2)
		#print(salto)
	
		addi $t0 $t0 1
	
		b loop

finfin:
	fin

	
	
