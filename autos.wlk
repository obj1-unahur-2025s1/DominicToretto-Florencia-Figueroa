object dominic {
    const autos = [] //Es constante por que siempre va a ser la misma lista por mas que cambie lo de adrentro

    method comprar(unAuto){
        autos.add(unAuto)
    }
    method autosNoEnCondiciones() = 
        autos.filter({a => not a.enCondiciones()}) //se puede usar not o !

    method autosEnCondiciones() = 
        autos.filter({a => a.enCondiciones()})

    method mandarAutosAlTaller(){
        taller.recibirAutos(self.autosNoEnCondiciones()) //manda los autos a la lista de taller
    }
    method hacerPruebaDeVelocidad(){
        autos.forEach({a => a.hacerPrueba()})
    }
    method venderAutos() {
        autos.clear()
    }
    method promedioVelocidad() = 
        autos.sum({a => a.velocidadMaxima()}) / autos.size()

    method masRapido() =  
        self.autosEnCondiciones().max({a => a.velocidadMaxima()})

    method hayAutoMuyRapido() = self.masRapido().velocidadMaxima()  >  (2 * self.promedioVelocidad())
}

object taller {
    const autosAReparar = []

    method recibirAutos(listaDeAutos){
        autosAReparar.addAll(listaDeAutos)
    }
    method repararAutos() {
      autosAReparar.forEach({a => a.reparar()}) //para que reparar se aplique a todos los autos de la lista 
      autosAReparar.clear() // para eliminar todos los autos de la lista
    }
}

object ferrari {
    var motor = 87

    method enCondiciones() = motor >= 65

    method reparar(){motor = 100}

    method velocidadMaxima() = 110 + if(motor > 75) 15 else 0

    method hacerPrueba(){motor = (motor - 30).max(0)} // para que devuelva el max entre esos valores, controla que no sea menos de 0
}

object flecha {
    var nivelCombustible = 100
    var property combustible = gasolina
    var color = azul 

    method nuevoColor(nuevo){color = nuevo}

    method enCondiciones() =  
        nivelCombustible > combustible.nivelMinimo()  and
        color == rojo

    method hacerPrueba (){
        nivelCombustible = (nivelCombustible - 5).max(0)
    }
    method reparar(){
        nivelCombustible = nivelCombustible * 2
        color = color.cambiarDeColor()
    }
    method velocidadMaxima(){
        return (nivelCombustible * 2) + combustible.calculoAdicional(nivelCombustible)
    }
}

object intocable {
    var property enCondiciones = true

    method hacerPrueba(){enCondiciones = false}

    method reparar(){enCondiciones = true}

    method velocidadMaxima() = 45
}

object mcLaren {
    var kilometrosRecorridos = 0 
    var potencia = 1000
    var nivelCombustible = 100
    const combustible = gasolina

    method enCondiciones() = kilometrosRecorridos <= 100
    method velocidadMaxima() = 50 + if(potencia > 900) 300 else 200
    method hacerPrueba(){
        kilometrosRecorridos = kilometrosRecorridos * combustible.calculoAdicional(nivelCombustible)}
    method reparar(){
        kilometrosRecorridos = 0
        nivelCombustible = 100
        potencia = 1000
    }

    method esConducidoKilometros(kilometros){
        kilometrosRecorridos = kilometrosRecorridos + kilometros
        nivelCombustible = nivelCombustible - (kilometros * 0.03)
        potencia = potencia - kilometros
    }
}


//Combustibles
object gasolina {
    method nivelMinimo() = 85
    method calculoAdicional(litros) = 10 
}

object nafta {
    method nivelMinimo() = 50
    method calculoAdicional(litros) = ((litros * 2) * 0.10) * -1
}

object nitrogeno {
    method nivelMinimo() = 0
    method calculoAdicional(litros) = (litros * 2) * 10
}


//Colores
object azul {
    method cambiarDeColor() = rojo
}

object rojo {
     method cambiarDeColor() = azul
}

object verde {
     method cambiarDeColor() = rojo
}