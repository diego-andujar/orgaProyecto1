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
ERROR: .asciiz "Error la coma o el punto estan mal posicionados"

COMA: .asciiz "con"
slash: .asciiz "/100"

y: .asciiz "y "
epale: .asciiz " epale "
 
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
once: .asciiz "once"
doce: .asciiz "doce"
trecez: .asciiz "trece"
catorcez: .asciiz "catorce"
quince: .asciiz "quince"

veinte: .asciiz "veinte"
treinta: .asciiz "treinta"
cuarenta: .asciiz "cuarenta"
cincuenta: .asciiz "cincuenta"
sesenta: .asciiz "sesenta"
setenta: .asciiz "setenta"
ochenta: .asciiz "ochenta"
noventa: .asciiz "noventa"

cien: .asciiz "cien"
cineto: .asciiz "ciento"
doscientos: .asciiz "doscientos"
trescientos: .asciiz "trescientos"
cuatrocientos: .asciiz "cuatrocientos"
quinientos: .asciiz "quinientos"
seiscientos: .asciiz "seiscientos"
sietecientos: .asciiz "setecientos"
ochocientos: .asciiz "ochocientos"
novecientos: .asciiz "novecientos"

mil: .asciiz "mil"
millones: .asciiz "millones"


cadena: .space 15

.text 
print(mensaje1)

li $v0 8
li $a1 15
la $a0 cadena
syscall 

print(salto)

li $t8 0
#loopver:
	#lb $t9 cadena($t8)
	
	#beq $t9 0x2E puntover # ver si es un punto
	#beq $t9 0x2C comaver # ver si es una coma
	
	#add $t8 $t8 1

li $t0 0 # contador para moverse en cadena
li $t4 0 # tener el numero anterior al actual

li $t6 0 # tener el numero anterior

li $s0 0 # contador para moverse en la cadena y ver los numeros siguientes de los cientos
li $s2 0 # contador para los cientos su max es 2

loop:
	li $t1 0 #saber la cantidad de espacios entre el numero actual y el numero final
	add $t1 $t1 $t0
	
	lb $t2 cadena($t0)
	
	beq $t2 0x2E punto # ver si es un punto
	beq $t2 0x2C coma # ver si es una coma
	
	blt $t2 0x30 finfin # ver si es un numero
	bgt $t2 0x39 finfin
	
	loopsig:
		
		lb $t3 cadena($t1) # loop interno para saber la posicion
	
		beq $t3 0x00 sigpaso
		beq $t3 0x0A sigpaso
		
		addi $t1 $t1 1
				
		b loopsig
		
	sigpaso:
		sub $t1 $t1 $t0
		beqz $t0 cantTotales
		b siguepaso
		
		cantTotales:
			add $t6 $t6 $t1
			
		siguepaso:
		###############################################################
		
		#subi $t4 $t0 1 # $t4 es un contador para ir al numero anterior
		#lb $t5 cadena($t4) #ver si tiene un numero antes y asi saber si se print un Y o no
			
		#subi $t5 $t5 0x30 #$t5 a numero
		
		###############################################################
		
		beq $t2 0x2E punto # ver si es un punto
		beq $t2 0x2C coma # ver si es una coma
		
		subi $t2 $t2 0x30
		
		beq $t1 1 comados
		beq $t1 2 comauno
		   
		#beq $t1 3 coma
		
		beq $t1 4 normal #
		beq $t1 5 diez # 
		beq $t1 6 cientos # 
		
		#beq $t1 7 siguesigue 
		
		beq $t1 8 normal #mil 
		beq $t1 9 diez #mil
		beq $t1 10 cientos #mil
		
		beq $t1 11 siguesigue
		
		beq $t1 12 normal #millones
		beq $t1 13 diez #millones
		beq $t1 14 cientos #millones
		
		normal:
		
			#num($t4)
			#num($t0)
			#addi $t4 $t0 1 # $t4 es un contador para ir al numero anterior
			#num($t4)
			lb $t5 cadena($t0) #ver si tiene un numero antes y asi saber si se print un Y o no
			
			subi $t5 $t5 0x30 #$t5 a numero
			
			beq $t5 0 siguesigue	
			#beq $t0 0 noY
			
			
				#se reinicia a 0 $t4
			print(y)
			#num($t4)
			
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
				#beq $t1 7 MIL	# si el contador $t1 es igual a 4 se va a mil
				#beq $t1 7 MILLONES # si el contador $t1 es igual a 4 se va a millones
				b siguesigue
			Dos:
				print(dos)
				print(espacio)
				b siguesigue
			Tres:
				print(tres)
				print(espacio)
				b siguesigue
			Cuatro:
				print(cuatro)
				print(espacio)
				b siguesigue
			Cinco:
				print(cinco)
				print(espacio)
				b siguesigue
			Seis:
				print(seis)
				print(espacio)
				b siguesigue
			Siete:
				print(siete)
				print(espacio)
				b siguesigue
			Ocho:
				print(ocho)
				print(espacio)
				b siguesigue
			Nueve:
				print(nueve)
				print(espacio)
				b siguesigue
				
			#ceroz: #dependiendo de la posicion se imprime millones o miles o nada
			#	beq $t1 4 MIL 
			#	beq $t1 7 MILLONES
			#	b siguesigue
			#MIL: #imprime mil
			#	print(mil)
			#	print(espacio)
			#	b siguesigue
			#MILLONES: #imprime millones
			#	print(millones)
			#	print(espacio)
			#	b siguesigue
		
		############# dieces ############# 
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
				add $s3 $t0 1
				#num($t0)
				#num($s3)
				lb $s5 cadena($s3)
				
				subi $s5 $s5 0x30
				
				beq $s5 1 Once
				beq $s5 2 Docess
				beq $s5 3 Trecess
				beq $s5 4 Catorcess
				beq $s5 5 Quincess
				
				print(dies)
				print(espacio)
				b siguesigue
				
				Once:
					print(once)
					print(espacio)
					addi $t0 $t0 1
					#num($t0)
					b siguesigue
				Docess:
					print(doce)
					print(espacio)
					addi $t0 $t0 1
					#num($t0)
					b siguesigue
				Trecess:
					print(trecez)
					print(espacio)
					addi $t0 $t0 1
					#num($t0)
					b siguesigue
				Catorcess:
					print(catorcez)
					print(espacio)
					addi $t0 $t0 1
					#num($t0)
					b siguesigue
				Quincess: 
					print(quince)
					print(espacio)
					addi $t0 $t0 1
					#num($t0)
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
		
		############# Cientos #############
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
				li $s0 0
				li $s2 0
				add $s0 $s0 $t0
				loopciento:
					
					addi $s0 $s0 1
					addi $s2 $s2 1
					#num($s2)
					#print(espacio)
					lb $s1 cadena($s0)
					#num($s0)
					#print(epale)
					subi $s1 $s1 0x30
					#print(epale)
					#num($s1)
					#print(espacio)
					bnez  $s1 cientoz
					beq $s2 2 ciens
					b loopciento
					
				cientoz:
					print(cineto)
					print(espacio)
					b siguesigue
				ciens:
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
		
		comauno:
			num($t2)
			b siguesigue
		comados:
			num($t2)
			print(slash)
			b siguesigue
			
		coma:
			print(COMA)
			print(espacio)
			b siguesigue
			
		punto:
			
			#subi $t4 $t0 1 # $t4 es un contador para ir al numero anterior
			#lb $t5 cadena($t4) #ver si tiene un numero antes y asi saber si se print un Y o no
			
			#subi $t5 $t5 0x30 #$t5 a numero
			#print(epale)
			#num($t6)
			
			beq $t6 14 catorce
			beq $t6 13 trece
			beq $t6 12 dozez
			beq $t6 10 diezez
			beq $t6 9 nuevez
			beq $t6 8 ochoz
			
			catorce:
				beq $t1 3 catorcemillones
				beq $t1 7 catorcemil
				catorcemil:
					print(mil)
					print(espacio)
					b siguesigue
				catorcemillones:
					print(millones)
					print(espacio)
					b siguesigue
			
			trece:
				beq $t1 2 trecemillones
				beq $t1 6 trecemil
				trecemil:
					print(mil)
					print(espacio)
					b siguesigue
				trecemillones:
					print(millones)
					print(espacio)
					b siguesigue
			dozez:
				beq $t1 1 dozezmillones
				beq $t1 5 dozezmil
				dozezmil:
					print(mil)
					print(espacio)
					b siguesigue
				dozezmillones:
					print(millones)
					print(espacio)
					b siguesigue
			diezez:
				beq $t1 3 diezezmil
				diezezmil:
					print(mil)
					print(espacio)
					b siguesigue
			nuevez:
				beq $t1 2 nuevezmil
				nuevezmil:
					print(mil)
					print(espacio)
					b siguesigue
			ochoz:
				beq $t1 1 ochozmill
				ochozmill:
					print(mil)
					print(espacio)
					b siguesigue
					
		siguesigue:
	
		#num($t1)
		#print(salto)
	
		#num($t2)
		#print(salto)
	
		addi $t0 $t0 1
		
		
		b loop

error:
	print(salto)
	print(ERROR)
	fin
finfin:
	fin

	
	
