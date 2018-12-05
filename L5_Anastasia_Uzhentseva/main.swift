import Foundation

//протокол Car - общий метод подсчёт скорости по времени и расстоянию
protocol Car {
    var time: Double { get set }
    var distance: Double { get set }
    func calculateSpeed () -> Double
}

//протокол для спорткара на движение
protocol CarMovable {
    func move(newDistance: Double) -> String
}

//создаём класс SportCar согласно протокола Car
//отличительные свойства turboEngine
class SportCar : Car, CarMovable {
    var time: Double
    var distance: Double
    var turboEngine: turboEngine
    
    enum turboEngine: String {
        case rotor = "роторный"
        case cilinderV = "V-образный мотор"
    }
    
    init(time: Double, distance: Double, turboEngine: turboEngine) {
        self.time = time
        self.distance = distance
        self.turboEngine = turboEngine
    }
    
    // расчёт скорости авто
    func calculateSpeed() -> Double {
        return self.distance / self.time
    }
    
    // подсчёт нового расстояния
    func move(newDistance: Double) -> String {
        let mov = self.distance + newDistance
        return "Авто проехало \(mov) км"
    }
    
}

extension SportCar : CustomStringConvertible {
    var description: String {
        return "Спорткар на двигателе \(self.turboEngine.rawValue) проехал \(self.distance) км за \(self.time) часов, скорость составила \(self.calculateSpeed()) км/ч. \n"
    }
}

//создаём класс TrunkCar согласно протокола Car
//отличительные свойства capacity и currentLoad
class TrunkCar: Car {
    var time: Double
    var distance: Double
    let capacity: Double
    var currentLoad: Double
    
    init(time: Double, distance: Double, capacity: Double, currentLoad: Double) {
        self.time = time
        self.distance = distance
        self.capacity = capacity
        self.currentLoad = currentLoad
    }
    
    // расчёт скорости
    func calculateSpeed() -> Double {
        return self.distance / self.time
    }
    
    // расчёт новой загрузки
    func loadTruck (weight: Double) -> String {
        let load = self.currentLoad + weight
        if load > capacity {
            print("Превышена допустимая вместимость")
        }
        return "Грузовик загружен на \(load) кг"
    }
}

extension TrunkCar : CustomStringConvertible {
    var description: String {
        return "Грузовик проехал \(self.distance) км за \(self.time) часов, скорость составила \(self.calculateSpeed()) км/ч. Назрузка составила \(self.loadTruck) из \(self.capacity) возможных.\n"
    }
}


// создаём экземпляры
let sportCar1 = SportCar(time: 4, distance: 520, turboEngine: .cilinderV)
let trunkCar2 = TrunkCar(time: 8, distance: 600, capacity: 500, currentLoad: 100)

// описание экземпляров
print(sportCar1.description)
print(trunkCar2.description)

// Как записать это в description?
print(sportCar1.move(newDistance: 200))
print(trunkCar2.loadTruck(weight: 130))
