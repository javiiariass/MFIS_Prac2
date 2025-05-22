enum TipoGusto {
  JUEGOS,
  PASEOS,
  DORMIR,
  JUGUETES,
  CARICIAS,
  COMIDA,
  AGUA,
  BANYOS,
  COMPETICIONES,
  CUIDADOS
}

enum Especie {
  PERRO,
  GATO,
  HURON,
  CONEJO,
  IGUANA,
  SERPIENTE,
  TORTUGA,
  LORO,
  PEZ
}

/**
  * Representa a la clase abstracta Usuario.
  */
abstract sig Usuario {
  nombre : one Nombre,
  
}

sig Propietario extends Usuario {
  dueño : some Mascota
}

sig Mascota extends Usuario {
	mascota : some Propietario,
	registroVacunacion : set Vacuna,
	amigos : set Mascota,
	gustos : some TipoGusto,
	vacunasTodas : lone vacunasAlDia,
	comportamiento : lone ComportamientoAgresivo,
	especieMascota : one Especie,
	publicacionesPropias : set PublicacionNormal,
}

/**
 * Esta firma representa al atributo Booleano "vacunasAlDia" de la mascota.
 * Tendrá una relación con Mascota "lone":
 * Si tiene relación con mascota, significa que la mascota tiene todas 
 * sus vacunas al día -> puede publicar anuncios de adopción
 * 
 * Si no tiene relación con mascota, significa que la mascota no 
 * tiene todas sus vacunas al día -> no puede publicar anuncios de adopción
 */
sig vacunasAlDia{
  // representa el atributo booleano "vacunasAlDia" de la mascota
}

sig Nombre{
  // representa el nombre del usuario
  // necesaria para fact NombreUnico
}

sig Vacuna {
  // representa objeto vacuna
}


sig Fecha{
  // Representamos las fechas como un número entero
  ValorDias:one Int
}

one sig fechaActual {
  // Representamos la fecha actual para poder 
  // realizar comparaciones con otras fechas
  ValorDias: one Int
}

one sig ComportamientoAgresivo{
  // Representa el comportamiento agresivo de una mascota
  // necesaria para restricciones de comportamiento en mascotas
}


// Un producto puede ir destinado a una o varias especies
sig Producto {
	Especiedestinada : some Especie,
}

sig Veterinario {
	comprueba : set Producto
}

	//No contemplabamos que una mascota creara un evento o anuncions
	//entonces lo hemos dividido en dos signaturas
abstract sig Publicacion {
	etiquetado : set Usuario,
  fechaPublicada : one Fecha,
}

sig PublicacionNormal extends Publicacion {
	publicador : one Mascota,
}

sig Comentario  {
	comentario : one Publicacion,
	autor : one Propietario
}

sig Evento extends Publicacion {
	participantes : set Mascota,
	creador : one Propietario,
  ubicacion : one Ubicacion,
  fechaEvento : one Fecha,
  estadoEvento : lone EventoConfirmado,
}

sig Ubicacion{
  // Representa la ubicación de un evento
  // necesaria para la restricción de eventos
}

one sig EventoConfirmado{
  // Representa el estado de confirmación de un evento
}

sig AnuncioAdopcion extends Publicacion {
  mascotaAdopcion : one Mascota
}

sig AnuncioProducto extends Publicacion {
	productoAnunciado : one Producto,
	mascotasRecomendadas : some Mascota,
}



// ********************************************** Restricciones para cardinalidades **********************************************


// Cardinalidad de la relación entre mascota y propietario ->     Mascota [1..4] <-> [1..*]Propietario 
/**
 * Hecho que indica que una mascota debe ser "mascota" del propietario que la tiene como dueño. 
 */
fact DueñosSimétricos {
  all m: Mascota | all p: m.mascota | m in p.dueño
}


/**
 * Hecho que indica que la amistad debe ser bidireccional.
 */
fact AmistadBidireccional {
	  // Para que dos mascotas sean amigas, deben tener una relación de amistad mutua
  all m1, m2: Mascota | m1 in m2.amigos implies m2 in m1.amigos
}



// El publicador de una publicacion debe tener esa publicacion en la 
// relacion publicacionesPropias ->     PublicacionNormal [0..*] <-> [1]Mascota
fact publicacionesBidireccionales{
  all p: PublicacionNormal | p in p.publicador.publicacionesPropias
}

fact anuncioMascota{
  all aP,aP2: AnuncioAdopcion | aP.mascotaAdopcion != aP2.mascotaAdopcion
}

// *********************************************** Restricciones para fechas **********************************************
/**
  * Hecho que indica que cualquier fecha debe ser positiva.
  */
fact fechaNoNegativa{
  all f :Fecha |f.ValorDias > 0 
}

fact fechaActualNoNegativa{
  fechaActual.ValorDias > 0
}

fact fechaPublicacionMenorQueFechaActual{
  all p: Publicacion | p.fechaPublicada.ValorDias <= fechaActual.ValorDias
}

/**
  * Función que calcula la diferencia de días entre la fecha actual y una fecha dada.
  * Devuelve un número entero.
  */
fun diasRestantes[f1: Fecha]: Int {
   f1.ValorDias.minus[fechaActual.ValorDias]
}

/**
  * Función que calcula la diferencia de días entre dos fechas.
  * Devuelve un número entero.
  */
fun diferenciaFechas[f1: Fecha, f2: Fecha]: Int {
  // Devuelve la diferencia entre dos fechas
  f1.ValorDias.minus[f2.ValorDias]
}

// ********************************************** Restricciones Generales **********************************************


/**
  * Hecho que indica que un producto puede tener máximo un AnuncioProducto.
  */
fact unAnuncioPorProducto{
	// Un producto puede tener o no tener un anuncio
	// Si tiene un anuncio, no puede tener más de uno
	all p: Producto | lone aP: AnuncioProducto | p in aP.productoAnunciado
}




// ***************** Restriccion 1 *****************
  // Numero maximo de mascotas por propietario
 fact CantidadMaximaDeMascotasPorPropietario {
   all p: Propietario | #p.dueño <= 4
 }

// ***************** Restriccion 2 *****************
// Compatibilidad entre mascotas

/**
 * Hecho que indica que dos mascotas deben tener al menos 2 gustos en común para ser amigas.
 */
fact AmistadBasadaEnGustos {
  // Para que dos mascotas sean amigas, deben tener al menos 2 gustos en común
  all m1, m2: Mascota | m2 in m1.amigos implies gustosCoincidentes[m1, m2] >= 2
}

/**
 * Función que calcula la cantidad de gustos en común entre dos mascotas.
 * Usada para verificar si dos mascotas pueden ser amigas.
 */
fun gustosCoincidentes[m1, m2: Mascota]: Int {
  #(m1.gustos & m2.gustos) // & -> intersección entre los conjuntos de gustos
}

// ***************** Restriccion 3 y 13 *****************

// Por simplificar el modelo en alloy, consideramos que un producto es verificado si ha sido revisado por al menos cuatro veterinarios

/**
 * Función que indica si un producto ha sido verificado.
 */
fun productoVerificadoPorVeterinario[prod: Producto]: Int {
  
  // Por simplificar, consideramos que un producto es verificado si ha sido revisado por al menos cuatro veterinarios
   #{ v: Veterinario | prod in v.comprueba } > 3 
   implies 1 
   else 0

}

/**
  * Hecho que indica que un AnuncioProducto debe ser de un producto recomendado por veterinarios (Verificado).
  * Se considera que un producto es verificado si ha sido revisado por al menos cuatro veterinarios.
  */
fact ProductoVerificadoPorVeterinarios {
  all aP: AnuncioProducto | productoVerificadoPorVeterinario[aP.productoAnunciado] > 0 
}


// ***************** Restriccion 4 *****************
/**
 * Hecho que indica que las mascotas recomendadas del anuncio producto deben ser de la/s especies indicadas por el producto.
 */
fact ProductoRecomendadoPorMascota {

	all aP: AnuncioProducto | {
		all m: aP.mascotasRecomendadas | {
			// La mascota recomendada debe ser la misma especie que el producto
			#(aP.productoAnunciado.Especiedestinada &
	 		m.especieMascota)=1
		}
	} 
}


// ***************** Restriccion 5 *****************

/**
  * Hecho que indica que una mascota puede ,como máximo, hacer 3 publicaciones al día.
  */
fact MascotaMaxTresPublicacionesPorFecha {
  // Para cada mascota y cada fecha, limitar a máximo 3 publicaciones en esa fecha
  all m: Mascota | all f: Fecha | 
    #{ p: PublicacionNormal | p in m.publicacionesPropias and p.fechaPublicada = f } <= 3
}

// ***************** Restriccion 6 *****************
// Las mascotas con compaortamiento agresivo son suspendidas
// En alloy, al no tener atributos, tratamos el estado de la mascota con una firma.
// Esta restriccion es irrelevante en este modelo en alloy


//***************** Restriccion 7 *****************
// Las mascotas puestas en adopcion deben tener todas sus vacunas al día
/**
 * Hecho que indica que una mascota de un anuncio de adopción debe tener todas sus vacunas al día.
 */
fact AnuncioAdopcionConVacunasValidas {
  all aa: AnuncioAdopcion | one aa.mascotaAdopcion.vacunasTodas
}


// ***************** Restriccion 8 *****************
// Una mascota no se puede apunar a dos evento con la misma fecha
fact MascotaNoPuedeApuntarseDosVeces {
  all m: Mascota, e1, e2: Evento | 
    e1 != e2 and m in e1.participantes and m in e2.participantes implies 
    e1.fechaEvento != e2.fechaEvento
}




//***************** Restriccion 9 *****************
fact EventoConMascotas {
  // Para cada evento, debe haber al menos 6 mascotas apuntadas
  all e: Evento | diasRestantes[e.fechaEvento] <=7 and #e.participantes > 6 
 
}


//***************** Restriccion 10 *****************

// Los eventos no pueden realizarse si  no hay 6 mascotas apuntadas


fact eventoSuspendido{
  all e: Evento | {
    (diasRestantes[e.fechaEvento] <= 7 and #{e.participantes}<=6) implies #(e.estadoEvento)>0
  } 
}
pred dsd{

  #Evento > 4
}
run dsd for 15

//***************** Restriccion 11 *****************

// No puede haber dos usuarios con el mismo nombre
fact NombreUnico {
  // No puede haber dos usuarios con el mismo nombre
  all u1, u2: Usuario | u1 != u2 implies u1.nombre != u2.nombre
}

// ***************** Restriccion 12 *****************
// Las mascotas suspendidas no pueden inscribirse a eventos 

fact EventoNoAgresivo {
  // No puede haber eventos que tengan mascotas con comportamiento agresivo
  all e:Evento | no e.participantes.comportamiento
}


// ***************** Restriccion 14 *****************
// Una mascota no puede ser amiga de sí misma
/**
* Hecho que indica que no puede haber mascotas que sean amigas de sí mismas.
*/
fact MascotaNoAmigos {
	// No puede haber mascotas que sean amigas de sí mismas
	all m: Mascota | m !in m.amigos
}

// ***************** Restriccion 15 *****************
// Las mascotas suspendidas no pueden ser adopatadas
/**
 * Hecho que indica que una mascota con comportamiento agresivo no puede tener amigos.
 */
fact AnuncioAgresivo {
	// No puede haber anuncios de adopción que tengan mascotas con comportamiento agresivo
  	all a:AnuncioAdopcion | no a.mascotaAdopcion.comportamiento 
}

// ***************** Restriccion 16 *****************

// Dos eventos no pueden tener la misma fecha si estan en la misma ubicacion

fact EventosNoPuedenTenerMismaFecha {
  all e1, e2: Evento | e1 != e2 implies ((e1.fechaEvento = e2.fechaEvento and e1.ubicacion != e2.ubicacion)
   or (e1.fechaEvento != e2.fechaEvento and e1.ubicacion = e2.ubicacion))
}

// ***************** Restriccion 17 *****************
/**
 * Hecho que indica que una mascota debe tener al menos 3 gustos.
 */
fact CantidadMinimaDeGustosPorMascota {
  all m: Mascota | #m.gustos >= 3
}

// ***************** Restriccion 18 *****************

// Todas las fechas generadas en el modelo deben ser posteriores a la fechaActual
/**
  * Hecho que indica que la fecha de un evento debe ser, al menos, 
  * 7 días posterior a la fecha de creacion del evento.
  */
// fact eventoConSemanaDeAnticipacion {
//   all e: Evento | diferenciaFechas[e.fechaEvento, e.fechaPublicada] > 7
// }

fact eventoConSemanaDeAnticipacion {
  all e: Evento | e.fechaEvento.ValorDias > e.fechaPublicada.ValorDias
}



// ********************************************** Predicados **********************************************


pred AmistadBidireccionalPred {
  #Mascota >= 4
  // Para cada mascota, si tiene amigos, entonces debe tener al menos 2 gustos en común con cada uno de ellos
  all m: Mascota | {
  // Si la mascota tiene amigos
  some m.amigos 
    
  }
}
 // run AmistadBidireccionalPred for 15

pred ProductoVerificadoPorVeterinariosPred {
  #AnuncioProducto > 4
  some p : Producto | productoVerificadoPorVeterinario[p] > 0
  some p2 : Producto | productoVerificadoPorVeterinario[p2] = 0	
}
 //run ProductoVerificadoPorVeterinariosPred for 15
pred unAnuncioPorProductoPred{
  #AnuncioProducto > 4
  some p: Producto | lone aP: AnuncioProducto | p in aP.productoAnunciado
}

//run unAnuncioPorProductoPred for 15


pred CantidadMaximaDeMascotasPorPropietarioPred {
  #Propietario =1
  #Mascota = 4
 
}
//run CantidadMaximaDeMascotasPorPropietarioPred for 15

pred ProductoRecomendadoPorMascotaPred {
  // Para cada anuncio de producto, las mascotas recomendadas deben ser de la/s especies indicadas por el producto
  #AnuncioProducto > 4
}
//run ProductoRecomendadoPorMascotaPred for 15

pred anuncios{
	// Para cada anuncio de adopción, la mascota en adopción debe tener todas sus vacunas al día
		// La mascota en adopción tiene todas sus vacunas al día
	#AnuncioProducto > 4
	some aa: AnuncioProducto | #aa.productoAnunciado.Especiedestinada = 1

	// Para cada anuncio de adopción, el propietario del anuncio debe ser el dueño de la mascota en adopción
	some ap: AnuncioProducto | #ap.productoAnunciado.Especiedestinada > 1

}


pred amigos{
	  // Para cada mascota, si tiene amigos, entonces debe tener al menos 2 gustos en común con cada uno de ellos
  all m: Mascota | {
	// Si la mascota tiene amigos
	some m.amigos 
	  
	}

  #Mascota >= 4
}



pred mascotaEnAdopcionSinVacunas {
  // Debe existir al menos un anuncio de adopción
  some aa: AnuncioAdopcion | {
    // La mascota en adopción NO tiene sus vacunas al día
    no aa.mascotaAdopcion.vacunasTodas
  }
  

  // Para verificar que estamos intentando específicamente violar el fact de las vacunas
  // y no otros facts del modelo
  all m: Mascota | m !in m.amigos  // Cumple con MascotaNoAmigos
}


pred cincoMascotasUnPropietario {
  -- Hay exactamente un propietario
  one p: Propietario | {
    -- Hay exactamente 5 mascotas
    #Mascota = 5
    
    -- Cada mascota pertenece al propietario
    all m: Mascota | m in p.dueño and p in m.mascota
  }
}
pred MascotaMaxTresPublicacionesPorFechaPred{
  one m: Mascota | {
    // La mascota tiene exactamente 4 publicaciones en un día
    one f: Fecha | 
      #{ p: PublicacionNormal | p in m.publicacionesPropias and p.fechaPublicada = f } = 4
  }
}
//run MascotaMaxTresPublicacionesPorFechaPred for 15

//run cincoMascotasUnPropietario for 15
/*
pred unPropietario {
  -- Hay exactamente un propietario
  one m: mascota | {
    -- Hay exactamente 5 mascotas
    #Propietario = 0
    
    
  }
}
*/
// run unPropietario for 15



// *********************************************** asserts para verificar facts *********************************************** 



// ************************************************ asserts ***********************************************
assert MascotaMaxTresPublicacionesPorFechaAssert {
	#PublicacionNormal > 4
  all m: Mascota| all f: Fecha | 
    #{ p: PublicacionNormal | p in m.publicacionesPropias and p.fechaPublicada = f } <= 3
}
//check MascotaMaxTresPublicacionesPorFechaAssert for 15




/**
 * assert que comprueba si la relación de amistad es bidireccional.
 */
assert AmistadBidireccionalAssert {
  all m: Mascota | all p: m.mascota | m in p.dueño
}



// Assert para verificar que la relación de amistad es simétrica
assert AmistadEsSimétrica {
  all m1, m2: Mascota | m1 in m2.amigos implies m2 in m1.amigos
}


assert AnuncioAdopcionConVacunasValidasAssert {
  all aa: AnuncioAdopcion | one aa.mascotaAdopcion.vacunasTodas
}


assert MascotaNoAmigosAssert {
	// No puede haber mascotas que sean amigas de sí mismas
	all m: Mascota | m !in m.amigos
}

assert CantidadMaximaDeMascotasPorPropietarioAssert {
   all p: Propietario | #p.dueño <= 4
 }

assert CantidadMinimaDeGustosPorMascotaAssert {
   all m: Mascota | #m.gustos >= 3
 }