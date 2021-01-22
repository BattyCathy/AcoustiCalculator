//
//  ContentView.swift
//  AcoustiCalculator
//
//  Created by Guy on 1/22/21.
//

import SwiftUI



struct ContentView: View {
    
    @State var inputString : String = ""
    @State var inputUnitPicker : Int = 0
    @State var outputUnitPicker : Int = 3
    
    var speedOfSound = 343.0
    var unitStrings: [String] {
        ["Period", "Wavelength", "Frequency", "Tempo"]
    }
    
    var unitLabels: [String] {
        ["Seconds", "Meters", "Hertz", "Beats per Minute"]
    }
    
    //MARK: INPUT VALUE ARRAY
    var inputConversion: [Double] {
       [periodToPeriod, wavelengthToPeriod, frequencyToPeriod, bpmToPeriod]
    }
    

    
    
//MARK: OUTPUT VALUE ARRAY
    var outputConversion: [Double] {
        [periodFromPeriod, wavelengthFromPeriod, frequencyFromPeriod, bpmFromPeriod]
    }
    
   
//MARK: INPUT CALCULATIONS
    var inputDouble: Double {
       Double(inputString) ?? 0
    }
    
    var periodToPeriod: Double {
        inputDouble
      
    }
    
    var wavelengthToPeriod: Double {
       inputDouble / speedOfSound
    }
    
    var frequencyToPeriod: Double {
       1 / inputDouble
    }
    
    var bpmToPeriod: Double {
        inputDouble / 60
    }
//BASE UNIT IS DURATION
    
    //Period = Period
    //Wavelength = Period * speed of sound
    //Frequency = 1 / Period
    //BPM = 60 / Period
//MARK: OUTPUT CALCULATIONS
    
    
    var rosetta: Double {
        inputConversion[inputUnitPicker]
    }
    
    var periodFromPeriod: Double {
        rosetta
    }
    var wavelengthFromPeriod: Double {
      rosetta * speedOfSound
    }
    
    var frequencyFromPeriod: Double {
        1 / rosetta
    }
    
    var bpmFromPeriod: Double {
        (60 * rosetta)
    }
    
    var outputValue: Double {
        outputConversion[outputUnitPicker]
    }
    

    var body: some View {
        NavigationView {
            Form{
            //MARK: INPUT SECTION
                Section {
                    TextField("Input Value in \(unitLabels[inputUnitPicker])",
                          text: $inputString)
                }
                .keyboardType(.decimalPad)
            //MARK: INPUT CONVERSION PICKER
                Section(header: Text("Convert From:")) {
                    Picker("Input Unit", selection: $inputUnitPicker) {
                        ForEach( 0 ..< inputConversion.count) {
                            Text("\(self.unitStrings[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            //MARK: OUTPUT CONVERSION PICKER
                Section(header: Text("To:")) {
                    Picker("Output Unit", selection: $outputUnitPicker) {
                        ForEach(0 ..< outputConversion.count) {
                            Text("\(self.unitStrings[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            //MARK: OUTPUT DISPLAY
                Section {
                    Text("\(outputValue, specifier: "%g") \(unitLabels[outputUnitPicker])")
                }
            }
            .navigationBarTitle("AcoustiCalculator")
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
