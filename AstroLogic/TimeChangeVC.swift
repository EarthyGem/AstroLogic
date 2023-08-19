//
//  TimeChangeViewController.swift
//  MVP
//
//  Created by Errick Williams on 2/25/23.
//

import UIKit
import SwiftEphemeris

protocol DatePickerDelegate: AnyObject {
    func datePickerDidChangeDate(_ date: Date)
}


class TimeChangeViewController: UIViewController  {
    
    
    weak var delegate: DatePickerDelegate?
    var onDateSelected: ((Date, Date) -> Void)?
    var chartCake: ChartCake?
    var selectedDate: Date?

       @IBAction func datePickerChanged(_ sender: UIDatePicker) {
           delegate?.datePickerDidChangeDate(sender.date)
       }
    

    
   public let chateTimeDP: UIDatePicker = {
        let chateTimeDP = UIDatePicker()
        chateTimeDP.datePickerMode = .dateAndTime
        chateTimeDP.preferredDatePickerStyle = .inline
        chateTimeDP.backgroundColor = .white
        chateTimeDP.tintColor = .green
       chateTimeDP.date = Date()
        return chateTimeDP
    }()
    
  
 
    @IBAction func doneButtonTapped(_ sender: UIToolbar) {
        // Capture the selected date
        let selectedDate = chateTimeDP.date
        
        // Create an instance of the next view controller
        let nextViewController = DateTransitPlanets(transitPlanets: [""]) // Correct the class name if needed
        nextViewController.passedData = selectedDate
        nextViewController.chartCake = chartCake
        // Push the next view controller to the navigation stack
        navigationController?.pushViewController(nextViewController, animated: true)
    }


    
    @objc func dismissDatePicker() {
        
     
    
           

           // Hide the date picker
           view.endEditing(true)
       }
    
    
      private let planetIntro: UILabel = {
          let planetIntro = UILabel()
          
          
          return planetIntro
          
      }()
      
      private let planetIntro1: UILabel = {
          let planetIntro1 = UILabel()
          
          
          return planetIntro1
          
      }()
      
      
      
      private let planetIntro2: UILabel = {
          let planetIntro2 = UILabel()
          
          
          return planetIntro2
          
      }()
      
      
      private let planetIntro3: UILabel = {
          let planetIntro3 = UILabel()
          
          
          return planetIntro3
          
      }()
      
      
      override func viewDidLoad() {
          super.viewDidLoad()

chateTimeDP.frame = CGRect(x: 0, y: 150, width: 400, height: 600)
          view.addSubview(chateTimeDP)
          
//
          let toolbar = UIToolbar()
          toolbar.frame = CGRect(x: 280, y: 600, width: 400, height: 40)
          toolbar.backgroundColor = .red
               // Create a "Done" button for the toolbar
               let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
               
               // Add the "Done" button to the toolbar
               toolbar.setItems([doneButton], animated: false)
          let selectedDate = chateTimeDP.date
 
               // Set the toolbar as the input accessory view of the date picker
          view.addSubview(toolbar)
          
          
          // Do any additional setup after loading the view.
      }

      
      override func viewDidLayoutSubviews() {
          super.viewWillLayoutSubviews()

          view.backgroundColor = .black
  //        title = myPlanetsText.uppercased()
  //
         
          
      }

 

  }

