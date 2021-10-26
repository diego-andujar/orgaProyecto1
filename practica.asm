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

y: .asciiz "y "
 
uno: .asciiz "uno"
dos: .asciiz "dos"
tres: .asciiz "tres"
cuatro: .asciiz "cuatro"
cinco: .asciiz "cinco"
seis: .asciiz "seis" 
siete: .asciiz "siete"
ocho: .asciiz "ocho"
nueve: .asciiz "nueve"

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

mil: .asciiz "mil"
millones: .asciiz "millones"


cadena: .space 10

.text 
print(mensaje1)

li $v0 8
li $a1 10
la $a0 cadena
syscall 

li $t0 0 # contador para moverse en cadena
li $t4 0 # tener el numero anterior al actual
loop:
	li $t1 0 #saber la cantidad de espacios entre el numero actual y el numero final
	add $t1 $t1 $t0
	
	lb $t2 cadena($t0)
	blt $t2 0x30 finfin
	bgt $t2 0x39 finfin
	
	loopsig:
		
		lb $t3 cadena($t1) # loop interno para saber los espacios 
	
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
		beq $t1 4 normal #normal mil
		beq $t1 5 diez # mil
		beq $t1 6 cientos # mil
		beq $t1 7 normal #millones
		beq $t1 8 diez #millones 
		beq $t1 9 cientos #millones
		
		normal:
		
			subi $t4 $t0 1 # $t4 es un contador para ir al numero anterior
			lb $t5 cadena($t4) #ver si tiene un numero antes y asi saber si se print un Y o no
			
			subi $t5 $t5 0x30 #$t5 a numero
			
			beq $t2 0 ceroz #si el numero es 0 se va a la seccion de 0 y asi no se imprime la "Y"
			beq $t5 0 noY	
			beq $t0 0 noY
			
			
			li $t4 0	#se reinicia a 0 $t4
			print(y)
			#num($t4)
			
			noY:
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
				print(uno)
				print(espacio)
				beq $t1 4 MIL	# si el contador $t1 es igual a 4 se va a mil
				beq $t1 7 MILLONES # si el contador $t1 es igual a 4 se va a millones
				b siguesigue
			Dos:
				print(dos)
				print(espacio)
				beq $t1 4 MIL
				beq $t1 7 MILLONES
				b siguesigue
			Tres:
				print(tres)
				print(espacio)
				beq $t1 4 MIL
				beq $t1 7 MILLONES
				b siguesigue
			Cuatro:
				print(cuatro)
				print(espacio)
				beq $t1 4 MIL
				beq $t1 7 MILLONES
				b siguesigue
			Cinco:
				print(cinco)
				print(espacio)
				beq $t1 4 MIL
				beq $t1 7 MILLONES
				b siguesigue
			Seis:
				print(seis)
				print(espacio)
				beq $t1 4 MIL
				beq $t1 7 MILLONES
				b siguesigue
			Siete:
				print(siete)
				print(espacio)
				beq $t1 4 MIL
				beq $t1 7 MILLONES
				b siguesigue
			Ocho:
				print(ocho)
				print(espacio)
				beq $t1 4 MIL
				beq $t1 7 MILLONES
				b siguesigue
			Nueve:
				print(nueve)
				print(espacio)
				beq $t1 4 MIL
				beq $t1 7 MILLONES
				b siguesigue
				
			ceroz: #dependiendo de la posicion se imprime millones o miles o nada
				beq $t1 4 MIL 
				beq $t1 7 MILLONES
				b siguesigue
			MIL: #imprime mil
				print(mil)
				print(espacio)
				b siguesigue
			MILLONES: #imprime millones
				print(millones)
				print(espacio)
				b siguesigue
								
		diez:
			beq $t2 0 siguesigue
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
			
			beq $t2 0 siguesigue
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
		
		siguesigue:
		
		#num($t1)
		#print(salto)
	
		#num($t2)
		#print(salto)
	
		addi $t0 $t0 1
		
		
		b loop

finfin:
	fin

	
	
