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

# loopveri se encarga de pasar por cada caracter de la cadena y ver que es, si es diferente a un numero o la coma y el punto salta a error
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
		spunto: # se encarga de sumar la cantidad de puntos que se encuentran en la cadena, el numero maximo de puntos es 2 y el minimo es 0 
			addi $t4 $t4 1 
			#beq $t8 0 errorpospunto
			b s
		scoma: # igual que spunto se encarga de sumar la cantidad de comas en la cadena, su maximo y minimo es 1
			addi $t0 $t0 1
			#beq $t8 0 errorposcoma
			b s
		
ver: # ver se encarga de ver la cantidad de puntos y comas en la cadena segun la cantidad total de caracteres, ademas de otras validaciones
li $t9 0
li $t6 0

# si la cadena tiene un tamano de 4, 7 u 11 va a error ya que colocar esa cantidad de caracteres representaria un error en como se colocaron los numeros
blt $t8 4 nosepermite 
beq $t8 7 nosepermite 
beq $t8 11 nosepermite

# ver si hay mas comas o puntos de los necesarios 
beq $t0 0 nohaycoma 
bgt $t4 2 errorMpunto
bgt $t0 1 errorMcoma

# segun la cantidad de la cadena los puntos y las comas siempre van a estar en la misma posicion
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

poscatorce:# si la cantidad de caracateres es 14, se revisa en que posociones estan los puntos y la coma
	lb $t9 cadena($t6)
	
	beq $t6 3 errorpunto
	beq $t6 7 errorpunto
	beq $t6 11 vercoma
	
	subi $t9 $t9 0x30
	
	verinerno:
	beq $t6 $t8 numeros
	addi $t6 $t6 1

	b poscatorce
	
	vercoma: #ver si la coma esta en la posicion 
		bne $t9 0x2C errorposcoma
		b verinerno
	errorpunto: #ver si el punto esta en la posicion 
		bne $t9 0x2E errorpospunto
		b verinerno

postrece:# si la cantidad de caracateres es 13, se revisa en que posociones estan los puntos y la coma
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

posdoce: # si la cantidad de caracateres es 12, se revisa en que posociones estan los puntos y la coma
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

posdies:# si la cantidad de caracateres es 10, se revisa en que posociones estan los puntos y la coma
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

posnueve:# si la cantidad de caracateres es 9, se revisa en que posociones estan los puntos y la coma
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

posocho:# si la cantidad de caracateres es 8, se revisa en que posociones estan los puntos y la coma
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

posseis:# si la cantidad de caracateres es 6, se revisa en que posociones estan los puntos y la coma
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

poscinco:# si la cantidad de caracateres es 5, se revisa en que posociones estan los puntos y la coma
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
		
poscuatro:# si la cantidad de caracateres es 4, se revisa en que posociones estan los puntos y la coma
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

# si todo se cumple se vuelve a colocar en 0 y se empieza a hacer la traduccion
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
		
		beq $t2 0x2E punto # ver si es un punto
		beq $t2 0x2C coma # ver si es una coma
		
		subi $t2 $t2 0x30
		
		beq $t1 1 comados
		beq $t1 2 comauno
		
		beq $t1 4 normal #
		beq $t1 5 diez # 
		beq $t1 6 cientos # 
		
		beq $t1 8 normal #mil 
		beq $t1 9 diez #mil
		beq $t1 10 cientos #mil
		
		
		beq $t1 12 normal #millones
		beq $t1 13 diez #millones
		beq $t1 14 cientos #millones
		
		normal: # imprime de el 1 al 9
			li $s4 0
			lb $t5 cadena($t0) #ver si tiene un numero antes y asi saber si se print un Y o no
			addi $s4 $t0 -1
			bltz $s4 menoracero #ver si el numero anterior es 0 tambien para asi no imprimir Y dando un error como doscientos y uno
			
			lb $s7 cadena($s4)
			
			subi $s7 $s7 0x30
			
			subi $t5 $t5 0x30 #$t5 a numero
			
			beq $t5 0 siguesigue # si es 0 pasa de largo
			beq $s7 0 noY
			
			menoracero: # Si el numero anterior es mayor para ver si Y o no
			subi $t5 $t5 0x30 #$t5 a numero

			beq $t5 0 siguesigue # si es 0 pasa de largo	
			beq $t0 0 noY
			
			print(y)

			noY:
			
			#ver que numero es
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
				beqz $t0 check # si es el primer numero va a check 
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
					
				check: # si es un millon o es mil, sino es uno y ya
				
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
					milpelao: # sigue ya que el punto es el que imprime mil 
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
				
		diez: # Imprime de el 10 al 90 
			
			#ver que numero es
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
				
				# se revisa que numero es el siguiente y si es 1, 2, 3, 4 o 5 salta a once, doce... y asi
				beq $s5 1 Once
				beq $s5 2 Docess
				beq $s5 3 Trecess
				beq $s5 4 Catorcess
				beq $s5 5 Quincess
				# si es no es ninguno solo se imprime diez
				print(dies)
				print(espacio)
				b siguesigue
				
				Once: #Imprime once
					print(once)
					print(espacio)
					addi $t0 $t0 1
					#num($t0)
					b siguesigue
				Docess:#Imprime doce
					print(doce)
					print(espacio)
					addi $t0 $t0 1
					#num($t0)
					b siguesigue
				Trecess:#Imprime trece
					print(trecez)
					print(espacio)
					addi $t0 $t0 1
					#num($t0)
					b siguesigue
				Catorcess:#Imprime catorce
					print(catorcez)
					print(espacio)
					addi $t0 $t0 1
					#num($t0)
					b siguesigue
				Quincess: #Imprime quince
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
		
		cientos: # Imprime desde el 100 al 900
			
			#ver que numero es
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
				loopciento: #ver los valores de los dos siguentes numeros
					
					addi $s0 $s0 1
					addi $s2 $s2 1

					lb $s1 cadena($s0)

					subi $s1 $s1 0x30

					bnez  $s1 cientoz # si alguno de los dos es distinto a 0 se imprime ciento
					beq $s2 2 ciens #si el contador llega a dos se imprime cien directamente
					b loopciento
					
				cientoz: # imprime ciento
					print(cineto)
					print(espacio)
					b siguesigue
				ciens: # imprime cien
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
		
		comauno: # imprime el primer numero despues de la coma, bolivares digitales y con
			li $s0 0
			li $s2 0
			li $t5 0
			
			# se ve la cantidad total de la cadena y se va a revisar si el numero es un cientos de millones, millones... solos, ej: 1.000.000,00 10.000.000,00 100.000.000,00
			beq $t6 14 vermensaje14
			beq $t6 13 vermensaje13
			beq $t6 12 vermensaje12
			
			#imprime la coma y sus mensajes
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
			
			vermensaje14: # si la cadena es de 14 se revisa si los numeros siguientes son 0 hasta llegar a la coma y si no se va a normalcoma
				li $s0 4
				vermensaje14in:
					lb $s2 cadena($s0)
					addi $s0 $s0 1
					
					beq $s2 0x2E vermensaje14in
					
					subi $s2 $s2 0x30
					bnez $s2 normalcoma

					beq $s0 11 millonesbs 
					b vermensaje14in
					b siguesigue
				
			vermensaje13:# si la cadena es de 13 se revisa si los numeros siguientes son 0 hasta llegar a la coma y si no se va a normalcoma
				li $s0 3
					vermensaje13in:
					lb $s2 cadena($s0)
					addi $s0 $s0 1
					
					beq $s2 0x2E vermensaje13in
					
					subi $s2 $s2 0x30
					bnez $s2 normalcoma

					beq $s0 10 millonesbs
					b vermensaje13in
					b siguesigue
					
			vermensaje12:# si la cadena es de 12 se revisa si los numeros siguientes son 0 hasta llegar a la coma y si no se va a normalcoma
				li $s0 2
					vermensaje12in:
					lb $s2 cadena($s0)
					addi $s0 $s0 1
					
					beq $s2 0x2E vermensaje12in
					
					subi $s2 $s2 0x30
					bnez $s2 normalcoma
					
					beq $s0 9 millonesbs
					b vermensaje12in
					b siguesigue
					
				millonesbs: # si se encuentra en millones y no hay mas valores distintos a 0 despues del punto se imprime el DE bolivares digitales
					print(mensaje2)
					print(espacio)
					num($t2)
					li $s0 0
					li $s2 0
					li $t5 0
					b siguesigue
					
		comados: #Imprime el segundo numero despues de la coma y el /100
			num($t2)
			print(slash)
			b siguesigue
			
		coma: # ve si es una coma simplemente sigue
			b siguesigue
			
		punto: # si es un punto se tiene que ver si es millones o mil o millon o miles 
			
			#todo depende de la cantidad de caracteres en la cadena
			beq $t6 14 catorce
			beq $t6 13 trece
			beq $t6 12 dozez
			beq $t6 10 diezez
			beq $t6 9 nuevez
			beq $t6 8 ochoz
			
			catorce: # ver la posicion para imprimir millones o mil
				beq $t1 3 catorcemillones
				beq $t1 7 catorcemil
				catorcemil:
					
					li $s0 0
					li $s2 0
					li $s4 0
					add $s0 $s0 $t0
					Versimilono: #ver si imprimir mil o no dependiendo de los valores de los caracteres en la posicion de los miles
						
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
			
			trece: # ver la posicion para imprimir millones o mil
				beq $t1 2 trecemillones
				beq $t1 6 trecemil
				
				
				trecemil:
				
					li $s0 0
					li $s2 0
					li $s4 0
					add $s0 $s0 $t0
					Versimilono1:#ver si imprimir mil o no dependiendo de los valores de los caracteres en la posicion de los miles
						
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
					
			dozez:# ver la posicion para imprimir millones o mil
				beq $t1 1 dozezmillones
				beq $t1 5 dozezmil
				dozezmil:
				
					li $s0 0
					li $s2 0
					li $s4 0
					add $s0 $s0 $t0
					Versimilono3:#ver si imprimir mil o no dependiendo de los valores de los caracteres en la posicion de los miles
						
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
					
			diezez:# ver la posicion para imprimir mil
				beq $t1 3 diezezmil
				diezezmil:
					print(mil)
					print(espacio)
					b siguesigue
			nuevez:# ver la posicion para imprimir mil
				beq $t1 2 nuevezmil
				nuevezmil:
					print(mil)
					print(espacio)
					b siguesigue
			ochoz:# ver la posicion para imprimir mil
				beq $t1 1 ochozmill
				ochozmill:
					print(mil)
					print(espacio)
					b siguesigue
					
		siguesigue: #Pasar al siguiente numero
	
		#num($t1)
		#print(salto)
	
		#num($t2)
		#print(salto)
	
		addi $t0 $t0 1
		
		
		b loop

#TODOS LOS ERRORES POSIBLES
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
	
#TERMINAR EL PROGRAMA
finfin:
	fin

	
	
