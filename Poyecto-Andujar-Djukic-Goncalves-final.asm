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
mensaje2: .asciiz "de bolivares digitales con"
mensaje3: .asciiz "bolivares digitales"

salto: .asciiz "\n"
dosciento: .asciiz "doscientos"
espacio: .asciiz " "

cantidadmala: .asciiz "Solo se permiten las cantidades de 14 13 12 10 9 8 6 5 4 caracteres, las comas y puntos son caracteres"

erro: .asciiz "ERROR no se permiten otros caracteres que no sean numero o puntos y comas"
ERROR: .asciiz "Error la coma o el punto estan mal posicionados"
maspunto: .asciiz "ERROR hay mas puntos de los que deberian"
mascomas: .asciiz "ERROR hay mas comas de las que deberian"
nohaycomaz: .asciiz "ERROR no hay comas, debe haber siempre una ej: 0,00"
comamala: .asciiz "ERROR la coma esta mal posicionada"
puntomalo: .asciiz "ERROR el punto esta mal posicionado"

COMA: .asciiz "con"
slash: .asciiz "/100"

y: .asciiz "y "
epale: .asciiz " epale "
 
uno: .asciiz "uno"
un: .asciiz "un"
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
millon: .asciiz "millon"


cadena: .space 15

.text 
print(mensaje1)

li $v0 8
li $a1 15
la $a0 cadena
syscall 

print(salto)

li $t8 0
li $t9 0
li $s2 0
li $t0 0
li $t6 0
li $t4 0
loopveri:
	loopveriin:
		lb $t9 cadena($t8)
 		
 		beq $t9 0x00 ver
		beq $t9 0x0A ver
		
		beq $t9 0x2E spunto
		beq $t9 0x2C scoma
		
		blt $t9 0x30 error
		bgt $t9 0x39 error
		
		s:
			addi $t8 $t8 1
			#num($t8)
			b loopveriin
		spunto:
			addi $t4 $t4 1
			#beq $t8 0 errorpospunto
			b s
		scoma:
			addi $t0 $t0 1
			#beq $t8 0 errorposcoma
			b s
		
ver:
li $t9 0
li $t6 0

blt $t8 4 nosepermite
beq $t8 7 nosepermite
beq $t8 11 nosepermite

beq $t0 0 nohaycoma 
bgt $t4 2 errorMpunto
bgt $t0 1 errorMcoma

beq $t8 14 poscatorce
beq $t8 13 postrece
beq $t8 12 posdoce
beq $t8 10 posdies
beq $t8 9 posnueve
beq $t8 8 posocho
beq $t8 6 posseis
beq $t8 5 poscinco
beq $t8 4 poscuatro

b numeros

poscatorce:
	lb $t9 cadena($t6)
	
	beq $t6 3 errorpunto
	beq $t6 7 errorpunto
	beq $t6 11 vercoma
	
	subi $t9 $t9 0x30
	
	verinerno:
	beq $t6 $t8 numeros
	addi $t6 $t6 1

	b poscatorce
	
	vercoma:
		bne $t9 0x2C errorposcoma
		b verinerno
	errorpunto:
		bne $t9 0x2E errorpospunto
		b verinerno

postrece:
	lb $t9 cadena($t6)
	
	beq $t6 2 errorpunto13
	beq $t6 6 errorpunto13
	beq $t6 10 vercoma13
	
	subi $t9 $t9 0x30
	
	verinerno13:
	beq $t6 $t8 numeros
	addi $t6 $t6 1

	b postrece
	
	vercoma13:
		bne $t9 0x2C errorposcoma
		b verinerno13
	errorpunto13:
		bne $t9 0x2E errorpospunto
		b verinerno13

posdoce:
	lb $t9 cadena($t6)
	
	beq $t6 1 errorpunto12
	beq $t6 5 errorpunto12
	beq $t6 9 vercoma12
	
	subi $t9 $t9 0x30
	
	verinerno12:
	beq $t6 $t8 numeros
	addi $t6 $t6 1

	b posdoce
	
	vercoma12:
		bne $t9 0x2C errorposcoma
		b verinerno12
	errorpunto12:
		bne $t9 0x2E errorpospunto
		b verinerno12

posdies:
	bgt $t4 1 errorMpunto
	lb $t9 cadena($t6)
	
	beq $t6 3 errorpunto10
	beq $t6 7 vercoma10
	
	subi $t9 $t9 0x30
	
	verinerno10:
	beq $t6 $t8 numeros
	addi $t6 $t6 1

	b posdies
	
	vercoma10:
		bne $t9 0x2C errorposcoma
		b verinerno10
	errorpunto10:
		bne $t9 0x2E errorpospunto
		b verinerno10

posnueve:
	bgt $t4 1 errorMpunto
	lb $t9 cadena($t6)
	
	beq $t6 2 errorpunto9
	beq $t6 6 vercoma9
	
	subi $t9 $t9 0x30
	
	verinerno9:
	beq $t6 $t8 numeros
	addi $t6 $t6 1

	b posnueve
	
	vercoma9:
		bne $t9 0x2C errorposcoma
		b verinerno9
	errorpunto9:
		bne $t9 0x2E errorpospunto
		b verinerno9

posocho:
	bgt $t4 1 errorMpunto
	lb $t9 cadena($t6)
	
	beq $t6 1 errorpunto8
	beq $t6 5 vercoma8
	
	subi $t9 $t9 0x30
	
	verinerno8:
	beq $t6 $t8 numeros
	addi $t6 $t6 1

	b posocho
	
	vercoma8:
		bne $t9 0x2C errorposcoma
		b verinerno8
	errorpunto8:
		bne $t9 0x2E errorpospunto
		b verinerno8

posseis:
	bgt $t4 0 errorMpunto
	lb $t9 cadena($t6)
	
	beq $t6 3 vercoma6
	
	subi $t9 $t9 0x30
	
	verinerno6:
	beq $t6 $t8 numeros
	addi $t6 $t6 1

	b posseis
	
	vercoma6:
		bne $t9 0x2C errorposcoma
		b verinerno6

poscinco:
	bgt $t4 0 errorMpunto
	lb $t9 cadena($t6)
	
	beq $t6 2 vercoma5
	
	subi $t9 $t9 0x30
	
	verinerno5:
	beq $t6 $t8 numeros
	addi $t6 $t6 1

	b poscinco
	
	vercoma5:
		bne $t9 0x2C errorposcoma
		b verinerno5
		
poscuatro:
	bgt $t4 0 errorMpunto
	lb $t9 cadena($t6)
	
	beq $t6 1 vercoma4
	
	subi $t9 $t9 0x30
	
	verinerno4:
	beq $t6 $t8 numeros
	addi $t6 $t6 1

	b poscuatro
	
	vercoma4:
		bne $t9 0x2C errorposcoma
		b verinerno4

numeros:
li $t9 0		
li $t8 0

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
			li $s4 0
			#num($t0)
			lb $t5 cadena($t0) #ver si tiene un numero antes y asi saber si se print un Y o no
			addi $s4 $t0 -1
			bltz $s4 menoracero
			
			lb $s7 cadena($s4)
			
			subi $s7 $s7 0x30
			
			subi $t5 $t5 0x30 #$t5 a numero
			#print(espacio)
			#print(epale)
			#num($t5)
			#print(epale)
			#num($s7)
			#print(espacio)
			beq $t5 0 siguesigue	
			beq $s7 0 noY
			
			menoracero:
			subi $t5 $t5 0x30 #$t5 a numero
			#print(epale)
			#print(epale)
			#num($t5)
			beq $t5 0 siguesigue	
			beq $t0 0 noY
			
			
				#se reinicia a 0 $t4
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
				beqz $t0 check
				unopro:
				li $s0 0
				li $s2 0
				
				add $s0 $t0 1
				lb $s2 cadena($s0)

				beq $s2 0x2E UN #ver si el siguiente caracter es un punto
								
				print(uno)
				print(espacio)
				li $s0 0
				li $s2 0
				b siguesigue
				
				UN:
					print(un)
					print(espacio)
					li $s0 0
					li $s2 0
					b siguesigue
				check:
					#num($t6)
					beq $t6 12 millonpelao
					beq $t6 8 milpelao
					print(uno)
					print(espacio)
					b siguesigue
					
					millonpelao:
						print(un)
						print(espacio)
						print(millon)
						print(espacio)
						addi $t0 $t0 1
						b siguesigue
					milpelao:
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
			li $s0 0
			li $s2 0
			li $t5 0
			
			beq $t6 14 vermensaje14
			beq $t6 13 vermensaje13
			beq $t6 12 vermensaje12
			
			normalcoma:
			print(mensaje3)
			print(espacio)
			print(COMA)
			print(espacio)
			num($t2)
			li $s0 0
			li $s2 0
			li $t5 0
			b siguesigue
			
			vermensaje14:
				li $s0 4
				vermensaje14in:
					lb $s2 cadena($s0)
					addi $s0 $s0 1
					
					beq $s2 0x2E vermensaje14in
					
					subi $s2 $s2 0x30
					bnez $s2 normalcoma
					#num($s2)
					#print(espacio)
					#num($s0)
					#print(epale)
					beq $s0 11 millonesbs
					b vermensaje14in
					b siguesigue
				
			vermensaje13:
				li $s0 3
					vermensaje13in:
					lb $s2 cadena($s0)
					addi $s0 $s0 1
					
					beq $s2 0x2E vermensaje13in
					
					subi $s2 $s2 0x30
					bnez $s2 normalcoma
					#num($s2)
					#print(espacio)
					#num($s0)
					#print(epale)
					beq $s0 10 millonesbs
					b vermensaje13in
					b siguesigue
					
			vermensaje12:
				li $s0 2
					vermensaje12in:
					lb $s2 cadena($s0)
					addi $s0 $s0 1
					
					beq $s2 0x2E vermensaje12in
					
					subi $s2 $s2 0x30
					bnez $s2 normalcoma
					#num($s2)
					#print(espacio)
					#num($s0)
					#print(epale)
					beq $s0 9 millonesbs
					b vermensaje12in
					b siguesigue
					
				millonesbs:
					print(mensaje2)
					print(espacio)
					num($t2)
					li $s0 0
					li $s2 0
					li $t5 0
					b siguesigue
					
		comados:
			num($t2)
			print(slash)
			b siguesigue
			
		coma:
			#print(COMA)
			#print(espacio)
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
					
					li $s0 0
					li $s2 0
					li $s4 0
					add $s0 $s0 $t0
					Versimilono:
						
						subi $s0 $s0 1
						lb $s2 cadena($s0)
					
						subi $s2 $s2 0x30
						addi $s4 $s4 1
						#
						bnez $s2 mil1
						beq $s4 3 nomil
						b Versimilono
					
					mil1:
					li $s0 0
					li $s2 0
					li $s4 0
					print(mil)
					print(espacio)
					b siguesigue
					
					nomil:
					li $s0 0
					li $s2 0
					li $s4 0
					b siguesigue
					
				catorcemillones:
					print(millones)
					print(espacio)
					b siguesigue
			
			trece:
				beq $t1 2 trecemillones
				beq $t1 6 trecemil
				
				
				trecemil:
				
					li $s0 0
					li $s2 0
					li $s4 0
					add $s0 $s0 $t0
					Versimilono1:
						
						subi $s0 $s0 1
						lb $s2 cadena($s0)
					
						subi $s2 $s2 0x30
						addi $s4 $s4 1
						#
						bnez $s2 mil2
						beq $s4 3 nomil2
						b Versimilono1
						
					mil2:
					li $s0 0
					li $s2 0
					li $s4 0
					print(mil)
					print(espacio)
					b siguesigue
					
					nomil2:
					li $s0 0
					li $s2 0
					li $s4 0
					b siguesigue
					
				trecemillones:
					print(millones)
					print(espacio)
					b siguesigue
			dozez:
				beq $t1 1 dozezmillones
				beq $t1 5 dozezmil
				dozezmil:
				
					li $s0 0
					li $s2 0
					li $s4 0
					add $s0 $s0 $t0
					Versimilono3:
						
						subi $s0 $s0 1
						lb $s2 cadena($s0)
					
						subi $s2 $s2 0x30
						addi $s4 $s4 1
						#
						bnez $s2 mil3
						beq $s4 3 nomil3
						b Versimilono3
						
					mil3:
					li $s0 0
					li $s2 0
					li $s4 0
					print(mil)
					print(espacio)
					b siguesigue
					
					nomil3:
					li $s0 0
					li $s2 0
					li $s4 0
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
	print(erro)
	fin
errorMpunto:
	print(maspunto)
	fin
errorMcoma:
	print(mascomas)
	fin
nohaycoma:
	print(nohaycomaz)
	fin
errorposcoma:
	print(comamala)
	fin
errorpospunto:
	print(puntomalo)
	fin
nosepermite:
	print(cantidadmala)
	fin
finfin:
	fin

	
	
