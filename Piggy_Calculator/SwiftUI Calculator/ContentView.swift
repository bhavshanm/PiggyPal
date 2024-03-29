


import SwiftUI
import AVFoundation

enum CalculationButton: String{
    
    case one = "1",two = "2",four = "4",five = "5",seven = "7" ,eight = "8",nine = "9",six = "6",three = "3",zero = "0",dot = "."
    case multiply = "x",subtract = "-",addition = "+",equal = "=",divide = "÷"
    case ac = "AC",plusMinus = "±",c = "C"    // percent = "%"
    case None
    
    var backgroundColor: Color{
        switch self {
        case .one, .two, .four, .five, .seven, .eight, .nine, .six, .three, .zero, .dot:
            return Color.init(red: 0.15, green: 0.39, blue: 0.00)
        case .multiply, .subtract, .addition, .equal, .divide:
            return Color.init(red: 0.25, green: 0.65, blue: 0.00)
        default:
            return Color(.lightGray)
        }
    }
}

class GlobalEnvironment: ObservableObject{
    
    @Published var display = "0"
    var storeValue = ""
    var secondaryStoreValue = ""
    var storeOperator:CalculationButton = .None
    var secondaryStoreOperator:CalculationButton = .None
    func calculate(_ value: CalculationButton){
        switch value {
        case .one, .two, .four, .five, .seven, .eight, .nine, .six, .three:
            if self.display != "0"{
                self.display = self.display + value.rawValue
            }
            else{
                self.display = value.rawValue
            }
        case .zero:
            if self.display != "0"{
                self.display = self.display + "0"
            }
            else{
                self.display = "0"
            }
        case .dot:
            if !self.display.contains(".") {
                self.display = self.display + "."
            }
        case .multiply:
            storeValue = self.display
            storeOperator = .multiply
            self.display = "0"
        case .subtract:
            storeValue = self.display
            storeOperator = .subtract
            self.display = "0"
        case .addition:
            storeValue = self.display
            storeOperator = .addition
            self.display = "0"
        case .divide:
            storeValue = self.display
            storeOperator = .divide
            self.display = "0"
        case .equal:
            switch storeOperator{
                case .multiply:
                    self.secondaryStoreValue = self.display
                    self.display = String(Float(self.storeValue)! * Float(self.display)!)
                    self.secondaryStoreOperator = self.storeOperator
                    self.storeOperator = .None
                case .subtract:
                    self.secondaryStoreValue = self.display
                    self.display = String(Float(self.storeValue)! - Float(self.display)!)
                    self.secondaryStoreOperator = self.storeOperator
                    self.storeOperator = .None
                case .addition:
                    self.secondaryStoreValue = self.display
                    self.display = String(Float(self.storeValue)! + Float(self.display)!)
                    self.secondaryStoreOperator = self.storeOperator
                    self.storeOperator = .None
                case .divide:
                    self.secondaryStoreValue = self.display
                    self.display = String(Float(self.storeValue)! / Float(self.display)!)
                    self.secondaryStoreOperator = self.storeOperator
                    self.storeOperator = .None
                default:
                    switch secondaryStoreOperator{
                        case .multiply:
                            self.display = String(Float(self.display)! * Float(self.display)!)
                        case .subtract:
                            self.display = String(Float(self.display)! - Float(self.secondaryStoreValue)!)
                        case .addition:
                            self.display = String(Float(self.display)! + Float(self.secondaryStoreValue)!)
                        case .divide:
                            self.display = String(Float(self.display)! / Float(self.secondaryStoreValue)!)
                        default:
                            self.display = "0"
                    }
            }
        case .ac:
            storeValue = ""
            storeOperator = .None
            self.display = "0"
            secondaryStoreValue = ""
            secondaryStoreOperator = .None
        case .c:
            self.display = String(self.display[..<self.display.index(before: self.display.endIndex)])
            if self.display == ""{
                self.display = "0"
            }
        case .plusMinus:
            self.display =  "-" == self.display[display.startIndex] ? String(self.display[self.display.index(after: self.display.firstIndex(of: "-") ?? self.display.startIndex)...]) : "-" + self.display
        default:
            self.display = ""
        }
        
    }
    
    
}

struct ContentView: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    let buttons: [[CalculationButton]] = [
        [.ac,.c,.plusMinus,.divide],
        [.seven,.eight,.nine,.multiply],
        [.four,.five,.six,.addition],
        [.one,.two,.three,.subtract],
        [.zero,.dot,.equal]
    ]
    var body: some View {
        ZStack(alignment: .bottom){
            Color.init(red: 0.93, green: 1.00, blue: 0.88)
            VStack(spacing: 12){
//                Spacer()
                HStack {
                    Spacer()
                    Text(env.display)
                        .foregroundColor(Color.init(red: 0.15, green: 0.39, blue: 0.00))
                        .font(.system(size: 60))
                }
                .padding()
                
                ForEach(buttons, id:\.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id:\.self){ button in
                            
                            calculatorButtonView(button: button)
                        }
                    }
                }
            }
            .padding(.bottom)
        }
        .ignoresSafeArea(.all)
        
    }
}


struct calculatorButtonView: View{
    
    let button: CalculationButton
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View{
        Button(action: {
            env.calculate(button)
            AudioServicesPlaySystemSound(1306)
        }, label: {
            Text(button.rawValue)
                .font(.system(size: 32))
                .frame(width: self.buttonWidth(button), height: (UIScreen.main.bounds.width - 5 * 12) / 4)
                .foregroundColor(.white)
                .background(button.backgroundColor)
                .cornerRadius(self.buttonWidth(button))
        })
    }
    
    private func buttonWidth(_ button: CalculationButton) -> CGFloat{
        
        var size: CGFloat {
            switch button{
            case .zero:
                return (UIScreen.main.bounds.width - 4 * 12) / 4 * 2
            default:
                return (UIScreen.main.bounds.width - 5 * 12) / 4
            }
        }
        
        return size
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environmentObject(GlobalEnvironment())
        }
    }
}
