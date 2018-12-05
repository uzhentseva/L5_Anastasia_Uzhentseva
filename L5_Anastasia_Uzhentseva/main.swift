//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.

import Foundation

//протокол Car - общий метод подсчёт скорости по времени и расстоянию
//Вопрос! нужно ли впихивать в протокол переменные расстония и времени или оставлять их в описании классов?
protocol Car {
    func calculateSpeed () -> Double
}


//создаём класс SportCar согласно протокола Car
class SportCar : Car {
    var time: Double
    var distance: Double
    
    init(time: Double, distance: Double) {
        self.time = time
        self.distance = distance
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
    var currentLoad: Double
    
    init(time: Double, distance: Double, capacity: Double, currentLoad: Double) {
        self.time = time
        self.distance = distance
        self.capacity = capacity
        self.currentLoad = currentLoad
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
        return "Спорткар проехал \(self.distance) км за \(self.time) часов, скорость составила \(self.calculateSpeed()) км/ч"
    }
}

extension TrunkCar : CustomStringConvertible {
    var description: String {
        return "Грузовик проехал \(self.distance) км за \(self.time) часов, скорость составила \(self.calculateSpeed()) км/ч. Его назрузка составила \(self.currentLoad) из \(self.capacity) возможных."
    }
}

let sportCar1 = SportCar(time: 4, distance: 520)
let trunkCar2 = TrunkCar(time: 8, distance: 600, capacity: 500, currentLoad: 100)

//загружаем груз в грузовик
print(trunkCar2.loadTruck(weight: 300))


// дискрипшн не берет новое значение - Вопрос! Как впихнуть туда newValue?
print(sportCar1.description)
print(trunkCar2.description)


//не понимаю как это работает вне описания функции и как это вызывать в экземпляре, само по себе не вызывается

//protocol Engine {
//    mutating func engineOnOff ()
//}
//enum engineState : Engine {
//    case on, off
//
//    mutating func engineOnOff() {
//        switch self {
//        case .off:
//            self = .on
//        case .on:
//            self = .off
//        }
//    }
//}


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
