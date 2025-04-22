open Practica1.use
!create dActual : Date
!dActual.dia := 3
!dActual.mes := 4
!dActual.anyo := 2025 
Date.fechaActual := dActual

!create dNac1 : Date
!dNac1.dia := 15
!dNac1.mes := 5
!dNac1.anyo := 2022

!create dNac2 : Date
!dNac2.dia := 10
!dNac2.mes := 3
!dNac2.anyo := 2023

!create dPub1 : Date
!dPub1.dia := 1
!dPub1.mes := 4
!dPub1.anyo := 2025

!create dEv1 : Date
!dEv1.dia := 10
!dEv1.mes := 4
!dEv1.anyo := 2025

!create dEv2 : Date
!dEv2.dia := 20 
!dEv2.mes := 4
!dEv2.anyo := 2025

!create dVac1 : Date
!dVac1.dia := 1
!dVac1.mes := 8
!dVac1.anyo := 2022


!create prop1 : Propietario
!prop1.id := 1
!prop1.nombreUsuario := 'juan85'
!prop1.Sexo := 'Masculino'
!prop1.nombre := 'Juan Pérez'
!prop1.dni := '11111111A'
!prop1.nFotosDiarias := 2 

!create prop2 : Propietario
!prop2.id := 2
!prop2.nombreUsuario := 'ana_catlover'
!prop2.Sexo := 'Femenino'
!prop2.nombre := 'Ana García'
!prop2.dni := '22222222B'
!prop2.nFotosDiarias := 3 



!create masc1_firu : Mascota
!masc1_firu.id := 101
!masc1_firu.nombreUsuario := 'firu_dog'
!masc1_firu.Sexo := 'Macho'
!masc1_firu.nombre := 'Firulais'
!masc1_firu.especie := 'Perro'
!masc1_firu.raza := 'Mestizo'
!masc1_firu.fechaNacimiento := dNac1
!masc1_firu.salud := 'Buena'
!masc1_firu.comportamientoAgresivo := false
!masc1_firu.estadoPerfil := 'Activo'
!masc1_firu.vacunasAlDia := true
!masc1_firu.gustos := Set{#JUEGOS, #PASEOS, #COMIDA, #JUGUETES}

!create masc2_michi : Mascota
!masc2_michi.id := 102
!masc2_michi.nombreUsuario := 'michi_siames'
!masc2_michi.Sexo := 'Hembra'
!masc2_michi.nombre := 'Michi'
!masc2_michi.especie := 'Gato'
!masc2_michi.raza := 'Siames'
!masc2_michi.fechaNacimiento := dNac2
!masc2_michi.salud := 'Excelente'
!masc2_michi.comportamientoAgresivo := false
!masc2_michi.estadoPerfil := 'Activo'
!masc2_michi.vacunasAlDia := true
!masc2_michi.gustos := Set{#DORMIR, #CARICIAS, #COMIDA}

!create masc3_brutus : Mascota
!masc3_brutus.id := 103
!masc3_brutus.nombreUsuario := 'brutus_agresivo'
!masc3_brutus.Sexo := 'Macho'
!masc3_brutus.nombre := 'Brutus'
!masc3_brutus.especie := 'Perro'
!masc3_brutus.raza := 'Bulldog'
!masc3_brutus.fechaNacimiento := dNac1
!masc3_brutus.salud := 'Regular'
!masc3_brutus.comportamientoAgresivo := true
!masc3_brutus.estadoPerfil := 'Suspendido' 
!masc3_brutus.vacunasAlDia := true
!masc3_brutus.gustos := Set{#COMIDA, #DORMIR, #AGUA} 

!create masc4_luna : Mascota
!masc4_luna.id := 104
!masc4_luna.nombreUsuario := 'luna_adoptame'
!masc4_luna.Sexo := 'Hembra'
!masc4_luna.nombre := 'Luna'
!masc4_luna.especie := 'Perro'
!masc4_luna.raza := 'Labrador'
!masc4_luna.fechaNacimiento := dNac2
!masc4_luna.salud := 'Buena'
!masc4_luna.comportamientoAgresivo := false
!masc4_luna.estadoPerfil := 'Activo'
!masc4_luna.vacunasAlDia := false 
!masc4_luna.gustos := Set{#PASEOS, #JUGUETES, #AGUA} 

!create masc5_adoptable : Mascota
!masc5_adoptable.id := 105
!masc5_adoptable.nombreUsuario := 'peluso_adopt'
!masc5_adoptable.Sexo := 'Macho'
!masc5_adoptable.nombre := 'Peluso'
!masc5_adoptable.especie := 'Gato'
!masc5_adoptable.raza := 'Común Europeo'
!masc5_adoptable.fechaNacimiento := dNac1
!masc5_adoptable.salud := 'Buena'
!masc5_adoptable.comportamientoAgresivo := false
!masc5_adoptable.estadoPerfil := 'Activo'
!masc5_adoptable.vacunasAlDia := true 
!masc5_adoptable.gustos := Set{#CARICIAS, #DORMIR, #JUGUETES} 



!insert (prop1, masc1_firu) into Tiene
!insert (prop1, masc2_michi) into Tiene -- prop1 tiene 2 mascotas (cumple <= 4)
!insert (prop2, masc3_brutus) into Tiene
!insert (prop2, masc4_luna) into Tiene
!insert (prop2, masc5_adoptable) into Tiene -- prop2 tiene 3 mascotas (cumple <= 4)



!create vac1 : Vacuna
!vac1.idVacuna := 901
!vac1.edadToma := dVac1

!create vac2 : Vacuna
!vac2.idVacuna := 902
!vac2.edadToma := dNac2 


!insert (masc1_firu, vac1) into RegistroVacunacion
!insert (masc1_firu, vac2) into RegistroVacunacion
!insert (masc5_adoptable, vac1) into RegistroVacunacion



!insert (masc1_firu, masc4_luna) into Amigos -- Amigos Perro-Perro (ambos activos)
!insert (masc2_michi, masc5_adoptable) into Amigos -- Amigos Gato-Gato (ambos activos)



!create pubGral1 : Publicacion
!pubGral1.idPublicacion := 201
!pubGral1.fechaPublicacion := dPub1
!pubGral1.numMeGusta := 10

!create evento1 : Evento
!evento1.idPublicacion := 301
!evento1.fechaPublicacion := dPub1
!evento1.numMeGusta := 5
!evento1.estadoConfirmacion := false 
!evento1.nParticipantes := 4
!evento1.fechaEvento := dEv1
!evento1.recordatorios := 'Traer bolsas'
!evento1.ubicacion := 'Parque Norte'
-- Este evento está a 7 días o más, nParticipantes <=6, estadoConfirmacion=false -> cumple eventosuspendido (no se suspende)

!create evento2 : Evento
!evento2.idPublicacion := 302
!evento2.fechaPublicacion := dPub1
!evento2.numMeGusta := 25
!evento2.estadoConfirmacion := true 
!evento2.nParticipantes := 8
!evento2.fechaEvento := dEv2 
!evento2.recordatorios := 'Agua y snacks'
!evento2.ubicacion := 'Playa Canina Oeste'


!create anuncioAdop1 : AnuncioAdopcion
!anuncioAdop1.idPublicacion := 401
!anuncioAdop1.fechaPublicacion := dPub1
!anuncioAdop1.numMeGusta := 50
!anuncioAdop1.enlace := 'http://adopta.org/peluso'

!create anuncioProd1 : AnuncioProducto
!anuncioProd1.idPublicacion := 501
!anuncioProd1.fechaPublicacion := dPub1
!anuncioProd1.numMeGusta := 3
!anuncioProd1.enlace := 'http://tienda.pet/pelota'



!insert (masc1_firu, pubGral1) into Publicaciones
!insert (masc1_firu, evento1) into Publicaciones 
!insert (masc4_luna, evento2) into Publicaciones
!insert (masc5_adoptable, anuncioAdop1) into Publicaciones 
!insert (masc1_firu, anuncioProd1) into Publicaciones 



!create com1 : Comentario
!com1.idComentario := 601
!com1.texto := '¡Qué guapo Firulais!'
!com1.numMeGusta := 2
!com1.idUsuario := masc2_michi.id 
!com1.fechaComentario := dActual

!create com2 : Comentario
!com2.idComentario := 602
!com2.texto := '¡Me apunto al evento del parque!'
!com2.numMeGusta := 1
!com2.idUsuario := masc4_luna.id 
!com2.fechaComentario := dActual


!insert (pubGral1, com1) into Comentarios
!insert (evento1, com2) into Comentarios



!create prodPerro1 : Producto
!prodPerro1.idProducto := 701
!prodPerro1.nombre := 'Pelota Super Dura'
!prodPerro1.foto := 'pelota.jpg'
!prodPerro1.esAprobadoVeterinariamente := false 
!prodPerro1.categoriaEspecie := 'Perro'
!prodPerro1.numRecomendaciones := 1 

!create prodGato1 : Producto
!prodGato1.idProducto := 702
!prodGato1.nombre := 'Rascador de Cartón'
!prodGato1.foto := 'rascador.png'
!prodGato1.esAprobadoVeterinariamente := false
!prodGato1.categoriaEspecie := 'Gato'
!prodGato1.numRecomendaciones := 0

!create prodUniAprobado : Producto
!prodUniAprobado.idProducto := 703
!prodUniAprobado.nombre := 'Fuente de Agua Automática'
!prodUniAprobado.foto := 'fuente.gif'
!prodUniAprobado.esAprobadoVeterinariamente := true
!prodUniAprobado.categoriaEspecie := 'todasLasEspecies'
!prodUniAprobado.numRecomendaciones := 3 

!create prodCasiAprobado : Producto
!prodCasiAprobado.idProducto := 704
!prodCasiAprobado.nombre := 'Comida Hipoalergénica'
!prodCasiAprobado.foto := 'comida.jpg'
!prodCasiAprobado.esAprobadoVeterinariamente := false 
!prodCasiAprobado.categoriaEspecie := 'Perro'
!prodCasiAprobado.numRecomendaciones := 1


-- Crear Veterinarios
!create vet1 : Veterinario
!vet1.idVeterinario := 801
!vet1.nombre := 'Dr. Canito'
!vet1.idCertificacion := 'VET-C-001'

!create vet2 : Veterinario
!vet2.idVeterinario := 802
!vet2.nombre := 'Dra. Felicia'
!vet2.idCertificacion := 'VET-F-002'

!create vet3 : Veterinario
!vet3.idVeterinario := 803
!vet3.nombre := 'Dr. Exótico'
!vet3.idCertificacion := 'VET-X-003'

!create vet4 : Veterinario
!vet4.idVeterinario := 804
!vet4.nombre := 'Dra. General'
!vet4.idCertificacion := 'VET-G-004'


!insert (prodUniAprobado, vet1) into ComprobadoPor
!insert (prodUniAprobado, vet2) into ComprobadoPor
!insert (prodUniAprobado, vet4) into ComprobadoPor


!insert (prodPerro1, vet1) into ComprobadoPor 


!insert (prodCasiAprobado, vet1) into ComprobadoPor
!insert (prodCasiAprobado, vet3) into ComprobadoPor
!insert (prodCasiAprobado, vet4) into ComprobadoPor




!insert (evento1, masc2_michi) into UsuariosInscritos 
!insert (evento1, prop2) into UsuariosInscritos  


!insert (evento2, masc1_firu) into UsuariosInscritos
!insert (evento2, prop1) into UsuariosInscritos 
!insert (evento2, masc5_adoptable) into UsuariosInscritos 



!insert (anuncioAdop1, masc5_adoptable) into MascotaEnAdopcion
!insert (anuncioProd1, prodUniAprobado) into ProductoAnunciado -- Cumple ProductoEspecifico


!insert (pubGral1, prop1) into Etiquetas -- Etiquetar a Juan en la publicación general
!insert (evento1, masc4_luna) into Etiquetas -- Etiquetar a Luna en el evento 1

