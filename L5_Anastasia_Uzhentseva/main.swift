//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.

import Foundation

//протокол Car - общий метод подсчёт скорости по времени и расстоянию
//Вопрос! нужно ли впихивать в протокол переменные расстония и времени или оставлять их в описании классов?
protocol Car {
    var time: Double { get set }
    var distance: Double { get set }
    func calculateSpeed () -> Double
}

protocol CarMovable {
    func move() -> Double
}

//extension Car {
//    
//}



//создаём класс SportCar согласно протокола Car
//отличительные свойства turboEngine
class SportCar : Car {
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
    
    func calculateSpeed() -> Double {
        return self.distance / self.time
    }
}

//создаём класс TrunkCar согласно протокола Car
//отличительные свойства capacity и currentLoad
class TrunkCar: Car {
    var time: Double
    var distance: Double
    let capacity: Double
    var currentLoad: Double {
        didSet {
            print("\(oldValue)")
        }
        willSet {
            print("\(newValue)")
        }
    }
    
    init?(time: Double, distance: Double, capacity: Double, currentLoad: Double?) {
        self.time = time
        self.distance = distance
        self.capacity = capacity
        self.currentLoad = currentLoad!
        if currentLoad! > capacity {
                return nil
            }
    }
    
    func calculateSpeed() -> Double {
        return self.distance / self.time
    }

    func loadTruck (weight: Double?) -> Double {
        return self.currentLoad + weight!
    }
    //Вопрос! где лучше написать условия первышения вместимости?
}

extension SportCar : CustomStringConvertible {
    var description: String {
        return "Спорткар на двигателе \(self.turboEngine.rawValue) проехал \(self.distance) км за \(self.time) часов, скорость составила \(self.calculateSpeed()) км/ч. \n"
    }
}

extension TrunkCar : CustomStringConvertible {
    var description: String {
        return "Грузовик проехал \(self.distance) км за \(self.time) часов, скорость составила \(self.calculateSpeed()) км/ч. Назрузка составила \(self.currentLoad) из \(self.capacity) возможных.\n"
    }
}

let sportCar1 = SportCar(time: 4, distance: 520, turboEngine: .cilinderV)
let trunkCar2 = TrunkCar(time: 8, distance: 600, capacity: 500, currentLoad: 100)

//загружаем груз в грузовик - здесь не идёт подсчёт в дискрипшн!! разобраться почему
print(trunkCar2!.loadTruck(weight: 300))


// дискрипшн не берет новое значение - Вопрос! Как впихнуть туда newValue?
print(sportCar1.description)
print(trunkCar2!.description)






//условия на проверку скорости

//if speed > 0 && speed < 300 {
//    return "Скорость составила \(speed) км/ч"
//} else {
//    return "wasted"
//}
//return "неизвестная ошибка"
//}

//if load > capacity {
//    return "Нагрузка больше вместимости"
//} else if weight < 0 {
//    return "Введено отрицательное значение"
//} else {
//    return "Было загружено \(weight) кг груза, общая нагрузка составила \(load) кг"
//}
